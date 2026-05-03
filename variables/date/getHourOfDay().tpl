___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getHourOfDay()",
  "description": "Returns the hour of the day (0-23) from a Unix timestamp, adjusted for a specific timezone offset.",
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
        "name": "offset",
        "displayName": "Timezone Offset (Hours)",
        "simpleValueType": true,
        "help": "⚙️ The number of hours to add or subtract from UTC to get the local time. Example: use \u003cstrong\u003e2\u003c/strong\u003e for CET (UTC+2), or \u003cstrong\u003e-5\u003c/strong\u003e for EST (UTC-5). Leave blank or 0 for UTC."
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet Local Hour (UTC+2)\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e1713960000000\u003c/strong\u003e (12:00:00 UTC)\u003cbr\u003e↪️ Output: \u003cstrong\u003e14\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Timestamp"
      }
    ],
    "help": "Extracts the hour (0-23) from a given timestamp, adjusted for timezone.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet UTC Hour\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e1713960000000\u003c/strong\u003e (12:00:00 UTC)\u003cbr\u003eTimezone Offset: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet Local Hour (UTC+2)\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e1713960000000\u003c/strong\u003e (12:00:00 UTC)\u003cbr\u003eTimezone Offset: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e14\u003c/strong\u003e"
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
* Returns the hour of the day (0-23) from a Unix timestamp.
* 
* @param {number|string} data.src - A Unix timestamp in milliseconds.
* @param {number|string} data.offset - The timezone offset in hours.
* @param {Function|string} [data.out] - Optional output handler.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
* 
* @returns {number|undefined} The hour of the day (0-23), or undefined if invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');
const Math = require('Math');

const getHourOfDay = function(timestamp, offset) {
    const ts = makeNumber(timestamp);
    if (ts !== ts) return undefined;
    
    let tzOffset = makeNumber(offset);
    if (tzOffset !== tzOffset) tzOffset = 0; 
    
    let hoursSinceEpoch = Math.floor(ts / 3600000);
    
    hoursSinceEpoch += tzOffset;
    
    let hourOfDay = hoursSinceEpoch % 24;
    
    if (hourOfDay < 0) {
        hourOfDay += 24;
    }
    
    return hourOfDay;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// getHourOfDay - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(getHourOfDay(value, data.offset));
*/
// ===============================================================================
// getHourOfDay(...) – Apply Mode
// ===============================================================================

return function(value) {
   return out(getHourOfDay(value, data.offset));
};


___TESTS___

scenarios:
  - name: '[example] Get UTC Hour'
    code: |-
      /* @display
      Input: 1713960000000
      @output
      12
      */
      const src = 1713960000000; // Wed Apr 24 2024 12:00:00 GMT+0000
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
      assertThat(variableResult).isEqualTo(12);
  - name: '[example] Get Local Hour (UTC+2)'
    code: |-
      /* @display
      Input: 1713960000000
      @output
      14
      */
      const src = 1713960000000; // Wed Apr 24 2024 12:00:00 GMT+0000
      const offset = 2;
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
      assertThat(variableResult).isEqualTo(14);
  - name: Negative offset wrapping past midnight
    code: |-
      const src = 1713916800000; // Wed Apr 24 2024 00:00:00 GMT+0000
      const offset = -5;
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
      assertThat(variableResult).isEqualTo(19); // 00:00 - 5 hours = 19:00 the day before
  - name: String inputs
    code: |-
      const src = "1713960000000";
      const offset = "2";
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
      assertThat(variableResult).isEqualTo(14);
  - name: Invalid timestamp returns undefined
    code: |-
      const src = "invalid";
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
