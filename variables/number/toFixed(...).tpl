___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "toFixed(...)",
  "description": "Rounds a \u003cem\u003enumber\u003c/em\u003e to a fixed \u003cem\u003enumber\u003c/em\u003e of decimal places using \u003cem\u003eMath.round\u003c/em\u003e. Returns the result as a \u003cem\u003estring\u003c/em\u003e with exact decimal precision.",
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
        "name": "dec",
        "displayName": "Decimal Places",
        "simpleValueType": true,
        "help": "🎯   Number of decimal places to keep.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRound to 2 decimals\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 3.14159\u003cbr\u003eDecimal Places: 2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3.14\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTrailing zeros added\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 10.5\u003cbr\u003eDecimal Places: 3\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e10.500\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Number To Round"
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
            "checkboxText": "⚡Use runtime parameter for: Decimal Places",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Rounds a \u003cem\u003enumber\u003c/em\u003e to a fixed number of decimal places.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRound to 2 decimals\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e3.14159\u003c/strong\u003e\u003cbr\u003eDecimal Places: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3.14\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTrailing zeros added\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e10.5\u003c/strong\u003e\u003cbr\u003eDecimal Places: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e10.500\u003c/strong\u003e"
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
* @returns {string} The rounded number as a string with fixed decimals.
*
* @framework ggLowCodeGTMKit
*/
const Math = require('Math');
const makeNumber = require('makeNumber');

const toFixed = function(num, decimals) {
   const numValue = makeNumber(num);
   const decValue = makeNumber(decimals);
   const factor = Math.pow(10, decValue);
   const rounded = Math.round(numValue * factor) / factor;
   const parts = rounded.toString().split('.');
   const integerPart = parts[0];
   let decimalPart = parts[1] || '';
   while (decimalPart.length < decValue) {
       decimalPart += '0';
   }
   if (decValue === 0) {
       return integerPart;
   }
   return integerPart + '.' + decimalPart;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// toFixed - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(toFixed(value, data.dec));
*/
// ===============================================================================
// toFixed(...) – Apply Mode
// ===============================================================================
return function(value, decimals) {
   decimals = data.rp1 ? data.dec : decimals;
   return out(toFixed(value, decimals));
};


___TESTS___

scenarios:
  - name: '[example] Round to 2 decimals'
    code: |-
      /* @display
      Value to Process: 3.14159
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
      assertThat(variableResult).isEqualTo("3.14");
  - name: Valid number with 0 decimal places - returns integer
    code: |-
      const src = 5.789;
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
      assertThat(variableResult).isEqualTo("6");
  - name: '[example] Trailing zeros added'
    code: |-
      /* @display
      Value to Process: 10.5
      Decimal Places: 3
      @output
      10.500
      */
      const src = 10.5;
      const dec = 3;
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
      assertThat(variableResult).isEqualTo("10.500");
  - name: String number with decimal places - converts and rounds
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
      assertThat(variableResult).isEqualTo("7.9");
  - name: Integer with decimal places - adds decimal point and zeros
    code: |-
      const src = 42;
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
      assertThat(variableResult).isEqualTo("42.00");
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
