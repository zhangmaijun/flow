(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

module Js = Js_of_ocaml.Js

module JsTranslator : sig
  val translation_errors : (Loc.t * Parse_error.t) list ref

  include Translator_intf.S
end = struct
  type t = Js.Unsafe.any

  let translation_errors = ref []

  let string x = Js.Unsafe.inject (Js.string x)

  let bool x = Js.Unsafe.inject (Js.bool x)

  let obj props = Js.Unsafe.inject (Js.Unsafe.obj (Array.of_list props))

  let array arr = Js.Unsafe.inject (Js.array (Array.of_list arr))

  let number x = Js.Unsafe.inject (Js.number_of_float x)

  let int x = number (float x)

  let null = Js.Unsafe.inject Js.null

  let regexp loc pattern flags =
    let regexp =
      try Js.Unsafe.new_obj (Js.Unsafe.variable "RegExp") [| string pattern; string flags |] with
      | _ ->
        translation_errors := (loc, Parse_error.InvalidRegExp) :: !translation_errors;

        (* Invalid RegExp. We already validated the flags, but we've been
         * too lazy to write a JS regexp parser in Ocaml, so we didn't know
         * the pattern was invalid. We'll recover with an empty pattern.
         *)
        Js.Unsafe.new_obj (Js.Unsafe.variable "RegExp") [| string ""; string flags |]
    in
    Js.Unsafe.inject regexp
end

module Token_translator = Token_translator.Translate (JsTranslator)

module Translate =
  Estree_translator.Translate
    (JsTranslator)
    (struct
      let include_locs = true
    end)

let bool_opt default jsopts name =
  let opt = Js.Unsafe.get jsopts name in
  if Js.Optdef.test opt then
    Js.to_bool opt
  else
    default

let parse_options jsopts =
  let open Parser_env in
  let defaults = Parser_env.default_parse_options in
  {
    enums = bool_opt defaults.enums jsopts "enums";
    esproposal_class_instance_fields =
      bool_opt defaults.esproposal_class_instance_fields jsopts "esproposal_class_instance_fields";
    esproposal_class_static_fields =
      bool_opt defaults.esproposal_class_static_fields jsopts "esproposal_class_static_fields";
    esproposal_decorators = bool_opt defaults.esproposal_decorators jsopts "esproposal_decorators";
    esproposal_export_star_as =
      bool_opt defaults.esproposal_export_star_as jsopts "esproposal_export_star_as";
    esproposal_optional_chaining =
      bool_opt defaults.esproposal_optional_chaining jsopts "esproposal_optional_chaining";
    esproposal_nullish_coalescing =
      bool_opt defaults.esproposal_nullish_coalescing jsopts "esproposal_nullish_coalescing";
    types = bool_opt defaults.types jsopts "types";
    use_strict = bool_opt defaults.use_strict jsopts "use_strict";
  }

let translate_tokens offset_table tokens =
  JsTranslator.array (List.rev_map (Token_translator.token offset_table) tokens)

let parse content options =
  let options =
    if options = Js.undefined then
      Js.Unsafe.obj [||]
    else
      options
  in
  let content = Js.to_string content in
  let parse_options = Some (parse_options options) in
  let include_tokens =
    let tokens = Js.Unsafe.get options "tokens" in
    Js.Optdef.test tokens && Js.to_bool tokens
  in
  let include_interned_comments =
    let comments = Js.Unsafe.get options "comments" in
    if Js.Optdef.test comments then
      Js.to_bool comments
    else
      true
  in
  let include_all_comments =
    let comments = Js.Unsafe.get options "all_comments" in
    if Js.Optdef.test comments then
      Js.to_bool comments
    else
      true
  in
  let rev_tokens = ref [] in
  let token_sink =
    if include_tokens then
      Some (fun token_data -> rev_tokens := token_data :: !rev_tokens)
    else
      None
  in
  let (ocaml_ast, errors) = Parser_flow.program ~fail:false ~parse_options ~token_sink content in
  JsTranslator.translation_errors := [];
  let offset_table = Offset_utils.make ~kind:Offset_utils.JavaScript content in
  let ocaml_ast =
    if include_interned_comments then
      ocaml_ast
    else
      Comment_utils.strip_inlined_comments ocaml_ast
  in
  let ocaml_ast =
    if include_all_comments then
      ocaml_ast
    else
      Comment_utils.strip_comments_list ocaml_ast
  in
  let ret = Translate.program (Some offset_table) ocaml_ast in
  let translation_errors = !JsTranslator.translation_errors in
  Js.Unsafe.set ret "errors" (Translate.errors (errors @ translation_errors));
  if include_tokens then Js.Unsafe.set ret "tokens" (translate_tokens offset_table !rev_tokens);
  ret
