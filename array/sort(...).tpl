___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "sort(...)",
  "description": "Returns a sorted input \u003cem\u003earray \u003c/em\u003e. A custom comparison  \u003cem\u003efunction \u003c/em\u003e can be provided to control the sort order.",
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
        "type": "CHECKBOX",
        "name": "add",
        "checkboxText": "Add Comparison Function (Optional)",
        "simpleValueType": true,
        "help": "⚖️   Enable custom comparison function to define sort order. If not enabled, items are sorted as strings in ascending order.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eBoolean\u003c/strong\u003e",
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
        "name": "cmp",
        "displayName": "Compare Function",
        "simpleValueType": true,
        "help": "⚖️   Comparison function to define sort order.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eFunction\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "add",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSort strings alphabetically\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: ['banana', 'apple', 'cherry', 'date']\u003cbr\u003eadd: false\u003cbr\u003eCompare Function: null\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['apple', 'banana', 'cherry', 'date']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty array unchanged\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: []\u003cbr\u003eadd: false\u003cbr\u003eCompare Function: null\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Array To Sort"
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
            "checkboxText": "⚡Use runtime parameter for: Comparison Function",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Returns a sorted \u003cem\u003earray\u003c/em\u003e. A custom comparison function can be provided to control the sort order.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSort strings alphabetically\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e['banana', 'apple', 'cherry', 'date']\u003c/strong\u003e\u003cbr\u003eAdd Comparison Function (Optional): \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eCompare Function: \u003cstrong\u003enull\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['apple', 'banana', 'cherry', 'date']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty array unchanged\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[]\u003c/strong\u003e\u003cbr\u003eAdd Comparison Function (Optional): \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eCompare Function: \u003cstrong\u003enull\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., arr =\u003e arr.reverse(), arr =\u003e arr.slice(0, 5) for limiting results). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Returns a new array with the elements sorted. Accepts an optional comparison function.
* 
* @param {Array} data.src - The array to sort.
* @param {boolean} data.add - Whether to use a custom comparison function.
* @param {Function} data.cmp - Comparison function to define sort order (used when add is true).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before sorting.
* 
* @returns {Array} A new sorted array, or an empty array if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');

const sort = function(arr, useCustomCompare, compareFn) {
   if (getType(arr) !== 'array') {
       return [];
   }
   return useCustomCompare && typeof compareFn === 'function' ? arr.slice().sort(compareFn) : arr.slice().sort();
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// sort - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(sort(value, data.add, data.cmp));
*/
// ===============================================================================
// sort(...) – Apply Mode
// ===============================================================================
return function(value, useCustomCompare, compareFn) {
   useCustomCompare = data.rp1 ? data.add : useCustomCompare;
   compareFn = data.rp1 ? data.cmp : compareFn;
   return out(sort(value, true, compareFn));
};


___TESTS___

scenarios:
  - name: Array of numbers - should sort numerically as strings by default
    code: |-
      const src = [3, 1, 4, 1, 5, 9, 2];
      const add = false;
      const cmp = null;
      const mockData = {
          src: src,
          add: add,
          cmp: cmp,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add, cmp);
      }
      assertThat(variableResult).isEqualTo([1, 1, 2, 3, 4, 5, 9]);
  - name: '[example] Sort strings alphabetically'
    code: |-
      /* @display
      Value to Process: ['banana', 'apple', 'cherry', 'date']
      Add Comparison Function (Optional): false
      Compare Function: null
      @output
      ['apple', 'banana', 'cherry', 'date']
      */
      const src = ['banana', 'apple', 'cherry', 'date'];
      const add = false;
      const cmp = null;
      const mockData = {
          src: src,
          add: add,
          cmp: cmp,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add, cmp);
      }
      assertThat(variableResult).isEqualTo(['apple', 'banana', 'cherry', 'date']);
  - name: Array with custom comparison function - should sort in descending order
    code: |-
      const src = [3, 1, 4, 1, 5];
      const add = true;
      const cmp = function(a, b) { return b - a; };
      const mockData = {
          src: src,
          add: add,
          cmp: cmp,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add, cmp);
      }
      assertThat(variableResult).isEqualTo([5, 4, 3, 1, 1]);
  - name: '[example] Empty array unchanged'
    code: |
      /* @display
      Value to Process: []
      Add Comparison Function (Optional): false
      Compare Function: null
      @output
      []
      */
      const src = [];
      const add = false;
      const cmp = null;
      const mockData = {
          src: src,
          add: add,
          cmp: cmp,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add, cmp);
      }
      assertThat(variableResult).isEqualTo([]);
  - name: Non-array input - should return empty array
    code: |-
      const src = 'not an array';
      const add = false;
      const cmp = null;
      const mockData = {
          src: src,
          add: add,
          cmp: cmp,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add, cmp);
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
