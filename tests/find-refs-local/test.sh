#!/bin/bash
. ../assert.sh
FLOW=$1

printf "\nVariable defs and uses:\n"
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 4 5
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 5 2

printf "\nNested functions:\n"
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 10 10
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 13 3

printf "\nClasses:\n"
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 18 7

# printf "\nType aliases:\n"
# assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 23 6

printf "\nRefinements:\n"
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 28 6
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 29 6
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 30 16
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 31 8
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 33 2

printf "\nDestructuring:\n"
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 36 7
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 37 10
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 37 26
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 38 7

# printf "\nNot in scope:\n"
# assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 41 2
# assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 42 2
# assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 42 9
# assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 43 2

# printf "\nJSX:\n"
# assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 50 4

printf "\nImports:\n"
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 55 2
# This is a type, which doesn't work yet
# assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 55 9

# printf "\nQualified types:\n"
# assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 58 9

printf "\nExports:\n"
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 64 20
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 65 6

printf "\nMethods and properties:\n\n"
printf "Method declaration: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 70 3
printf "Property declaration: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 71 5
printf "Method call (finds definition and other references): "
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 80 13

printf "Method call on an imported class (finds other references but not the definition since it's in another file): "
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 90 16

printf "Method call within a class that has type params: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root locals.js 96 10

printf "Instance method on a superclass: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root classInheritance.js 4 3
printf "Call of instance method on subclass which does not override: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root classInheritance.js 20 10
printf "Instance method on a subclass which does override: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root classInheritance.js 10 3
printf "Call of instance method on a subclass which does override: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root classInheritance.js 21 10
printf "Definition of a method in a parameterized class: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root classInheritance.js 25 3
printf "Call of an instance method on an upcasted class: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root classInheritance.js 31 15

printf "Method declaration in an object type alias: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root objects.js 4 4
printf "Property declaration in an object type alias: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root objects.js 5 4
printf "Method call on an object type alias: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root objects.js 9 4

printf "Property access on an object without an annotation: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root objects.js 15 4
printf "Property definition on an object without an annotation: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root objects.js 14 12

printf "Introduction of a shadow property via a write: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root objects.js 19 4
printf "Use of a shadow property: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root objects.js 20 4

printf "Introduction of a shadow property via a read: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root objects.js 23 4
printf "Write of a shadow property introduced via a read: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root objects.js 24 4

printf "Introduction of a shadow property that is never written: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root objects.js 27 4
printf "Read of a shadow property that is never written: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root objects.js 28 4

printf "Use of a property that came through type spread: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root objects.js 35 25

printf "Use as a JSX component class: "
assert_ok "$FLOW" find-refs --json --pretty --strip-root jsx.js 5 7
