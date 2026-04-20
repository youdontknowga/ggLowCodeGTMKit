___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "find(...)",
  "description": "Finds the first element in an \u003cem\u003earray\u003c/em\u003e that satisfies a provided testing function, useful for locating specific items based on custom conditions.",
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
        "name": "fnc",
        "displayName": "Test Function",
        "simpleValueType": true,
        "help": "🔍   A function to test each element. Should return true for the desired element.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eFunction\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFind first match\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: [1, 3, 4, 5, 6]\u003cbr\u003eTest Function: function(x) { return x % 2 === 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e4\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: [1, 3, 5, 7]\u003cbr\u003eTest Function: function(x) { return x % 2 === 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Array To Process"
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
            "checkboxText": "⚡Use runtime parameter for: Test Function",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Returns the first element in an \u003cem\u003earray\u003c/em\u003e that satisfies the given predicate function.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFind first match\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[1, 3, 4, 5, 6]\u003c/strong\u003e\u003cbr\u003eTest Function: \u003cstrong\u003efunction(x) { return x % 2 === 0; }\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e4\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[1, 3, 5, 7]\u003c/strong\u003e\u003cbr\u003eTest Function: \u003cstrong\u003efunction(x) { return x % 2 === 0; }\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., result =\u003e result || 'not found', result =\u003e result.id). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Finds the first element in an array that satisfies a provided testing function.
* 
* @param {Array} data.src - The array to search in.
* @param {Function} data.fnc - A function to test each element. Should return true for the desired element.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before searching.
* 
* @returns {*} The first element that satisfies the testing function, or undefined if no element is found.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');
const find = function(arr, testFunction) {
   if (getType(arr) !== 'array' || typeof testFunction !== 'function') {
       return undefined;
   }
   
   for (let i = 0; i < arr.length; i++) {
       if (testFunction(arr[i], i, arr)) {
           return arr[i];
       }
   }
   return undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// find - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedArray = applyCast(data.pre, data.src);
return out(find(processedArray, data.fnc));
*/
// ===============================================================================
// find(...) – Apply Mode
// ===============================================================================
return function(value, testFunction) {
   testFunction = data.rp1 ? data.fnc : testFunction;
   return out(find(value, testFunction));
};


___TESTS___

scenarios:
  - name: '[example] Find first match'
    code: |-
      /* @display
      Value to Process: [1, 3, 4, 5, 6]
      Test Function: function(x) { return x % 2 === 0; }
      @output
      4
      */
      const src = [1, 3, 4, 5, 6];
      const fnc = function(x) { return x % 2 === 0; };
      const mockData = {
          src: src,
          fnc: fnc,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc);
      }
      assertThat(variableResult).isEqualTo(4);
  - name: Find first string longer than 3 characters
    code: |-
      // Find first string longer than 3 characters - should return 'hello'
      const src = ['hi', 'bye', 'hello', 'world'];
      const fnc = function(s) { return s.length > 3; };
      const mockData = {
          src: src,
          fnc: fnc,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc);
      }
      assertThat(variableResult).isEqualTo('hello');
  - name: '[example] No match returns undefined'
    code: |-
      /* @display
      Value to Process: [1, 3, 5, 7]
      Test Function: function(x) { return x % 2 === 0; }
      @output
      undefined
      */
      const src = [1, 3, 5, 7];
      const fnc = function(x) { return x % 2 === 0; };
      const mockData = {
          src: src,
          fnc: fnc,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc);
      }
      assertThat(variableResult).isUndefined();
  - name: Find first element (returns first match)
    code: |-
      const src = [10, 20, 30, 40];
      const fnc = function(x) { return x > 15; };
      const mockData = {
          src: src,
          fnc: fnc,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc);
      }
      assertThat(variableResult).isEqualTo(20);
  - name: Empty array returns undefined
    code: |-
      const src = [];
      const fnc = function(x) { return x > 0; };
      const mockData = {
          src: src,
          fnc: fnc,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc);
      }
      assertThat(variableResult).isUndefined();
  - name: Find object with specific property
    code: |-
      const src = [{id: 1, name: 'Alice'}, {id: 2, name: 'Bob'}, {id: 3, name: 'Charlie'}];
      const fnc = function(obj) { return obj.id === 2; };
      const mockData = {
          src: src,
          fnc: fnc,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc);
      }
      assertThat(variableResult).isEqualTo({id: 2, name: 'Bob'});
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
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
