___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "compact()",
  "description": "Removes all falsy values (e.g., \u003cem\u003efalse, 0, null, undefined, NaN, \"\"\u003c/em\u003e) from the input \u003cem\u003earray\u003c/em\u003e, returning a new \u003cem\u003earray\u003c/em\u003e with only truthy values.",
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
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove falsy values\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e[1, false, 2, null, 3, 0, 4, '', 5, undefined]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo falsy values unchanged\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e[1, 'hello', true, {}, []]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[1, 'hello', true, {}, []]\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Array To Clean"
      }
    ],
    "help": "Removes all falsy values from an \u003cem\u003earray\u003c/em\u003e (false, null, 0, \"\", undefined, NaN).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove falsy values\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[1, false, 2, null, 3, 0, 4, '', 5, undefined]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo falsy values unchanged\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[1, 'hello', true, {}, []]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[1, 'hello', true, {}, []]\u003c/strong\u003e"
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
* Removes all falsy values from the input array.
* 
* @param {Array} data.src - The array to clean of falsy values.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before cleaning.
* 
* @returns {Array} A new array with only truthy values.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');

const compact = function(arr) {
   if (getType(arr) !== 'array') {
       return [];
   }
   const result = [];
   for (let i = 0; i < arr.length; i++) {
       if (arr[i]) {
           result.push(arr[i]);
       }
   }
   return result;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// compact - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(compact(value));
*/
// ===============================================================================
// compact() – Apply Mode
// ===============================================================================
return function(value) {
  return out(compact(value));
};


___TESTS___

scenarios:
  - name: '[example] Remove falsy values'
    code: |-
      /* @display
      Value to Process: [1, false, 2, null, 3, 0, 4, '', 5, undefined]
      @output
      [1, 2, 3, 4, 5]
      */
      const src = [1, false, 2, null, 3, 0, 4, '', 5, undefined];
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
      assertThat(variableResult).isEqualTo([1, 2, 3, 4, 5]);
  - name: '[example] No falsy values unchanged'
    code: |-
      /* @display
      Value to Process: [1, 'hello', true, {}, []]
      @output
      [1, 'hello', true, {}, []]
      */
      const src = [1, 'hello', true, {}, []];
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
      assertThat(variableResult).isEqualTo([1, 'hello', true, {}, []]);
  - name: Array with only falsy values - should return empty array
    code: |-
      const src = [false, null, 0, '', undefined];
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
      assertThat(variableResult).isEqualTo([]);
  - name: Empty array - should return empty array
    code: |-
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
      assertThat(variableResult).isEqualTo([]);
  - name: Non-array input - should return empty array
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
