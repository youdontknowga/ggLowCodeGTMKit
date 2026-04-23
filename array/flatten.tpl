___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "flatten",
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
        "type": "SIMPLE_TABLE",
        "name": "src",
        "displayName": "Values to Flatten",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "val",
            "type": "TEXT"
          }
        ],
        "help": "💾 A list of values to flatten. Each row can contain an array or a single value. Arrays will be unpacked one level deep.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e: \u003cem\u003e[\"a\", \"b\", \"c\"]\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eSingle value\u003c/strong\u003e: \u003cem\u003e\"x\"\u003c/em\u003e, \u003cem\u003e123\u003c/em\u003e, \u003cem\u003etrue\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eVariable reference\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFlatten nested arrays\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty array unchanged\u003c/em\u003e***"
      }
    ],
    "help": "Flattens a nested \u003cem\u003earray\u003c/em\u003e into a single-level array.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFlatten nested arrays\u003c/em\u003e***\u003cbr\u003eValues to Flatten: \u003cstrong\u003e[{val: ['apple', 'banana']}, {val: ['orange']}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['apple', 'banana', 'orange']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty array unchanged\u003c/em\u003e***\u003cbr\u003eValues to Flatten: \u003cstrong\u003e[]\u003c/strong\u003e\u003cbr\u003esep: \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the extracted values array before flattening (e.g., filter values, transform array). Note: Values are extracted from the table's \u003ccode\u003eval\u003c/code\u003e property before this function is applied."
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
const extractItemValues = (items) => items.map(item => item ? item.val : null);
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const extractedValues = extractItemValues(data.src);
const value = applyCast(data.pre, extractedValues);
return out(flatten(value));
// ===============================================================================
// flatten() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(flatten(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Flatten nested arrays'
    code: |-
      /* @display
      Values to Flatten: [{val: ['apple', 'banana']}, {val: ['orange']}]
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
      Values to Flatten: []
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
