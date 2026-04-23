___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "filterArray(...)",
  "description": "Filters items in an \u003cem\u003earray\u003c/em\u003e using a callback  \u003cem\u003efunction\u003c/em\u003e , returning only items for which the callback returns \u003cem\u003etrue\u003c/em\u003e. Useful for data filtering and conditional selection.",
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
        "name": "cbk",
        "displayName": "Filter Callback Function",
        "simpleValueType": true,
        "help": "⚙️   A function that receives each item and returns true to keep it, false to remove it.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eFunction\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFilter even numbers\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: [1, 2, 3, 4, 5, 6]\u003cbr\u003eFilter Callback Function: function(x) { return x % 2 === 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[2, 4, 6]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty array unchanged\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: []\u003cbr\u003eFilter Callback Function: function(x) { return x \u003e 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Array To Filter"
      },
      {
        "type": "GROUP",
        "name": "Advanced Settings",
        "displayName": "Advanced Settings",
        "groupStyle": "ZIPPY_OPEN_ON_PARAM",
        "subParams": [
          {
            "type": "CHECKBOX",
            "name": "rp1",
            "checkboxText": "⚡Use runtime parameter for: Filter Callback Function",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Filters an \u003cem\u003earray\u003c/em\u003e using a callback function, returning only elements that pass the test.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFilter even numbers\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[1, 2, 3, 4, 5, 6]\u003c/strong\u003e\u003cbr\u003eFilter Callback Function: \u003cstrong\u003efunction(x) { return x % 2 === 0; }\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[2, 4, 6]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty array unchanged\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[]\u003c/strong\u003e\u003cbr\u003eFilter Callback Function: \u003cstrong\u003efunction(x) { return x \u003e 0; }\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., arr =\u003e arr.length, arr =\u003e arr.join(',') for string conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Filters items in the array using a callback function.
* 
* @param {Array} data.src - The array of values to filter.
* @param {Function} data.cbk - A function that receives each item and returns true to keep it.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before filtering.
* 
* @returns {Array} A new array containing only the items that passed the callback test.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');
const filterArray = function(arr, callback) {
   if (getType(arr) !== 'array' || typeof callback !== 'function') {
       return [];
   }
   return arr.filter(callback);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// filterArray - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedArray = applyCast(data.pre, data.src);
return out(filterArray(processedArray, data.cbk));
*/
// ===============================================================================
// filterArray(...) – Apply Mode
// ===============================================================================
return function(value, callback) {
   callback = data.rp1 ? data.cbk : callback;
   return out(filterArray(value, callback));
};


___TESTS___

scenarios:
  - name: '[example] Filter even numbers'
    code: |
      /* @display
      Value to Process: [1, 2, 3, 4, 5, 6]
      Filter Callback Function: function(x) { return x % 2 === 0; }
      @output
      [2, 4, 6]
      */
      const src = [1, 2, 3, 4, 5, 6];
      const cbk = function(x) { return x % 2 === 0; };
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
      assertThat(variableResult).isEqualTo([2, 4, 6]);
  - name: Array with strings - filter strings longer than 3 characters
    code: |-
      const src = ['hi', 'hello', 'yo', 'world'];
      const cbk = function(s) { return s.length > 3; };
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
      assertThat(variableResult).isEqualTo(['hello', 'world']);
  - name: Array with no matching items - should return empty array
    code: |-
      const src = [1, 3, 5, 7];
      const cbk = function(x) { return x % 2 === 0; };
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
  - name: Array with all matching items - should return all items
    code: |-
      const src = [2, 4, 6, 8];
      const cbk = function(x) { return x % 2 === 0; };
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
      assertThat(variableResult).isEqualTo([2, 4, 6, 8]);
  - name: '[example] Empty array unchanged'
    code: |-
      /* @display
      Value to Process: []
      Filter Callback Function: function(x) { return x > 0; }
      @output
      []
      */
      const src = [];
      const cbk = function(x) { return x > 0; };
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
  - name: Array with objects - filter by property value
    code: |
      const src = [{name: 'John', age: 25}, {name: 'Jane', age: 30}, {name: 'Bob', age: 20}];
      const cbk = function(obj) { return obj.age >= 25; };
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
      assertThat(variableResult).isEqualTo([{name: 'John', age: 25}, {name: 'Jane', age: 30}]);
  - name: Array with mixed types - filter truthy values
    code: |-
      const src = [0, 1, '', 'hello', null, 'world', undefined, 42];
      const cbk = function(val) { return !!val; };
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
      assertThat(variableResult).isEqualTo([1, 'hello', 'world', 42]);
  - name: Non-array input - should return empty array
    code: |-
      const src = 'not an array';
      const cbk = function(x) { return true; };
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
  - name: Null input - should return empty array
    code: |-
      const src = null;
      const cbk = function(x) { return true; };
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
  - name: Non-function callback - should return empty array
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
      assertThat(variableResult).isEqualTo([]);
  - name: Filter with index parameter - keep items at even indices
    code: |-
      const src = ['a', 'b', 'c', 'd', 'e'];
      const cbk = function(val, idx) { return idx % 2 === 0; };
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
      assertThat(variableResult).isEqualTo(['a', 'c', 'e']);
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'apply';
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
