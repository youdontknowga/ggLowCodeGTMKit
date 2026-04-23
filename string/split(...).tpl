___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "split(...)",
  "description": "Splits a \u003cem\u003estring\u003c/em\u003e  into an \u003cem\u003earray\u003c/em\u003e  of substrings based on a delimiter, with an optional limit on the number of substrings.",
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
        "name": "del",
        "displayName": "Delimiter",
        "simpleValueType": true,
        "help": "✂️   The delimiter used to split the string.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "lim",
        "displayName": "Limit",
        "simpleValueType": true,
        "help": "🎯   The maximum number of substrings to return (optional).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp2",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit by comma\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: apple,banana,cherry\u003cbr\u003eDelimiter: ,\u003cbr\u003eLimit: undefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['apple', 'banana', 'cherry']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit with limit\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello world from paris\u003cbr\u003eDelimiter:  \u003cbr\u003eLimit: 2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['hello', 'world']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns empty array\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 12345\u003cbr\u003eDelimiter: ,\u003cbr\u003eLimit: undefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 String To Split: \u003cem\u003echained callback parameter\u003c/em\u003e \u003cbr\u003e"
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
            "checkboxText": "⚡Use runtime parameter for: Delimiter",
            "simpleValueType": true
          },
          {
            "type": "CHECKBOX",
            "name": "rp2",
            "checkboxText": "⚡Use runtime parameter for: Limit",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Splits a \u003cem\u003estring\u003c/em\u003e into an array of substrings based on a delimiter, with an optional limit on the number of substrings.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit by comma\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eapple,banana,cherry\u003c/strong\u003e\u003cbr\u003eDelimiter: \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003eLimit: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['apple', 'banana', 'cherry']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit with limit\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world from paris\u003c/strong\u003e\u003cbr\u003eDelimiter: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003eLimit: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['hello', 'world']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns empty array\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003eDelimiter: \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003eLimit: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., arr =\u003e arr.map(s =\u003e s.trim()), arr =\u003e arr.filter(s =\u003e s.length \u003e 0) for filtering empty strings). Useful for chaining transformations on the output."
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
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(split(value, data.del, data.lim));
*/
// ===============================================================================
// split(...) – Apply Mode
// ===============================================================================
return function(value, delimiter, limit) {
   delimiter = data.rp1 ? data.del : delimiter;
   limit = data.rp2 ? data.lim : limit;
   return out(split(value, delimiter, limit));
};


___TESTS___

scenarios:
  - name: '[example] Split by comma'
    code: |-
      /* @display
      Value to Process: apple,banana,cherry
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
      Value to Process: hello world from paris
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
      Value to Process: 12345
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
