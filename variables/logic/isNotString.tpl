___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "isNotString",
  "description": "Checks if the provided value is not\u003cem\u003e string\u003c/em\u003e.",
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
        "help": "💾   The value to check.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAll\u003c/strong\u003e"
      }
    ],
    "help": "Checks if the provided value is not\u003cem\u003e string\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNumber returns true\u003c/em\u003e***\u003cbr\u003eValue To Check: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString returns false\u003c/em\u003e***\u003cbr\u003eValue To Check: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
 * Checks if the value is not a string.
 * 
 * @param {any} data.src - The value to check.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform `src` before checking.
 * 
 * @returns {boolean} True if the value is not a string, false otherwise.
 *
 * @framework ggLowCodeGTMKit
 */
const isNotString = function(value) {
	return typeof value !== 'string';
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// isNotString - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(isNotString(value));
// ===============================================================================
// isNotString() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(isNotString(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Number returns true'
    code: |-
      /* @display
      Value To Check: 42
      @output
      true
      */
      const src = 42;
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
  - name: Object - should return true
    code: |-
      const src = {key: 'value'};
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
  - name: Boolean - should return true
    code: |-
      const src = true;
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
  - name: '[example] String returns false'
    code: |-
      /* @display
      Value To Check: hello world
      @output
      false
      */
      const src = 'hello world';
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
  - name: Empty string - should return false
    code: |-
      const src = '';
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
