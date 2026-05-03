___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "extractNumber()",
  "description": "Extracts the first number found in a \u003cem\u003estring\u003c/em\u003e. Returns \u003cem\u003eundefined\u003c/em\u003e if no number is found.",
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
        "help": "Extracts the first number found in a \u003cem\u003estring\u003c/em\u003e (including decimals and negatives). Returns \u003cem\u003eundefined\u003c/em\u003e if no number is found."
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String To Search"
      }
    ],
    "help": "Extracts the first number found in a \u003cem\u003estring\u003c/em\u003e (including decimals and negatives). Returns \u003cem\u003eundefined\u003c/em\u003e if no number is found.\n\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract integer from text\u003c/em\u003e***\u003cbr\u003eString To Search: \u003cstrong\u003eThe price is 42 dollars\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract decimal number\u003c/em\u003e***\u003cbr\u003eString To Search: \u003cstrong\u003eTemperature is 36.5 degrees\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e36.5\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo numbers returns undefined\u003c/em\u003e***\u003cbr\u003eString To Search: \u003cstrong\u003eNo numbers here\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., num =\u003e Math.round(num) for rounding, num =\u003e num || 0 to default undefined to zero). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Extracts the first number found in a string.
 *
 * @param {string} data.src - The string to search for numbers.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before extracting.
 * 
 * @returns {number|undefined} The first number found, or undefined if no number is found.
 *
 * @framework ggLowCodeGTMKit
 */

const makeNumber = require('makeNumber');

const extractNumber = function(stringToMatch) {
    if (typeof stringToMatch !== 'string') { 
        return undefined; 
    }
    const match = stringToMatch.match("-?\\d+(\\.\\d+)?");
    if (match) {
        return makeNumber(match[0]);
    }
    return undefined;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// extractNumber - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(extractNumber(value));
*/
// ===============================================================================
// extractNumber() – Apply Mode
// ===============================================================================
return function(value) {
   return out(extractNumber(value));
};


___TESTS___

scenarios:
  - name: '[example] Extract integer from text'
    code: |-
      /* @display
      String To Search: The price is 42 dollars
      @output
      42
      */
      const src = 'The price is 42 dollars';
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
      assertThat(variableResult).isEqualTo(42);
  - name: '[example] Extract decimal number'
    code: |-
      /* @display
      String To Search: Temperature is 36.5 degrees
      @output
      36.5
      */
      const src = 'Temperature is 36.5 degrees';
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
      assertThat(variableResult).isEqualTo(36.5);
  - name: String with negative number - should extract negative number
    code: |-
      const src = 'Balance: -150.75 euros';
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
      assertThat(variableResult).isEqualTo(-150.75);
  - name: '[example] No numbers returns undefined'
    code: |-
      /* @display
      String To Search: No numbers here
      @output
      undefined
      */
      const src = 'No numbers here';
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
  - name: Non-string input - should return undefined
    code: |-
      const src = 12345;
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
