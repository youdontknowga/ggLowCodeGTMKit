___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "calculateDaysDifference(...)",
  "description": "Calculate the difference in days between two dates in YYYY-MM-DD format without using the Date object.",
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
        "name": "end",
        "displayName": "End Date",
        "simpleValueType": true,
        "help": "⏹️   End date in YYYY-MM-DD format.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePositive day difference\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 2024-01-01\u003cbr\u003eEnd Date: 2024-01-10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e9\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSame dates return 0\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 2024-06-15\u003cbr\u003eEnd Date: 2024-06-15\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid format returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 2024/01/01\u003cbr\u003eEnd Date: 2024-01-10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Start Date"
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
            "checkboxText": "⚡Use runtime parameter for: End Date",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Calculates the difference in days between two dates in YYYY-MM-DD format. Returns positive if end date is after start date.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePositive day difference\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e2024-01-01\u003c/strong\u003e\u003cbr\u003eEnd Date: \u003cstrong\u003e2024-01-10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e9\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSame dates return 0\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e2024-06-15\u003c/strong\u003e\u003cbr\u003eEnd Date: \u003cstrong\u003e2024-06-15\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid format returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e2024/01/01\u003c/strong\u003e\u003cbr\u003eEnd Date: \u003cstrong\u003e2024-01-10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
* Calculate the difference in days between two dates in YYYY-MM-DD format without using the Date object.
* 
* @param {string} data.src - Start date in YYYY-MM-DD format.
* @param {string} data.end - End date in YYYY-MM-DD format.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before calculation.
* 
* @returns {number|undefined} The difference in days (positive if endDate > startDate), or undefined if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const calculateDaysDifference = function(startDate, endDate) {
   if (typeof startDate !== 'string' || typeof endDate !== 'string') { return undefined; }
   const reDateFormatISO8601 = "^(\\d{4})-(\\d{2})-(\\d{2})$";
   const startDateMatchParts = startDate.match(reDateFormatISO8601);
   const endDateMatchParts = endDate.match(reDateFormatISO8601);
   if (startDateMatchParts === null || endDateMatchParts === null) { return undefined; }
   
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
   
   const startTotalDays = calculateDaysSinceEpoch(makeNumber(startDateMatchParts[1]), makeNumber(startDateMatchParts[2]), makeNumber(startDateMatchParts[3]));
   const endTotalDays = calculateDaysSinceEpoch(makeNumber(endDateMatchParts[1]), makeNumber(endDateMatchParts[2]), makeNumber(endDateMatchParts[3]));
   return endTotalDays - startTotalDays;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// calculateDaysDifference - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(calculateDaysDifference(value, data.end));
*/
// ===============================================================================
// calculateDaysDifference(...) – Apply Mode
// ===============================================================================
return function(value, endDate) {
   endDate = data.rp1 ? data.end : endDate;
   return out(calculateDaysDifference(value, endDate));
};


___TESTS___

scenarios:
  - name: '[example] Positive day difference'
    code: |-
      /* @display
      Value to Process: 2024-01-01
      End Date: 2024-01-10
      @output
      9
      */
      const src = "2024-01-01";
      const end = "2024-01-10";
      const mockData = {
          src: src,
          end: end,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, end);
      }
      assertThat(variableResult).isEqualTo(9);
  - name: '[example] Same dates return 0'
    code: |-
      /* @display
      Value to Process: 2024-06-15
      End Date: 2024-06-15
      @output
      0
      */
      const src = "2024-06-15";
      const end = "2024-06-15";
      const mockData = {
          src: src,
          end: end,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, end);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: End date before start date - returns negative number
    code: |-
      const src = "2024-12-31";
      const end = "2024-01-01";
      const mockData = {
          src: src,
          end: end,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, end);
      }
      assertThat(variableResult).isEqualTo(-365);
  - name: Dates spanning leap year - handles leap year correctly
    code: |
      const src = "2024-02-28";
      const end = "2024-03-01";
      const mockData = {
          src: src,
          end: end,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, end);
      }
      assertThat(variableResult).isEqualTo(2);
  - name: '[example] Invalid format returns undefined'
    code: |-
      /* @display
      Value to Process: 2024/01/01
      End Date: 2024-01-10
      @output
      undefined
      */
      const src = "2024/01/01";
      const end = "2024-01-10";
      const mockData = {
          src: src,
          end: end,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, end);
      }
      assertThat(variableResult).isUndefined();
  - name: Invalid input - returns undefined
    code: |-
      const src = {};
      const end = null;
      const mockData = {
          src: src,
          end: end,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, end);
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
