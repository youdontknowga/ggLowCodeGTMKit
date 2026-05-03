___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "head",
  "description": "Returns the first item of the input \u003cem\u003earray\u003c/em\u003e without modifying it. Returns \u003cem\u003eundefined\u003c/em\u003e if the \u003cem\u003earray\u003c/em\u003e is empty or invalid.",
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
        "displayName": "Array To Inspect",
        "simpleValueType": true,
        "help": "💾   The array to get the first item from.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e"
      }
    ],
    "help": "Returns the first item from the input \u003cem\u003earray\u003c/em\u003e. Returns \u003cem\u003eundefined\u003c/em\u003e if the array is empty or invalid.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFirst element\u003c/em\u003e***\u003cbr\u003eArray To Inspect: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty array returns undefined\u003c/em\u003e***\u003cbr\u003eArray To Inspect: \u003cstrong\u003e[]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
* Returns the first item of the input array without modifying it.
* 
* @param {Array} data.src - The array to inspect.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before getting first item.
* 
* @returns {*} The first item of the array, or undefined if the array is empty or invalid.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');
const head = function(arr) {
   if (getType(arr) !== 'array' || arr.length === 0) {
       return undefined;
   }
   return arr[0];
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// head - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(head(value));
// ===============================================================================
// head() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(head(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] First element'
    code: |
      /* @display
      Array To Inspect: [1, 2, 3, 4, 5]
      @output
      1
      */
      const src = [1, 2, 3, 4, 5];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(1);
  - name: Array with single item - should return that item
    code: |
      const src = ['only'];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('only');
  - name: '[example] Empty array returns undefined'
    code: |-
      /* @display
      Array To Inspect: []
      @output
      undefined
      */
      const src = [];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isUndefined();
  - name: Array with mixed types - should return first item
    code: |-
      const src = [{key: 'value'}, 'hello', true, null, 1];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo({key: 'value'});
  - name: Non-array input - should return undefined
    code: |-
      const src = 'not an array';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isUndefined();
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
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
