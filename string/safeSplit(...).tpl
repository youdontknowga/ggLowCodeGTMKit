___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "safeSplit(...)",
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
        "name": "sep",
        "displayName": "Separator",
        "simpleValueType": true,
        "defaultValue": ",",
        "help": "🔪   The separator character to split by (default: comma).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template."
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Input To Split"
      },
      {
        "type": "GROUP",
        "name": "Advanced Settings",
        "displayName": "Advanced Settings",
        "groupStyle": "ZIPPY_OPEN_ON_PARAM",
        "subParams": [
          {
            "type": "CHECKBOX",
            "name": "rp1",
            "checkboxText": "⚡Use runtime parameter for: Separator",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Safely splits a \u003cem\u003estring\u003c/em\u003e into an array using the specified separator. If input is already an \u003cem\u003earray\u003c/em\u003e, returns it as-is. Returns empty array for invalid input.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit by comma\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eapple,banana,cherry\u003c/strong\u003e\u003cbr\u003esep: \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\"apple\", \"banana\", \"cherry\"]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit by pipe\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eone|two|three\u003c/strong\u003e\u003cbr\u003esep: \u003cstrong\u003e|\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\"one\", \"two\", \"three\"]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid input returns empty array\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003esep: \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(safeSplit(value, data.sep));
*/
// ===============================================================================
// safeSplit(...) – Apply Mode
// ===============================================================================
return function(value, separator) {
   separator = data.rp1 ? data.sep : separator;
   return out(safeSplit(value, separator));
};


___TESTS___

scenarios:
  - name: '[example] Split by comma'
    code: |-
      /* @display
      Value to Process: apple,banana,cherry
      sep: ,
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
      Value to Process: one|two|three
      sep: |
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
      Value to Process: 12345
      sep: ,
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
