___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "convertMillisecondsToHours()",
  "description": "Converts a number of milliseconds to the equivalent duration in hours, useful for time calculations and duration conversions with \u003cem\u003enumber\u003c/em\u003e input.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMilliseconds to hours\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e7200000\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eZero returns 0\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Number of Milliseconds"
      }
    ],
    "help": "Converts milliseconds to hours.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMilliseconds to hours\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e7200000\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eZero returns 0\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., hrs =\u003e Math.round(hrs) for whole hours, val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Converts a number of milliseconds to hours.
* 
* @param {string|number} data.src - The number of milliseconds to convert to hours.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {number|undefined} The time in hours, or undefined if input is not a valid number.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const convertMillisecondsToHours = function(timeValue) {
   const timeNum = makeNumber(timeValue);
   if (timeNum === timeNum) {
       return timeNum / (1000 * 60 * 60);
   }
   return undefined;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// convertMillisecondsToHours - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(convertMillisecondsToHours(value));
*/
// ===============================================================================
// convertMillisecondsToHours() – Apply Mode
// ===============================================================================
return function(value) {
  return out(convertMillisecondsToHours(value));
};


___TESTS___

scenarios:
  - name: '[example] Milliseconds to hours'
    code: |-
      /* @display
      Value to Process: 7200000
      @output
      2
      */
      const src = 7200000;
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
  - name: String milliseconds - converts to hours
    code: |-
      const src = "3600000";
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
  - name: Partial hour milliseconds - converts to decimal hours
    code: |-
      const src = 1800000;
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
  - name: '[example] Zero returns 0'
    code: |-
      /* @display
      Value to Process: 0
      @output
      0
      */
      const src = 0;
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
      assertThat(variableResult).isEqualTo(0);
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'apply';
  // ===================================================================================================
  // Derived flags
  // ===================================================================================================
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 


___NOTES___

Created on 21/03/2026, 20:36:28


