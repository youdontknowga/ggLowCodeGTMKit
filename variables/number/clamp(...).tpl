___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "clamp(...)",
  "description": "Clamps a \u003cem\u003enumber\u003c/em\u003e within a specified range defined by the min and max values, ensuring the result stays within bounds.",
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
        "help": "📉   The lower bound of the range.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "📈   The upper bound of the range.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eWithin range unchanged\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 5\u003cbr\u003eMinimum Value: 0\u003cbr\u003eMaximum Value: 10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBelow minimum clamped up\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: -5\u003cbr\u003eMinimum Value: 0\u003cbr\u003eMaximum Value: 10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAbove maximum clamped down\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 15\u003cbr\u003eMinimum Value: 0\u003cbr\u003eMaximum Value: 10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e10\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Value To Clamp"
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
    "help": "Clamps a \u003cem\u003enumber\u003c/em\u003e within a specified range defined by min and max values.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eWithin range unchanged\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003eMinimum Value: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003eMaximum Value: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBelow minimum clamped up\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e-5\u003c/strong\u003e\u003cbr\u003eMinimum Value: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003eMaximum Value: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAbove maximum clamped down\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e15\u003c/strong\u003e\u003cbr\u003eMinimum Value: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003eMaximum Value: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e10\u003c/strong\u003e"
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
* Clamps a number within a specified range defined by the min and max values.
* 
* @param {number} data.src - The number to be clamped.
* @param {number|string} data.min - The lower bound of the range.
* @param {number|string} data.max - The upper bound of the range.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before clamping.
* 
* @returns {number} The clamped number, constrained between min and max.
*
* @framework ggLowCodeGTMKit
*/
const Math = require('Math');
const makeNumber = require('makeNumber');

const clamp = function(value, min, max) {
   const val = makeNumber(value);
   const minVal = makeNumber(min);
   const maxVal = makeNumber(max);
   return Math.max(minVal, Math.min(val, maxVal));
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// clamp - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(clamp(value, data.min, data.max));
*/
// ===============================================================================
// clamp(...) – Apply Mode:
// ===============================================================================
return function(value, min, max) {
  min = data.rp1 ? data.min : min;
  max = data.rp2 ? data.max : max;
  return out(clamp(value, min, max));
};


___TESTS___

scenarios:
  - name: '[example] Within range unchanged'
    code: |-
      /* @display
      Value to Process: 5
      Minimum Value: 0
      Maximum Value: 10
      @output
      5
      */
      const src = 5;
      const min = 0;
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
      assertThat(variableResult).isEqualTo(5);
  - name: '[example] Below minimum clamped up'
    code: |-
      /* @display
      Value to Process: -5
      Minimum Value: 0
      Maximum Value: 10
      @output
      0
      */
      const src = -5;
      const min = 0;
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
      assertThat(variableResult).isEqualTo(0);
  - name: '[example] Above maximum clamped down'
    code: |-
      /* @display
      Value to Process: 15
      Minimum Value: 0
      Maximum Value: 10
      @output
      10
      */
      const src = 15;
      const min = 0;
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
      assertThat(variableResult).isEqualTo(10);
  - name: Clamp value at minimum boundary
    code: |-
      const src = 0;
      const min = 0;
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
      assertThat(variableResult).isEqualTo(0);
  - name: Clamp value at maximum boundary
    code: |-
      const src = 10;
      const min = 0;
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
      assertThat(variableResult).isEqualTo(10);
  - name: Clamp negative range
    code: |-
      const src = -5;
      const min = -10;
      const max = -1;
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
      assertThat(variableResult).isEqualTo(-5);
  - name: Clamp decimal value
    code: |-
      const src = 5.7;
      const min = 0;
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
      assertThat(variableResult).isEqualTo(5.7);
  - name: String number values
    code: |-
      const src = '7';
      const min = '0';
      const max = '10';
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
      assertThat(variableResult).isEqualTo(7);
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
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
