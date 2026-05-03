___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "isWeekend()",
  "description": "Checks if a given date string (YYYY-MM-DD) falls on a Saturday or Sunday.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSaturday\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e2024-04-27\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Target Date"
      }
    ],
    "help": "Determines if a given date string is a weekend (Saturday or Sunday) and returns true or false.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSaturday\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e2024-04-27\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eWednesday\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e2024-04-24\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
* Checks if a given date string is a weekend.
* 
* @param {string} data.src - Target date in YYYY-MM-DD format.
* @param {Function|string} [data.out] - Optional output handler.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src.
* 
* @returns {boolean|undefined} True if Saturday or Sunday, false if weekday. Undefined if invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const isWeekend = function(dateString) {
    if (typeof dateString !== 'string') return undefined;

    const reDateFormatISO8601 = "^(\\d{4})-(\\d{2})-(\\d{2})$";
    const matchParts = dateString.match(reDateFormatISO8601);
    if (matchParts === null) return undefined;
    
    let year = makeNumber(matchParts[1]);
    let month = makeNumber(matchParts[2]);
    let day = makeNumber(matchParts[3]);

    function isLeapYear(y) {
        return (y % 4 === 0 && y % 100 !== 0) || (y % 400 === 0);
    }
    
    function dateToAbsoluteDays(y, m, d) {
        if (y < 1900 || y > 2100) return undefined;
        let total = 0;
        for (let i = 1900; i < y; i++) {
            total += isLeapYear(i) ? 366 : 365;
        }
        const daysInMonth = [0, 31, isLeapYear(y) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (d > daysInMonth[m]) return undefined; // Invalid day
        for (let i = 1; i < m; i++) {
            total += daysInMonth[i];
        }
        total += d;
        return total;
    }
    
    const absDays = dateToAbsoluteDays(year, month, day);
    if (absDays === undefined) return undefined;
    
    // Jan 1, 1900 was a Monday (absDays = 1).
    // So absDays % 7 returns: 1 = Mon, 2 = Tue, 3 = Wed, 4 = Thu, 5 = Fri, 6 = Sat, 0 = Sun
    const dayOfWeek = absDays % 7;
    
    return dayOfWeek === 0 || dayOfWeek === 6;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// isWeekend - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(isWeekend(value));
*/
// ===============================================================================
// isWeekend(...) – Apply Mode
// ===============================================================================

return function(value) {
   return out(isWeekend(value));
};


___TESTS___

scenarios:
  - name: '[example] Saturday'
    code: |-
      /* @display
      Input: 2024-04-27
      @output
      true
      */
      const src = "2024-04-27";
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
      assertThat(variableResult).isTrue();
  - name: '[example] Wednesday'
    code: |-
      /* @display
      Input: 2024-04-24
      @output
      false
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
      assertThat(variableResult).isFalse();
  - name: Sunday
    code: |-
      const src = "2024-04-28";
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
      assertThat(variableResult).isTrue();
  - name: Friday
    code: |-
      const src = "2024-04-26";
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
      assertThat(variableResult).isFalse();
  - name: Invalid date returns undefined
    code: |-
      const src = "invalid";
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
  // Change this to switch test mode ('direct', or 'apply')
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
