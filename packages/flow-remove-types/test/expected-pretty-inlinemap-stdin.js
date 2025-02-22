/*  */
// @nolint

// Regular import
import {
  Something,
} from 'some-module';

// Import types

// Typed function
async function test(x, y /*.*/ /*.*/ , z /*.*/ /*.*/ = 123) {
  // Typed expression
  return await (x);
}

// Interface

// Exported interface

// Interface extends

// Implements interface
class Bar extends Other /*.*/ {
  // Class Property with default value
  answer = 42;

  // Class Property with default value and variance
covariant = 42;

  // Class Property
  prop;

  // Class Property with variance
propCo;

  method() {
    return;
  }
}

// Class expression implements interface
var SomeClass = class Baz {
  prop;

  method() {
    return;
  }
};

// Parametric class
class Wrapper {
  get() {
    return this.value;
  }

  map() {
    // do something
  }
}

// Extends Parametric class
class StringWrapper extends Wrapper {
  // ...
}

// Declare class

// Declare funtion

// Declare interface

// Declare module

// Declare type alias

// Declare variable

// Type alias

// Export type

// Regular export
export { Wrapper };

// Exported type alias

// Object with types within
var someObj = {
  objMethod() {
    // do nothing.
  }
}

// Example from README
import SomeClass from 'some-module'

export class MyClass extends SomeClass {

  value

  constructor(value) {
    this.value = value
  }

  get() {
    return this.value
  }

}

// Test async/await functions
async function asyncFunction(input) {
  return await t;
}

// Test read-only data

// Test covariant type variant class with constaint and default.
export class TestClassWithDefault {

  constructor() {}
}

var newline_arrow = () => 42;

var newline_arrow_2 = ()=>42;

// Test calling a function with explicit type arguments
doSomething(3);
doSomething(3);

// Test invoking a constructor with explicit type arguments
new Event();

// Test type union and intersection syntax with leading "operator"
var union;
var intersection;

// Test generic async arrow funcion
const f = async() => {};

// Comment type annotations are preserved
var X /*: {
  version: string,
} */ = { version: '42'};

function method(param /*: string */) /*: number */ {
  // ...
}

// declared class fields
class MyClass {
}

// Comment type includes are emptied out
class MyClass {
  /*:: prop; */
}

// Inferred predicate
function testit(arg) {
  return !!arg;
}

// Test function with default type parameter
function f() {}

// Opaque types

// Declare export

//this params

function z () {}
function u (...a) {}

function v (...a) {}

function w (...a) {}

const f = function() {}
const g = function(...a) {}
const h = function(...a) {}

