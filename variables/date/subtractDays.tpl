___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "subtractDays",
  "description": "Subtracts a specific number of days from a target date string (YYYY-MM-DD).",
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
        "help": "💾   The starting date in YYYY-MM-DD format.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "days",
        "displayName": "Days to Subtract",
        "simpleValueType": true,
        "help": "🔢 The number of days to subtract from the target date."
      }
    ],
    "help": "Subtracts a given number of days from a date string and returns the new date in YYYY-MM-DD format.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSubtract One Week\u003c/em\u003e***\u003cbr\u003eTarget Date: \u003cstrong\u003e2024-04-20\u003c/strong\u003e\u003cbr\u003eDays to Subtract: \u003cstrong\u003e7\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e2024-04-13\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCross Month Boundary\u003c/em\u003e***\u003cbr\u003eTarget Date: \u003cstrong\u003e2024-05-01\u003c/strong\u003e\u003cbr\u003eDays to Subtract: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e2024-04-30\u003c/strong\u003e"
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
* Subtracts a specific number of days from a target date string.
* 
* @param {string} data.src - The starting date in YYYY-MM-DD format.
* @param {number|string} data.days - The number of days to subtract.
* @param {Function|string} [data.out] - Optional output handler.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src.
* 
* @returns {string|undefined} The new date in YYYY-MM-DD format, or undefined if invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const subtractDays = function(dateString, daysToSubtract) {
    if (typeof dateString !== 'string') { return undefined; }

    var days = makeNumber(daysToSubtract);
    if (days !== days) { days = 0; }

    var matchParts = dateString.match("^(\\d{4})-(\\d{2})-(\\d{2})$");
    if (matchParts === null) { return undefined; }

    var year = makeNumber(matchParts[1]);
    var month = makeNumber(matchParts[2]);
    var day = makeNumber(matchParts[3]);

    var isLeapYear = function(y) {
        return (y % 4 === 0 && y % 100 !== 0) || (y % 400 === 0);
    };

    var dateToAbsoluteDays = function(y, m, d) {
        if (y < 1900 || y > 2100) { return undefined; }
        if (m < 1 || m > 12) { return undefined; }

        var daysInMonth = [0, 31, isLeapYear(y) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (d < 1 || d > daysInMonth[m]) { return undefined; }

        var total = 0;
        var i = 1900;

        while (i < y) {
            total = total + (isLeapYear(i) ? 366 : 365);
            i = i + 1;
        }

        i = 1;
        while (i < m) {
            total = total + daysInMonth[i];
            i = i + 1;
        }

        return total + d;
    };

    var absoluteDaysToDate = function(absDays) {
        var y = 1900;
        var yearDays = isLeapYear(y) ? 366 : 365;

        while (absDays > yearDays) {
            absDays = absDays - yearDays;
            y = y + 1;
            yearDays = isLeapYear(y) ? 366 : 365;
        }

        var m = 1;
        var daysInMonth = [0, 31, isLeapYear(y) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

        while (absDays > daysInMonth[m]) {
            absDays = absDays - daysInMonth[m];
            m = m + 1;
        }

        var d = absDays;

        var mm = m < 10 ? '0' + m : '' + m;
        var dd = d < 10 ? '0' + d : '' + d;

        return y + '-' + mm + '-' + dd;
    };

    var absDays = dateToAbsoluteDays(year, month, day);
    if (absDays === undefined) { return undefined; }

    var newAbsDays = absDays - days;
    if (newAbsDays < 1) { return undefined; }

    return absoluteDaysToDate(newAbsDays);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// subtractDays - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(subtractDays(value, data.days));
// ===============================================================================
// subtractDays(...) – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(subtractDays(value, data.days));
};
*/


___TESTS___

scenarios:
  - name: '[example] Subtract One Week'
    code: |-
      /* @display
      Target Date: 2024-04-20
      Days to Subtract: 7
      @output
      2024-04-13
      */
      const src = "2024-04-20";
      const days = 7;
      const mockData = {
          src: src,
          days: days,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("2024-04-13");
  - name: '[example] Cross Month Boundary'
    code: |-
      /* @display
      Target Date: 2024-05-01
      Days to Subtract: 1
      @output
      2024-04-30
      */
      const src = "2024-05-01";
      const days = 1;
      const mockData = {
          src: src,
          days: days,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("2024-04-30");
  - name: Cross Leap Year Boundary
    code: |-
      const src = "2024-03-01";
      const days = 1;
      const mockData = {
          src: src,
          days: days,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("2024-02-29");
  - name: Cross Non-Leap Year Boundary
    code: |-
      const src = "2023-03-01";
      const days = 1;
      const mockData = {
          src: src,
          days: days,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("2023-02-28");
  - name: Subtract 365 Days
    code: |-
      const src = "2024-01-01";
      const days = 365;
      const mockData = {
          src: src,
          days: days,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("2023-01-01"); // 2024 is leap year, but we're subtracting from Jan 1, so 2023 is non-leap (365 days back is Jan 1)
  - name: Subtract negative days
    code: |-
      const src = "2024-01-05";
      const days = -5;
      const mockData = {
          src: src,
          days: days,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("2024-01-10");
  - name: Invalid date returns undefined
    code: |-
      const mockData = {
          src: "invalid",
          days: 1,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func("invalid");
      }
      assertThat(variableResult).isUndefined();
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'direct';
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
