___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "sumProductOfProperties",
  "description": "Multiplies two numeric properties for each object in an \u003cem\u003earray\u003c/em\u003e and sums the results, ignoring non-numeric values. Useful for calculating totals like price × quantity across object collections.",
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
        "name": "pr1",
        "displayName": "First Property Name",
        "simpleValueType": true,
        "help": "💾   The name of the first numeric property to multiply (e.g., \"price\").\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "pr2",
        "displayName": "Second Property Name",
        "simpleValueType": true,
        "help": "💾   The name of the second numeric property to multiply (e.g., \"quantity\").\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Multiplies two numeric properties for each object and sums the results. Useful for price × quantity totals.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSum of price × quantity\u003c/em\u003e***\u003cbr\u003eInput Array: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{price: \u003cstrong\u003e10, quantity: 2},\u003c/strong\u003e\u003cbr\u003e{price: \u003cstrong\u003e20, quantity: 3},\u003c/strong\u003e\u003cbr\u003e{price: \u003cstrong\u003e30, quantity: 1}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e110\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty array returns 0\u003c/em\u003e***\u003cbr\u003eInput Array: \u003cstrong\u003e[]\u003c/strong\u003e\u003cbr\u003eFirst Property Name: \u003cstrong\u003eprice\u003c/strong\u003e\u003cbr\u003eSecond Property Name: \u003cstrong\u003equantity\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e"
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
 * Sums the product of two numeric properties across all objects in an array.
 *
 * @param {Array} data.src - The array of objects.
 * @param {string} data.pr1 - The first numeric property to multiply (e.g., "price").
 * @param {string} data.pr2 - The second numeric property to multiply (e.g., "quantity").
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * @returns {number} The sum of (value1 * value2) for each item. Returns 0 if array is invalid.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');
const makeNumber = require('makeNumber');

const sumProductOfProperties = function(arr, prop1, prop2) {
  if (getType(arr) !== 'array' || typeof prop1 !== 'string' || typeof prop2 !== 'string') {
    return 0;
  }

  let sum = 0;
  for (let i = 0; i < arr.length; i++) {
    const v1 = makeNumber(arr[i][prop1]);
    const v2 = makeNumber(arr[i][prop2]);
    if (typeof v1 === 'number' && v1 === v1 && typeof v2 === 'number' && v2 === v2) {
      sum += v1 * v2;
    }
  }
  return sum;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// sumProductOfProperties - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(sumProductOfProperties(value, data.pr1, data.pr2));

// ===============================================================================
// sumProductOfProperties - Apply mode
// ===============================================================================
/*
return function(arr, prop1, prop2) {
  prop1 = data.rp1 ? data.pr1 : prop1;
  prop2 = data.rp2 ? data.pr2 : prop2;
  return out(sumProductOfProperties(arr, prop1, prop2));
};
*/


___TESTS___

scenarios:
  - name: '[example] Sum of price × quantity'
    code: |-
      /* @display
      Input Array: [
          {price: 10, quantity: 2},
          {price: 20, quantity: 3},
          {price: 30, quantity: 1}
      ]
      @output
      110
      */
      const src = [
          {price: 10, quantity: 2},
          {price: 20, quantity: 3},
          {price: 30, quantity: 1}
      ];
      const mockData = {src: src, pr1: 'price', pr2: 'quantity'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, 'price', 'quantity');
      }
      assertThat(variableResult).isEqualTo(110); // (10*2) + (20*3) + (30*1)
  - name: Skips invalid (non-numeric) values
    code: |-
      const src = [
          {price: 10, quantity: 2},
          {price: 'invalid', quantity: 3},
          {price: 20, quantity: null},
          {price: 30, quantity: 2}
      ];
      const mockData = {src: src, pr1: 'price', pr2: 'quantity'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, 'price', 'quantity');
      }
      assertThat(variableResult).isEqualTo(80); // (10*2) + (30*2)
  - name: Returns 0 for invalid array input
    code: |-
      const mockData = {src: null, pr1: 'price', pr2: 'quantity'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(null, 'price', 'quantity');
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Returns 0 for invalid property names
    code: |-
      const src = [
          {price: 10, quantity: 2},
          {price: 20, quantity: 3},
          {price: 30, quantity: 1}
      ];
      const mockData = {src: src, pr1: 123, pr2: 'quantity'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, 123, 'quantity');
      }
      assertThat(variableResult).isEqualTo(0);
  - name: '[example] Empty array returns 0'
    code: |-
      /* @display
      Input Array: []
      First Property Name: price
      Second Property Name: quantity
      @output
      0
      */
      const mockData = {src: [], pr1: 'price', pr2: 'quantity'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([], 'price', 'quantity');
      }
      assertThat(variableResult).isEqualTo(0);
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
