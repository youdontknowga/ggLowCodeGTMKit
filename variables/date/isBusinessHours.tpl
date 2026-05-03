___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "isBusinessHours",
  "description": "Checks if a given timestamp falls within business hours (Monday-Friday, between a specific start and end hour).",
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
        "displayName": "Timestamp",
        "simpleValueType": true,
        "help": "💾   A Unix timestamp in milliseconds.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "offset",
        "displayName": "Timezone Offset (Hours)",
        "simpleValueType": true,
        "help": "⚙️ The number of hours to add or subtract from UTC to get the local time. Example: use \u003cstrong\u003e2\u003c/strong\u003e for CET (UTC+2), or \u003cstrong\u003e-5\u003c/strong\u003e for EST (UTC-5). Leave blank or 0 for UTC."
      },
      {
        "type": "TEXT",
        "name": "startHour",
        "displayName": "Start Hour (0-23)",
        "simpleValueType": true,
        "help": "⏰ The hour when business starts (e.g., 9 for 9:00 AM). Defaults to 9."
      },
      {
        "type": "TEXT",
        "name": "endHour",
        "displayName": "End Hour (0-23)",
        "simpleValueType": true,
        "help": "⏰ The hour when business ends (e.g., 17 for 5:00 PM). Business hours are strictly \u003cem\u003ebefore\u003c/em\u003e this hour. Defaults to 17."
      }
    ],
    "help": "Checks if a given timestamp falls within business hours (Monday-Friday, between a specific start and end hour), adjusted for timezone.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValid Business Time\u003c/em\u003e***\u003cbr\u003eTimestamp: \u003cstrong\u003e[Wednesday 2:00 PM]\u003c/strong\u003e\u003cbr\u003eHours: \u003cstrong\u003e9 to 17\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eWeekend Time\u003c/em\u003e***\u003cbr\u003eTimestamp: \u003cstrong\u003e[Saturday 2:00 PM]\u003c/strong\u003e\u003cbr\u003eHours: \u003cstrong\u003e9 to 17\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
* Checks if a given timestamp falls within business hours.
* 
* @param {number|string} data.src - A Unix timestamp in milliseconds.
* @param {number|string} data.offset - The timezone offset in hours.
* @param {number|string} data.startHour - Start hour (default 9).
* @param {number|string} data.endHour - End hour (default 17).
* @param {Function|string} [data.out] - Optional output handler.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function.
* 
* @returns {boolean|undefined} True if within business hours, false otherwise. Undefined if invalid timestamp.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');
const Math = require('Math');

const isBusinessHours = function(timestamp, offset, startHour, endHour) {
    const ts = makeNumber(timestamp);
    if (ts !== ts) return undefined;
    
    let tzOffset = makeNumber(offset);
    if (tzOffset !== tzOffset) tzOffset = 0;
    
    let start = makeNumber(startHour);
    if (start !== start) start = 9;
    
    let end = makeNumber(endHour);
    if (end !== end) end = 17;
    
    const localTs = ts + (tzOffset * 3600000);
    const localDaysSinceEpoch = Math.floor(localTs / 86400000);
    
    // 0 = Thursday, 1 = Friday, 2 = Saturday, 3 = Sunday, 4 = Monday...
    const dayOfWeek = (localDaysSinceEpoch + 4) % 7;
    const positiveDayOfWeek = (dayOfWeek + 7) % 7; // Ensure positive: 0 = Sunday, 6 = Saturday
    
    if (positiveDayOfWeek === 0 || positiveDayOfWeek === 6) {
        return false;
    }
    
    let hoursSinceEpoch = Math.floor(localTs / 3600000);
    let hourOfDay = hoursSinceEpoch % 24;
    if (hourOfDay < 0) hourOfDay += 24;
    
    return (hourOfDay >= start && hourOfDay < end);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// isBusinessHours - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(isBusinessHours(value, data.offset, data.startHour, data.endHour));
// ===============================================================================
// isBusinessHours(...) – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(isBusinessHours(value, data.offset, data.startHour, data.endHour));
};
*/


___TESTS___

scenarios:
  - name: '[example] Valid Business Time'
    code: |-
      /* @display
      Timestamp: 1713960000000 (Wed Apr 24 2024 12:00:00 GMT+0000)
      Hours: 9 to 17
      @output
      true
      */
      const src = 1713960000000;
      const offset = 0;
      const startHour = 9;
      const endHour = 17;
      const mockData = {
          src: src,
          offset: offset,
          startHour: startHour,
          endHour: endHour,
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
  - name: '[example] Weekend Time'
    code: |-
      /* @display
      Timestamp: 1714219200000 (Sat Apr 27 2024 12:00:00 GMT+0000)
      Hours: 9 to 17
      @output
      false
      */
      const src = 1714219200000;
      const offset = 0;
      const mockData = {
          src: src,
          offset: offset,
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
  - name: Outside Business Hours (Before Start)
    code: |-
      const src = 1713942000000; // 07:00:00 UTC
      const mockData = {
          src: src,
          offset: 0,
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
  - name: Outside Business Hours (After End)
    code: |-
      const src = 1713985200000; // 19:00:00 UTC
      const mockData = {
          src: src,
          offset: 0,
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
  - name: Within Business Hours with Timezone Offset
    code: |-
      const src = 1713934800000; // 05:00:00 UTC (Too early)
      const offset = 5; // Local time is 10:00:00 (Business hours!)
      const mockData = {
          src: src,
          offset: offset,
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
  - name: Invalid timestamp returns undefined
    code: |-
      const mockData = {
          src: "invalid",
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
