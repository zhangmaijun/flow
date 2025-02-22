//@flow
let x: number => number = (x) => 3;
x = (x) => 3; // No missing annot

let y = (x: number) => 3;
y = (x) => 3; // Missing annot

let [a, b]: [number => number, number => number] = [(x) => x, (y) => y]
a = (x) => x; // No missing annot
[a, b] = [(y) => y , (y) => y]; // No missing annots

var c;
c = (x) => 3; // Missing annot

var d: (number) => number;
d = (x) => 3; // No missing annot

let e;
e = (x) => 3; // Missing annot

let f: (number) => number;
f = (x) => 3; // No missing annot
