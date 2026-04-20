___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "subtractValues(...)",
  "description": "Subtracts the subtrahend from the minuend and returns the result. Returns \u003cem\u003eundefined\u003c/em\u003e if either input is not a valid \u003cem\u003enumber\u003c/em\u003e.",
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
        "name": "sub",
        "displayName": "Subtrahend (Amount)",
        "simpleValueType": true,
        "help": "💾   The number to subtract (amount to remove).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eStringified Number\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSimple subtraction\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003emin: 10\u003cbr\u003eSubtrahend (Amount): 3\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e7\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString numbers subtracted\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003emin: 20\u003cbr\u003eSubtrahend (Amount): 8\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003emin: hello\u003cbr\u003eSubtrahend (Amount): 5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Minuend"
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
            "checkboxText": "⚡Use runtime parameter for: Second Number",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Subtracts one \u003cem\u003enumber\u003c/em\u003e from another. Returns \u003cem\u003eundefined\u003c/em\u003e if invalid.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSimple subtraction\u003c/em\u003e***\u003cbr\u003emin: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003eSubtrahend (Amount): \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e7\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString numbers subtracted\u003c/em\u003e***\u003cbr\u003emin: \u003cstrong\u003e20\u003c/strong\u003e\u003cbr\u003eSubtrahend (Amount): \u003cstrong\u003e8\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid returns undefined\u003c/em\u003e***\u003cbr\u003emin: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003eSubtrahend (Amount): \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., val =\u003e Math.round(val), val =\u003e val.toFixed(2) for decimal places). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Subtracts the subtrahend from the minuend and returns the result.
 *
 * @param {*} data.min - The number to subtract from (the starting value).
 * @param {*} data.sub - The number to subtract (the amount to remove).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform min before calculation.
 * 
 * @returns {number|undefined} The result of the subtraction, or undefined if either input is not a valid number.
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');

const subtractValues = function(minuend, subtrahend) {
    const min = makeNumber(minuend);
    const sub = makeNumber(subtrahend);
    if (min === min && sub === sub) {
        return min - sub;
    }
    return undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// subtractValues - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedMinuend = applyCast(data.pre, data.min);
return out(subtractValues(processedMinuend, data.sub));
*/
// ===============================================================================
// subtractValues(...) – Apply Mode
// ===============================================================================
return function(value, subtrahend) {
   subtrahend = data.rp1 ? data.sub : subtrahend;
   return out(subtractValues(value, subtrahend));
};


___TESTS___

scenarios:
  - name: '[example] Simple subtraction'
    code: |-
      /* @display
      min: 10
      Subtrahend (Amount): 3
      @output
      7
      */
      const min = 10;
      const sub = 3;
      const mockData = {
          min: min,
          sub: sub,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(min, sub);
      }
      assertThat(variableResult).isEqualTo(7);
  - name: Negative result - should return negative difference
    code: |-
      const min = 5;
      const sub = 10;
      const mockData = {
          min: min,
          sub: sub,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(min, sub);
      }
      assertThat(variableResult).isEqualTo(-5);
  - name: '[example] String numbers subtracted'
    code: |
      /* @display
      min: 20
      Subtrahend (Amount): 8
      @output
      12
      */
      const min = '20';
      const sub = '8';
      const mockData = {
          min: min,
          sub: sub,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(min, sub);
      }
      assertThat(variableResult).isEqualTo(12);
  - name: Decimal numbers - should handle decimals
    code: |-
      const min = 10.5;
      const sub = 3.2;
      const mockData = {
          min: min,
          sub: sub,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(min, sub);
      }
      assertThat(variableResult).isEqualTo(7.3);
  - name: '[example] Invalid returns undefined'
    code: |-
      /* @display
      min: hello
      Subtrahend (Amount): 5
      @output
      undefined
      */
      const min = 'hello';
      const sub = 5;
      const mockData = {
          min: min,
          sub: sub,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(min, sub);
      }
      assertThat(variableResult).isUndefined();
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'apply';
  // ==========================================================a=========================================
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
