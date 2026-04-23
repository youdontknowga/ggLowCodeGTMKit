___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "sumPropertyNested(...)",
  "description": "Sums a specified numeric property across all \u003cem\u003eobjects\u003c/em\u003e in an \u003cem\u003earray\u003c/em\u003e. Non-numeric or missing values are ignored.",
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
        "name": "pth",
        "displayName": "Property Path",
        "simpleValueType": true,
        "help": "💾 The path to the numeric property to sum. Uses dot notation for nested properties. Non-numeric values are ignored.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString (dot notation)\u003c/strong\u003e: \u003cem\u003e\"price\"\u003c/em\u003e, \u003cem\u003e\"product.price\"\u003c/em\u003e, \u003cem\u003e\"order.total.amount\"\u003c/em\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSum simple property\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eprice\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e60\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSum nested property\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eproduct.price.amount\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e450\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Array of Objects"
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
            "checkboxText": "⚡Use runtime parameter for: Property Path",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Sums a specified numeric property across all objects. Supports nested paths. String numbers are auto-converted.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSum simple property\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{price: \u003cstrong\u003e10},\u003c/strong\u003e\u003cbr\u003e{price: \u003cstrong\u003e20},\u003c/strong\u003e\u003cbr\u003e{price: \u003cstrong\u003e30}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003eProperty Path: \u003cstrong\u003eprice\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e60\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSum nested property\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{product: \u003cstrong\u003e{price: {amount: 100}}},\u003c/strong\u003e\u003cbr\u003e{product: \u003cstrong\u003e{price: {amount: 200}}},\u003c/strong\u003e\u003cbr\u003e{product: \u003cstrong\u003e{price: {amount: 150}}}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003eProperty Path: \u003cstrong\u003eproduct.price.amount\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e450\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the sum before returning it (e.g., \u003ccode\u003esum =\u003e sum.toFixed(2)\u003c/code\u003e for currency, \u003ccode\u003esum =\u003e sum / 100\u003c/code\u003e for cents to dollars, \u003ccode\u003esum =\u003e Math.round(sum)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Sums a numeric property across all objects in an array, using a path string.
 *
 * @param {Array} data.src - The array of objects.
 * @param {string} data.pth - The path to the numeric value (e.g., "price.amount").
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {number} The sum of the values found at the specified path. Returns 0 if array is invalid or empty.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');
const makeNumber = require('makeNumber');

const getNested = function(obj, path) {
    const parts = path.split('.');
    let current = obj;
    for (let i = 0; i < parts.length; i++) {
        if (current == null || !current.hasOwnProperty(parts[i])) {
            return undefined;
        }
        current = current[parts[i]];
    }
    return current;
};

const sumBy = function(array, path) {
    if (getType(array) !== 'array' || typeof path !== 'string') {
        return 0;
    }
    
    let sum = 0;
    for (let i = 0; i < array.length; i++) {
        const value = makeNumber(getNested(array[i], path));
        if (typeof value === 'number' && value === value) {
            sum += value;
        }
    }
    return sum;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// sumPropertyByPath - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(sumBy(value, data.pth));
*/
// ===============================================================================
// sumPropertyByPath(...) – Apply Mode
// ===============================================================================
return function(array, path) {
   path = data.rp1 ? data.pth : path;
   return out(sumBy(array, path));
};


___TESTS___

scenarios:
  - name: '[example] Sum simple property'
    code: |-
      /* @display
      Value to Process: [
          {price: 10},
          {price: 20},
          {price: 30}
      ]
      Property Path: price
      @output
      60
      */
      const src = [
          {price: 10},
          {price: 20},
          {price: 30}
      ];
      const pth = 'price';
      const mockData = {
          src: src,
          pth: pth,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth);
      }
      assertThat(variableResult).isEqualTo(60);
  - name: '[example] Sum nested property'
    code: |-
      /* @display
      Value to Process: [
          {product: {price: {amount: 100}}},
          {product: {price: {amount: 200}}},
          {product: {price: {amount: 150}}}
      ]
      Property Path: product.price.amount
      @output
      450
      */
      const src = [
          {product: {price: {amount: 100}}},
          {product: {price: {amount: 200}}},
          {product: {price: {amount: 150}}}
      ];
      const pth = 'product.price.amount';
      const mockData = {
          src: src,
          pth: pth,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth);
      }
      assertThat(variableResult).isEqualTo(450);
  - name: Test with missing property in some objects
    code: |-
      const src = [
          {price: 10},
          {price: 20},
          {name: 'item'},
          {price: 30}
      ];
      const pth = 'price';
      const mockData = {
          src: src,
          pth: pth,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth);
      }
      assertThat(variableResult).isEqualTo(60);
  - name: Test with string numbers converted to numbers
    code: |-
      const src = [
          {price: '10'},
          {price: '20.5'},
          {price: '15.5'}
      ];
      const pth = 'price';
      const mockData = {
          src: src,
          pth: pth,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth);
      }
      assertThat(variableResult).isEqualTo(46);
  - name: Test with empty array returns 0
    code: |-
      const src = [];
      const pth = 'price';
      const mockData = {
          src: src,
          pth: pth,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Test with non-numeric values skipped
    code: |-
      const src = [
          {price: 10},
          {price: 'invalid'},
          {price: 20},
          {price: null},
          {price: 30}
      ];
      const pth = 'price';
      const mockData = {
          src: src,
          pth: pth,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth);
      }
      assertThat(variableResult).isEqualTo(60);
  - name: Test with negative numbers
    code: |-
      const src = [
          {amount: 100},
          {amount: -30},
          {amount: 50},
          {amount: -20}
      ];
      const pth = 'amount';
      const mockData = {
          src: src,
          pth: pth,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth);
      }
      assertThat(variableResult).isEqualTo(100);
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
