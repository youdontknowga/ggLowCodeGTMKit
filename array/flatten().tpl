___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "flatten()",
  "description": "Flattens nested arrays into a single \u003cem\u003earray\u003c/em\u003e, one level deep.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFlatten nested arrays\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e[{val: ['apple', 'banana']}, {val: ['orange']}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['apple', 'banana', 'orange']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty array unchanged\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: []\u003cbr\u003esep: ,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Array to Flatten"
      }
    ],
    "help": "Flattens a nested \u003cem\u003earray\u003c/em\u003e into a single-level array.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFlatten nested arrays\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[{val: ['apple', 'banana']}, {val: ['orange']}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['apple', 'banana', 'orange']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty array unchanged\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[]\u003c/strong\u003e\u003cbr\u003esep: \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the flattened array before returning it (e.g., \u003ccode\u003earr =\u003e arr.filter(v =\u003e v)\u003c/code\u003e, \u003ccode\u003earr =\u003e arr.slice(0, 5)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Flattens nested arrays into a single array (one level deep).
 *
 * @param {Array} data.src - A list of objects with a `val` property (Direct mode) or plain values (Apply mode).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {Array} A flat array of all values.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const flatten = function(paramList) {
    const list = paramList || [];
    const result = [];
    
    for (let i = 0; i < list.length; i++) {
        const val = list[i];
        if (val === null || val === undefined) continue;
        
        const type = getType(val);
        if (type === 'array') {
            for (let j = 0; j < val.length; j++) {
                result.push(val[j]);
            }
        } else {
            result.push(val);
        }
    }
    return result;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// flatten - Direct mode
// ===============================================================================
/*
const extractItemValues = (items) => items.map(item => item ? item.val : null);
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const extractedValues = extractItemValues(data.src);
const value = applyCast(data.pre, extractedValues);
return out(flatten(value));
*/
// ===============================================================================
// flatten() – Apply Mode
// ===============================================================================
return function(value) {
   return out(flatten(value));
};


___TESTS___

scenarios:
  - name: '[example] Flatten nested arrays'
    code: |-
      /* @display
      Value to Process: [{val: ['apple', 'banana']}, {val: ['orange']}]
      @output
      ['apple', 'banana', 'orange']
      */
      const src = [{val: ['apple', 'banana']}, {val: ['orange']}];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([['apple', 'banana'], ['orange']]);
      }
      assertThat(variableResult).isEqualTo(['apple', 'banana', 'orange']);
  - name: Test flattening with mixed arrays and single values
    code: |-
      const src = [{val: [1, 2]}, {val: 3}, {val: [4, 5]}];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([[1, 2], 3, [4, 5]]);
      }
      assertThat(variableResult).isEqualTo([1, 2, 3, 4, 5]);
  - name: Test with null and undefined values
    code: |
      const src = [{val: ['a']}, {val: null}, {val: undefined}, {val: 'b'}];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([['a'], null, undefined, 'b']);
      }
      assertThat(variableResult).isEqualTo(['a', 'b']);
  - name: Test with non-string, non-array values (numbers, booleans)
    code: |-
      const src = [{val: 123}, {val: true}, {val: ['x', 'y']}];
      const sep = ',';
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
          variableResult = func([123, true, ['x', 'y']], sep);
      }
      assertThat(variableResult).isEqualTo([123, true, 'x', 'y']);
  - name: '[example] Empty array unchanged'
    code: |-
      /* @display
      Value to Process: []
      sep: ,
      @output
      []
      */
      const src = [];
      const sep = ',';
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
          variableResult = func([], sep);
      }
      assertThat(variableResult).isEqualTo([]);
  - name: Test with nested arrays (one level only)
    code: |-
      const src = [{val: [1, 2]}, {val: [[3, 4]]}];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([[1, 2], [[3, 4]]]);
      }
      assertThat(variableResult).isEqualTo([1, 2, [3, 4]]);
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
