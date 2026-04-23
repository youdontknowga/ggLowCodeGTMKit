___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "calculateDiffRatio",
  "description": "Calculates the ratio of the difference between two values relative to the first value. Formula: \u003cem\u003e(value - reference) / value\u003c/em\u003e. Useful for margin, discount rate, and proportional difference.",
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
        "displayName": "Value",
        "simpleValueType": true,
        "help": "💾 The base value to use as the denominator and minuend (e.g., price, original value).\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e: \u003cem\u003e100\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eStringified Number\u003c/strong\u003e: \u003cem\u003e\"100\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eVariable\u003c/strong\u003e: \u003cem\u003e{{price}}\u003c/em\u003e",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "ref",
        "displayName": "Reference Value",
        "simpleValueType": true,
        "help": "💾 The value to subtract from the base value (e.g., cost, sale price).\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e: \u003cem\u003e60\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eStringified Number\u003c/strong\u003e: \u003cem\u003e\"60\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eVariable\u003c/strong\u003e: \u003cem\u003e{{cost}}\u003c/em\u003e",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "enablingConditions": []
      }
    ],
    "help": "Calculates the ratio of the difference between two values. Formula: (value - reference) / value.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMargin calculation\u003c/em\u003e***\u003cbr\u003emockData: \u003cstrong\u003e{src: 100, ref: 60}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0.4\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eZero base returns undefined\u003c/em\u003e***\u003cbr\u003emockData: \u003cstrong\u003e{src: 0, ref: 60}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the base value before calculating."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., \u003ccode\u003ex =\u003e x * 100\u003c/code\u003e to convert to percentage, \u003ccode\u003ex =\u003e (x * 100).toFixed(2)\u003c/code\u003e for formatted percentage)."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Calculates the ratio of the difference between two values relative to the first value.
 * Formula: (value - reference) / value
 * Useful for margin, discount rate, and other proportional difference calculations.
 *
 * @param {number} data.src - The base value (e.g., price, current value).
 * @param {number} data.ref - The reference value to subtract (e.g., cost, sale price).
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function.
 *
 * @returns {number|undefined} The ratio (src - ref) / src, or undefined if inputs are invalid.
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');
const calculateDiffRatio = function(value, reference) {
    const v = makeNumber(value);
    const r = makeNumber(reference);
    if (typeof v !== 'number' || v !== v) return undefined;
    if (typeof r !== 'number' || r !== r) return undefined;
    if (v === 0) return undefined;
    return (v - r) / v;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// calculateDiffRatio - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(calculateDiffRatio(value, data.ref));
// ===============================================================================
// calculateDiffRatio(...) – Apply Mode
// ===============================================================================
/*
return function(value, reference) {
    reference = data.rp1 ? data.ref : reference;
    return out(calculateDiffRatio(value, reference));
};
*/


___TESTS___

scenarios:
  - name: '[example] Margin calculation'
    code: |-
      /* @display
      Value: 100
      Reference Value: 60
      @output
      0.4
      */
      const mockData = {src: 100, ref: 60};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(100, 60);
      }
      assertThat(variableResult).isEqualTo(0.4); // (100 - 60) / 100
  - name: Discount rate
    code: |-
      const mockData = {src: 200, ref: 150};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(200, 150);
      }
      assertThat(variableResult).isEqualTo(0.25); // (200 - 150) / 200
  - name: Stringified numbers are converted
    code: |-
      const mockData = {src: '100', ref: '60'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('100', '60');
      }
      assertThat(variableResult).isEqualTo(0.4);
  - name: '[example] Zero base returns undefined'
    code: |
      /* @display
      Value: 0
      Reference Value: 60
      @output
      undefined
      */
      const mockData = {src: 0, ref: 60};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(0, 60);
      }
      assertThat(variableResult).isUndefined();
  - name: Invalid src returns undefined
    code: |
      const mockData = {src: 'invalid', ref: 60};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('invalid', 60);
      }
      assertThat(variableResult).isUndefined();
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
