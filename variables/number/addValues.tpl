___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "addValues",
  "description": "Add one number (addend) to another (augend). Returns \u003cem\u003eundefined\u003c/em\u003e if either input is not a valid \u003cem\u003enumber\u003c/em\u003e.",
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
        "displayName": "First Number",
        "simpleValueType": true,
        "help": "💾   The first number (the base value to add to).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "add",
        "displayName": "Second Number",
        "simpleValueType": true,
        "help": "💾   The second number (the value to add).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Adds two \u003cem\u003enumber\u003c/em\u003e values and returns the sum. Returns \u003cem\u003eundefined\u003c/em\u003e if inputs are invalid.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid input returns undefined\u003c/em\u003e***\u003cbr\u003eFirst Number: \u003cstrong\u003e50\u003c/strong\u003e\u003cbr\u003eSecond Number: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert string to number, apply transformations). Internal transformations such as number conversion will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., num =\u003e num.toFixed(2), val =\u003e val + ' total' for formatting). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Adds two numbers and returns the result.
* 
* @param {*} data.src - The first number (the base value to add to).
* @param {*} data.add - The second number (the value to add).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before addition.
* 
* @returns {number|undefined} The result of the addition, or undefined if invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const addition = function(augend, addend) {
   const num1 = makeNumber(augend);
   const num2 = makeNumber(addend);
   if (num1 === num1 && num2 === num2) {
       return num1 + num2;
   }
   return undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// addition - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(addition(value, data.add));
// ===============================================================================
// addition(...) – Apply Mode
// ===============================================================================
/*
return function(value, addend) {
   addend = data.rp1 ? data.add : addend;
   return out(addition(value, addend));
};
*/


___TESTS___

scenarios:
  - name: Valid numbers addition - returns sum
    code: |-
      const src = 10;
      const add = 5;
      const mockData = {
          src: src,
          add: add,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult).isEqualTo(15);
  - name: String numbers addition - converts and adds
    code: |-
      const src = "25";
      const add = "15";
      const mockData = {
          src: src,
          add: add,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult).isEqualTo(40);
  - name: Negative numbers addition - handles negative values
    code: |-
      const src = -10;
      const add = 25;
      const mockData = {
          src: src,
          add: add,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult).isEqualTo(15);
  - name: Invalid first parameter - returns undefined
    code: |-
      const src = "not a number";
      const add = 10;
      const mockData = {
          src: src,
          add: add,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult).isUndefined();
  - name: '[example] Invalid input returns undefined'
    code: |-
      /* @display
      First Number: 50
      Second Number: undefined
      @output
      undefined
      */
      const src = 50;
      const add = undefined;
      const mockData = {
          src: src,
          add: add,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
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
