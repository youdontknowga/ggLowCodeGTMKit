___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "millisecondsToDays()",
  "description": "Converts a number of milliseconds to the equivalent duration in days, useful for time calculations and duration conversions with \u003cem\u003enumber\u003c/em\u003e input.",
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
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMilliseconds to 1 day\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e86400000\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMilliseconds to 7 days\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e604800000\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e7\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Number of Milliseconds"
      }
    ],
    "help": "Converts milliseconds to days.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMilliseconds to 1 day\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e86400000\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMilliseconds to 7 days\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e604800000\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e7\u003c/strong\u003e"
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
* Converts a number of milliseconds to days.
* 
* @param {string|number} data.src - The number of milliseconds to convert to days.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {number|undefined} The time in days, or undefined if input is not a valid number.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const millisecondsToDays = function(timeValue) {
   const timeNum = makeNumber(timeValue);
   if (timeNum === timeNum) {
       return timeNum / (1000 * 60 * 60 * 24);
   }
   return undefined;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// millisecondsToDays - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(millisecondsToDays(value));
*/
// ===============================================================================
// millisecondsToDays() – Apply Mode
// ===============================================================================
return function(value) {
  return out(millisecondsToDays(value));
};


___TESTS___

scenarios:
  - name: '[example] Milliseconds to 1 day'
    code: |-
      /* @display
      Value to Process: 86400000
      @output
      1
      */
      const src = 86400000;
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(1);
  - name: '[example] Milliseconds to 7 days'
    code: |-
      /* @display
      Value to Process: 604800000
      @output
      7
      */
      const src = 604800000;
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(7);
  - name: String milliseconds - converts to days
    code: |
      const src = "172800000";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(2);
  - name: Partial day milliseconds - converts to decimal days
    code: |-
      const src = 43200000;
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(0.5);
  - name: Invalid string input - returns undefined
    code: |-
      const src = "not a number";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isUndefined();
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
