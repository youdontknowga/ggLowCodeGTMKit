___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "parseFloatValue",
  "description": "Attempts to convert a given value into a floating-point \u003cem\u003enumber\u003c/em\u003e. It extracts the numeric part from the start of the string and stops when it encounters a non-numeric character.",
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
        "displayName": "Value To Convert",
        "simpleValueType": true,
        "help": "Converts a value to a floating-point \u003cem\u003enumber\u003c/em\u003e. Extracts the numeric part from the start of a string.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse float string\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e3.14\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3.14\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract leading number\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e12.5abc\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12.5\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-numeric returns NaN\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eabc123\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
      }
    ],
    "help": "Attempts to convert a given value into a floating-point \u003cem\u003enumber\u003c/em\u003e. It extracts the numeric part from the start of the string and stops when it encounters a non-numeric character.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse float string\u003c/em\u003e***\u003cbr\u003eValue To Convert: \u003cstrong\u003e3.14\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3.14\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract leading number\u003c/em\u003e***\u003cbr\u003eValue To Convert: \u003cstrong\u003e12.5abc\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12.5\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-numeric returns NaN\u003c/em\u003e***\u003cbr\u003eValue To Convert: \u003cstrong\u003eabc123\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
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
 * Attempts to convert a given value into a floating-point number.
 * It extracts the numeric part from the start of the string and stops when it encounters a non-numeric character.
 *
 * @param {any} data.src - The value to be converted to a float.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before parsing.
 * 
 * @returns {number} The parsed floating-point number, or NaN if the value cannot be converted.
 *
 * @framework ggLowCodeGTMKit
 */

const makeNumber = require('makeNumber');
const getType = require('getType');

const parseFloatValue = function(input) {
    const safeNaN = 0/0;
    if (input == null) { 
        return safeNaN; 
    }
    const inputString = input.toString();
    if (getType(inputString.match("^(\\d+\\.?\\d*)")) !== "null") {
        return makeNumber(inputString.match("^(\\d+\\.?\\d*)")[0]);
    }
    return safeNaN;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// parseFloatValue - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(parseFloatValue(value));

// ===============================================================================
// parseFloatValue() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(parseFloatValue(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Parse float string'
    code: |-
      /* @display
      Value To Convert: 3.14
      @output
      3.14
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
      assertThat(variableResult).isEqualTo(3.14);
  - name: '[example] Extract leading number'
    code: |-
      /* @display
      Value To Convert: 12.5abc
      @output
      12.5
      */
      const src = '12.5abc';
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
      assertThat(variableResult).isEqualTo(12.5);
  - name: Integer string - should parse to integer (as float)
    code: |-
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
  - name: '[example] Non-numeric returns NaN'
    code: |
      /* @display
      Value To Convert: abc123
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
