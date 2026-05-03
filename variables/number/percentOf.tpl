___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "percentOf",
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
        "name": "src",
        "displayName": "Value",
        "simpleValueType": true,
        "help": "💾   The value you want to find the percentage for.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "val",
        "displayName": "Total Value",
        "simpleValueType": true,
        "help": "💾   The total or base value to compare against.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Calculates what percentage the first value is of the second value. Formula: (Value / Total Value) × 100.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCalculate percentage\u003c/em\u003e***\u003cbr\u003eValue: \u003cstrong\u003e25\u003c/strong\u003e\u003cbr\u003eTotal Value: \u003cstrong\u003e100\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e25\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReturns 0 if total is 0\u003c/em\u003e***\u003cbr\u003eValue: \u003cstrong\u003e50\u003c/strong\u003e\u003cbr\u003eTotal Value: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e"
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
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(percentOf(value, data.val));
// ===============================================================================
// percentOf(...) – Apply Mode
// ===============================================================================
/*
return function(value, totalValue) {
   totalValue = data.rp1 ? totalValue : data.val;
   return out(percentOf(value, totalValue));
};
*/


___TESTS___

scenarios:
  - name: '[example] Calculate percentage'
    code: |-
      /* @display
      Value: 25
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
