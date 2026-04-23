___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "join(...)",
  "description": "Joins the elements of an \u003cem\u003earray\u003c/em\u003e into a single string, with an optional separator between each element.",
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
        "name": "sep",
        "displayName": "Separator (use {{space}} for space, blank for no separator)",
        "simpleValueType": true,
        "defaultValue": ",",
        "help": "💾 The separator string to place between array elements. Spaces are trimmed in GTM fields, so use \u003ccode\u003e{{space}}\u003c/code\u003e to represent a space character.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e (use {{space}} for space)\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eEmpty string\u003c/strong\u003e (no separator)",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eJoin with comma\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003earr: ['apple', 'banana', 'orange']\u003cbr\u003eSeparator (use {{space}} for space, blank for no separator): ,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eapple,banana,orange\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-array returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003earr: not an array\u003cbr\u003eSeparator (use {{space}} for space, blank for no separator): ,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Array to Join: chained callback parameter"
      }
    ],
    "help": "Joins the elements of an \u003cem\u003earray\u003c/em\u003e into a single string, with an optional separator between each element.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eJoin with comma\u003c/em\u003e***\u003cbr\u003earr: \u003cstrong\u003e['apple', 'banana', 'orange']\u003c/strong\u003e\u003cbr\u003eSeparator (use {{space}} for space, blank for no separator): \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eapple,banana,orange\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-array returns undefined\u003c/em\u003e***\u003cbr\u003earr: \u003cstrong\u003enot an array\u003c/strong\u003e\u003cbr\u003eSeparator (use {{space}} for space, blank for no separator): \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the joined string before returning it (e.g., \u003ccode\u003estr =\u003e str.toUpperCase()\u003c/code\u003e, \u003ccode\u003estr =\u003e str.trim()\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Joins the elements of an array into a single string, with an optional separator between each element.
 *
 * @param {Array} data.arr - The array of elements to join.
 * @param {string} data.sep - The separator to use between elements.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform arr before joining.
 * 
 * @returns {string|undefined} The joined string if the input is an array, or undefined if the input is not an array.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const join = function(array, separator) {
  if (getType(array) === 'array') {
    return array.join(separator);
  }
  return undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// join - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedArray = applyCast(data.pre, data.arr);
return out(join(processedArray, data.sep));
*/
// ===============================================================================
// join(...) – Apply Mode
// ===============================================================================
return function(value, separator) {
   return out(join(value, data.sep));
};


___TESTS___

scenarios:
  - name: '[example] Join with comma'
    code: |-
      /* @display
      Array to Join: ['apple', 'banana', 'orange']
      Separator (use {{space}} for space, blank for no separator): ,
      @output
      apple,banana,orange
      */
      const arr = ['apple', 'banana', 'orange'];
      const sep = ',';
      const mockData = {
          arr: arr,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, sep);
      }
      assertThat(variableResult).isEqualTo('apple,banana,orange');
  - name: Test joining array with space separator
    code: |-
      const arr = ['Hello', 'World'];
      const sep = ' ';
      const mockData = {
          arr: arr,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, sep);
      }
      assertThat(variableResult).isEqualTo('Hello World');
  - name: Test joining array with no separator (empty string)
    code: |
      const arr = ['a', 'b', 'c'];
      const sep = '';
      const mockData = {
          arr: arr,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, sep);
      }
      assertThat(variableResult).isEqualTo('abc');
  - name: '[example] Non-array returns undefined'
    code: |-
      /* @display
      Array to Join: not an array
      Separator (use {{space}} for space, blank for no separator): ,
      @output
      undefined
      */
      const arr = 'not an array';
      const sep = ',';
      const mockData = {
          arr: arr,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, sep);
      }
      assertThat(variableResult).isUndefined();
  - name: Test joining array with mixed types
    code: |-
      const arr = [1, true, 'text', null];
      const sep = '-';
      const mockData = {
          arr: arr,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, sep);
      }
      assertThat(variableResult).isEqualTo('1-true-text-');
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
