___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "convertDateToUnixTimestamp()",
  "description": "Convert a date in YYYY-MM-DD format to Unix timestamp (milliseconds since epoch) without using the Date object, returning a \u003cem\u003enumber\u003c/em\u003e.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDate to Unix timestamp\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e2024-01-15\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1705276800000\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEpoch returns 0\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e1970-01-01\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Date String"
      }
    ],
    "help": "Converts a date string to Unix timestamp in milliseconds.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDate to Unix timestamp\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e2024-01-15\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1705276800000\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEpoch returns 0\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e1970-01-01\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., ts =\u003e ts / 1000 to convert to seconds, ts =\u003e ts || 0 to default undefined to zero). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Convert a date in YYYY-MM-DD format to Unix timestamp (milliseconds since epoch) without using the Date object.
* 
* @param {string} data.src - Date string in YYYY-MM-DD format.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {number|undefined} Unix timestamp in milliseconds, or undefined if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');
const Math = require('Math');

const convertDateToUnixTimestamp = function(dateStr) {
   if (typeof dateStr !== 'string') { return undefined; }
   const reDateFormatISO8601 = "^(\\d{4})-(\\d{2})-(\\d{2})$";
   const dateMatchParts = dateStr.match(reDateFormatISO8601);
   if (dateMatchParts === null) { return undefined; }
   
   const year = makeNumber(dateMatchParts[1]);
   const month = makeNumber(dateMatchParts[2]);
   const day = makeNumber(dateMatchParts[3]);
   
   function calculateDaysSinceEpoch(year, month, day) {
       function isLeapYear(year) {
           return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
       }
       
       const daysInFebruary = isLeapYear(year) ? 29 : 28;
       
       // Days in each month including a dummy value for index 0
       const daysInMonth = [0, 31, daysInFebruary, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
       
       if (day > daysInMonth[month]) {
           return undefined;
       }
       
       // Days from 1970 to the year before
       let totalDays = 0;
       for (let y = 1970; y < year; y++) {
           totalDays += isLeapYear(y) ? 366 : 365;
       }
       
       // Add days from months in the current year
       for (let m = 1; m < month; m++) {
           totalDays += daysInMonth[m];
       }
       
       // Add days from the current month
       totalDays += day - 1;
       
       return totalDays;
   }
   
   const daysSinceEpoch = calculateDaysSinceEpoch(year, month, day);
   return daysSinceEpoch !== undefined ? daysSinceEpoch * 24 * 60 * 60 * 1000 : undefined;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// convertDateToUnixTimestamp - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(convertDateToUnixTimestamp(value));
*/
// ===============================================================================
// convertDateToUnixTimestamp() – Apply Mode
// ===============================================================================
return function(value) {
  return out(convertDateToUnixTimestamp(value));
};


___TESTS___

scenarios:
  - name: '[example] Date to Unix timestamp'
    code: |-
      /* @display
      Value to Process: 2024-01-15
      @output
      1705276800000
      */
      const src = '2024-01-15';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(1705276800000);
  - name: '[example] Epoch returns 0'
    code: |-
      /* @display
      Value to Process: 1970-01-01
      @output
      0
      */
      const src = '1970-01-01';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Leap year date - should calculate correctly
    code: |
      const src = '2020-02-29';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(1582934400000);
  - name: Invalid date format - should return undefined
    code: |-
      const src = '2024/01/15';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isUndefined();
  - name: Invalid day in month - should return undefined
    code: |-
      const src = '2024-02-30';
      const mockData = {
          src: src
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
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'apply';
  // ===================================================================================================
  // Derived flags
  // ===================================================================================================
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 


___NOTES___

Created on 22/03/2026, 14:19:06


