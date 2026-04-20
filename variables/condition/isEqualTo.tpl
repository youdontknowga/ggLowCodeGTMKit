___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "isEqualTo",
  "description": "Checks if the provided inputs are exactly equal, including case sensitivity. It returns \u003cem\u003etrue\u003c/em\u003e if they are identical and \u003cem\u003efalse otherwise\u003c/em\u003e.",
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
        "displayName": "Value To Compare",
        "simpleValueType": true,
        "help": "💾   The value to compare.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003ePrimitive value\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "ref",
        "displayName": "Reference Value",
        "simpleValueType": true,
        "help": "🎯 Value to compare against. Case-sensitive, exact match required.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e  ✓ \u003cstrong\u003ePrimitive value\u003c/strong\u003e"
      }
    ],
    "help": "Checks if the provided inputs are exactly equal, including case sensitivity. Returns \u003cem\u003etrue\u003c/em\u003e if identical, \u003cem\u003efalse\u003c/em\u003e otherwise. Primitive values only.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEqual strings\u003c/em\u003e***\u003cbr\u003eValue To Compare: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003eReference Value: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDifferent values\u003c/em\u003e***\u003cbr\u003eValue To Compare: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003eReference Value: \u003cstrong\u003eHello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eStrict type check\u003c/em\u003e***\u003cbr\u003eValue To Compare: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003eReference Value: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
 * Checks if the value is strictly equal to a reference value.
 * 
 * @param {any} data.src - The value to check.
 * @param {any} data.ref - The reference value to compare against.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform `src` before checking.
 * 
 * @returns {boolean} True if the value is strictly equal to the reference, false otherwise.
 *
 * @framework ggLowCodeGTMKit
 */
const isEqualTo = function(value, reference) {
	return value === reference;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// isEqualTo - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(isEqualTo(value, data.ref));
// ===============================================================================
// isEqualTo(...) – Apply Mode
// ===============================================================================
/*
return function(value, reference) {
   reference = data.rp1 ? data.ref : reference;
   return out(isEqualTo(value, reference));
};
*/


___TESTS___

scenarios:
  - name: '[example] Equal strings'
    code: |-
      /* @display
      Value To Compare: hello
      Reference Value: hello
      @output
      true
      */
      const src = 'hello';
      const ref = 'hello';
      const mockData = {
          src: src,
          ref: ref,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ref);
      }
      assertThat(variableResult).isTrue();
  - name: Equal numbers - should return true
    code: |-
      const src = 42;
      const ref = 42;
      const mockData = {
          src: src,
          ref: ref,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ref);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] Different values'
    code: |-
      /* @display
      Value To Compare: hello
      Reference Value: Hello
      @output
      false
      */
      const src = 'hello';
      const ref = 'Hello';
      const mockData = {
          src: src,
          ref: ref,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ref);
      }
      assertThat(variableResult).isFalse();
  - name: '[example] Strict type check'
    code: |-
      /* @display
      Value To Compare: 42
      Reference Value: 42
      @output
      false
      */
      const src = '42';
      const ref = 42;
      const mockData = {
          src: src,
          ref: ref,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ref);
      }
      assertThat(variableResult).isFalse();
  - name: Both null - should return true
    code: |-
      const src = null;
      const ref = null;
      const mockData = {
          src: src,
          ref: ref,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ref);
      }
      assertThat(variableResult).isTrue();
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
