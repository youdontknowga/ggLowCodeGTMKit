___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "selectFromArray(...)",
  "description": "Selects an element from the \u003cem\u003earray\u003c/em\u003e based on the provided index. Returns undefined if the index is invalid or array is not valid.",
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
        "name": "idx",
        "displayName": "Index",
        "simpleValueType": true,
        "help": "🎯   The index of the element to select.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSelect by index\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: ['apple', 'banana', 'cherry', 'date']\u003cbr\u003eIndex: 2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003echerry\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOut of bounds returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: [1, 2, 3]\u003cbr\u003eIndex: 10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Array To Select From"
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
            "checkboxText": "⚡Use runtime parameter for: Index",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Selects an element from the \u003cem\u003earray\u003c/em\u003e based on the provided index. Returns \u003cem\u003eundefined\u003c/em\u003e if invalid.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSelect by index\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e['apple', 'banana', 'cherry', 'date']\u003c/strong\u003e\u003cbr\u003eIndex: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003echerry\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOut of bounds returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[1, 2, 3]\u003c/strong\u003e\u003cbr\u003eIndex: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., val =\u003e val.toUpperCase(), val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Selects an element from the array based on the provided index.
* 
* @param {Array} data.src - The array from which to select an element.
* @param {number|string} data.idx - The index of the element to select.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before selection.
* 
* @returns {any} The selected element at the specified index, or undefined if the index is invalid or array is not valid.
*
* @framework ggLowCodeGTMKit
*/
const getType = require("getType");
const makeNumber = require('makeNumber');

const selectFromArray = function(array, index) {
   if (getType(array) === 'array') {
       const idx = makeNumber(index);
       return array[idx]; 
   }
   return undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// selectFromArray - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(selectFromArray(value, data.idx));
*/
// ===============================================================================
// selectFromArray(...) – Apply Mode
// ===============================================================================
return function(value, index) {
   index = data.rp1 ? data.idx : index;
   return out(selectFromArray(value, index));
};


___TESTS___

scenarios:
  - name: '[example] Select by index'
    code: |-
      /* @display
      Value to Process: ['apple', 'banana', 'cherry', 'date']
      Index: 2
      @output
      cherry
      */
      const src = ['apple', 'banana', 'cherry', 'date'];
      const idx = 2;
      const mockData = {
          src: src,
          idx: idx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx);
      }
      assertThat(variableResult).isEqualTo('cherry');
  - name: String index parameter - converts to number and selects element
    code: |-
      const src = [10, 20, 30, 40, 50];
      const idx = "3";
      const mockData = {
          src: src,
          idx: idx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx);
      }
      assertThat(variableResult).isEqualTo(40);
  - name: Index zero - returns first element
    code: |-
      const src = ['first', 'second', 'third'];
      const idx = 0;
      const mockData = {
          src: src,
          idx: idx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx);
      }
      assertThat(variableResult).isEqualTo('first');
  - name: '[example] Out of bounds returns undefined'
    code: |
      /* @display
      Value to Process: [1, 2, 3]
      Index: 10
      @output
      undefined
      */
      const src = [1, 2, 3];
      const idx = 10;
      const mockData = {
          src: src,
          idx: idx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx);
      }
      assertThat(variableResult).isUndefined();
  - name: Non-array input - returns undefined
    code: |-
      const src = "not an array";
      const idx = 0;
      const mockData = {
          src: src,
          idx: idx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx);
      }
      assertThat(variableResult).isUndefined();
  - name: Non-integer index - returns undefined
    code: |-
      const src = ['zero', 'one', 'two', 'three', 'four'];
      const idx = 2.7;
      const mockData = {
          src: src,
          idx: idx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx);
      }
      assertThat(variableResult).isUndefined();
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
