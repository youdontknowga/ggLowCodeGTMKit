___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "uniq",
  "description": "Returns a new \u003cem\u003earray\u003c/em\u003e with only unique values, removing all duplicates. Preserves the order of first occurrence.",
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
        "displayName": "Array",
        "simpleValueType": true,
        "help": "💾   The array to process for unique values.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e"
      }
    ],
    "help": "Returns a new \u003cem\u003earray\u003c/em\u003e with only unique values, removing all duplicates.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove duplicates\u003c/em\u003e***\u003cbr\u003eArray: \u003cstrong\u003e[1, 2, 2, 3, 4, 3, 5]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo duplicates unchanged\u003c/em\u003e***\u003cbr\u003eArray: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert string to array, filter values). Internal transformations will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., arr =\u003e arr.length, arr =\u003e arr.join(',')). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Returns a new array with only unique values, removing all duplicates.
 * 
 * @param {Array} data.src - The array to process for unique values.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before getting unique values.
 * 
 * @returns {Array} A new array containing only unique values from the input array.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const uniq = function(value) {
   if (getType(value) !== 'array') { return []; }
   const result = [];
   for (let i = 0; i < value.length; i++) {
      const val = value[i];
      let found = false;
      for (let j = 0; j < result.length; j++) {
         if (result[j] === val || (val !== val && result[j] !== result[j])) { // Handle NaN
            found = true;
            break;
         }
      }
      if (!found) {
         result.push(val);
      }
   }
   return result;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// uniq - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(uniq(value));

// ===============================================================================
// uniq() – Apply Mode: runtime parameter
// ===============================================================================
/*
return function(value) {
   return out(uniq(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Remove duplicates'
    code: |-
      /* @display
      Array: [1, 2, 2, 3, 4, 3, 5]
      @output
      [1, 2, 3, 4, 5]
      */
      const src = [1, 2, 2, 3, 4, 3, 5];
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
  - name: Array with string duplicates - should return unique strings
    code: |-
      const src = ['apple', 'banana', 'apple', 'cherry', 'banana'];
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
      assertThat(variableResult).isEqualTo(['apple', 'banana', 'cherry']);
  - name: '[example] No duplicates unchanged'
    code: |-
      /* @display
      Array: [1, 2, 3, 4, 5]
      @output
      [1, 2, 3, 4, 5]
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
      assertThat(variableResult).isEqualTo([1, 2, 3, 4, 5]);
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
  - name: Array with mixed types - should handle different types
    code: |-
      const src = [1, '1', 2, '2', 1, 2];
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
      assertThat(variableResult).isEqualTo([1, '1', 2, '2']);
  - name: Single element array - should return same array
    code: |-
      const src = [42];
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
      assertThat(variableResult).isEqualTo([42]);
  - name: Array with undefined and null - should handle special values
    code: |-
      const src = [1, null, 2, undefined, null, 3];
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
      assertThat(variableResult).isEqualTo([1, null, 2, undefined, 3]);
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
