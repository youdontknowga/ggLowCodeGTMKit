___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "timestampToDayIndex",
  "description": "Converts a Unix timestamp in \u003cem\u003emilliseconds\u003c/em\u003e to a day index since epoch. Useful for measuring days between two events by subtracting day indices in your analytics tool.",
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
        "help": "💾 The Unix timestamp in milliseconds to convert to a day index.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e: \u003cem\u003e1718726400000\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eStringified Number\u003c/strong\u003e: \u003cem\u003e\"1718726400000\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eVariable\u003c/strong\u003e: \u003cem\u003e{{currentTimestamp}}\u003c/em\u003e",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      }
    ],
    "help": "Converts a Unix timestamp in milliseconds to a day index since epoch. Useful for measuring days between events.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eConvert timestamp to day index\u003c/em\u003e***\u003cbr\u003eTimestamp: \u003cstrong\u003e1718726400000\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e19892\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid input returns undefined\u003c/em\u003e***\u003cbr\u003eTimestamp: \u003cstrong\u003einvalid\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., parse string to number, apply mathematical operations). Internal transformations such as absolute value calculation will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the day index before returning it (e.g., \u003ccode\u003ex =\u003e x * -1\u003c/code\u003e to negate, \u003ccode\u003ex =\u003e x.toString()\u003c/code\u003e to convert to string)."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Converts a Unix timestamp in milliseconds to a day index since epoch (January 1, 1970).
 * Useful for calculating the number of days between two events by subtracting day indices.
 *
 * @param {number} data.src - The Unix timestamp in milliseconds.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function.
 *
 * @returns {number} The day index since epoch, or undefined if input is invalid.
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');
const Math = require('Math');
const timestampToDayIndex = function(timestamp) {
    const ts = makeNumber(timestamp);
    if (typeof ts !== 'number' || ts !== ts) return undefined;
    return Math.floor(ts / 86400000);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// timestampToDayIndex - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(timestampToDayIndex(value));
// ===============================================================================
// timestampToDayIndex(...) – Apply Mode
// ===============================================================================
/*
return function(timestamp) {
    return out(timestampToDayIndex(timestamp));
};
*/


___TESTS___

scenarios:
  - name: '[example] Convert timestamp to day index'
    code: |-
      /* @display
      Timestamp: 1718726400000
      @output
      19892
      */
      const mockData = {src: 1718726400000}; // 2024-06-18
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(1718726400000);
      }
      assertThat(variableResult).isEqualTo(19892);
  - name: Difference between two day indices equals number of days
    code: |
      const mockData = {src: 1719331200000}; // 2024-06-25 → 7 days later
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(1719331200000);
      }
      assertThat(variableResult - 19892).isEqualTo(7);
  - name: Same day returns same index
    code: |-
      const dayStart = 19892 * 86400000;        // start of day 19892
      const dayMiddle = dayStart + 43200000;    // + 12 hours, same day
      let variableResult3a;
      let variableResult3b;
      if (isDirectMode) {
          variableResult3a = runCode({src: dayStart});
          variableResult3b = runCode({src: dayMiddle});
      } else if (isApplyMode) {
          const func = runCode({src: dayStart});
          variableResult3a = func(dayStart);
          variableResult3b = func(dayMiddle);
      }
      assertThat(variableResult3a).isEqualTo(variableResult3b);
  - name: Stringified number is converted
    code: |-
      const mockData = {src: '1718726400000'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('1718726400000');
      }
      assertThat(variableResult).isEqualTo(19892);
  - name: '[example] Invalid input returns undefined'
    code: |-
      /* @display
      Timestamp: invalid
      @output
      undefined
      */
      const mockData = {src: 'invalid'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('invalid');
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

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
