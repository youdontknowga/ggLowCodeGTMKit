___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "divide",
  "description": "Divides the numerator by the denominator and returns the result. Returns undefined if inputs are invalid or division by zero.",
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
        "displayName": "Numerator",
        "simpleValueType": true,
        "help": "💾   The number to divide (dividend).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "div",
        "displayName": "Denominator",
        "simpleValueType": true,
        "help": "💾   The number to divide by (divisor).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Divides the numerator by the denominator. Returns \u003cem\u003eundefined\u003c/em\u003e for division by zero.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSimple division\u003c/em\u003e***\u003cbr\u003eNumerator: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003eDenominator: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDivision by zero returns undefined\u003c/em\u003e***\u003cbr\u003eNumerator: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003eDenominator: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
* Divides the numerator by the denominator and returns the result.
* 
* @param {*} data.src - The number to divide (dividend).
* @param {*} data.div - The number to divide by (divisor).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before division.
* 
* @returns {number|undefined} The result of the division, or undefined if invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const divide = function(numerator, denominator) {
   const num = makeNumber(numerator);
   const den = makeNumber(denominator);
   if (num === num && den === den && den !== 0) {
       return num / den;
   }
   return undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// divide - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(divide(value, data.div));
// ===============================================================================
// divide(...) – Apply Mode
// ===============================================================================
/*
return function(value, denominator) {
   denominator = data.rp1 ? data.div : denominator;
   return out(divide(value, denominator));
};
*/


___TESTS___

scenarios:
  - name: '[example] Simple division'
    code: |-
      /* @display
      Numerator: 10
      Denominator: 2
      @output
      5
      */
      const src = 10;
      const div = 2;
      const mockData = {
          src: src,
          div: div,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, div);
      }
      assertThat(variableResult).isEqualTo(5);
  - name: String numbers - converts and divides
    code: |-
      const src = "20";
      const div = "4";
      const mockData = {
          src: src,
          div: div,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, div);
      }
      assertThat(variableResult).isEqualTo(5);
  - name: Decimal result - returns decimal
    code: |-
      const src = 7;
      const div = 2;
      const mockData = {
          src: src,
          div: div,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, div);
      }
      assertThat(variableResult).isEqualTo(3.5);
  - name: '[example] Division by zero returns undefined'
    code: |-
      /* @display
      Numerator: 10
      Denominator: 0
      @output
      undefined
      */
      const src = 10;
      const div = 0;
      const mockData = {
          src: src,
          div: div,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, div);
      }
      assertThat(variableResult).isUndefined();
  - name: Invalid input - returns undefined
    code: |-
      const src = "not a number";
      const div = 5;
      const mockData = {
          src: src,
          div: div,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, div);
      }
      assertThat(variableResult).isUndefined();
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
