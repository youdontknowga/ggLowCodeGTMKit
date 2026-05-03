___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "calculateLeadTime",
  "description": "Calculates the number of days between today and a future target date (YYYY-MM-DD).",
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
        "displayName": "Target Date",
        "simpleValueType": true,
        "help": "▶️   Target date in YYYY-MM-DD format.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Calculates the lead time (in days) between the current date and the provided target date.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFuture Date\u003c/em\u003e***\u003cbr\u003eTarget Date: \u003cstrong\u003e[Tomorrow's Date]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eToday\u003c/em\u003e***\u003cbr\u003eTarget Date: \u003cstrong\u003e[Today's Date]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePast Date\u003c/em\u003e***\u003cbr\u003eTarget Date: \u003cstrong\u003e[Yesterday's Date]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e-1\u003c/strong\u003e"
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
* Calculates the number of days between today and a future target date.
* 
* @param {string} data.src - Target date in YYYY-MM-DD format.
* @param {Function|string} [data.out] - Optional output handler.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function.
* 
* @returns {number|undefined} The lead time in days (positive if target date is in the future), or undefined if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');
const getTimestampMillis = require('getTimestampMillis');
const Math = require('Math');

const calculateLeadTime = function(targetDate) {
   if (typeof targetDate !== 'string') { return undefined; }
   const reDateFormatISO8601 = "^(\\d{4})-(\\d{2})-(\\d{2})$";
   const matchParts = targetDate.match(reDateFormatISO8601);
   if (matchParts === null) { return undefined; }
   
   function calculateDaysSinceEpoch(year, month, day) {
       function isLeapYear(year) {
           return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
       }
       
       const daysInFebruary = isLeapYear(year) ? 29 : 28;
       const daysInMonth = [0, 31, daysInFebruary, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
       
       if (day > daysInMonth[month]) { return undefined; }
       
       let totalDays = 0;
       for (let y = 1970; y < year; y++) {
           totalDays += isLeapYear(y) ? 366 : 365;
       }
       for (let m = 1; m < month; m++) {
           totalDays += daysInMonth[m];
       }
       totalDays += day - 1;
       return totalDays;
   }
   
   const targetDays = calculateDaysSinceEpoch(makeNumber(matchParts[1]), makeNumber(matchParts[2]), makeNumber(matchParts[3]));
   if (targetDays === undefined) { return undefined; }
   
   const currentDays = Math.floor(getTimestampMillis() / (1000 * 60 * 60 * 24));
   
   return targetDays - currentDays;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// calculateLeadTime - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(calculateLeadTime(value));
// ===============================================================================
// calculateLeadTime() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(calculateLeadTime(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Future Date'
    code: |-
      /* @display
      Target Date: 2024-04-25
      @output
      1
      */
      const src = "2024-04-25";
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
  - name: '[example] Today'
    code: |-
      /* @display
      Target Date: 2024-04-24
      @output
      0
      */
      const src = "2024-04-24";
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
  - name: '[example] Past Date'
    code: |-
      /* @display
      Target Date: 2024-04-23
      @output
      -1
      */
      const src = "2024-04-23";
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
      assertThat(variableResult).isEqualTo(-1);
  - name: Invalid format returns undefined
    code: |-
      const src = "2024/01/01";
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
  - name: Invalid input - returns undefined
    code: |-
      const src = {};
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
  const mode = 'direct';
  // ===================================================================================================
  // Derived flags
  // ===================================================================================================
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 

  // Mock getTimestampMillis so that tests run deterministically if needed.
  mock('getTimestampMillis', function() {
     // Return a fixed timestamp for tests if needed, otherwise just let the logic run
     return 1713916800000; // e.g. 2024-04-24 00:00:00 UTC
  });


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
