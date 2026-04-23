___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "isInRange(...)",
  "description": "Check if a value falls within a specified numeric range (inclusive of both min and max values).",
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
        "name": "min",
        "displayName": "Minimum Value",
        "simpleValueType": true,
        "help": "📉 The minimum value of the range (inclusive).\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eStringified Number\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "max",
        "displayName": "Maximum Value",
        "simpleValueType": true,
        "help": "📈 The maximum value of the range (inclusive).\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eStringified Number\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp2",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValue in range\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 5\u003cbr\u003eMinimum Value: 1\u003cbr\u003eMaximum Value: 10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValue below range\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 0\u003cbr\u003eMinimum Value: 1\u003cbr\u003eMaximum Value: 10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Value To Check"
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
            "checkboxText": "⚡Use runtime parameter for: Minimum Value",
            "simpleValueType": true
          },
          {
            "type": "CHECKBOX",
            "name": "rp2",
            "checkboxText": "⚡Use runtime parameter for: Maximum Value",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Checks if a given value falls within a specified range (inclusive). Returns \u003cem\u003efalse\u003c/em\u003e if the value or boundaries cannot be converted to numbers.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValue in range\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003eMinimum Value: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003eMaximum Value: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValue below range\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003eMinimum Value: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003eMaximum Value: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
 * Checks if a given value is within a specified range.
 * 
 * @param {any} data.src - The value to check.
 * @param {any} data.min - The minimum value of the range.
 * @param {any} data.max - The maximum value of the range.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform `src` before checking.
 * 
 * @returns {boolean} True if the value is within the range (inclusive), false otherwise or if any value cannot be converted to a number.
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');

const isInRange = function(value, min, max) {
	value = makeNumber(value);
	if (typeof value !== 'number') { 
		return false;
	}
	const minNum = makeNumber(min);
	const maxNum = makeNumber(max);
	return value >= minNum && value <= maxNum;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// isInRange - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(isInRange(value, data.min, data.max));
*/
// ===============================================================================
// isInRange(...) – Apply Mode
// ===============================================================================
return function(value, min, max) {
   min = data.rp1 ? data.min : min;
   max = data.rp2 ? data.max : max;
   return out(isInRange(value, min, max));
};


___TESTS___

scenarios:
  - name: '[example] Value in range'
    code: |-
      /* @display
      Value to Process: 5
      Minimum Value: 1
      Maximum Value: 10
      @output
      true
      */
      const src = 5;
      const min = 1;
      const max = 10;
      const mockData = {
          src: src,
          min: min,
          max: max,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, min, max);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] Value below range'
    code: |-
      /* @display
      Value to Process: 0
      Minimum Value: 1
      Maximum Value: 10
      @output
      false
      */
      const src = 0;
      const min = 1;
      const max = 10;
      const mockData = {
          src: src,
          min: min,
          max: max,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, min, max);
      }
      assertThat(variableResult).isFalse();
  - name: Value above range - should return false
    code: |-
      const src = 15;
      const min = 1;
      const max = 10;
      const mockData = {
          src: src,
          min: min,
          max: max,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, min, max);
      }
      assertThat(variableResult).isFalse();
  - name: Value equal to minimum - should return true (inclusive)
    code: |-
      const src = 1;
      const min = 1;
      const max = 10;
      const mockData = {
          src: src,
          min: min,
          max: max,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, min, max);
      }
      assertThat(variableResult).isTrue();
  - name: Value equal to maximum - should return true (inclusive)
    code: |-
      const src = 10;
      const min = 1;
      const max = 10;
      const mockData = {
          src: src,
          min: min,
          max: max,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, min, max);
      }
      assertThat(variableResult).isTrue();
  - name: String number within range - should convert and return true
    code: |-
      const src = '5';
      const min = 1;
      const max = 10;
      const mockData = {
          src: src,
          min: min,
          max: max,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, min, max);
      }
      assertThat(variableResult).isTrue();
  - name: Non-numeric value - should return false
    code: |-
      const src = 'hello';
      const min = 1;
      const max = 10;
      const mockData = {
          src: src,
          min: min,
          max: max,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, min, max);
      }
      assertThat(variableResult).isFalse();
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'apply';
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
