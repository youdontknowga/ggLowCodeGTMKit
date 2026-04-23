___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "isGreaterThan",
  "description": "Compare two values to check if the first is strictly greater.",
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
        "help": "💾   The value to compare.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e \u003cbr\u003e  ✓ \u003cstrong\u003eStringified Number\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "ref",
        "displayName": "Reference Value",
        "simpleValueType": true,
        "help": "🎯 Value to compare against. Case-sensitive, exact match required.\u003cbr\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e \u003cbr\u003e  ✓ \u003cstrong\u003eStringified Number\u003c/strong\u003e"
      }
    ],
    "help": "Checks if a given value is strictly greater than another value. Returns \u003cem\u003efalse\u003c/em\u003e if either value cannot be converted to a number.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSmaller number\u003c/em\u003e***\u003cbr\u003eValue To Compare: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003eReference Value: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGreater number\u003c/em\u003e***\u003cbr\u003eValue To Compare: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003eReference Value: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEqual numbers\u003c/em\u003e***\u003cbr\u003eValue To Compare: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003eReference Value: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
 * Checks if a given value is strictly greater than another value.
 * 
 * @param {any} data.src - The value to check.
 * @param {any} data.ref - The reference value to compare against.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform `src` before checking.
 * 
 * @returns {boolean} True if the value is strictly greater than the reference, false otherwise or if either value is not a number.
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');

const isGreaterThan = function(value, reference) {
	value = makeNumber(value);
	if (typeof value !== 'number') { 
		return false;
	}
	return value > makeNumber(reference);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// isGreaterThan - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(isGreaterThan(value, data.ref));
// ===============================================================================
// isGreaterThan(...) – Apply Mode
// ===============================================================================
/*
return function(value, reference) {
   reference = data.rp1 ? data.ref : reference;
   return out(isGreaterThan(value, reference));
};
*/


___TESTS___

scenarios:
  - name: '[example] Smaller number'
    code: |-
      /* @display
      Value To Compare: 5
      Reference Value: 10
      @output
      false
      */
      const src = 5;
      const ref = 10;
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
  - name: '[example] Greater number'
    code: |-
      /* @display
      Value To Compare: 10
      Reference Value: 5
      @output
      true
      */
      const src = 10;
      const ref = 5;
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
  - name: '[example] Equal numbers'
    code: |-
      /* @display
      Value To Compare: 10
      Reference Value: 10
      @output
      false
      */
      const src = 10;
      const ref = 10;
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
  - name: String vs number - should convert and compare
    code: |-
      const src = '10';
      const ref = 5;
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
  - name: Number vs string - should convert and compare
    code: |-
      const src = 10;
      const ref = '5';
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
  - name: Negative numbers - should return true
    code: |-
      const src = -5;
      const ref = -10;
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
  - name: Decimal numbers - should return true
    code: |-
      const src = 3.15;
      const ref = 3.14;
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
  - name: Null vs number - should return false (null convert to 0)
    code: |-
      const src = 10;
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
