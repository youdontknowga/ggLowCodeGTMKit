___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getMonthNameShort()",
  "description": "Returns the abbreviated name of the month based on the given \u003cem\u003enumber\u003c/em\u003e where 0 \u003d Jan, 1 \u003d Feb, etc.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex 0 returns Jan\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJan\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex 11 returns Dec\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e11\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eDec\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Month Index"
      }
    ],
    "help": "Returns the abbreviated name of the month. 0 = Jan, 11 = Dec.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex 0 returns Jan\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJan\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex 11 returns Dec\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e11\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eDec\u003c/strong\u003e"
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
* Returns the abbreviated name of the month based on the given integer where 0 = January, 1 = February, etc.
* 
* @param {number|string} data.src - An integer representing the month of the year (0 to 11).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {string|undefined} The abbreviated name of the month (e.g., "Jan", "Feb", etc.), or undefined if the index is invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const getMonthNameShort = function(monthInt) {
   const month = makeNumber(monthInt);
   const monthList = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"];
   return monthList[month];
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// getMonthNameShort - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(getMonthNameShort(value));
*/
// ===============================================================================
// getMonthNameShort() – Apply Mode
// ===============================================================================
return function(value) {
  return out(getMonthNameShort(value));
};


___TESTS___

scenarios:
  - name: '[example] Index 0 returns Jan'
    code: |-
      /* @display
      Value to Process: 0
      @output
      Jan
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
      assertThat(variableResult).isEqualTo("Jan");
  - name: Valid month index 5 - returns June
    code: |-
      const src = 5;
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
      assertThat(variableResult).isEqualTo("Jun");
  - name: '[example] Index 11 returns Dec'
    code: |-
      /* @display
      Value to Process: 11
      @output
      Dec
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
      assertThat(variableResult).isEqualTo("Dec");
  - name: Invalid month index - returns undefined
    code: |-
      const src = 15;
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
