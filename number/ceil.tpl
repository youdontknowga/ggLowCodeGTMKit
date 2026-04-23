___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "ceil",
  "description": "Rounds the provided input up to the nearest integer, returning the smallest integer greater than or equal to the input value.",
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
        "displayName": "Number To Round Up",
        "simpleValueType": true,
        "help": "💾   The number to round up to the nearest integer.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eStringified Number\u003c/strong\u003e"
      }
    ],
    "help": "Rounds the provided input up to the nearest \u003cem\u003einteger\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRound up decimal\u003c/em\u003e***\u003cbr\u003eNumber To Round Up: \u003cstrong\u003e4.3\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInteger unchanged\u003c/em\u003e***\u003cbr\u003eNumber To Round Up: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e5\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert string to number, apply mathematical operations). Internal transformations such as type handling will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., num =\u003e num + ' units', val =\u003e val.toString() for string conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Rounds the provided input up to the nearest integer.
 * 
 * @param {number} data.src - The number to round up.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform input before rounding.
 * 
 * @returns {number} The smallest integer greater than or equal to the input.
 *
 * @framework ggLowCodeGTMKit
 */
const Math = require('Math');
const ceil = function(value) {
    return Math.ceil(value);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// ceil - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(ceil(value));
// ===============================================================================
// ceil() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(Math.ceil(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Round up decimal'
    code: |-
      /* @display
      Number To Round Up: 4.3
      @output
      5
      */
      const src = 4.3;
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(5);
  - name: Round up negative decimal
    code: |-
      const src = -4.3;
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(-4);
  - name: '[example] Integer unchanged'
    code: |-
      /* @display
      Number To Round Up: 5
      @output
      5
      */
      const src = 5;
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(5);
  - name: Round up zero - should return 0
    code: |-
      const src = 0;
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Round up string number - should convert and round
    code: |-
      const src = '4.7';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(5);
  - name: Undefined input - should return NaN
    code: |-
      const src = undefined;
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isNaN();
  - name: mpty string - should return 0
    code: |-
      const src = "";
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
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
