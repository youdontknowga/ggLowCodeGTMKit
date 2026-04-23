___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getMonthName()",
  "description": "Returns the full name of the month based on the given \u003cem\u003enumber\u003c/em\u003e where 0 \u003d January, 1 \u003d February, etc.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex 0 returns January\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJanuary\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex 11 returns December\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e11\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eDecember\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid index returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e12\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Month Index"
      }
    ],
    "help": "Returns the full name of the month. 0 = January, 11 = December.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex 0 returns January\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJanuary\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex 11 returns December\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e11\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eDecember\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid index returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e12\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
* Returns the full name of the month based on the given integer where 0 = January, 1 = February, etc.
* 
* @param {number|string} data.src - An integer representing the month of the year (0 to 11).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {string|undefined} The full name of the month (e.g., "January", "February", etc.), or undefined if the index is invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const getMonthFullName = function(monthInt) {
   const month = makeNumber(monthInt);
   const monthList = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
   return monthList[month];
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// getMonthFullName - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(getMonthFullName(value));
*/
// ===============================================================================
// getMonthFullName() – Apply Mode
// ===============================================================================
return function(value) {
  return out(getMonthFullName(value));
};


___TESTS___

scenarios:
  - name: '[example] Index 0 returns January'
    code: |-
      /* @display
      Value to Process: 0
      @output
      January
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
      assertThat(variableResult).isEqualTo("January");
  - name: '[example] Index 11 returns December'
    code: |-
      /* @display
      Value to Process: 11
      @output
      December
      */
      const src = 11;
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
      assertThat(variableResult).isEqualTo("December");
  - name: String number month index - converts and returns month name
    code: |-
      const src = "5";
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
      assertThat(variableResult).isEqualTo("June");
  - name: '[example] Invalid index returns undefined'
    code: |
      /* @display
      Value to Process: 12
      @output
      undefined
      */
      const src = 12;
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
  - name: Invalid string input - returns undefined
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
