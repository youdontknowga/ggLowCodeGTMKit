___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "calculateRatioPercentage(...)",
  "description": "Calculates the percentage ratio of the first value to the difference between two values. Formula: (firstValue / (secondValue - firstValue)) × 100, rounded to nearest integer.",
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
        "name": "val",
        "displayName": "Second Value",
        "simpleValueType": true,
        "help": "💾   The second value (comparison value).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCalculate ratio percentage\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 25\u003cbr\u003eSecond Value: 100\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e33\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEqual values return 0\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 100\u003cbr\u003eSecond Value: 100\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: First Value"
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
            "checkboxText": "⚡Use runtime parameter for: Second Value",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Calculates the percentage ratio. Formula: (firstValue / (secondValue - firstValue)) × 100.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCalculate ratio percentage\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e25\u003c/strong\u003e\u003cbr\u003eSecond Value: \u003cstrong\u003e100\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e33\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEqual values return 0\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e100\u003c/strong\u003e\u003cbr\u003eSecond Value: \u003cstrong\u003e100\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e"
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
* Calculates the percentage ratio of the first value to the difference between two values.
* 
* @param {number|string} data.src - The first value (base value).
* @param {number|string} data.val - The second value (comparison value).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before calculation.
* 
* @returns {number} Rounded percentage from value difference, or 0 if invalid.
*
* @framework ggLowCodeGTMKit
*/
const Math = require('Math');
const makeNumber = require('makeNumber');

const calculateRatioPercentage = function(firstValue, secondValue) {
   const val = makeNumber(firstValue);
   const val = makeNumber(secondValue);
   if (val !== val || val !== val) return 0; // Guard against NaN inputs
   if (val <= val) return 0;
   return Math.round((100 * val) / (val - val));
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// calculateRatioPercentage - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(calculateRatioPercentage(value, data.val));
*/
// ===============================================================================
// calculateRatioPercentage(...) – Apply Mode
// ===============================================================================
return function(value, secondValue) {
   secondValue = data.rp1 ? data.val : secondValue;
   return out(calculateRatioPercentage(value, secondValue));
};


___TESTS___

scenarios:
  - name: '[example] Calculate ratio percentage'
    code: |-
      /* @display
      Value to Process: 25
      Second Value: 100
      @output
      33
      */
      const src = 25;
      const val = 100;
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo(33);
  - name: String numbers - converts and calculates
    code: |-
      const src = "20";
      const val = "50";
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo(67);
  - name: Second value less than or equal to first - returns 0
    code: |
      const src = 50;
      const val = 30;
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: '[example] Equal values return 0'
    code: |-
      /* @display
      Value to Process: 100
      Second Value: 100
      @output
      0
      */
      const src = 100;
      const val = 100;
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Invalid input - returns 0
    code: |-
      const src = "not a number";
      const val = 100;
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Invalid inputs - returns 0
    code: |-
      const src = "not a number";
      const val = "not a number";
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo(0);
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
