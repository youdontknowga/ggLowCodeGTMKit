___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "convertUnixTimestampToDate",
  "description": "Convert a Unix timestamp (seconds since epoch) to YYYY-MM-DD format without using the Date object, returning a formatted date \u003cem\u003estring\u003c/em\u003e.",
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
        "displayName": "Unix Timestamp",
        "simpleValueType": true,
        "help": "💾   Unix timestamp in seconds since epoch.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Converts a Unix timestamp to a date string in YYYY-MM-DD format.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTimestamp to date string\u003c/em\u003e***\u003cbr\u003eUnix Timestamp: \u003cstrong\u003e1735084800000\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e2024-12-25\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEpoch returns 1970-01-01\u003c/em\u003e***\u003cbr\u003eUnix Timestamp: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1970-01-01\u003c/strong\u003e"
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
* Convert a Unix timestamp (seconds since epoch) to YYYY-MM-DD format without using the Date object.
* 
* @param {number} data.src - Unix timestamp in seconds.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {string|undefined} Date in YYYY-MM-DD format, or undefined if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');
const Math = require('Math');

const convertUnixTimestampToDate = function(timestamp) {
   const timestampNum = makeNumber(timestamp);
   if (timestampNum !== timestampNum) { return undefined; }
   
   const daysSinceEpoch = Math.floor(timestampNum / (1000 * 60 * 60 * 24));
   
   const daysSinceEpochToDate = function (days) {
       let year = 1970;
       let remainingDays = days;
    
       function isLeapYear(yr) {
           return (yr % 4 === 0 && yr % 100 !== 0) || (yr % 400 === 0);
       }
       
       const daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
       
       while (true) {
           const daysInYear = isLeapYear(year) ? 366 : 365;
           if (remainingDays < daysInYear) {
               break;
           }
           remainingDays = remainingDays - daysInYear;
           year++;
       }
       
       if (isLeapYear(year)) {
           daysInMonth[2] = 29;
       }
       
       let month = 1;
       
       while (month <= 12 && remainingDays >= daysInMonth[month]) {
           remainingDays = remainingDays - daysInMonth[month];
           month++;
       }
       
       const day = remainingDays + 1;
       
       return { year: year, month: month, day: day };
   };
     
   const dateParts = daysSinceEpochToDate(daysSinceEpoch);
   const year = dateParts.year.toString();
   // Handle padding
   const month = dateParts.month < 10 ? '0' + dateParts.month : dateParts.month.toString();
   const day = dateParts.day < 10 ? '0' + dateParts.day : dateParts.day.toString();
   return year + "-" + month + "-" + day;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// convertUnixTimestampToDate - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(convertUnixTimestampToDate(value));

// ===============================================================================
// convertUnixTimestampToDate() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(convertUnixTimestampToDate(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Timestamp to date string'
    code: |-
      /* @display
      Unix Timestamp: 1735084800000
      @output
      2024-12-25
      */
      const src = 1735084800000;
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
      assertThat(variableResult).isEqualTo("2024-12-25");
  - name: '[example] Epoch returns 1970-01-01'
    code: |-
      /* @display
      Unix Timestamp: 0
      @output
      1970-01-01
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
      assertThat(variableResult).isEqualTo("1970-01-01");
  - name: Leap year date - converts correctly
    code: |-
      const src = 1709251200000;
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
      assertThat(variableResult).isEqualTo("2024-03-01");
  - name: End of year timestamp - converts correctly
    code: |
      const src = 1735689600000;
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
      assertThat(variableResult).isEqualTo("2025-01-01");
  - name: Invalid input (NaN) - returns undefined
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
  const mode = 'direct';
  // ===================================================================================================
  // Derived flags
  // ===================================================================================================
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 


___NOTES___

Created on 22/03/2026, 14:18:02


