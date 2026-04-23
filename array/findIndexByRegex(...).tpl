___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "findIndexByRegex(...)",
  "description": "Finds the first index in an \u003cem\u003earray\u003c/em\u003e where an item matches a regular expression pattern, useful for locating strings based on pattern matching.",
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
        "name": "ptn",
        "displayName": "Regex Pattern",
        "simpleValueType": true,
        "help": "🔍 A regex pattern string to match against array items.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString (regex pattern)\u003c/strong\u003e: \u003cem\u003e\"^abc\"\u003c/em\u003e, \u003cem\u003e\"value$\"\u003c/em\u003e, \u003cem\u003e\"\\d+\"\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e⚠️ \u003cstrong\u003eEscaping note:\u003c/strong\u003e In this UI field, use single backslash (e.g., \u003ccode\u003e\\d+\u003c/code\u003e for digits). GTM automatically handles the escaping.",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "idx",
        "displayName": "Start Index (optional)",
        "simpleValueType": true,
        "help": "💾 Optional index to start searching from. Default is 0 (search from beginning).\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e: \u003cem\u003e0\u003c/em\u003e, \u003cem\u003e1\u003c/em\u003e, \u003cem\u003e2\u003c/em\u003e",
        "enablingConditions": [
          {
            "paramName": "rp2",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFind by regex pattern\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: ['apple', 'banana', 'apricot', 'cherry']\u003cbr\u003eRegex Pattern: ^ap\u003cbr\u003eStart Index: 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns -1\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: ['apple', 'banana', 'cherry']\u003cbr\u003eRegex Pattern: ^orange\u003cbr\u003eStart Index: 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e-1\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Input Array"
      }
    ],
    "help": "Returns the index of the first element matching a regex pattern. Returns \u003cem\u003e-1\u003c/em\u003e if not found.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFind by regex pattern\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e['apple', 'banana', 'apricot', 'cherry']\u003c/strong\u003e\u003cbr\u003eRegex Pattern: \u003cstrong\u003e^ap\u003c/strong\u003e\u003cbr\u003eStart Index (optional): \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns -1\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e['apple', 'banana', 'cherry']\u003c/strong\u003e\u003cbr\u003eRegex Pattern: \u003cstrong\u003e^orange\u003c/strong\u003e\u003cbr\u003eStart Index (optional): \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e-1\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result index before returning it (e.g., \u003ccode\u003eidx =\u003e idx !== -1\u003c/code\u003e for boolean, \u003ccode\u003eidx =\u003e idx + 1\u003c/code\u003e for 1-based indexing). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Finds the first index in an array where an item matches a regex pattern.
 * 
 * @param {Array|string} data.src - An array of strings or a comma-separated string.
 * @param {string} data.ptn - A regex pattern string (e.g., "^abc", "value$").
 * @param {number} [data.idx] - Optional index to start searching from (default: 0).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before searching.
 * 
 * @returns {number} The index of the first matching item, or -1 if no match is found.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const findIndexByRegex = function(array, pattern, fromIndex) {
    const arr = getType(array) === 'string' ? array.split(',') : array;
    
    if (getType(arr) !== 'array') {
        return -1;
    }
    
    const startIndex = typeof fromIndex === 'number' ? fromIndex : 0;
    
    for (let i = startIndex; i < arr.length; i++) {
        const item = arr[i];
        if (typeof item === 'string' && item.match(pattern)) {
            return i;
        }
    }
    
    return -1;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// findIndexByRegex - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedArray = applyCast(data.pre, data.src);
return out(findIndexByRegex(processedArray, data.ptn, data.idx));
*/
// ===============================================================================
// findIndexByRegex(...) – Apply Mode
// ===============================================================================
return function(array, pattern, fromIndex) {
   return out(findIndexByRegex(array, data.ptn , data.idx ));
};


___TESTS___

scenarios:
  - name: '[example] Find by regex pattern'
    code: |-
      /* @display
      Value to Process: ['apple', 'banana', 'apricot', 'cherry']
      Regex Pattern: ^ap
      Start Index (optional): 0
      @output
      0
      */
      const src = ['apple', 'banana', 'apricot', 'cherry'];
      const ptn = '^ap';
      const idx = 0;
      const mockData = {
          src: src,
          ptn: ptn,
          idx: idx,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, idx);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Test finding item that ends with pattern
    code: |-
      const src = ['test123', 'example', 'value456', 'sample'];
      const ptn = '\\d+$';
      const idx = 0;
      const mockData = {
          src: src,
          ptn: ptn,
          idx: idx,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, idx);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Test with fromIndex to skip first matches
    code: |-
      const src = ['item1', 'item2', 'item3', 'item4'];
      const ptn = 'item';
      const idx = 2;
      const mockData = {
          src: src,
          ptn: ptn,
          idx: idx,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, idx);
      }
      assertThat(variableResult).isEqualTo(2);
  - name: Test with comma-separated string input
    code: |
      const src = 'hello,world,test,example';
      const ptn = 'test';
      const idx = 0;
      const mockData = {
          src: src,
          ptn: ptn,
          idx: idx,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, idx);
      }
      assertThat(variableResult).isEqualTo(2);
  - name: '[example] No match returns -1'
    code: |-
      /* @display
      Value to Process: ['apple', 'banana', 'cherry']
      Regex Pattern: ^orange
      Start Index (optional): 0
      @output
      -1
      */
      const src = ['apple', 'banana', 'cherry'];
      const ptn = '^orange';
      const idx = 0;
      const mockData = {
          src: src,
          ptn: ptn,
          idx: idx,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, idx);
      }
      assertThat(variableResult).isEqualTo(-1);
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
