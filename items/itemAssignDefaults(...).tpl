___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "itemAssignDefaults(...)",
  "description": "Assigns default values to missing or \u003cem\u003eundefined\u003c/em\u003e properties on each \u003cem\u003eobject\u003c/em\u003e in an \u003cem\u003earray\u003c/em\u003e. Existing values are always preserved.",
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
        "name": "dfs",
        "displayName": "Default Values",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Property Name",
            "name": "key",
            "type": "TEXT"
          },
          {
            "defaultValue": "",
            "displayName": "Default Value",
            "name": "val",
            "type": "TEXT"
          }
        ],
        "help": "💾 The property name to assign a default value to (e.g., \u003cem\u003e\"price\"\u003c/em\u003e, \u003cem\u003e\"quantity\"\u003c/em\u003e, \u003cem\u003e\"currency\"\u003c/em\u003e).\n\n💾 The default value to assign if the property is missing or \u003cem\u003eundefined\u003c/em\u003e (e.g., \u003cem\u003e0\u003c/em\u003e, \u003cem\u003e1\u003c/em\u003e, \u003cem\u003e\"EUR\"\u003c/em\u003e, \u003cem\u003e\"Unknown\"\u003c/em\u003e).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAssign missing defaults\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExisting values preserved\u003c/em\u003e***"
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template."
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Array of Objects"
      }
    ],
    "help": "Assigns default values to missing or undefined properties on each object in an array. Existing values are preserved.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAssign missing defaults\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{name: \u003cstrong\u003e'Shirt', price: 10},\u003c/strong\u003e\u003cbr\u003e{name: \u003cstrong\u003e'Pants'}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003eDefault Values: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{key: \u003cstrong\u003e'price', val: 0},\u003c/strong\u003e\u003cbr\u003e{key: \u003cstrong\u003e'quantity', val: 1},\u003c/strong\u003e\u003cbr\u003e{key: \u003cstrong\u003e'currency', val: 'EUR'}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\n          {name: 'Shirt', price: 10, quantity: 1, currency: 'EUR'},\n          {name: 'Pants', price: 0, quantity: 1, currency: 'EUR'}\n      ]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExisting values preserved\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{name: \u003cstrong\u003e'Shirt', price: 10, quantity: 3}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003eDefault Values: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{key: \u003cstrong\u003e'quantity', val: 1},\u003c/strong\u003e\u003cbr\u003e{key: \u003cstrong\u003e'currency', val: 'EUR'}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\n          {name: 'Shirt', price: 10, quantity: 3, currency: 'EUR'}\n      ]\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the resulting array before returning it (e.g., \u003ccode\u003earr =\u003e arr.filter(x =\u003e x.price \u003e 0)\u003c/code\u003e to keep only items with a positive price)."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Assigns default values to missing or undefined properties on each object in an array.
 * Only fills properties that are undefined on each item — existing values are preserved.
 *
 * @param {Array} data.src - The array of objects to process.
 * @param {Array} data.dfs - Array of objects with property name (key) and default value (val) pairs.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 *
 * @returns {Array} A new array of objects with default values assigned to missing properties.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');
const itemAssignDefaults = function(arr, defaults) {
    if (getType(arr) !== 'array') return [];
    if (!defaults || defaults.length === 0) return arr;

    return arr.map(function(item) {
        if (item == null || typeof item !== 'object') return item;
        const result = {};
        for (const k in item) {
            if (item.hasOwnProperty(k)) result[k] = item[k];
        }
        for (let i = 0; i < defaults.length; i++) {
            const key = defaults[i].key;
            const val = defaults[i].val;
            if (key && result[key] === undefined) {
                result[key] = val;
            }
        }
        return result;
    });
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// itemAssignDefaults - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(itemAssignDefaults(value, data.dfs));
*/
// ===============================================================================
// itemAssignDefaults(...) – Apply Mode
// ===============================================================================
return function(arr) {
    return out(itemAssignDefaults(arr, data.dfs));
};


___TESTS___

scenarios:
  - name: '[example] Assign missing defaults'
    code: |
      /* @display
      Value to Process: [
          {name: 'Shirt', price: 10},
          {name: 'Pants'}
      ]
      Default Values: [
              {key: 'price', val: 0},
              {key: 'quantity', val: 1},
              {key: 'currency', val: 'EUR'}
          ]
      @output
      [
          {name: 'Shirt', price: 10, quantity: 1, currency: 'EUR'},
          {name: 'Pants', price: 0, quantity: 1, currency: 'EUR'}
      ]
      */
      const src = [
          {name: 'Shirt', price: 10},
          {name: 'Pants'}
      ];
      const dfs = [
              {key: 'price', val: 0},
              {key: 'quantity', val: 1},
              {key: 'currency', val: 'EUR'}
          ];
      const mockData = {
          src: src,
          dfs: dfs
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {name: 'Shirt', price: 10, quantity: 1, currency: 'EUR'},
          {name: 'Pants', price: 0, quantity: 1, currency: 'EUR'}
      ]);
  - name: '[example] Existing values preserved'
    code: |-
      /* @display
      Value to Process: [
          {name: 'Shirt', price: 10, quantity: 3}
      ]
      Default Values: [
              {key: 'quantity', val: 1},
              {key: 'currency', val: 'EUR'}
          ]
      @output
      [
          {name: 'Shirt', price: 10, quantity: 3, currency: 'EUR'}
      ]
      */
      const src = [
          {name: 'Shirt', price: 10, quantity: 3}
      ];
      const dfs = [
              {key: 'quantity', val: 1},
              {key: 'currency', val: 'EUR'}
          ];
      const mockData = {
          src: src,
          dfs: dfs
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {name: 'Shirt', price: 10, quantity: 3, currency: 'EUR'}
      ]);
  - name: Does not overwrite falsy values (0, false, empty string)
    code: |-
      const src = [
          {name: 'Shirt', price: 0, quantity: 0, discount: false}
      ];
      const dfs = [
              {key: 'price', val: 99},
              {key: 'quantity', val: 1},
              {key: 'discount', val: true}
          ];
      const mockData = {
          src: src,
          dfs: dfs
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {name: 'Shirt', price: 0, quantity: 0, discount: false}
      ]);
  - name: Empty defaults returns original array
    code: |
      const src = [
          {name: 'Shirt', price: 10}
      ];
      const dfs = [];
      const mockData = {
          src: src,
          dfs: dfs
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {name: 'Shirt', price: 10}
      ]);
  - name: Invalid src returns empty array
    code: |-
      const dfs = [{key: 'currency', val: 'EUR'}];
      const mockData = {
          src: null,
          dfs: dfs
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(null);
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
