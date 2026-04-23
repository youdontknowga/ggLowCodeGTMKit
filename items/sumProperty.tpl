___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "sumProperty",
  "description": "Sums the specified property across all objects in an \u003cem\u003earray\u003c/em\u003e, ignoring items where the property is missing or not a number. Useful for calculating totals from object collections.",
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
        "displayName": "Input Array",
        "simpleValueType": true,
        "help": "💾   The array of objects.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "prp",
        "displayName": "Property Name",
        "simpleValueType": true,
        "help": "💾   The name of the numeric property to sum.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Sums a specified property across all objects in an array. Non-numeric values are ignored.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSum numeric property\u003c/em\u003e***\u003cbr\u003eInput Array: \u003cstrong\u003e[{price: 10}, {price: 20}, {price: 30}]\u003c/strong\u003e\u003cbr\u003eProperty Name: \u003cstrong\u003eprice\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e60\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIgnores invalid values\u003c/em\u003e***\u003cbr\u003eInput Array: \u003cstrong\u003e[{count: 5}, {count: 'invalid'}, {count: 10}, {count: null}]\u003c/strong\u003e\u003cbr\u003eProperty Name: \u003cstrong\u003ecount\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e15\u003c/strong\u003e"
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
* Sums the specified property across all objects in the array.
* 
* @param {Array} data.src - The array of objects.
* @param {string} data.prp - The name of the numeric property to sum.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before summing.
* 
* @returns {number} The total sum of the specified property.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');
const makeNumber = require('makeNumber');
const sumProperty = function(arr, property) {
   if (getType(arr) !== 'array' || typeof property !== 'string') {
       return 0;
   }
   
   let sum = 0;
   for (let i = 0; i < arr.length; i++) {
       const value = makeNumber(arr[i][property]);
       if (typeof value === 'number' && value === value) {
           sum += value;
       }
   }
   return sum;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// sumProperty - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedArray = applyCast(data.pre, data.src);
return out(sumProperty(processedArray, data.prp));
// ===============================================================================
// sumProperty(...) – Apply Mode
// ===============================================================================
/*
return function(value, property) {
   property = data.rp1 ? data.prp : property;
   return out(sumProperty(value, property));
};
*/


___TESTS___

scenarios:
  - name: '[example] Sum numeric property'
    code: |-
      /* @display
      Input Array: [{price: 10}, {price: 20}, {price: 30}]
      Property Name: price
      @output
      60
      */
      const src = [{price: 10}, {price: 20}, {price: 30}];
      const prp = 'price';
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(60);
  - name: Array of objects with string numbers - should convert and sum
    code: |-
      const src = [{amount: '5'}, {amount: '10'}, {amount: '15'}];
      const prp = 'amount';
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(30);
  - name: '[example] Ignores invalid values'
    code: |-
      /* @display
      Input Array: [{count: 5}, {count: 'invalid'}, {count: 10}, {count: null}]
      Property Name: count
      @output
      15
      */
      const src = [{count: 5}, {count: 'invalid'}, {count: 10}, {count: null}];
      const prp = 'count';
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(15);
  - name: Array of objects with decimal values - should return correct sum
    code: |
      const src = [{value: 1.5}, {value: 2.3}, {value: 3.2}];
      const prp = 'value';
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(7);
  - name: Array of objects with negative numbers - should sum correctly
    code: |-
      const src = [{balance: -10}, {balance: 20}, {balance: -5}];
      const prp = 'balance';
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(5);
  - name: Array of objects with zero values - should return 0
    code: |-
      const src = [{num: 0}, {num: 0}, {num: 0}];
      const prp = 'num';
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Empty array - should return 0
    code: |
      const src = [];
      const prp = 'value';
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Array of objects with missing property - should return 0
    code: |
      const src = [{name: 'John'}, {name: 'Jane'}, {name: 'Bob'}];
      const prp = 'price';
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Array of objects with some missing property - should sum only existing
    code: |-
      const src = [{quantity: 5}, {name: 'test'}, {quantity: 10}];
      const prp = 'quantity';
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(15);
  - name: Non-array input - should return 0
    code: |-
      const src = 'not an array';
      const prp = 'value';
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Non-string property - should return 0
    code: |-
      const src = [{price: 10}, {price: 20}];
      const prp = 123;
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Array of objects with undefined values - should ignore undefined
    code: |-
      const src = [{total: 15}, {total: undefined}, {total: 25}];
      const prp = 'total';
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(40);
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
