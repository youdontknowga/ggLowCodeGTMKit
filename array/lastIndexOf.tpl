___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "lastIndexOf",
  "description": "Searches for the last occurrence of a specified value in a string or array, starting from a specified position. The position can be given as a fromIndex.",
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
        "displayName": "Input (String or Array)",
        "simpleValueType": true,
        "help": "💾 The string or array to search for the last occurrence.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e: \u003cem\u003e\"hello world\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e: \u003cem\u003e[1, 2, 3, 2, 1]\u003c/em\u003e"
      },
      {
        "type": "TEXT",
        "name": "val",
        "displayName": "Search Value",
        "simpleValueType": true,
        "help": "💾 The value to search for. For strings, searches for substring. For arrays, searches for element.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny type\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "idx",
        "displayName": "From Index (optional)",
        "simpleValueType": true,
        "help": "💾 Optional position to start searching backwards from. If not provided, searches from the end. Negative values return -1.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e: \u003cem\u003e5\u003c/em\u003e, \u003cem\u003e10\u003c/em\u003e"
      }
    ],
    "help": "Returns the index of the last occurrence of a specified value in a \u003cem\u003estring\u003c/em\u003e or \u003cem\u003earray\u003c/em\u003e. Returns \u003cem\u003e-1\u003c/em\u003e if not found.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eLast index in array\u003c/em\u003e***\u003cbr\u003eInput (String or Array): \u003cstrong\u003e[1, 2, 3, 2, 5]\u003c/strong\u003e\u003cbr\u003eSearch Value: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNot found returns -1\u003c/em\u003e***\u003cbr\u003eInput (String or Array): \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003eSearch Value: \u003cstrong\u003ez\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e-1\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before searching (e.g., normalize case, filter array)."
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
        "help": "⚙️ Optional function to apply to the index result before returning it (e.g., \u003ccode\u003eidx =\u003e idx !== -1\u003c/code\u003e for boolean, \u003ccode\u003eidx =\u003e idx + 1\u003c/code\u003e for 1-based indexing). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Returns the index of the last occurrence of a specified value in a string or an array.
 * 
 * @param {string|Array} data.src - The string or array to search.
 * @param {any} data.val - The element to search for in the string or array.
 * @param {number} [data.idx] - Optional position at which to start the search (searches backwards from this index).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before searching.
 * 
 * @returns {number} The index of the last occurrence of the value, or -1 if not found or input is invalid.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const lastIndexOf = function(input, searchElement, fromIndex) {
    const inputType = getType(input);
    
    if (inputType !== 'array' && inputType !== 'string') {
        return -1;
    }
    
    // Use default fromIndex if not provided
    const startIndex = typeof fromIndex === 'number' ? fromIndex : input.length - 1;
    
    if (startIndex < 0) {
        return -1;
    }
    
    return input.lastIndexOf(searchElement, startIndex);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// lastIndexOf - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(lastIndexOf(value, data.val, data.idx));
// ===============================================================================
// lastIndexOf(...) – Apply Mode
// ===============================================================================
/*
return function(input, searchElement, fromIndex) {
   searchElement = data.rp1 ? data.val : searchElement;
   fromIndex = data.rp2 ? data.idx : fromIndex;
   return out(lastIndexOf(input, searchElement, fromIndex));
};
*/


___TESTS___

scenarios:
  - name: Find last occurrence of character in string
    code: |-
      const src = "hello world hello";
      const val = "l";
      const mockData = {
          src: src,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo(15);
  - name: '[example] Last index in array'
    code: |-
      /* @display
      Input (String or Array): [1, 2, 3, 2, 5]
      Search Value: 2
      @output
      3
      */
      const src = [1, 2, 3, 2, 5];
      const val = 2;
      const mockData = {
          src: src,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo(3);
  - name: Search with fromIndex parameter limiting search range
    code: |-
      const src = "javascript javascript";
      const val = "a";
      const idx = 8;
      const mockData = {
          src: src,
          val: val,
          idx: idx,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val, idx);
      }
      assertThat(variableResult).isEqualTo(3);
  - name: '[example] Not found returns -1'
    code: |-
      /* @display
      Input (String or Array): hello world
      Search Value: z
      @output
      -1
      */
      const src = "hello world";
      const val = "z";
      const mockData = {
          src: src,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo(-1);
  - name: Invalid input type returns -1
    code: |-
      const src = 12345;
      const val = "3";
      const mockData = {
          src: src,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo(-1);
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
