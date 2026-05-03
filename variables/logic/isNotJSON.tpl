___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "isNotJSON",
  "description": "Checks if a given input is not valid\u003cem\u003e JSON\u003c/em\u003e.",
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
        "displayName": "Value To Check",
        "simpleValueType": true,
        "help": "💾   The value to check."
      }
    ],
    "help": "Checks if a given input is not valid\u003cem\u003e JSON\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValid JSON returns false\u003c/em\u003e***\u003cbr\u003eValue To Check: \u003cstrong\u003e{\"key\": \"value\"}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid JSON returns true\u003c/em\u003e***\u003cbr\u003eValue To Check: \u003cstrong\u003e{key: \"value\"}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
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
 * Checks if a given string is not valid JSON by parsing it and ensuring the result is undefined.
 * 
 * @param {any} data.src - The value to check.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform `src` before checking.
 * 
 * @returns {boolean} True if the value is not valid JSON, false otherwise.
 *
 * @framework ggLowCodeGTMKit
 */
const JSON = require('JSON');
const isNotJSON = function(value) {
	return JSON.parse(value) === undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// isNotJSON - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(isNotJSON(value));
// ===============================================================================
// isNotJSON() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(isNotJSON(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Valid JSON returns false'
    code: |
      /* @display
      Value To Check: {"key": "value"}
      @output
      false
      */
      const src = '{"key": "value"}';
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
      assertThat(variableResult).isFalse();
  - name: '[example] Invalid JSON returns true'
    code: |-
      /* @display
      Value To Check: {key: "value"}
      @output
      true
      */
      const src = '{key: "value"}';
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
      assertThat(variableResult).isTrue();
  - name: Object value - should return true
    code: |-
      const src = {'test':'test'};
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
      assertThat(variableResult).isTrue();
  - name: Number value - should return false
    code: |-
      const src = 1234;
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
      assertThat(variableResult).isFalse();
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'direct';
  // ==========================================================a=========================================
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
