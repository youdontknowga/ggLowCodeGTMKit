___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "takeItemsRight",
  "description": "Returns the \u003cstrong\u003elast\u003c/strong\u003e count elements from the \u003cem\u003earray\u003c/em\u003e. If count is 0 or less, an empty array is returned.",
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
        "displayName": "Array To Process",
        "simpleValueType": true,
        "help": "💾   The array to take items from the end.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "cnt",
        "displayName": "Count",
        "simpleValueType": true,
        "help": "💾   The number of items to take from the end.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Returns the last N elements from an \u003cem\u003earray\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTake last 3\u003c/em\u003e***\u003cbr\u003eArray To Process: \u003cstrong\u003e[1, 2, 3, 4, 5, 6]\u003c/strong\u003e\u003cbr\u003eCount: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[4, 5, 6]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCount exceeds length\u003c/em\u003e***\u003cbr\u003eArray To Process: \u003cstrong\u003e['a', 'b', 'c']\u003c/strong\u003e\u003cbr\u003eCount: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['a', 'b', 'c']\u003c/strong\u003e"
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
* Returns the last count elements from the array.
* 
* @param {Array} data.src - The array to take items from.
* @param {number|string} data.cnt - The number of items to take from the end.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before taking items.
* 
* @returns {Array} A new array with up to count elements from the end, or empty array if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');
const Math = require('Math');
const makeNumber = require('makeNumber');

const takeItemsRight = function(arr, count) {
   const cnt = makeNumber(count);
   if (getType(arr) !== 'array' || cnt !== cnt || cnt < 0) {
       return [];
   }
   return arr.slice(Math.max(arr.length - cnt, 0));
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// takeItemsRight - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(takeItemsRight(value, data.cnt));
// ===============================================================================
// takeItemsRight(...) – Apply Mode
// ===============================================================================
/*
return function(value, count) {
   count = data.rp1 ? data.cnt : count;
   return out(takeItemsRight(value, count));
};
*/


___TESTS___

scenarios:
  - name: '[example] Take last 3'
    code: |-
      /* @display
      Array To Process: [1, 2, 3, 4, 5, 6]
      Count: 3
      @output
      [4, 5, 6]
      */
      const src = [1, 2, 3, 4, 5, 6];
      const cnt = 3;
      const mockData = {
          src: src,
          cnt: cnt,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cnt);
      }
      assertThat(variableResult).isEqualTo([4, 5, 6]);
  - name: '[example] Count exceeds length'
    code: |-
      /* @display
      Array To Process: ['a', 'b', 'c']
      Count: 10
      @output
      ['a', 'b', 'c']
      */
      const src = ['a', 'b', 'c'];
      const cnt = 10;
      const mockData = {
          src: src,
          cnt: cnt,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cnt);
      }
      assertThat(variableResult).isEqualTo(['a', 'b', 'c']);
  - name: String count parameter - converts to number and takes items
    code: |-
      const src = [10, 20, 30, 40, 50];
      const cnt = "2";
      const mockData = {
          src: src,
          cnt: cnt,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cnt);
      }
      assertThat(variableResult).isEqualTo([40, 50]);
  - name: Negative count - returns empty array
    code: |-
      const src = [1, 2, 3, 4];
      const cnt = -2;
      const mockData = {
          src: src,
          cnt: cnt,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cnt);
      }
      assertThat(variableResult).isEqualTo([]);
  - name: Non-array input - returns empty array
    code: |-
      const src = "not an array";
      const cnt = 3;
      const mockData = {
          src: src,
          cnt: cnt,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cnt);
      }
      assertThat(variableResult).isEqualTo([]);
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
