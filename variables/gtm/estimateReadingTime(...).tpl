___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "estimateReadingTime(...)",
  "description": "Estimates reading time in seconds based on word count. Applies a fallback minimum duration if the calculated time is too low.",
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
        "name": "wpm",
        "displayName": "Words Per Minute",
        "simpleValueType": true,
        "help": "💾   Average reading speed in words per minute (default: 350).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
        "enablingConditions": []
      },
      {
        "type": "TEXT",
        "name": "min",
        "displayName": "Minimum Seconds",
        "simpleValueType": true,
        "help": "💾   Minimum number of seconds to return (default: 30).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
        "enablingConditions": []
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDefault reading time\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 700\u003cbr\u003eWords Per Minute: undefined\u003cbr\u003eMinimum Seconds: undefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e120\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid input returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: not a number\u003cbr\u003eWords Per Minute: undefined\u003cbr\u003eMinimum Seconds: undefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Word Count"
      }
    ],
    "help": "Estimates the reading time of content based on word count.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDefault reading time\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e700\u003c/strong\u003e\u003cbr\u003eWords Per Minute: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003eMinimum Seconds: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e120\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid input returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003enot a number\u003c/strong\u003e\u003cbr\u003eWords Per Minute: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003eMinimum Seconds: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
* Estimates reading time in seconds based on word count.
* 
* @param {number} data.src - The total number of words to base the estimate on.
* @param {number|string} data.wpm - Average reading speed in words per minute (default: 350).
* @param {number|string} data.min - Minimum number of seconds to return (default: 30).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before calculation.
* 
* @returns {number|undefined} Estimated reading time in seconds, or undefined if word count is invalid.
* @author Markus Baersch
* @see https://bit.ly/4katPuD
* @modified Adaptation to the library framework
*
* @framework ggLowCodeGTMKit
*/
const Math = require('Math');
const makeNumber = require('makeNumber');

const estimateReadingTime = function(wordCount, wordsPerMinute, minSecs) {
   const words = makeNumber(wordCount);
   if (words !== words) { return undefined; }
   const wpmNum = makeNumber(wordsPerMinute);
   const wpm = (wpmNum === wpmNum && wordsPerMinute !== undefined) ? wpmNum : 350;
   const minSecsNum = makeNumber(minSecs);
   const minSeconds = (minSecsNum === minSecsNum && minSecs !== undefined) ? minSecsNum : 30;
   const timeInSeconds = Math.round((words / wpm) * 60);
   return Math.max(timeInSeconds, minSeconds);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// estimateReadingTime - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(estimateReadingTime(value, data.wpm, data.min));
*/
// ===============================================================================
// estimateReadingTime(...) – Apply Mode
// ===============================================================================
return function(value, wordsPerMinute, minSecs) {
   return out(estimateReadingTime(value, data.wpm , data.min));
};


___TESTS___

scenarios:
  - name: '[example] Default reading time'
    code: |-
      /* @display
      Value to Process: 700
      Words Per Minute: undefined
      Minimum Seconds: undefined
      @output
      120
      */
      const src = 700;
      const wpm = undefined;
      const min = undefined;
      const mockData = {
          src: src,
          wpm: wpm,
          min: min,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, wpm, min);
      }
      assertThat(variableResult).isEqualTo(120);
  - name: Valid word count with custom words per minute - calculates correctly
    code: |-
      const src = 500;
      const wpm = 250;
      const min = undefined;
      const mockData = {
          src: src,
          wpm: wpm,
          min: min,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, wpm, min);
      }
      assertThat(variableResult).isEqualTo(120);
  - name: Low word count below minimum - returns minimum seconds
    code: |-
      const src = 50;
      const wpm = undefined;
      const min = undefined;
      const mockData = {
          src: src,
          wpm: wpm,
          min: min,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, wpm, min);
      }
      assertThat(variableResult).isEqualTo(30);
  - name: Valid word count with custom minimum - respects custom minimum
    code: |
      const src = 100;
      const wpm = undefined;
      const min = 60;
      const mockData = {
          src: src,
          wpm: wpm,
          min: min,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, wpm, min);
      }
      assertThat(variableResult).isEqualTo(60);
  - name: '[example] Invalid input returns undefined'
    code: |-
      /* @display
      Value to Process: not a number
      Words Per Minute: undefined
      Minimum Seconds: undefined
      @output
      undefined
      */
      const src = "not a number";
      const wpm = undefined;
      const min = undefined;
      const mockData = {
          src: src,
          wpm: wpm,
          min: min,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, wpm, min);
      }
      assertThat(variableResult).isUndefined();
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'apply';
  // ==========================================================a=========================================
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
