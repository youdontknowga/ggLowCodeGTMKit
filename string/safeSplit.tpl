___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "safeSplit",
  "description": "Safely splits a comma-separated string into an \u003cem\u003earray\u003c/em\u003e. If the input is not a \u003cem\u003estring\u003c/em\u003e, returns the value as-is.",
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
        "displayName": "Input To Split",
        "simpleValueType": true,
        "help": "💾   String to split or array to return as-is.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "sep",
        "displayName": "Separator",
        "simpleValueType": true,
        "defaultValue": ",",
        "help": "🔪   The separator character to split by (default: comma).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Safely splits a \u003cem\u003estring\u003c/em\u003e into an array using the specified separator. If input is already an \u003cem\u003earray\u003c/em\u003e, returns it as-is. Returns empty array for invalid input.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit by comma\u003c/em\u003e***\u003cbr\u003eInput To Split: \u003cstrong\u003eapple,banana,cherry\u003c/strong\u003e\u003cbr\u003eSeparator: \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\"apple\", \"banana\", \"cherry\"]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit by pipe\u003c/em\u003e***\u003cbr\u003eInput To Split: \u003cstrong\u003eone|two|three\u003c/strong\u003e\u003cbr\u003eSeparator: \u003cstrong\u003e|\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\"one\", \"two\", \"three\"]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid input returns empty array\u003c/em\u003e***\u003cbr\u003eInput To Split: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003eSeparator: \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., trim whitespace, normalize format). Internal transformations such as splitting will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., arr =\u003e arr.length for count, arr =\u003e arr.join('|') to rejoin). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Safely splits a string into an array, returns array as-is if already array.
* 
* @param {string|Array} data.src - String to split or array to return.
* @param {string} [data.sep] - Separator (default: ',').
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before splitting.
* 
* @returns {Array} Array of elements, or empty array if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');

const safeSplit = function(input, separator) {
   if (getType(input) === 'array') return input;
   if (typeof input !== 'string') return [];
   const sep = separator || ',';
   return input.split(sep);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// safeSplit - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(safeSplit(value, data.sep));
// ===============================================================================
// safeSplit(...) – Apply Mode
// ===============================================================================
/*
return function(value, separator) {
   separator = data.rp1 ? data.sep : separator;
   return out(safeSplit(value, separator));
};
*/


___TESTS___

scenarios:
  - name: '[example] Split by comma'
    code: |-
      /* @display
      Input To Split: apple,banana,cherry
      Separator: ,
      @output
      ["apple", "banana", "cherry"]
      */
      const src = "apple,banana,cherry";
      const sep = ",";
      const mockData = {
          src: src,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sep);
      }
      assertThat(variableResult).isEqualTo(["apple", "banana", "cherry"]);
  - name: '[example] Split by pipe'
    code: |-
      /* @display
      Input To Split: one|two|three
      Separator: |
      @output
      ["one", "two", "three"]
      */
      const src = "one|two|three";
      const sep = "|";
      const mockData = {
          src: src,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sep);
      }
      assertThat(variableResult).isEqualTo(["one", "two", "three"]);
  - name: Array input - returns array as-is
    code: |-
      const src = ["already", "an", "array"];
      const sep = ",";
      const mockData = {
          src: src,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sep);
      }
      assertThat(variableResult).isEqualTo(["already", "an", "array"]);
  - name: Empty string - returns array with one empty string
    code: |-
      const src = "";
      const sep = ",";
      const mockData = {
          src: src,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sep);
      }
      assertThat(variableResult).isEqualTo([""]);
  - name: '[example] Invalid input returns empty array'
    code: |-
      /* @display
      Input To Split: 12345
      Separator: ,
      @output
      []
      */
      const src = 12345;
      const sep = ",";
      const mockData = {
          src: src,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sep);
      }
      assertThat(variableResult).isEqualTo([]);
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
