___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "itemSet",
  "description": "Adds or overwrites a property on each \u003cem\u003eobject\u003c/em\u003e in an \u003cem\u003earray\u003c/em\u003e. Preserves all existing properties. Useful for adding computed fields like totals or margins to item collections.",
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
        "displayName": "Source Array",
        "simpleValueType": true,
        "help": "💾 The array of objects to process.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eItems variable\u003c/strong\u003e: \u003cem\u003e{{ecommerce.items}}\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray literal\u003c/strong\u003e: \u003cem\u003e[{price: 10, quantity: 2}]\u003c/em\u003e",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "key",
        "displayName": "Property Key",
        "simpleValueType": true,
        "help": "💾 The property name to add or overwrite on each item.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNew property\u003c/strong\u003e: \u003cem\u003e\"total\"\u003c/em\u003e, \u003cem\u003e\"margin\"\u003c/em\u003e, \u003cem\u003e\"currency\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eExisting property\u003c/strong\u003e: \u003cem\u003e\"price\"\u003c/em\u003e (will be overwritten)",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "SELECT",
        "name": "mod",
        "displayName": "Value Mode",
        "simpleValueType": true,
        "defaultValue": "fn",
        "help": "💾 How to determine the value to set on each item.\u003cbr\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eComputed\u003c/strong\u003e: uses a callback function receiving the item\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eStatic\u003c/strong\u003e: sets the same value on every item",
        "selectItems": [
          {
            "value": "fn",
            "displayValue": "Computed (function)"
          },
          {
            "value": "val",
            "displayValue": "Static value"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "fn",
        "displayName": "Value Function",
        "simpleValueType": true,
        "help": "💾 A function that receives each item and returns the value to set.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eapplyFromObject\u003c/strong\u003e: \u003cem\u003e{{applyFromObject(...)}}\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eCustom function\u003c/strong\u003e: \u003cem\u003eitem =\u003e Math.round(item.price)\u003c/em\u003e",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "mod",
            "paramValue": "fn",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "val",
        "displayName": "Static Value",
        "simpleValueType": true,
        "help": "💾 The static value to set on every item.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e: \u003cem\u003e\"EUR\"\u003c/em\u003e, \u003cem\u003e\"active\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e: \u003cem\u003e1\u003c/em\u003e, \u003cem\u003e0\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eVariable\u003c/strong\u003e: \u003cem\u003e{{currency}}\u003c/em\u003e",
        "enablingConditions": [
          {
            "paramName": "mod",
            "paramValue": "val",
            "type": "EQUALS"
          }
        ]
      }
    ],
    "help": "Adds or overwrites a property on each object in an array using a callback or static value.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAdd computed property\u003c/em\u003e***\u003cbr\u003eSource Array: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{price: \u003cstrong\u003e10, quantity: 2},\u003c/strong\u003e\u003cbr\u003e{price: \u003cstrong\u003e20, quantity: 3}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003eValue Function: \u003cstrong\u003efunction(item) { return item.price * item.quantity; }\u003c/strong\u003e\u003cbr\u003eProperty Key: \u003cstrong\u003etotal\u003c/strong\u003e\u003cbr\u003eValue Mode: \u003cstrong\u003efn\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\n          {price: 10, quantity: 2, total: 20},\n          {price: 20, quantity: 3, total: 60}\n      ]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSet static value\u003c/em\u003e***\u003cbr\u003eSource Array: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{price: \u003cstrong\u003e10, quantity: 2},\u003c/strong\u003e\u003cbr\u003e{price: \u003cstrong\u003e20, quantity: 3}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003eProperty Key: \u003cstrong\u003ecurrency\u003c/strong\u003e\u003cbr\u003eValue Mode: \u003cstrong\u003eval\u003c/strong\u003e\u003cbr\u003eStatic Value: \u003cstrong\u003eEUR\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\n          {price: 10, quantity: 2, currency: 'EUR'},\n          {price: 20, quantity: 3, currency: 'EUR'}\n      ]\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the source array before processing."
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
        "help": "⚙️ Optional function to apply to the resulting array before returning it (e.g., \u003ccode\u003earr =\u003e arr.filter(x =\u003e x.total \u003e 0)\u003c/code\u003e to keep only items with a positive total)."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Adds or overwrites a property on each object in an array using a static value or a callback function.
 * Preserves all existing properties of each item.
 *
 * @param {Array} data.src - The array of objects to process.
 * @param {string} data.key - The property name to set on each item.
 * @param {string} data.mod - Value mode: "fn" for computed value, "val" for static value.
 * @param {Function} [data.fn] - A function that receives the item and returns the value to set (when mod="fn").
 * @param {*} [data.val] - Static value to set on each item (when mod="val").
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
const itemSetProperty = function(arr, key, fn, val) {
    if (getType(arr) !== 'array') return [];
    if (!key) return arr;

    const getValue = typeof fn === 'function'
        ? fn
        : function() { return val; };

    return arr.map(function(item) {
        if (item == null || typeof item !== 'object') return item;
        const result = {};
        for (const k in item) {
            if (item.hasOwnProperty(k)) result[k] = item[k];
        }
        result[key] = getValue(item);
        return result;
    });
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// itemSetProperty - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
const fn = data.mod === 'fn' ? data.fn : undefined;
const val = data.mod === 'val' ? data.val : undefined;
return out(itemSetProperty(value, data.key, fn, val));
// ===============================================================================
// itemSetProperty(...) – Apply Mode
// ===============================================================================
/*
return function(arr) {
    const fn = data.mod === 'fn' ? data.fn : undefined;
    const val = data.mod === 'val' ? data.val : undefined;
    return out(itemSetProperty(arr, data.key, fn, val));
};
*/


___TESTS___

scenarios:
  - name: '[example] Add computed property'
    code: |-
      /* @display
      Source Array: [
          {price: 10, quantity: 2},
          {price: 20, quantity: 3}
      ]
      Value Function: function(item) { return item.price * item.quantity; }
      Property Key: total
      Value Mode: fn
      @output
      [
          {price: 10, quantity: 2, total: 20},
          {price: 20, quantity: 3, total: 60}
      ]
      */
      const src = [
          {price: 10, quantity: 2},
          {price: 20, quantity: 3}
      ];
      const fn = function(item) { return item.price * item.quantity; };
      const mockData = {
          src: src,
          key: 'total',
          mod: 'fn',
          fn: fn};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {price: 10, quantity: 2, total: 20},
          {price: 20, quantity: 3, total: 60}
      ]);
  - name: '[example] Set static value'
    code: |-
      /* @display
      Source Array: [
          {price: 10, quantity: 2},
          {price: 20, quantity: 3}
      ]
      Property Key: currency
      Value Mode: val
      Static Value: EUR
      @output
      [
          {price: 10, quantity: 2, currency: 'EUR'},
          {price: 20, quantity: 3, currency: 'EUR'}
      ]
      */
      const src = [
          {price: 10, quantity: 2},
          {price: 20, quantity: 3}
      ];
      const mockData = {
          src: src,
          key: 'currency',
          mod: 'val',
          val: 'EUR'
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {price: 10, quantity: 2, currency: 'EUR'},
          {price: 20, quantity: 3, currency: 'EUR'}
      ]);
  - name: Overwrite existing property with static value
    code: |-
      const src = [
          {price: 10, quantity: 2},
          {price: 20, quantity: 3}
      ];
      const mockData = {
          src: src,
          key: 'quantity',
          mod: 'val',
          val: 1
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {price: 10, quantity: 1},
          {price: 20, quantity: 1}
      ]);
  - name: Preserves all existing properties
    code: |-
      const src = [
          {name: 'Shirt', price: 10, quantity: 2, category: 'clothing'}
      ];
      const mockData = {
          src: src,
          key: 'total',
          mod: 'fn',
          fn: function(item) { return item.price * item.quantity; }
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {name: 'Shirt', price: 10, quantity: 2, category: 'clothing', total: 20}
      ]);
  - name: Invalid src returns empty array
    code: |-
      const mockData = {
          src: null,
          key: 'total',
          mod: 'fn',
          fn: function(item) { return item.price * item.quantity; }
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(null);
      }
      assertThat(variableResult).isEqualTo([]);
  - name: Invalid fn falls back to static undefined
    code: |-
      const src = [
          {price: 10, quantity: 2}
      ];
      const mockData = {
          src: src,
          key: 'total',
          mod: 'fn',
          fn: 'notAFunction'
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {price: 10, quantity: 2, total: undefined}
      ]);
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
