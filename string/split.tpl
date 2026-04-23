___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "split",
  "description": "Splits a \u003cem\u003estring\u003c/em\u003e  into an array of substrings based on a delimiter, with an optional limit on the number of substrings.",
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
        "displayName": "String To Split",
        "simpleValueType": true,
        "help": "💾   The string to split into substrings.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "del",
        "displayName": "Delimiter",
        "simpleValueType": true,
        "help": "✂️   The delimiter used to split the string.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "lim",
        "displayName": "Limit",
        "simpleValueType": true,
        "help": "🎯   The maximum number of substrings to return (optional).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Splits a \u003cem\u003estring\u003c/em\u003e into an array of substrings based on a delimiter, with an optional limit on the number of substrings.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit by comma\u003c/em\u003e***\u003cbr\u003eString To Split: \u003cstrong\u003eapple,banana,cherry\u003c/strong\u003e\u003cbr\u003eDelimiter: \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003eLimit: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['apple', 'banana', 'cherry']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit with limit\u003c/em\u003e***\u003cbr\u003eString To Split: \u003cstrong\u003ehello world from paris\u003c/strong\u003e\u003cbr\u003eDelimiter: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003eLimit: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['hello', 'world']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns empty array\u003c/em\u003e***\u003cbr\u003eString To Split: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003eDelimiter: \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003eLimit: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
 * Splits a string into substrings based on a delimiter, with an optional limit on the number of substrings.
 * 
 * @param {string} data.src - The string to split.
 * @param {string} data.del - The delimiter used to split the string.
 * @param {number|string} data.lim - The maximum number of substrings to return (optional).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before splitting.
 * 
 * @returns {Array} Returns an array of substrings, or an empty array if input is invalid.
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');

const split = function(input, delimiter, limit) {
    if (typeof input !== 'string') return [];
    if (limit !== undefined) {
        const limitNum = makeNumber(limit);
        if (limitNum !== limitNum || limitNum < 0) return []; // NaN check and negative check
        return input.split(delimiter, limitNum);
    }
    return input.split(delimiter);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// split - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(split(value, data.del, data.lim));
// ===============================================================================
// split(...) – Apply Mode
// ===============================================================================
/*
return function(value, delimiter, limit) {
   delimiter = data.rp1 ? data.del : delimiter;
   limit = data.rp2 ? data.lim : limit;
   return out(split(value, delimiter, limit));
};
*/


___TESTS___

scenarios:
  - name: '[example] Split by comma'
    code: |-
      /* @display
      String To Split: apple,banana,cherry
      Delimiter: ,
      Limit: undefined
      @output
      ['apple', 'banana', 'cherry']
      */
      const src = 'apple,banana,cherry';
      const del = ',';
      const lim = undefined;
      const mockData = {
          src: src,
          del: del,
          lim: lim,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, del, lim);
      }
      assertThat(variableResult).isEqualTo(['apple', 'banana', 'cherry']);
  - name: '[example] Split with limit'
    code: |-
      /* @display
      String To Split: hello world from paris
      Delimiter:  
      Limit: 2
      @output
      ['hello', 'world']
      */
      const src = 'hello world from paris';
      const del = ' ';
      const lim = 2;
      const mockData = {
          src: src,
          del: del,
          lim: lim,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, del, lim);
      }
      assertThat(variableResult).isEqualTo(['hello', 'world']);
  - name: String with no delimiter found - should return array with original string
    code: |-
      const src = 'hello';
      const del = ',';
      const lim = undefined;
      const mockData = {
          src: src,
          del: del,
          lim: lim,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, del, lim);
      }
      assertThat(variableResult).isEqualTo(['hello']);
  - name: Empty string - should return array with empty string
    code: |
      const src = '';
      const del = ',';
      const lim = undefined;
      const mockData = {
          src: src,
          del: del,
          lim: lim,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, del, lim);
      }
      assertThat(variableResult).isEqualTo(['']);
  - name: '[example] Non-string input returns empty array'
    code: |-
      /* @display
      String To Split: 12345
      Delimiter: ,
      Limit: undefined
      @output
      []
      */
      const src = 12345;
      const del = ',';
      const lim = undefined;
      const mockData = {
          src: src,
          del: del,
          lim: lim,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, del, lim);
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
