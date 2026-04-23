___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "map",
  "description": "Transforms array items using a callback \u003cem\u003efunction\u003c/em\u003e or extracts a property from objects. Returns new array with results.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "paramSection",
    "displayName": "𝘋𝘦𝘴𝘤𝘳𝘪𝘱𝘵𝘪𝘰𝘯",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "src",
        "displayName": "Array to Map",
        "simpleValueType": true,
        "help": "💾 The array to transform or extract values from.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e: \u003cem\u003e[1, 2, 3]\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray of objects\u003c/strong\u003e: \u003cem\u003e[{name: \"John\"}, {name: \"Jane\"}]\u003c/em\u003e"
      },
      {
        "type": "TEXT",
        "name": "cbk",
        "displayName": "Callback or Property Name",
        "simpleValueType": true,
        "help": "💾 Function to transform each item, or property name to extract.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eFunction\u003c/strong\u003e: \u003cem\u003ex =\u003e x * 2\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eProperty name\u003c/strong\u003e: \u003cem\u003e\"name\"\u003c/em\u003e, \u003cem\u003e\"id\"\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e💡 Using a property name extracts that property from each object in the array."
      }
    ],
    "help": "Transforms each item in an \u003cem\u003earray\u003c/em\u003e using a callback function or extracts a property from each object.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMultiply each by 2\u003c/em\u003e***\u003cbr\u003eArray to Map: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003eCallback or Property Name: \u003cstrong\u003efunction(x) { return x * 2; }\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[2, 4, 6, 8, 10]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract property from objects\u003c/em\u003e***\u003cbr\u003eArray to Map: \u003cstrong\u003e[{name: 'John', age: 25}, {name: 'Jane', age: 30}, {name: 'Bob', age: 35}]\u003c/strong\u003e\u003cbr\u003eCallback or Property Name: \u003cstrong\u003efunction(obj) { return obj.name; }\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['John', 'Jane', 'Bob']\u003c/strong\u003e"
  },
  {
    "type": "GROUP",
    "name": "Input Setup",
    "displayName": "Input Setup",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "TEXT",
        "name": "pre",
        "displayName": "Input Function (optional)",
        "simpleValueType": true,
        "help": "⚙️ Optional pre-processing function applied to the array before mapping (e.g., filter invalid items, sort array)."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "Result Handling",
    "displayName": "Result Handling",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "TEXT",
        "name": "out",
        "displayName": "Output Function (optional)",
        "simpleValueType": true,
        "help": "⚙️ Optional function to apply to the result array before returning it (e.g., \u003ccode\u003earr =\u003e arr.join(',')\u003c/code\u003e, \u003ccode\u003earr =\u003e arr.filter(x =\u003e x != null)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Applies a callback function or extracts a property from each item in the array and returns a new array of results.
 * 
 * @param {Array} data.src - The array of values to transform.
 * @param {Function|string} data.cbk - A function that receives each item and returns a transformed value, or a property name to extract.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before mapping.
 * 
 * @returns {Array} A new array containing the results of applying the callback or extracted property values.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const mapArray = function(arr, callbackOrProperty) {
   if (getType(arr) !== 'array') {
       return [];
   }
   
   if (typeof callbackOrProperty === 'string') {
       const prop = callbackOrProperty;
       return arr.map(function(item) {
           return item != null ? item[prop] : undefined;
       });
   }
  
   if (typeof callbackOrProperty === 'function') {
       return arr.map(callbackOrProperty);
   }
   
   return [];
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// map - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedArray = applyCast(data.pre, data.src);
return out(mapArray(processedArray, data.cbk));
// ===============================================================================
// map(...) – Apply Mode
// ===============================================================================
/*
return function(value, callback) {
   callback = data.rp1 ? data.cbk : callback;
   return out(mapArray(value, callback));
};
*/


___TESTS___

scenarios:
  - name: '[example] Multiply each by 2'
    code: |
      /* @display
      Array to Map: [1, 2, 3, 4, 5]
      Callback or Property Name: function(x) { return x * 2; }
      @output
      [2, 4, 6, 8, 10]
      */
      const src = [1, 2, 3, 4, 5];
      const cbk = function(x) { return x * 2; };
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo([2, 4, 6, 8, 10]);
  - name: Array of strings - convert to uppercase
    code: |-
      const src = ['hello', 'world', 'test'];
      const cbk = function(s) { return s.toUpperCase(); };
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo(['HELLO', 'WORLD', 'TEST']);
  - name: '[example] Extract property from objects'
    code: |-
      /* @display
      Array to Map: [{name: 'John', age: 25}, {name: 'Jane', age: 30}, {name: 'Bob', age: 35}]
      Callback or Property Name: function(obj) { return obj.name; }
      @output
      ['John', 'Jane', 'Bob']
      */
      const src = [{name: 'John', age: 25}, {name: 'Jane', age: 30}, {name: 'Bob', age: 35}];
      const cbk = function(obj) { return obj.name; };
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo(['John', 'Jane', 'Bob']);
  - name: Array with index parameter - create indexed strings
    code: |-
      const src = ['a', 'b', 'c'];
      const cbk = function(val, idx) { return val + idx; };
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo(['a0', 'b1', 'c2']);
  - name: Empty array - should return empty array
    code: |-
      const src = [];
      const cbk = function(x) { return x * 2; };
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo([]);
  - name: Non-array input - should return empty array
    code: |-
      const src = 'not an array';
      const cbk = function(x) { return x; };
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo([]);
  - name: Map with unmatch property string - should maintain array alignment
    code: |-
      const src = [1, 2, 3];
      const cbk = 'not a function';
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo([undefined,undefined,undefined]);
  - name: Array of mixed types - transform to string lengths
    code: |-
      const src = ['hello', 123, true, null, 'world'];
      const cbk = function(val) { return ('' + val).length; };
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo([5, 3, 4, 4, 5]);
  - name: Map with property string
    code: |-
      const src = [{name: "John", age: 30}, {name: "Jane", age: 25}];
      const cbk = "name";
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult[0]).isEqualTo("John");
      assertThat(variableResult[1]).isEqualTo("Jane");
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
  const mode = 'direct';
  // ===================================================================================================
  // Derived flags
  // ===================================================================================================
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
