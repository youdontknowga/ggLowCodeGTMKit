___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "left",
  "description": "Returns a substring from the start of a specified \u003cem\u003estring\u003c/em\u003e, extracting the specified number of characters from the left.",
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
        "displayName": "Source String",
        "simpleValueType": true,
        "help": "Returns a substring from the start of a specified \u003cem\u003estring\u003c/em\u003e, extracting the specified number of characters from the left.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract first 5 characters\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eSource String: Hello World\u003cbr\u003eNumber of Characters: 5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCount exceeds string length\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eSource String: Hello\u003cbr\u003eNumber of Characters: 10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eSource String: 12345\u003cbr\u003eNumber of Characters: 3\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "num",
        "displayName": "Number of Characters",
        "simpleValueType": true,
        "help": "🎯   The number of characters to extract from the left side of the string (default is 1).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Returns a substring from the start of a specified \u003cem\u003estring\u003c/em\u003e, extracting the specified number of characters from the left.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract first 5 characters\u003c/em\u003e***\u003cbr\u003eSource String: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003eNumber of Characters: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCount exceeds string length\u003c/em\u003e***\u003cbr\u003eSource String: \u003cstrong\u003eHello\u003c/strong\u003e\u003cbr\u003eNumber of Characters: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input\u003c/em\u003e***\u003cbr\u003eSource String: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003eNumber of Characters: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., normalize case, trim whitespace). Internal transformations such as string validation will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toUpperCase(), val =\u003e val + ' extracted' for string modifications). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Returns a substring from the start of a specified string.
 * 
 * @param {string} data.src - The string from which to extract the left portion.
 * @param {number|string} data.num - The number of characters to extract from the left side of the string (default is 1).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before extraction.
 * 
 * @returns {string} The left portion of the string, or an empty string if num is 0.
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');
const left = function(searchData, numCharacters) {
    const numChars = numCharacters !== undefined ? makeNumber(numCharacters) : 1;
    if (typeof searchData !== 'string' || typeof numChars !== 'number' || numChars <= 0) {
        return '';
    }
    return searchData.slice(0, numChars);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// left - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(left(value, data.num));
// ===============================================================================
// left(...) – Apply Mode
// ===============================================================================
/*
return function(value, numCharacters) {
  numCharacters = data.rp1 ? data.num : numCharacters;
  return out(left(value, numCharacters));
};
*/


___TESTS___

scenarios:
  - name: '[example] Extract first 5 characters'
    code: |-
      /* @display
      Source String: Hello World
      Number of Characters: 5
      @output
      Hello
      */
      const src = 'Hello World';
      const num = 5;
      const mockData = {
          src: src,
          num: num,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, num);
      }
      assertThat(variableResult).isEqualTo('Hello');
  - name: Default behavior (1 character when num is undefined)
    code: |-
      const src = 'Hello World';
      const num = undefined;
      const mockData = {
          src: src,
          num: num,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, num);
      }
      assertThat(variableResult).isEqualTo('H');
  - name: Extract 0 characters (returns empty string)
    code: |-
      const src = 'Hello World';
      const num = 0;
      const mockData = {
          src: src,
          num: num,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, num);
      }
      assertThat(variableResult).isEqualTo('');
  - name: '[example] Count exceeds string length'
    code: |-
      /* @display
      Source String: Hello
      Number of Characters: 10
      @output
      Hello
      */
      const src = 'Hello';
      const num = 10;
      const mockData = {
          src: src,
          num: num,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, num);
      }
      assertThat(variableResult).isEqualTo('Hello');
  - name: String number parameter
    code: |
      const src = 'Hello World';
      const num = '3';
      const mockData = {
          src: src,
          num: num,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, num);
      }
      assertThat(variableResult).isEqualTo('Hel');
  - name: Empty string input
    code: |-
      const src = '';
      const num = 5;
      const mockData = {
          src: src,
          num: num,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, num);
      }
      assertThat(variableResult).isEqualTo('');
  - name: '[example] Non-string input'
    code: |-
      /* @display
      Source String: 12345
      Number of Characters: 3
      */
      const src = 12345;
      const num = 3;
      const mockData = {
          src: src,
          num: num,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, num);
      }
      assertThat(variableResult).isEqualTo('');
  - name: Negative number (returns empty string)
    code: |-
      const src = 'Hello World';
      const num = -3;
      const mockData = {
          src: src,
          num: num,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, num);
      }
      assertThat(variableResult).isEqualTo('');
  - name: UI-bound mode with static num
    code: |-
      const src = 'Hello World';
      const num = 999;
      const mockData = {
          src: src,
          num: 7,
          rp1: true
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, num);
      }
      assertThat(variableResult).isEqualTo('Hello W');
  - name: Single character extraction
    code: |-
      const src = 'A';
      const num = 1;
      const mockData = {
          src: src,
          num: num,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, num);
      }
      assertThat(variableResult).isEqualTo('A');
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
