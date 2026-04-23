___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "multiply",
  "description": "Multiplies two numbers and returns the result. Returns undefined if inputs are not valid \u003cem\u003enumber\u003c/em\u003e values.",
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
        "help": "💾   The first number to multiply.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "mul",
        "displayName": "Second Number",
        "simpleValueType": true,
        "help": "💾   The second number to multiply.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Multiplies two \u003cem\u003enumbers\u003c/em\u003e and returns the product. Returns \u003cem\u003eundefined\u003c/em\u003e if invalid.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMultiply positive numbers\u003c/em\u003e***\u003cbr\u003eFirst Number: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003eSecond Number: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e15\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString numbers multiplied\u003c/em\u003e***\u003cbr\u003eFirst Number: \u003cstrong\u003e6\u003c/strong\u003e\u003cbr\u003eSecond Number: \u003cstrong\u003e7\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid returns undefined\u003c/em\u003e***\u003cbr\u003eFirst Number: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003eSecond Number: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
* Multiplies two numbers and returns the result.
* 
* @param {*} data.src - The first number to multiply.
* @param {*} data.mul - The second number to multiply.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before multiplication.
* 
* @returns {number|undefined} The result of the multiplication, or undefined if inputs are invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const multiply = function(num1, num2) {
   const number1 = makeNumber(num1);
   const number2 = makeNumber(num2);
   if (number1 === number1 && number2 === number2) {
       return number1 * number2;
   }
   return undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// multiply - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(multiply(value, data.mul));
// ===============================================================================
// multiply(...) – Apply Mode
// ===============================================================================
/*
return function(value, multiplier) {
   multiplier = data.rp1 ? data.mul : multiplier;
   return out(multiply(value, multiplier));
};
*/


___TESTS___

scenarios:
  - name: '[example] Multiply positive numbers'
    code: |-
      /* @display
      First Number: 5
      Second Number: 3
      @output
      15
      */
      const src = 5;
      const mul = 3;
      const mockData = {
          src: src,
          mul: mul,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, mul);
      }
      assertThat(variableResult).isEqualTo(15);
  - name: Negative number multiplication - should return negative product
    code: |-
      const src = -4;
      const mul = 5;
      const mockData = {
          src: src,
          mul: mul,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, mul);
      }
      assertThat(variableResult).isEqualTo(-20);
  - name: '[example] String numbers multiplied'
    code: |-
      /* @display
      First Number: 6
      Second Number: 7
      @output
      42
      */
      const src = '6';
      const mul = '7';
      const mockData = {
          src: src,
          mul: mul,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, mul);
      }
      assertThat(variableResult).isEqualTo(42);
  - name: Decimal numbers - should handle decimals
    code: |-
      const src = 2.5;
      const mul = 4;
      const mockData = {
          src: src,
          mul: mul,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, mul);
      }
      assertThat(variableResult).isEqualTo(10);
  - name: '[example] Invalid returns undefined'
    code: |-
      /* @display
      First Number: hello
      Second Number: 5
      @output
      undefined
      */
      const src = 'hello';
      const mul = 5;
      const mockData = {
          src: src,
          mul: mul,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, mul);
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
