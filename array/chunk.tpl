___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "chunk",
  "description": "Splits an \u003cem\u003earray\u003c/em\u003e into chunks (smaller sub-arrays) of the specified size. The last chunk may be smaller if the array can\u0027t be split evenly.",
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
        "displayName": "Array To Split",
        "simpleValueType": true,
        "help": "💾   The array to split into chunks.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "siz",
        "displayName": "Chunk Size",
        "simpleValueType": true,
        "help": "🎯   The size of each chunk (must be \u003e= 1).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Splits an \u003cem\u003earray\u003c/em\u003e into groups of the specified size.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit into equal chunks\u003c/em\u003e***\u003cbr\u003eArray To Split: \u003cstrong\u003e[1, 2, 3, 4, 5, 6]\u003c/strong\u003e\u003cbr\u003eChunk Size: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[[1, 2], [3, 4], [5, 6]]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemainder in last chunk\u003c/em\u003e***\u003cbr\u003eArray To Split: \u003cstrong\u003e[1, 2, 3, 4, 5, 6, 7]\u003c/strong\u003e\u003cbr\u003eChunk Size: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[[1, 2, 3], [4, 5, 6], [7]]\u003c/strong\u003e"
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
* Splits an array into chunks of the specified size.
* 
* @param {Array} data.src - The array to split into chunks.
* @param {number|string} data.siz - The size of each chunk (must be >= 1).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before chunking.
* 
* @returns {Array[]} A new array containing sub-arrays (chunks) of the specified size. The last chunk may be smaller if the array can't be split evenly.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');
const makeNumber = require('makeNumber');

const chunk = function(arr, size) {
   const sizeNum = makeNumber(size);
   if (getType(arr) !== 'array' || typeof sizeNum !== 'number' || sizeNum < 1) {
       return [];
   }
   const result = [];
   for (let i = 0; i < arr.length; i += sizeNum) {
       result.push(arr.slice(i, i + sizeNum));
   }
   return result;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// chunk - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(chunk(value, data.siz));
// ===============================================================================
// chunk(...) – Apply Mode
// ===============================================================================
/*
return function(value, size) {
   size = data.rp1 ? data.siz : size;
   return out(chunk(value, size));
};
*/


___TESTS___

scenarios:
  - name: '[example] Split into equal chunks'
    code: |-
      /* @display
      Array To Split: [1, 2, 3, 4, 5, 6]
      Chunk Size: 2
      @output
      [[1, 2], [3, 4], [5, 6]]
      */
      const src = [1, 2, 3, 4, 5, 6];
      const siz = 2;
      const mockData = {
          src: src,
          siz: siz,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, siz);
      }
      assertThat(variableResult).isEqualTo([[1, 2], [3, 4], [5, 6]]);
  - name: '[example] Remainder in last chunk'
    code: |-
      /* @display
      Array To Split: [1, 2, 3, 4, 5, 6, 7]
      Chunk Size: 3
      @output
      [[1, 2, 3], [4, 5, 6], [7]]
      */
      const src = [1, 2, 3, 4, 5, 6, 7];
      const siz = 3;
      const mockData = {
          src: src,
          siz: siz,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, siz);
      }
      assertThat(variableResult).isEqualTo([[1, 2, 3], [4, 5, 6], [7]]);
  - name: String size parameter - converts to number and chunks
    code: |-
      const src = ['a', 'b', 'c', 'd', 'e'];
      const siz = "2";
      const mockData = {
          src: src,
          siz: siz,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, siz);
      }
      assertThat(variableResult).isEqualTo([['a', 'b'], ['c', 'd'], ['e']]);
  - name: Invalid size less than 1 - returns empty array
    code: |-
      const src = [1, 2, 3, 4];
      const siz = 0;
      const mockData = {
          src: src,
          siz: siz,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, siz);
      }
      assertThat(variableResult).isEqualTo([]);
  - name: Non-array input - returns empty array
    code: |-
      const src = "not an array";
      const siz = 2;
      const mockData = {
          src: src,
          siz: siz,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, siz);
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
