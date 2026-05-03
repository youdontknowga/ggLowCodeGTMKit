___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "percentOf(...)",
  "description": "Calculates what percentage the first value is of the second value. Formula: (firstValue / secondValue) × 100.",
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
        "displayName": "Total Value",
        "simpleValueType": true,
        "help": "💾   The total or base value to compare against.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCalculate percentage\u003c/em\u003e***\u003cbr\u003eInput 1: \u003cstrong\u003e25\u003c/strong\u003e\u003cbr\u003eInput 2: \u003cstrong\u003e100\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e25\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReturns 0 if total is 0\u003c/em\u003e***\u003cbr\u003eInput 1: \u003cstrong\u003e50\u003c/strong\u003e\u003cbr\u003eInput 2: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameters: (Value, Total Value)"
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
            "checkboxText": "⚡Use runtime parameter for: Total Value",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Calculates what percentage the first value is of the second value. Formula: (Value / Total Value) × 100.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCalculate percentage\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e25\u003c/strong\u003e\u003cbr\u003eTotal Value: \u003cstrong\u003e100\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e25\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReturns 0 if total is 0\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e50\u003c/strong\u003e\u003cbr\u003eTotal Value: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str + ' %', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Calculates what percentage the first value is of the second value.
* 
* @param {number|string} data.src - The value to find the percentage for.
* @param {number|string} data.val - The total value.
* @param {Function|string} [data.out] - Optional output handler.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before calculation.
* 
* @returns {number} The calculated percentage, or 0 if inputs are invalid or total is 0.
*
* @framework ggLowCodeGTMKit
*/
const Math = require('Math');
const makeNumber = require('makeNumber');

const percentOf = function(value, totalValue) {
   const val = makeNumber(value);
   const tot = makeNumber(totalValue);
   if (val !== val || tot !== tot) return 0; // Guard against NaN inputs
   if (tot === 0) return 0;
   return Math.round((val / tot) * 100);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// percentOf - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(percentOf(value, data.val));
*/
// ===============================================================================
// percentOf(...) – Apply Mode
// ===============================================================================
return function(value, totalValue) {
   totalValue = data.rp1 ? totalValue : data.val;
   return out(percentOf(value, totalValue));
};


___TESTS___

scenarios:
  - name: '[example] Calculate percentage'
    code: |-
      /* @display
      Value to Process: 25
      Total Value: 100
      @output
      25
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
      assertThat(variableResult).isEqualTo(25);
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
      assertThat(variableResult).isEqualTo(40);
  - name: Returns 0 if total is 0
    code: |
      const src = 50;
      const val = 0;
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
  - name: Rounds to nearest integer
    code: |-
      const src = 1;
      const val = 3;
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
