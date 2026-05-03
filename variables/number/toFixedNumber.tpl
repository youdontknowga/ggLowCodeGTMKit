___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "toFixedNumber",
  "description": "Rounds a \u003cem\u003enumber\u003c/em\u003e to a fixed \u003cem\u003enumber\u003c/em\u003e of decimal places and returns the result as a \u003cem\u003enumber\u003c/em\u003e.",
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
        "displayName": "Number To Round",
        "simpleValueType": true,
        "help": "💾   The number to round to fixed decimal places.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "dec",
        "displayName": "Decimal Places",
        "simpleValueType": true,
        "help": "🎯   Number of decimal places to keep.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Rounds a \u003cem\u003enumber\u003c/em\u003e to a fixed number of decimal places and returns it as a \u003cem\u003enumber\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRound to 2 decimals\u003c/em\u003e***\u003cbr\u003eNumber To Round: \u003cstrong\u003e3.14159\u003c/strong\u003e\u003cbr\u003eDecimal Places: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3.14\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRound to integer\u003c/em\u003e***\u003cbr\u003eNumber To Round: \u003cstrong\u003e10.5\u003c/strong\u003e\u003cbr\u003eDecimal Places: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e11\u003c/strong\u003e"
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
* Rounds a number to a fixed number of decimal places using Math.round.
* 
* @param {number} data.src - The number to round.
* @param {number|string} data.dec - Number of decimal places to keep.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before rounding.
* 
* @returns {number} The rounded number.
*
* @framework ggLowCodeGTMKit
*/
const Math = require('Math');
const makeNumber = require('makeNumber');

const toFixedNumber = function(num, decimals) {
   const numValue = makeNumber(num);
   const decValue = makeNumber(decimals);
   if (numValue !== numValue || decValue !== decValue) { return undefined; }
   const factor = Math.pow(10, decValue);
   return Math.round(numValue * factor) / factor;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// toFixedNumber - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(toFixedNumber(value, data.dec));
// ===============================================================================
// toFixedNumber(...) – Apply Mode
// ===============================================================================
/*
return function(value, decimals) {
   decimals = data.rp1 ? decimals : data.dec;
   return out(toFixedNumber(value, decimals));
};
*/


___TESTS___

scenarios:
  - name: '[example] Round to 2 decimals'
    code: |-
      /* @display
      Number To Round: 3.14159
      Decimal Places: 2
      @output
      3.14
      */
      const src = 3.14159;
      const dec = 2;
      const mockData = {
          src: src,
          dec: dec,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, dec);
      }
      assertThat(variableResult).isEqualTo(3.14);
  - name: '[example] Round to integer'
    code: |-
      /* @display
      Number To Round: 10.5
      Decimal Places: 0
      @output
      11
      */
      const src = 10.5;
      const dec = 0;
      const mockData = {
          src: src,
          dec: dec,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, dec);
      }
      assertThat(variableResult).isEqualTo(11);
  - name: String number converts and rounds
    code: |-
      const src = "7.8956";
      const dec = "1";
      const mockData = {
          src: src,
          dec: dec,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, dec);
      }
      assertThat(variableResult).isEqualTo(7.9);
  - name: Invalid inputs return undefined
    code: |-
      const src = "hello";
      const dec = 2;
      const mockData = {
          src: src,
          dec: dec,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, dec);
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