//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIjxzdGRpbj4iXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkdBQUcsQUFBSzs7Ozs7O0VBTU4sQUFBQSxBQUFJLENBQUMsQUFBQSxBQUFRLEFBQUMsQUFBQTtFQUNkLEFBQUEsQUFBTSxDQUFDLEFBQUEsQUFBYyxBQUFBOzs7O0FBSXZCLEFBQTRDLEFBQUE7OztxQkFHdkIsQUFBTSxVQUFVLEFBQUEsQUFBQyxpQkFBaUIsQUFBQSxBQUFDLE9BQU8sQUFBQSxBQUFjLE9BQU8sQUFBUTs7aUJBRTNFLEFBQUs7Ozs7QUFJdEIsQUFJQyxBQUFBOzs7QUFHRCxBQUVDLEFBQUE7OztBQUdELEFBRUMsQUFBQTs7O3dCQUd1QixBQUFBLEFBQVUsT0FBTyxBQUFBLEFBQUcsQUFBQyxDQUFDLEFBQUEsQUFBVTs7UUFFaEQsQUFBUTs7O0VBR2QsQUFBQSxBQUFDLFNBQVMsQUFBUTs7O01BR2QsQUFBSzs7O0VBR1QsQUFBQSxBQUFDLE1BQU0sQUFBUTs7VUFFUCxBQUFPOzs7Ozs7MEJBTVMsQUFBQSxBQUFVLENBQUMsQUFBQSxBQUFHO01BQ2xDLEFBQUs7O1VBRUQsQUFBTzs7Ozs7O2FBTUosQUFBRztPQUNULEFBQUc7Ozs7S0FJTCxBQUFHLEVBQUUsQUFBWTs7Ozs7O21DQU1hLEFBQVE7Ozs7O0FBSzNDLEFBRUMsQUFBQTs7O0FBR0QsQUFBa0MsQUFBQTs7O0FBR2xDLEFBRUMsQUFBQTs7O0FBR0QsQUFFQyxBQUFBOzs7QUFHRCxBQUdFLEFBQUE7OztBQUdGLEFBQStCLEFBQUE7OztBQUcvQixBQUFnQixBQUFBOzs7QUFHaEIsQUFBa0IsQUFBQTs7Ozs7O0FBTWxCLEFBQWtDLEFBQUE7Ozs7YUFJckIsQUFBTTs7Ozs7OztBQU9uQixBQUFnRCxBQUFBOztvQkFFNUIsQUFBRyxtQkFBbUIsQUFBQSxBQUFVLENBQUMsQUFBQSxBQUFhOztPQUUzRCxBQUFHOzttQkFFUyxBQUFHOzs7O09BSWYsQUFBRzs7Ozs7Ozs0QkFPa0IsQUFBRyxNQUFNLEFBQUcsQ0FBQyxBQUFZOzs7OztBQUtyRCxBQUVHLEFBQUE7OztpQ0FHOEIsQUFBaUM7Ozs7O3NCQUs1QyxBQUNoQjs7eUJBRW1CLEFBQUEsQUFDbkI7OztXQUdLLEFBQVE7WUFDUCxBQUFBLEFBQU07OztTQUdULEFBQVE7OztTQUdSLEFBQVM7Z0JBQ0YsQUFBUzs7O2dCQUdULEFBQUEsQUFBRyxFQUFFLEFBQUc7Ozs7Ozs7Ozs7Ozs7RUFhdEIsQUFBQSxBQUFxQixBQUFBOzs7OztXQUtaLEFBQVE7Ozs7bUJBSUEsQUFBTyxDQUFDLEFBQVMsQ0FBQyxBQUFBLEFBQU87Ozs7O1VBS2xDLEFBQVU7OztBQUdwQixBQUF1QixBQUFBO0FBQ3ZCLEFBQStCLEFBQUE7QUFDL0IsQUFBc0IsQUFBQTtBQUN0QixBQUE4QixBQUFBO0FBQzlCLEFBQThCLEFBQUE7OztBQUc5QixBQUE2QixBQUFBO0FBQzdCLEFBQWtDLEFBQUE7QUFDbEMsQUFBeUIsQUFBQTs7OztBQUl6QixBQUF5QyxBQUFBO0FBQ3pDLEFBQStCLEFBQUE7WUFDbkIsQUFBYTtZQUNiLEFBQWEsQUFBQSxBQUFhLEFBQUEsQUFDRixBQUFBLEFBQUEsQUFBWTttQkFDWixBQUFZLEFBQUEsQUFDWCxBQUFBIiwic291cmNlc0NvbnRlbnQiOlsiLyogQGZsb3cgKi9cbi8vIEBub2xpbnRcblxuLy8gUmVndWxhciBpbXBvcnRcbmltcG9ydCB7XG4gIFNvbWV0aGluZyxcbiAgdHlwZSBTb21lVHlwZSxcbiAgdHlwZW9mIFNvbWVPdGhlclRoaW5nXG59IGZyb20gJ3NvbWUtbW9kdWxlJztcblxuLy8gSW1wb3J0IHR5cGVzXG5pbXBvcnQgdHlwZSB7IFNvbWVUeXBlIH0gZnJvbSAnc29tZS1tb2R1bGUnO1xuXG4vLyBUeXBlZCBmdW5jdGlvblxuYXN5bmMgZnVuY3Rpb24gdGVzdCh4OiBUeXBlLCB5IC8qLiovID8gLyouKi8gLCB6IC8qLiovID8gLyouKi8gOiAvKi4qLyBudW1iZXIgPSAxMjMpOiBzdHJpbmcge1xuICAvLyBUeXBlZCBleHByZXNzaW9uXG4gIHJldHVybiBhd2FpdCAoeDogYW55KTtcbn1cblxuLy8gSW50ZXJmYWNlXG5pbnRlcmZhY2UgRm9vIHtcbiAgcHJvcDogYW55O1xuXG4gIG1ldGhvZCgpOiBtaXhlZDtcbn1cblxuLy8gRXhwb3J0ZWQgaW50ZXJmYWNlXG5leHBvcnQgaW50ZXJmYWNlIElUaGluZyB7XG4gIGV4cG9ydGVkOiB0cnVlO1xufVxuXG4vLyBJbnRlcmZhY2UgZXh0ZW5kc1xuaW50ZXJmYWNlIFNpbGx5Rm9vIGV4dGVuZHMgRm9vIHtcbiAgc2lsbHk6IHN0cmluZztcbn1cblxuLy8gSW1wbGVtZW50cyBpbnRlcmZhY2VcbmNsYXNzIEJhciBleHRlbmRzIE90aGVyIGltcGxlbWVudHMgLyouKi8gRm9vLCBJU29tZXRoaW5nIHtcbiAgLy8gQ2xhc3MgUHJvcGVydHkgd2l0aCBkZWZhdWx0IHZhbHVlXG4gIGFuc3dlcjogbnVtYmVyID0gNDI7XG5cbiAgLy8gQ2xhc3MgUHJvcGVydHkgd2l0aCBkZWZhdWx0IHZhbHVlIGFuZCB2YXJpYW5jZVxuICArY292YXJpYW50OiBudW1iZXIgPSA0MjtcblxuICAvLyBDbGFzcyBQcm9wZXJ0eVxuICBwcm9wOiBhbnk7XG5cbiAgLy8gQ2xhc3MgUHJvcGVydHkgd2l0aCB2YXJpYW5jZVxuICArcHJvcENvOiBudW1iZXI7XG5cbiAgbWV0aG9kKCk6IG1peGVkIHtcbiAgICByZXR1cm47XG4gIH1cbn1cblxuLy8gQ2xhc3MgZXhwcmVzc2lvbiBpbXBsZW1lbnRzIGludGVyZmFjZVxudmFyIFNvbWVDbGFzcyA9IGNsYXNzIEJheiBpbXBsZW1lbnRzIEZvbyB7XG4gIHByb3A6IGFueTtcblxuICBtZXRob2QoKTogbWl4ZWQge1xuICAgIHJldHVybjtcbiAgfVxufTtcblxuLy8gUGFyYW1ldHJpYyBjbGFzc1xuY2xhc3MgV3JhcHBlcjxUPiB7XG4gIGdldCgpOiBUIHtcbiAgICByZXR1cm4gdGhpcy52YWx1ZTtcbiAgfVxuXG4gIG1hcDxNPigpOiBXcmFwcGVyPE0+IHtcbiAgICAvLyBkbyBzb21ldGhpbmdcbiAgfVxufVxuXG4vLyBFeHRlbmRzIFBhcmFtZXRyaWMgY2xhc3NcbmNsYXNzIFN0cmluZ1dyYXBwZXIgZXh0ZW5kcyBXcmFwcGVyPHN0cmluZz4ge1xuICAvLyAuLi5cbn1cblxuLy8gRGVjbGFyZSBjbGFzc1xuZGVjbGFyZSBjbGFzcyBCYXoge1xuICBtZXRob2QoKTogbWl4ZWQ7XG59XG5cbi8vIERlY2xhcmUgZnVudGlvblxuZGVjbGFyZSBmdW5jdGlvbiBzb21lRnVuYygpOiB2b2lkO1xuXG4vLyBEZWNsYXJlIGludGVyZmFjZVxuZGVjbGFyZSBpbnRlcmZhY2UgSVNvbWV0aGluZyB7XG4gIGFuc3dlcjogbnVtYmVyO1xufVxuXG4vLyBEZWNsYXJlIG1vZHVsZVxuZGVjbGFyZSBtb2R1bGUgJ2ZzJyB7XG4gIGRlY2xhcmUgZnVuY3Rpb24gcmVhZFRoaW5nKHBhdGg6IHN0cmluZyk6IHN0cmluZztcbn1cblxuLy8gRGVjbGFyZSB0eXBlIGFsaWFzXG5kZWNsYXJlIHR5cGUgTG9jYXRpb24gPSB7XG4gIGxhdDogbnVtYmVyLFxuICBsb246IG51bWJlclxufTtcblxuLy8gRGVjbGFyZSB2YXJpYWJsZVxuZGVjbGFyZSB2YXIgU09NRV9DT05TVDogc3RyaW5nO1xuXG4vLyBUeXBlIGFsaWFzXG50eXBlIFQgPSBzdHJpbmc7XG5cbi8vIEV4cG9ydCB0eXBlXG5leHBvcnQgdHlwZSB7IFQgfTtcblxuLy8gUmVndWxhciBleHBvcnRcbmV4cG9ydCB7IFdyYXBwZXIgfTtcblxuLy8gRXhwb3J0ZWQgdHlwZSBhbGlhc1xuZXhwb3J0IHR5cGUgT05FID0geyBvbmU6IG51bWJlciB9O1xuXG4vLyBPYmplY3Qgd2l0aCB0eXBlcyB3aXRoaW5cbnZhciBzb21lT2JqID0ge1xuICBvYmpNZXRob2QoKTogdm9pZCB7XG4gICAgLy8gZG8gbm90aGluZy5cbiAgfVxufVxuXG4vLyBFeGFtcGxlIGZyb20gUkVBRE1FXG5pbXBvcnQgU29tZUNsYXNzIGZyb20gJ3NvbWUtbW9kdWxlJ1xuaW1wb3J0IHR5cGUgeyBTb21lSW50ZXJmYWNlIH0gZnJvbSAnc29tZS1tb2R1bGUnXG5cbmV4cG9ydCBjbGFzcyBNeUNsYXNzPFQ+IGV4dGVuZHMgU29tZUNsYXNzIGltcGxlbWVudHMgU29tZUludGVyZmFjZSB7XG5cbiAgdmFsdWU6IFRcblxuICBjb25zdHJ1Y3Rvcih2YWx1ZTogVCkge1xuICAgIHRoaXMudmFsdWUgPSB2YWx1ZVxuICB9XG5cbiAgZ2V0KCk6IFQge1xuICAgIHJldHVybiB0aGlzLnZhbHVlXG4gIH1cblxufVxuXG4vLyBUZXN0IGFzeW5jL2F3YWl0IGZ1bmN0aW9uc1xuYXN5bmMgZnVuY3Rpb24gYXN5bmNGdW5jdGlvbjxUPihpbnB1dDogVCk6IFByb21pc2U8VD4ge1xuICByZXR1cm4gYXdhaXQgdDtcbn1cblxuLy8gVGVzdCByZWFkLW9ubHkgZGF0YVxuZXhwb3J0IHR5cGUgVGVzdFJlYWRPbmx5ID0ge3xcbiAgK3JlYWRPbmx5OiAkUmVhZE9ubHlBcnJheTw+XG58fTtcblxuLy8gVGVzdCBjb3ZhcmlhbnQgdHlwZSB2YXJpYW50IGNsYXNzIHdpdGggY29uc3RhaW50IGFuZCBkZWZhdWx0LlxuZXhwb3J0IGNsYXNzIFRlc3RDbGFzc1dpdGhEZWZhdWx0PCtUOiBUZXN0UmVhZE9ubHkgPSBUZXN0UmVhZE9ubHk+IHtcblxuICBjb25zdHJ1Y3RvcigpIHt9XG59XG5cbnZhciBuZXdsaW5lX2Fycm93ID0gKCk6XG5udW1iZXIgPT4gNDI7XG5cbnZhciBuZXdsaW5lX2Fycm93XzIgPSAoKSA6XG5udW1iZXI9PjQyO1xuXG4vLyBUZXN0IGNhbGxpbmcgYSBmdW5jdGlvbiB3aXRoIGV4cGxpY2l0IHR5cGUgYXJndW1lbnRzXG5kb1NvbWV0aGluZzxudW1iZXI+KDMpO1xuZG9Tb21ldGhpbmcgPFQsIFU+KDMpO1xuXG4vLyBUZXN0IGludm9raW5nIGEgY29uc3RydWN0b3Igd2l0aCBleHBsaWNpdCB0eXBlIGFyZ3VtZW50c1xubmV3IEV2ZW50PG51bWJlcj4oKTtcblxuLy8gVGVzdCB0eXBlIHVuaW9uIGFuZCBpbnRlcnNlY3Rpb24gc3ludGF4IHdpdGggbGVhZGluZyBcIm9wZXJhdG9yXCJcbnZhciB1bmlvbjogfCBUIHwgVTtcbnZhciBpbnRlcnNlY3Rpb246ICYgVCAmIFU7XG5cbi8vIFRlc3QgZ2VuZXJpYyBhc3luYyBhcnJvdyBmdW5jaW9uXG5jb25zdCBmID0gYXN5bmMgPFQ+KCk6IFQgPT4ge307XG5cbi8vIENvbW1lbnQgdHlwZSBhbm5vdGF0aW9ucyBhcmUgcHJlc2VydmVkXG52YXIgWCAvKjoge1xuICB2ZXJzaW9uOiBzdHJpbmcsXG59ICovID0geyB2ZXJzaW9uOiAnNDInfTtcblxuZnVuY3Rpb24gbWV0aG9kKHBhcmFtIC8qOiBzdHJpbmcgKi8pIC8qOiBudW1iZXIgKi8ge1xuICAvLyAuLi5cbn1cblxuLy8gZGVjbGFyZWQgY2xhc3MgZmllbGRzXG5jbGFzcyBNeUNsYXNzIHtcbiAgZGVjbGFyZSBwcm9wOiBzdHJpbmc7XG59XG5cbi8vIENvbW1lbnQgdHlwZSBpbmNsdWRlcyBhcmUgZW1wdGllZCBvdXRcbmNsYXNzIE15Q2xhc3Mge1xuICAvKjo6IHByb3A6IHN0cmluZzsgKi9cbn1cblxuLy8gSW5mZXJyZWQgcHJlZGljYXRlXG5mdW5jdGlvbiB0ZXN0aXQoYXJnOiBtaXhlZCk6IGJvb2xlYW4gJWNoZWNrcyB7XG4gIHJldHVybiAhIWFyZztcbn1cblxuLy8gVGVzdCBmdW5jdGlvbiB3aXRoIGRlZmF1bHQgdHlwZSBwYXJhbWV0ZXJcbmZ1bmN0aW9uIGY8VCwgUyA9IFQ+KCkge31cblxuLy8gT3BhcXVlIHR5cGVzXG5vcGFxdWUgdHlwZSBBID0gbnVtYmVyO1xub3BhcXVlIHR5cGUgQjogc3RyaW5nID0gc3RyaW5nO1xuZGVjbGFyZSBvcGFxdWUgdHlwZSBBO1xuZGVjbGFyZSBvcGFxdWUgdHlwZSBCOiBzdHJpbmc7XG5leHBvcnQgb3BhcXVlIHR5cGUgQSA9IG51bWJlcjtcblxuLy8gRGVjbGFyZSBleHBvcnRcbmRlY2xhcmUgZXhwb3J0IG9wYXF1ZSB0eXBlIEI7XG5kZWNsYXJlIGV4cG9ydCBmdW5jdGlvbiB4KCk6IHZvaWQ7XG5kZWNsYXJlIGV4cG9ydCBkZWZhdWx0IFQ7XG5cbi8vdGhpcyBwYXJhbXNcblxuZGVjbGFyZSBmdW5jdGlvbiB5ICh0aGlzIDogc3RyaW5nKSA6IHZvaWRcbnR5cGUgVCA9ICh0aGlzIDogc3RyaW5nKSA6IHZvaWRcbmZ1bmN0aW9uIHogKHRoaXMgOiBzdHJpbmcpIHt9XG5mdW5jdGlvbiB1ICh0aGlzIDogc3RyaW5nLCAuLi5hKSB7fVxuXG5mdW5jdGlvbiB2ICh0aGlzIDogc3RyaW5nXG4gICAsIC4uLmEpIHt9XG5cbmZ1bmN0aW9uIHcgKHRoaXNcbiAgOiBzdHJpbmdcblxuICAgLFxuICAgLi4uYSkge31cblxuY29uc3QgZiA9IGZ1bmN0aW9uKHRoaXM6IHN0cmluZykge31cbmNvbnN0IGcgPSBmdW5jdGlvbih0aGlzOiBzdHJpbmcsIC4uLmEpIHt9XG5jb25zdCBoID0gZnVuY3Rpb24odGhpc1xuOiBzdHJpbmcsXG4uLi5hKSB7fVxuIl19
