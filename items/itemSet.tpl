___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "itemSet",
  "description": "Adds or overwrites a property on each \u003cem\u003eobject\u003c/em\u003e in an \u003cem\u003earray\u003c/em\u003e. Accepts a static value or a callback function (auto-detected). Preserves all existing properties.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "paramSection",
    "displayName": "\ud835\ude0b\ud835\ude26\ud835\ude34\ud835\ude24\ud835\ude33\ud835\ude2a\ud835\ude31\ud835\ude35\ud835\ude2a\ud835\ude30\ud835\ude2f",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "src",
        "displayName": "Items (Array of Objects)",
        "simpleValueType": true,
        "help": "\ud83d\udcbe   Array of objects to process.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;\u2713 \u003cstrong\u003eArray\u003c/strong\u003e",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "prp",
        "displayName": "Property Name",
        "simpleValueType": true,
        "help": "\ud83d\udcbe   The property name to add or overwrite on each item.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;\u2713 \u003cstrong\u003eString\u003c/strong\u003e",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "val",
        "displayName": "Value or Function",
        "simpleValueType": true,
        "help": "\ud83c\udfaf   The value to set on each item, or a function that receives the item and returns the value (e.g. item =\u003e item.price * item.quantity).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;\u2713 \u003cstrong\u003eAny\u003c/strong\u003e (static value set on every item) \u003cbr\u003e \u0026nbsp;\u0026nbsp;\u2713 \u003cstrong\u003eFunction\u003c/strong\u003e (receives each item, returns value)"
      }
    ],
    "help": "Adds or overwrites a property on each object in an array.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAdd computed property\u003c/em\u003e***\u003cbr\u003eItems: \u003cstrong\u003e[{price: 10, quantity: 2}, {price: 20, quantity: 3}]\u003c/strong\u003e\u003cbr\u003eProperty Name: \u003cstrong\u003etotal\u003c/strong\u003e\u003cbr\u003eValue or Function: \u003cstrong\u003efunction(item) { return item.price * item.quantity; }\u003c/strong\u003e\u003cbr\u003e\u2197\ufe0f Output: \u003cstrong\u003e[{price: 10, quantity: 2, total: 20}, {price: 20, quantity: 3, total: 60}]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSet static value\u003c/em\u003e***\u003cbr\u003eItems: \u003cstrong\u003e[{price: 10}, {price: 20}]\u003c/strong\u003e\u003cbr\u003eProperty Name: \u003cstrong\u003ecurrency\u003c/strong\u003e\u003cbr\u003eValue or Function: \u003cstrong\u003eEUR\u003c/strong\u003e\u003cbr\u003e\u2197\ufe0f Output: \u003cstrong\u003e[{price: 10, currency: 'EUR'}, {price: 20, currency: 'EUR'}]\u003c/strong\u003e"
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
        "help": "\u2699\ufe0f Optional pre-processing function applied to the input before internal logic (e.g., convert object to string, normalize case). Internal transformations such as case handling will still apply afterward."
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
        "help": "\u2699\ufe0f Optional function to apply to the result before returning it (e.g., str =\u003e str + ' \u20ac', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Adds or overwrites a property on each object in an array using a static value or a callback function (auto-detected).
 * Preserves all existing properties of each item.
 *
 * @param {Array} data.src - Array of objects to process.
 * @param {string} data.prp - Property name to set on each item.
 * @param {any|Function} [data.val] - The value to set, or a function that receives the item and returns the value (e.g. item => item.price * item.quantity).
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {Array} A new array of objects with the specified property added or overwritten.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const itemSetProperty = function(items, property, valueOrFn) {
    if (getType(items) !== 'array') return [];
    if (!property) return items;

    const getValue = typeof valueOrFn === 'function'
        ? valueOrFn
        : function() { return valueOrFn; };

    return items.map(function(item) {
        if (item == null || typeof item !== 'object') return item;
        const result = {};
        for (var k in item) {
            if (item.hasOwnProperty(k)) result[k] = item[k];
        }
        result[property] = getValue(item);
        return result;
    });
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// itemSet - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(itemSetProperty(value, data.prp, data.val));

// ===============================================================================
// itemSet(...) - Apply Mode
// ===============================================================================
/*
return function(value, property, valueOrFn) {
   property = data.rp1 ? data.prp : property;
   valueOrFn = data.rp2 ? data.val : valueOrFn;
   return out(itemSetProperty(value, property, valueOrFn));
};
*/


___TESTS___

scenarios:
  - name: '[example] Add computed property'
    code: |
      /* @display
      Items (Array of Objects): [{price: 10, quantity: 2}, {price: 20, quantity: 3}]
      Property Name: total
      Value or Function: function(item) { return item.price * item.quantity; }
      @output
      [{price: 10, quantity: 2, total: 20}, {price: 20, quantity: 3, total: 60}]
      */
      const src = [{price: 10, quantity: 2}, {price: 20, quantity: 3}];
      const mockData = {
          src: src,
          prp: 'total',
          val: function(item) { return item.price * item.quantity; },
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, 'total', mockData.val);
      }
      assertThat(variableResult).isEqualTo([
          {price: 10, quantity: 2, total: 20},
          {price: 20, quantity: 3, total: 60}
      ]);
  - name: '[example] Set static value'
    code: |
      /* @display
      Items (Array of Objects): [{price: 10}, {price: 20}]
      Property Name: currency
      Value or Function: EUR
      @output
      [{price: 10, currency: "EUR"}, {price: 20, currency: "EUR"}]
      */
      const src = [{price: 10}, {price: 20}];
      const mockData = {
          src: src,
          prp: 'currency',
          val: 'EUR',
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, 'currency', 'EUR');
      }
      assertThat(variableResult).isEqualTo([
          {price: 10, currency: 'EUR'},
          {price: 20, currency: 'EUR'}
      ]);
  - name: Overwrite existing property
    code: |-
      const src = [{price: 10, quantity: 2}, {price: 20, quantity: 3}];
      const mockData = { src: src, prp: 'quantity', val: 1, rp1: false, rp2: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, 'quantity', 1);
      assertThat(variableResult).isEqualTo([{price: 10, quantity: 1}, {price: 20, quantity: 1}]);
  - name: Preserves all existing properties
    code: |-
      const src = [{name: 'Shirt', price: 10, quantity: 2, category: 'clothing'}];
      const fn = function(item) { return item.price * item.quantity; };
      const mockData = { src: src, prp: 'total', val: fn, rp1: false, rp2: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, 'total', fn);
      assertThat(variableResult).isEqualTo([{name: 'Shirt', price: 10, quantity: 2, category: 'clothing', total: 20}]);
  - name: Empty array returns empty
    code: |-
      const mockData = { src: [], prp: 'total', val: 'x', rp1: false, rp2: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)([], 'total', 'x');
      assertThat(variableResult).isEqualTo([]);
  - name: Invalid src returns empty array
    code: |-
      const mockData = { src: null, prp: 'total', val: 'x', rp1: false, rp2: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(null, 'total', 'x');
      assertThat(variableResult).isEqualTo([]);
setup: |-
  const mode = 'direct';
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply';


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
