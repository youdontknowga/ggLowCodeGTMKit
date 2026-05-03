___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "parseIntValue()",
  "description": "Attempts to convert a given value into an \u003cem\u003einteger\u003c/em\u003e. It extracts the numeric part from the start of the string and stops when it encounters a non-numeric character.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse integer string\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDecimal truncated to integer\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e3.14\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-numeric returns NaN\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eabc123\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Value To Convert"
      }
    ],
    "help": "Converts a value to an \u003cem\u003einteger\u003c/em\u003e. Extracts the numeric part from the start of a string.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse integer string\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDecimal truncated to integer\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e3.14\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-numeric returns NaN\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eabc123\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., num =\u003e num || 0 to default NaN to 0, num =\u003e Math.abs(num) for absolute value). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Attempts to convert a given value into an integer.
 * It extracts the numeric part from the start of the string and stops when it encounters a non-numeric character.
 *
 * @param {any} data.src - The value to be converted to an integer.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before parsing.
 * 
 * @returns {number} The parsed integer, or NaN if the value cannot be converted.
 *
 * @framework ggLowCodeGTMKit
 */

const makeInteger = require('makeInteger');
const getType = require('getType');

const parseIntValue = function(input) {
    const safeNaN = 0/0;
    if (input == null) { 
        return safeNaN; 
    }
    const inputString = input.toString();
    if (getType(inputString.match("^(\\d+)")) !== "null") {
        return makeInteger(inputString.match("^(\\d+)")[0]);
    }
    return safeNaN;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// parseIntValue - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(parseIntValue(value));
*/
// ===============================================================================
// parseIntValue() – Apply Mode
// ===============================================================================
return function(value) {
   return out(parseIntValue(value));
};


___TESTS___

scenarios:
  - name: '[example] Parse integer string'
    code: |-
      /* @display
      Value to Process: 42
      @output
      42
      */
      const src = '42';
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
  - name: String starting with number - should extract leading digits
    code: |-
      const src = '123abc456';
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
      assertThat(variableResult).isEqualTo(123);
  - name: '[example] Decimal truncated to integer'
    code: |-
      /* @display
      Value to Process: 3.14
      @output
      3
      */
      const src = '3.14';
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
      assertThat(variableResult).isEqualTo(3);
  - name: '[example] Non-numeric returns NaN'
    code: |-
      /* @display
      Value to Process: abc123
      @output
      true
      */
      const src = 'abc123';
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
      assertThat(variableResult !== variableResult).isTrue();
  - name: Null input - should return NaN
    code: |-
      const src = null;
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
      assertThat(variableResult !== variableResult).isTrue();
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
