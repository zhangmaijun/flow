(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

module Ast = Flow_ast
open Flow_ast_mapper

module Make (L : Loc_sig.S) = struct
  module L = L

  type for_kind =
    | In
    | Of

  type root =
    | Annotation of (L.t, L.t) Ast.Type.annotation
    | Value of (L.t, L.t) Ast.Expression.t
    | Contextual of L.t
    | Catch
    | For of for_kind * (L.t, L.t) Ast.Expression.t

  type selector =
    | Elem of int
    | Prop of {
        prop: string;
        has_default: bool;
      }
    | Computed of (L.t, L.t) Ast.Expression.t
    | ObjRest of {
        used_props: string list;
        after_computed: bool;
      }
    | ArrRest of int
    | Default of (L.t, L.t) Ast.Expression.t

  type binding =
    | Root of root
    | Select of selector * binding

  type import =
    | Named of {
        kind: Ast.Statement.ImportDeclaration.import_kind option;
        remote: string;
      }
    | Namespace
    | Default

  type def =
    | Binding of L.t * binding
    | OpAssign of L.t * Ast.Expression.Assignment.operator * (L.t, L.t) Ast.Expression.t
    | Update of L.t * Ast.Expression.Update.operator
    | Function of {
        fully_annotated: bool;
        function_: (L.t, L.t) Ast.Function.t;
      }
    | Class of {
        fully_annotated: bool;
        class_: (L.t, L.t) Ast.Class.t;
      }
    | DeclaredClass of (L.t, L.t) Ast.Statement.DeclareClass.t
    | TypeAlias of (L.t, L.t) Ast.Statement.TypeAlias.t
    | OpaqueType of (L.t, L.t) Ast.Statement.OpaqueType.t
    | TypeParam of (L.t, L.t) Ast.Type.TypeParam.t
    | Interface of (L.t, L.t) Ast.Statement.Interface.t
    | Enum of L.t Ast.Statement.EnumDeclaration.body
    | Import of {
        import_kind: Ast.Statement.ImportDeclaration.import_kind;
        import: import;
        source: string;
      }

  type map = def L.LMap.t

  module Destructure = struct
    open Ast.Pattern

    let type_of_pattern (_, p) =
      let open Ast.Pattern in
      match p with
      | Array { Array.annot = Ast.Type.Available t; _ }
      | Object { Object.annot = Ast.Type.Available t; _ }
      | Identifier { Identifier.annot = Ast.Type.Available t; _ } ->
        Some t
      | _ -> None

    let pattern_default acc = function
      | None -> acc
      | Some e -> Select (Default e, acc)

    let array_element acc i = Select (Elem i, acc)

    let array_rest_element acc i = Select (ArrRest i, acc)

    let object_named_property acc x ~has_default = Select (Prop { prop = x; has_default }, acc)

    let object_computed_property acc e = Select (Computed e, acc)

    let object_rest_property acc xs has_computed =
      Select (ObjRest { used_props = xs; after_computed = has_computed }, acc)

    let object_property acc xs key ~has_default =
      let open Ast.Pattern.Object in
      match key with
      | Property.Identifier (_, { Ast.Identifier.name = x; comments = _ }) ->
        let acc = object_named_property acc x ~has_default in
        (acc, x :: xs, false)
      | Property.Literal (_, { Ast.Literal.value = Ast.Literal.String x; _ }) ->
        let acc = object_named_property acc x ~has_default in
        (acc, x :: xs, false)
      | Property.Computed (_, { Ast.ComputedKey.expression; comments = _ }) ->
        let acc = object_computed_property acc expression in
        (acc, xs, true)
      | Property.Literal (_, _) -> (acc, xs, false)

    let identifier ~f acc name_loc = f name_loc (Binding (name_loc, acc))

    let rec pattern ~f acc (_, p) =
      match p with
      | Array { Array.elements; annot = _; comments = _ } -> array_elements ~f acc elements
      | Object { Object.properties; annot = _; comments = _ } -> object_properties ~f acc properties
      | Identifier { Identifier.name = id; optional = _; annot = _ } ->
        let (id_loc, _) = id in
        identifier ~f acc id_loc
      | Expression _ -> ()

    and array_elements ~f acc =
      let open Ast.Pattern.Array in
      Base.List.iteri ~f:(fun i -> function
        | Hole _ -> ()
        | Element (_, { Element.argument = p; default = d }) ->
          let acc = array_element acc i in
          let acc = pattern_default acc d in
          pattern ~f acc p
        | RestElement (_, { Ast.Pattern.RestElement.argument = p; comments = _ }) ->
          let acc = array_rest_element acc i in
          pattern ~f acc p
      )

    and object_properties =
      let open Ast.Pattern.Object in
      let prop ~f acc xs has_computed p =
        match p with
        | Property (_, { Property.key; pattern = p; default = d; shorthand = _ }) ->
          let has_default = d <> None in
          let (acc, xs, has_computed') = object_property acc xs key ~has_default in
          let acc = pattern_default acc d in
          pattern ~f acc p;
          (xs, has_computed || has_computed')
        | RestElement (_, { Ast.Pattern.RestElement.argument = p; comments = _ }) ->
          let acc = object_rest_property acc xs has_computed in
          pattern ~f acc p;
          (xs, false)
      in
      let rec loop ~f acc xs has_computed = function
        | [] -> ()
        | p :: ps ->
          let (xs, has_computed) = prop ~f acc xs has_computed p in
          loop ~f acc xs has_computed ps
      in
      (fun ~f acc ps -> loop ~f acc [] false ps)
  end

  let func_is_annotated { Ast.Function.return; _ } =
    match return with
    | Ast.Type.Missing _ -> false
    | Ast.Type.Available _ -> true

  let def_of_function function_ =
    Function { fully_annotated = func_is_annotated function_; function_ }

  let def_of_class ({ Ast.Class.body = (_, { Ast.Class.Body.body; _ }); _ } as class_) =
    let open Ast.Class.Body in
    let fully_annotated =
      Base.List.for_all
        ~f:(function
          | Method
              ( _,
                {
                  Ast.Class.Method.key = Ast.Expression.Object.Property.Identifier _;
                  value = (_, value);
                  _;
                }
              ) ->
            func_is_annotated value
          | Method _ -> false
          | Property
              ( _,
                {
                  Ast.Class.Property.key = Ast.Expression.Object.Property.Identifier _;
                  annot = Ast.Type.Available _;
                  _;
                }
              ) ->
            true
          | Property _ -> false
          | PrivateField (_, { Ast.Class.PrivateField.annot = Ast.Type.Available _; _ }) -> true
          | PrivateField (_, { Ast.Class.PrivateField.annot = Ast.Type.Missing _; _ }) -> false)
        body
    in
    Class { fully_annotated; class_ }

  class def_finder =
    object (this)
      inherit [map, L.t] Flow_ast_visitor.visitor ~init:L.LMap.empty as super

      method add_binding loc src = this#update_acc (L.LMap.add loc src)

      method! variable_declarator ~kind decl =
        let open Ast.Statement.VariableDeclaration.Declarator in
        let (_, { id; init }) = decl in
        let source =
          match (Destructure.type_of_pattern id, init) with
          | (Some annot, _) -> Some (Annotation annot)
          | (None, Some init) -> Some (Value init)
          | (None, None) -> None
        in
        Base.Option.iter
          ~f:(fun acc -> Destructure.pattern ~f:this#add_binding (Root acc) id)
          source;
        super#variable_declarator ~kind decl

      method! declare_variable loc (decl : ('loc, 'loc) Ast.Statement.DeclareVariable.t) =
        let open Ast.Statement.DeclareVariable in
        let { id = (id_loc, _); annot; comments = _ } = decl in
        this#add_binding id_loc (Binding (id_loc, Root (Annotation annot)));
        super#declare_variable loc decl

      method! function_param (param : ('loc, 'loc) Ast.Function.Param.t) =
        let open Ast.Function.Param in
        let (loc, { argument; default }) = param in
        let source =
          match Destructure.type_of_pattern argument with
          | Some annot -> Annotation annot
          | None -> Contextual loc
        in
        let source = Destructure.pattern_default (Root source) default in
        Destructure.pattern ~f:this#add_binding source argument;
        super#function_param param

      method! function_rest_param (expr : ('loc, 'loc) Ast.Function.RestParam.t) =
        let open Ast.Function.RestParam in
        let (loc, { argument; _ }) = expr in
        let source =
          match Destructure.type_of_pattern argument with
          | Some annot -> Annotation annot
          | None -> Contextual loc
        in
        Destructure.pattern ~f:this#add_binding (Root source) argument;
        super#function_rest_param expr

      method! catch_clause_pattern pat =
        Destructure.pattern ~f:this#add_binding (Root Catch) pat;
        super#catch_clause_pattern pat

      method! function_ loc expr =
        let open Ast.Function in
        let { id; _ } = expr in
        begin
          match id with
          | Some (id_loc, _) -> this#add_binding id_loc (def_of_function expr)
          | None -> ()
        end;
        super#function_ loc expr

      method! class_ loc expr =
        let open Ast.Class in
        let { id; _ } = expr in
        begin
          match id with
          | Some (id_loc, _) -> this#add_binding id_loc (def_of_class expr)
          | None -> ()
        end;
        super#class_ loc expr

      method! declare_function loc (decl : ('loc, 'loc) Ast.Statement.DeclareFunction.t) =
        match Declare_function_utils.declare_function_to_function_declaration_simple loc decl with
        | Some stmt ->
          let _ = this#statement (loc, stmt) in
          decl
        | None ->
          let open Ast.Statement.DeclareFunction in
          let { id = (id_loc, _); annot; predicate = _; comments = _ } = decl in
          this#add_binding id_loc (Binding (id_loc, Root (Annotation annot)));
          super#declare_function loc decl

      method! declare_class loc (decl : ('loc, 'loc) Ast.Statement.DeclareClass.t) =
        let open Ast.Statement.DeclareClass in
        let { id = (id_loc, _); _ } = decl in
        this#add_binding id_loc (DeclaredClass decl);
        super#declare_class loc decl

      method! assignment loc (expr : ('loc, 'loc) Ast.Expression.Assignment.t) =
        let open Ast.Expression.Assignment in
        let { operator; left = (_, lhs_node) as left; right; comments = _ } = expr in
        let () =
          match (operator, lhs_node) with
          | (None, _) -> Destructure.pattern ~f:this#add_binding (Root (Value right)) left
          | (Some operator, Ast.Pattern.Identifier { Ast.Pattern.Identifier.name = (id_loc, _); _ })
            ->
            this#add_binding id_loc (OpAssign (id_loc, operator, right))
          | _ -> ()
        in
        super#assignment loc expr

      method! update_expression loc (expr : (L.t, L.t) Ast.Expression.Update.t) =
        let open Ast.Expression.Update in
        let { argument; operator; prefix = _; comments = _ } = expr in
        begin
          match argument with
          | (_, Ast.Expression.Identifier (id_loc, _)) ->
            this#add_binding id_loc (Update (id_loc, operator))
          | _ -> ()
        end;
        super#update_expression loc expr

      method! for_of_statement loc (stuff : ('loc, 'loc) Ast.Statement.ForOf.t) =
        let open Ast.Statement.ForOf in
        let { left; right; body = _; await = _; comments = _ } = stuff in
        begin
          match left with
          | LeftDeclaration
              ( _,
                {
                  Ast.Statement.VariableDeclaration.declarations =
                    [(_, { Ast.Statement.VariableDeclaration.Declarator.id; _ })];
                  _;
                }
              ) ->
            let source =
              match Destructure.type_of_pattern id with
              | Some annot -> Annotation annot
              | None -> For (Of, right)
            in
            Destructure.pattern ~f:this#add_binding (Root source) id
          | LeftDeclaration _ -> failwith "Invalid AST structure"
          | LeftPattern pat -> Destructure.pattern ~f:this#add_binding (Root (For (Of, right))) pat
        end;
        super#for_of_statement loc stuff

      method! for_in_statement loc (stuff : ('loc, 'loc) Ast.Statement.ForIn.t) =
        let open Ast.Statement.ForIn in
        let { left; right; body = _; each = _; comments = _ } = stuff in
        begin
          match left with
          | LeftDeclaration
              ( _,
                {
                  Ast.Statement.VariableDeclaration.declarations =
                    [(_, { Ast.Statement.VariableDeclaration.Declarator.id; _ })];
                  _;
                }
              ) ->
            let source =
              match Destructure.type_of_pattern id with
              | Some annot -> Annotation annot
              | None -> For (In, right)
            in
            Destructure.pattern ~f:this#add_binding (Root source) id
          | LeftDeclaration _ -> failwith "Invalid AST structure"
          | LeftPattern pat -> Destructure.pattern ~f:this#add_binding (Root (For (In, right))) pat
        end;
        super#for_in_statement loc stuff

      method! type_alias loc (alias : ('loc, 'loc) Ast.Statement.TypeAlias.t) =
        let open Ast.Statement.TypeAlias in
        let { id = (id_loc, _); _ } = alias in
        this#add_binding id_loc (TypeAlias alias);
        super#type_alias loc alias

      method! opaque_type loc (otype : ('loc, 'loc) Ast.Statement.OpaqueType.t) =
        let open Ast.Statement.OpaqueType in
        let { id = (id_loc, _); _ } = otype in
        this#add_binding id_loc (OpaqueType otype);
        super#opaque_type loc otype

      method! type_param (tparam : ('loc, 'loc) Ast.Type.TypeParam.t) =
        let open Ast.Type.TypeParam in
        let (_, { name = (name_loc, _); _ }) = tparam in
        this#add_binding name_loc (TypeParam tparam);
        super#type_param tparam

      method! interface loc (interface : ('loc, 'loc) Ast.Statement.Interface.t) =
        let open Ast.Statement.Interface in
        let { id = (name_loc, _); _ } = interface in
        this#add_binding name_loc (Interface interface);
        super#interface loc interface

      method! enum_declaration loc (enum : ('loc, 'loc) Ast.Statement.EnumDeclaration.t) =
        let open Ast.Statement.EnumDeclaration in
        let { id = (name_loc, _); body; _ } = enum in
        this#add_binding name_loc (Enum body);
        super#enum_declaration loc enum

      method! import_declaration loc (decl : ('loc, 'loc) Ast.Statement.ImportDeclaration.t) =
        let open Ast.Statement.ImportDeclaration in
        let {
          import_kind;
          source = (_, { Ast.StringLiteral.value = source; _ });
          specifiers;
          default;
          comments = _;
        } =
          decl
        in
        begin
          match specifiers with
          | Some (ImportNamedSpecifiers specifiers) ->
            Base.List.iter
              ~f:(fun { kind; local; remote = (rem_id_loc, { Ast.Identifier.name = remote; _ }) } ->
                let id_loc =
                  Base.Option.value_map ~f:(fun (id_loc, _) -> id_loc) ~default:rem_id_loc local
                in
                this#add_binding
                  id_loc
                  (Import { import_kind; source; import = Named { kind; remote } }))
              specifiers
          | Some (ImportNamespaceSpecifier (_, (id_loc, _))) ->
            this#add_binding id_loc (Import { import_kind; source; import = Namespace })
          | None -> ()
        end;
        Base.Option.iter
          ~f:(fun (id_loc, _) ->
            this#add_binding id_loc (Import { import_kind; source; import = Default }))
          default;
        super#import_declaration loc decl
    end

  let find_defs ast =
    let finder = new def_finder in
    finder#eval finder#program ast
end

module With_Loc = Make (Loc_sig.LocS)
module With_ALoc = Make (Loc_sig.ALocS)
