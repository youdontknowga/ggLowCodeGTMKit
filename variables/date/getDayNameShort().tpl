___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getDayNameShort()",
  "description": "Returns the abbreviated name of the day of the week from an ISO 8601 day number (1 \u003d Monday, 7 \u003d Sunday).",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex 1 returns Mon\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eMon\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid index returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Day Index"
      }
    ],
    "help": "Returns the abbreviated name of the day of the week. 1 = Mon, 7 = Sun (ISO 8601).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex 1 returns Mon\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eMon\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid index returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
* Returns the abbreviated name of the day of the week based on the given integer where 0 = Monday, 1 = Tuesday, etc.
* 
* @param {number|string} data.src - An integer representing the day of the week (0 to 6).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {string|undefined} The abbreviated name of the day (e.g., "Mon", "Tues", etc.), or undefined if the index is invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const getDayName = function(dayInt) {
   const day = makeNumber(dayInt);
   if (day < 1 || day > 7) return undefined;
   const dayList = ["Mon", "Tues", "Wed", "Thu", "Fri", "Sat", "Sun"];
   return dayList[day - 1];
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// getDayName - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(getDayName(value));
*/
// ===============================================================================
// getDayName() – Apply Mode: runtime parameter
// ===============================================================================
return function(value) {
  return out(getDayName(value));
};


___TESTS___

scenarios:
  - name: '[example] Index 1 returns Mon'
    code: |
      /* @display
      Value to Process: 1
      @output
      Mon
      */
      const src = 1;
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
      assertThat(variableResult).isEqualTo("Mon");
  - name: Valid day index 4 - returns Thursday
    code: |-
      const src = 4;
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
      assertThat(variableResult).isEqualTo("Thu");
  - name: Valid day index 7 - returns Sunday
    code: |-
      const src = 7;
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
      assertThat(variableResult).isEqualTo("Sun");
  - name: '[example] Invalid index returns undefined'
    code: |-
      /* @display
      Value to Process: 10
      @output
      undefined
      */
      const src = 10;
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
