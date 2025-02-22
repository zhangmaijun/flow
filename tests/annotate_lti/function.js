// @flow

function f(x) {
  return x;
}
f(1);

function f2(x, y) {
  return x == 1 ? y : null;
}
f2(1, 'test');

function internal_annot(x) {
  return (x: string);
}

function unknown(x) {
  return x;
}

function with_default(x=1) {
  return x;
}

function skip(x: number) {
  return x;
}

const f_expr = function fn_expr(x) {
  return (x: string);
}

function rest(x, ...args) {
  return x;
}
rest(1, 2, 3, 4);

// Should be annotated with `NumType`, not `NumType | number`
function g(x) {}
type NumType = number;
const y: NumType = 1;
g(y);
g(2);

// Should be annotated with `NumType | StringType`, not `NumType | StringType | string`
function g2(x) {}
type StringType = string;
const z: NumType | StringType = 1;
g2(z);
g2('test');

function obj({num}) {
  return num;
}
obj({num: 1});

function arr([num, ...rest]) {
  return num;
}
arr([1, 2, 3, 4]);

function default_arr_ok([num=0]) {
  return 1;
}
default_arr_ok([1, 2, 3, 4]);

// This seems very rare. Causes a "Validation Error"
function default_arr_err([num=0]) {
  return 1;
}

// This seems very rare. Causes a "Validation Error"
function default_obj_err({x: y=1}) {
  return 1;
}

// Only annotate with `number` instead of `any | number`.
function any_propagation(props) {}
any_propagation(1);
(any_propagation: any);
