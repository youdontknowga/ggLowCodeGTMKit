___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "dropItems(...)",
  "description": "Removes the first count elements from the \u003cem\u003earray\u003c/em\u003e and returns the rest. If count is 0 or less, the original array is returned.",
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
        "name": "cnt",
        "displayName": "Count",
        "simpleValueType": true,
        "help": "🎯   The number of items to drop from the beginning.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDrop first 2 items\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: [1, 2, 3, 4, 5]\u003cbr\u003eCount: 2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[3, 4, 5]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDrop all returns empty\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: [1, 2, 3]\u003cbr\u003eCount: 10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
            "checkboxText": "⚡Use runtime parameter for: Count",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Removes the first N elements from an \u003cem\u003earray\u003c/em\u003e and returns the rest.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDrop first 2 items\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003eCount: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[3, 4, 5]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDrop all returns empty\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[1, 2, 3]\u003c/strong\u003e\u003cbr\u003eCount: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
* Removes the first count elements from the array and returns the rest.
* 
* @param {Array} data.src - The array to drop items from.
* @param {number|string} data.cnt - The number of items to drop from the beginning.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before dropping items.
* 
* @returns {Array} A new array with the first count items removed, or empty array if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');
const makeNumber = require('makeNumber');

const dropItems = function(arr, count) {
   const cnt = makeNumber(count);
   if (getType(arr) !== 'array' || cnt !== cnt || cnt < 0) {
       return [];
   }
   return arr.slice(cnt);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// dropItems - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(dropItems(value, data.cnt));
*/
// ===============================================================================
// dropItems(...) – Apply Mode
// ===============================================================================
return function(value, count) {
   count = data.rp1 ? data.cnt : count;
   return out(dropItems(value, count));
};


___TESTS___

scenarios:
  - name: '[example] Drop first 2 items'
    code: |-
      /* @display
      Value to Process: [1, 2, 3, 4, 5]
      Count: 2
      @output
      [3, 4, 5]
      */
      const src = [1, 2, 3, 4, 5];
      const cnt = 2;
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
      assertThat(variableResult).isEqualTo([3, 4, 5]);
  - name: String count parameter - converts to number and drops elements
    code: |-
      const src = ['a', 'b', 'c', 'd'];
      const cnt = "1";
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
      assertThat(variableResult).isEqualTo(['b', 'c', 'd']);
  - name: '[example] Drop all returns empty'
    code: |-
      /* @display
      Value to Process: [1, 2, 3]
      Count: 10
      @output
      []
      */
      const src = [1, 2, 3];
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
      assertThat(variableResult).isEqualTo([]);
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
      const cnt = 2;
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
