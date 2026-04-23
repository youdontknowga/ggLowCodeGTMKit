___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "findIndexByCallback",
  "description": "Finds the first index in an \u003cem\u003earray\u003c/em\u003e for which a provided \u003cem\u003efunction\u003c/em\u003e returns \u003cem\u003etrue\u003c/em\u003e, useful for locating specific items based on custom conditions.",
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
        "displayName": "Input Array",
        "simpleValueType": true,
        "help": "💾   An array or comma-separated string of values.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "fnc",
        "displayName": "Test Function",
        "simpleValueType": true,
        "help": "💾   A callback function to test each item. Should return a boolean.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eFunction\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "idx",
        "displayName": "Start Index",
        "simpleValueType": true,
        "help": "💾   Optional index to start the search from (default: 0).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e"
      }
    ],
    "help": "Returns the index of the first element that satisfies the given callback function. Returns \u003cem\u003e-1\u003c/em\u003e if not found.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFind element index\u003c/em\u003e***\u003cbr\u003eInput Array: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003eTest Function: \u003cstrong\u003efunction(x) { return x \u003e 3; }\u003c/strong\u003e\u003cbr\u003eStart Index: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns -1\u003c/em\u003e***\u003cbr\u003eInput Array: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003eTest Function: \u003cstrong\u003efunction(x) { return x \u003e 10; }\u003c/strong\u003e\u003cbr\u003eStart Index: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e-1\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert object to string, normalize case). Internal transformations such as case handling will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str + ' €', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Finds the first index in an array for which a provided function returns true.
* 
* @param {Array|string} data.src - An array or comma-separated string of values.
* @param {Function} data.fnc - A callback function to test each item. Should return a boolean.
* @param {number} data.idx - Optional index to start the search from (default: 0).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before searching.
* 
* @returns {number} The index of the first matching item, or -1 if no match is found.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');

const findIndexByCallback = function(array, matchFn, fromIndex) {
   const arr = typeof array === 'string' ? array.split(',') : array;
   const startIndex = typeof fromIndex === 'number' ? fromIndex : 0;
   
   if (getType(arr) !== 'array' || typeof matchFn !== 'function') { 
       return -1; 
   }
   
   for (var i = startIndex; i < arr.length; i++) {
       var item = arr[i];
       if (matchFn(item, i, arr)) {
           return i;
       }
   }
   return -1;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// findIndexByCallback - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedArray = applyCast(data.pre, data.src);
return out(findIndexByCallback(processedArray, data.fnc, data.idx));
// ===============================================================================
// findIndexByCallback(...) – Apply Mode
// ===============================================================================
/*
return function(value, matchFn, fromIndex) {
   matchFn = data.rp1 ? data.fnc : matchFn;
   return out(findIndexByCallback(value, matchFn, data.idx));
};
*/


___TESTS___

scenarios:
  - name: '[example] Find element index'
    code: |-
      /* @display
      Input Array: [1, 2, 3, 4, 5]
      Test Function: function(x) { return x > 3; }
      Start Index: 0
      @output
      3
      */
      const src = [1, 2, 3, 4, 5];
      const fnc = function(x) { return x > 3; };
      const idx = 0;
      const mockData = {
          src: src,
          fnc: fnc,
          idx: idx,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc, idx);
      }
      assertThat(variableResult).isEqualTo(3);
  - name: Comma-separated string - splits and finds match
    code: |-
      const src = "apple,banana,cherry,date";
      const fnc = function(x) { return x === "cherry"; };
      const idx = 0;
      const mockData = {
          src: src,
          fnc: fnc,
          idx: idx,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc, idx);
      }
      assertThat(variableResult).isEqualTo(2);
  - name: Array with fromIndex - starts search from specified index
    code: |
      const src = [10, 20, 30, 40, 50];
      const fnc = function(x) { return x > 25; };
      const idx = 2;
      const mockData = {
          src: src,
          fnc: fnc,
          idx: idx,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc, idx);
      }
      assertThat(variableResult).isEqualTo(2);
  - name: '[example] No match returns -1'
    code: |-
      /* @display
      Input Array: [1, 2, 3, 4, 5]
      Test Function: function(x) { return x > 10; }
      Start Index: 0
      @output
      -1
      */
      const src = [1, 2, 3, 4, 5];
      const fnc = function(x) { return x > 10; };
      const idx = 0;
      const mockData = {
          src: src,
          fnc: fnc,
          idx: idx,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc, idx);
      }
      assertThat(variableResult).isEqualTo(-1);
  - name: Non-array input - returns -1
    code: |-
      const src = 12345;
      const fnc = function(x) { return x > 0; };
      const idx = 0;
      const mockData = {
          src: src,
          fnc: fnc,
          idx: idx,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc, idx);
      }
      assertThat(variableResult).isEqualTo(-1);
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
