___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getDayNameFromDateString()",
  "description": "Returns the name of the day of the week (e.g., \"Monday\") from an ISO 8601 date string (YYYY-MM-DD) using an internal calculation. Does not rely on JavaScript\u0027s built-in Date object.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eISO date to Saturday\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e2024-11-02\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eSaturday\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid format returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e25/12/2024\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Date String (YYYY-MM-DD)"
      }
    ],
    "help": "Returns the day name from an ISO 8601 date string (YYYY-MM-DD).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eISO date to Saturday\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e2024-11-02\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eSaturday\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid format returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e25/12/2024\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
* Returns the day name (e.g., "Monday") corresponding to an ISO 8601 date string using Zeller's Congruence algorithm.
* 
* @param {string} data.src - A date string in YYYY-MM-DD format.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before calculation.
* 
* @returns {string|undefined} The name of the day (e.g., "Friday"), or undefined if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const Math = require('Math');
const makeNumber = require('makeNumber');

const getDayNameFromDateString = function(dateStr) {
   const reDateFormatISO8601 = "(\\d\\d\\d\\d)-(\\d\\d)-(\\d\\d)";
   const dateMatchParts = dateStr.match(reDateFormatISO8601);
   if (dateMatchParts === null) { return undefined; }
   
   let year = makeNumber(dateMatchParts[1]);
   let month = makeNumber(dateMatchParts[2]);
   let day = makeNumber(dateMatchParts[3]);
   
   // Zeller's Congruence algorithm
   if (month < 3) {
       month = month + 12;
       year = year - 1;
   }
   const q = day;
   const m = month;
   const k = year % 100;
   const j = Math.floor(year / 100);
   const h = (q + Math.floor((13 * (m + 1)) / 5) + k + Math.floor(k / 4) + Math.floor(j / 4) + 5 * j) % 7;
   const days = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
   return days[h];
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// getDayNameFromDateString - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(getDayNameFromDateString(value));
*/
// ===============================================================================
// getDayNameFromDateString() – Apply Mode
// ===============================================================================
return function(value) {
  return out(getDayNameFromDateString(value));
};


___TESTS___

scenarios:
  - name: '[example] ISO date to Saturday'
    code: |-
      /* @display
      Value to Process: 2024-11-02
      @output
      Saturday
      */
      const src = "2024-11-02";
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
      assertThat(variableResult).isEqualTo("Saturday");
  - name: Valid ISO date Monday - returns Monday
    code: |-
      const src = "2024-12-23";
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
      assertThat(variableResult).isEqualTo("Monday");
  - name: Valid ISO date with January - handles month adjustment correctly
    code: |-
      const src = "2025-01-01";
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
      assertThat(variableResult).isEqualTo("Wednesday");
  - name: '[example] Invalid format returns undefined'
    code: |-
      /* @display
      Value to Process: 25/12/2024
      @output
      undefined
      */
      const src = "25/12/2024";
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
  - name: Invalid string - returns undefined
    code: |-
      const src = "not a date";
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
