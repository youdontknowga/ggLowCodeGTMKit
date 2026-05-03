___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "absolute",
  "description": "Returns the absolute value of the input.",
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
        "name": "num",
        "displayName": "Number",
        "simpleValueType": true,
        "help": "💾   The number to calculate the absolute value for.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e"
      }
    ],
    "help": "Returns the absolute (non-negative) value of a \u003cem\u003enumber\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePositive stays positive\u003c/em\u003e***\u003cbr\u003eNumber: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNegative to positive\u003c/em\u003e***\u003cbr\u003eNumber: \u003cstrong\u003e-42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., parse string to number, apply mathematical operations). Internal transformations such as absolute value calculation will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., num =\u003e num + ' units', val =\u003e val.toFixed(2) for decimal formatting). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Returns the absolute value of the provided input.
 * 
 * @param {number} data.num - The number to calculate the absolute value for.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform num before calculation.
 * 
 * @returns {number} The absolute value of the input number.
 *
 * @framework ggLowCodeGTMKit
 */
const Math = require('Math');
const absolute = function(num) {
	return Math.abs(num);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// absolute - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const num = applyCast(data.pre, data.num);
return out(absolute(num));
// ===============================================================================
// absolute() – Apply Mode
// ===============================================================================
/*
return function(num) {
   return out(absolute(num));
};
*/


___TESTS___

scenarios:
  - name: '[example] Positive stays positive'
    code: |-
      /* @display
      Number: 42
      @output
      42
      */
      const num = 42;
      const mockData = {
          num: num
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(num);
      }
      assertThat(variableResult).isEqualTo(42);
  - name: '[example] Negative to positive'
    code: |-
      /* @display
      Number: -42
      @output
      42
      */
      const num = -42;
      const mockData = {
          num: num
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(num);
      }
      assertThat(variableResult).isEqualTo(42);
  - name: Zero - should return 0
    code: |-
      const num = 0;
      const mockData = {
          num: num
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(num);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Negative decimal - should return positive decimal
    code: |-
      const num = -3.14;
      const mockData = {
          num: num
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(num);
      }
      assertThat(variableResult).isEqualTo(3.14);
  - name: String negative number - should convert and return positive value
    code: |-
      const num = '-25';
      const mockData = {
          num: num
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(num);
      }
      assertThat(variableResult).isEqualTo(25);
  - name: Null input - should return 0
    code: |-
      const num = null;
      const mockData = {
          num: num
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(num);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Undefined input - should return NaN
    code: |-
      const num = undefined;
      const mockData = {
          num: num
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(num);
      }
      assertThat(variableResult).isNaN();
  - name: Empty string - should return 0
    code: |-
      const num = "";
      const mockData = {
          num: num
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(num);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Array with single string number - should convert and return positive value
    code: |-
      const num = ["-123.45"];
      const mockData = {
          num: num
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(num);
      }
      assertThat(variableResult).isEqualTo(123.45);
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
