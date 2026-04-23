___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "isGreaterThan(...)",
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
        "name": "ref",
        "displayName": "Reference Value",
        "simpleValueType": true,
        "help": "🎯 Value to compare against.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eStringified Number\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSmaller number\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 5\u003cbr\u003eReference Value: 10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGreater number\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 10\u003cbr\u003eReference Value: 5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEqual numbers\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 10\u003cbr\u003eReference Value: 10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Value To Compare: \u003cem\u003echained callback parameter\u003c/em\u003e \u003cbr\u003e"
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
            "checkboxText": "⚡Use runtime parameter for: Reference Value",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Checks if a given value is strictly greater than another value. Returns \u003cem\u003efalse\u003c/em\u003e if either value cannot be converted to a number.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSmaller number\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003eReference Value: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGreater number\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003eReference Value: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEqual numbers\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003eReference Value: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., bool =\u003e !bool to invert result, bool =\u003e bool ? 'yes' : 'no' for string conversion). Useful for chaining transformations on the output."
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
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(isGreaterThan(value, data.ref));
*/
// ===============================================================================
// isGreaterThan(...) – Apply Mode
// ===============================================================================
return function(value, reference) {
   reference = data.rp1 ? data.ref : reference;
   return out(isGreaterThan(value, reference));
};


___TESTS___

scenarios:
  - name: '[example] Smaller number'
    code: |-
      /* @display
      Value to Process: 5
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
      Value to Process: 10
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
      Value to Process: 10
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
