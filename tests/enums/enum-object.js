// @flow

enum E {
  A,
  B,
}

enum F {
  A,
  B,
}

// Comparison of enum object types
type EO = typeof E;
(E: EO); // Valid
(F: EO); // Error: types are incompatible

// Invalid access from enum object type
EO.A;

// Refinements
type VoidableEO = void | EO;

const x: VoidableEO = E;

if (typeof x === "undefined") {
  (x: void); // Valid
  (x: EO); // Error
}

if (typeof x !== "undefined") {
  (x: void); // Error
  (x: EO); // Valid
}

if (typeof x === "object") {
  (x: void); // Error
  (x: EO); // Valid
}

if (typeof x !== "object") {
  (x: void); // Valid
  (x: EO); // Error
}

if (x) {
  (x: void); // Error
  (x: EO); // Valid
}

if (!x) {
  (x: void); // Valid
  (x: EO); // Error
}

// Iteration
for (const x of E) { // Error
}
for (const x of E.members()) { // Valid
}

function* f1() {
  yield* E; // Error
}
function* f2() {
  yield* E.members(); // Valid
}

for (const x in E) { // Error
}
