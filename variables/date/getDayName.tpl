___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getDayName",
  "description": "Returns the full name of the day of the week from an ISO 8601 day number (1 \u003d Monday, 7 \u003d Sunday).",
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
        "displayName": "Day Index",
        "simpleValueType": true,
        "help": "💾   An ISO 8601 day number (1 = Monday, 7 = Sunday).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Returns the full name of the day of the week. 1 = Monday, 7 = Sunday (ISO 8601).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex 1 returns Monday\u003c/em\u003e***\u003cbr\u003eDay Index: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eMonday\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex 7 returns Sunday\u003c/em\u003e***\u003cbr\u003eDay Index: \u003cstrong\u003e7\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eSunday\u003c/strong\u003e"
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
* Returns the full name of the day of the week based on the given integer where 0 = Monday, 1 = Tuesday, etc.
* 
* @param {number|string} data.src - An integer representing the day of the week (0 to 6).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {string|undefined} The full name of the day (e.g., "Monday", "Tuesday", etc.), or undefined if the index is invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const getDayFullName = function(dayInt) {
   const day = makeNumber(dayInt);
   if (day < 1 || day > 7) return undefined;
   const dayList = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
   return dayList[day - 1];
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// getDayFullName - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(getDayFullName(value));
// ===============================================================================
// getDayFullName() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(getDayFullName(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Index 1 returns Monday'
    code: |
      /* @display
      Day Index: 1
      @output
      Monday
      */
      const src = 1;
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
  - name: Valid day index 4 - returns Thursday
    code: |-
      const src = 4;
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
      assertThat(variableResult).isEqualTo("Thursday");
  - name: '[example] Index 7 returns Sunday'
    code: |-
      /* @display
      Day Index: 7
      @output
      Sunday
      */
      const src = 7;
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
      assertThat(variableResult).isEqualTo("Sunday");
  - name: Non valid day index 10 - returns undefined
    code: |-
      const src = 10;
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

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
