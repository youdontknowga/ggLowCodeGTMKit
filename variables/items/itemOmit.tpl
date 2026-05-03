___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "itemOmit",
  "description": "Removes specified properties from each \u003cem\u003eobject\u003c/em\u003e in an \u003cem\u003earray\u003c/em\u003e, returning a new \u003cem\u003earray\u003c/em\u003e with only the remaining properties. Useful for stripping sensitive or unnecessary fields.",
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
        "help": "💾 The array of objects to process.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eItems variable\u003c/strong\u003e: \u003cem\u003e{{ecommerce.items}}\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray literal\u003c/strong\u003e: \u003cem\u003e[{name: \"Shirt\", price: 10, internalId: \"abc\"}]\u003c/em\u003e",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "kys",
        "displayName": "Properties to Remove",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Property Name",
            "name": "value",
            "type": "TEXT"
          }
        ],
        "help": "💾 The property name to remove from each item (e.g., \u003cem\u003e\"internalId\"\u003c/em\u003e, \u003cem\u003e\"cost\"\u003c/em\u003e, \u003cem\u003e\"_private\"\u003c/em\u003e).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove single property\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove multiple properties\u003c/em\u003e***"
      }
    ],
    "help": "Removes specified properties from each object in an array.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove single property\u003c/em\u003e***\u003cbr\u003eSource Array: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{name: \u003cstrong\u003e'Shirt', price: 10, internalId: 'abc'},\u003c/strong\u003e\u003cbr\u003e{name: \u003cstrong\u003e'Pants', price: 20, internalId: 'def'}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003eProperties to Remove: \u003cstrong\u003e[{value: 'internalId'}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\n          {name: 'Shirt', price: 10},\n          {name: 'Pants', price: 20}\n      ]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove multiple properties\u003c/em\u003e***\u003cbr\u003eSource Array: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{name: \u003cstrong\u003e'Shirt', price: 10, cost: 5, internalId: 'abc'},\u003c/strong\u003e\u003cbr\u003e{name: \u003cstrong\u003e'Pants', price: 20, cost: 8, internalId: 'def'}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003eProperties to Remove: \u003cstrong\u003e[{value: 'cost'}, {value: 'internalId'}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\n          {name: 'Shirt', price: 10},\n          {name: 'Pants', price: 20}\n      ]\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the resulting array before returning it (e.g., \u003ccode\u003earr =\u003e arr.filter(x =\u003e x.price \u003e 0)\u003c/code\u003e to keep only items with a positive price)."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Creates a new array of objects with specified properties removed from each item.
 * Preserves all other existing properties.
 *
 * @param {Array} data.src - The array of objects to process.
 * @param {Array} data.kys - Array of objects with property names to remove.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 *
 * @returns {Array} A new array of objects with the specified properties removed.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');
const createFlatArrayFromValues = function(list, property) {
    const result = [];
    if (!list) return result;
    for (let i = 0; i < list.length; i++) {
        const val = list[i][property];
        if (getType(val) === 'array') {
            for (let j = 0; j < val.length; j++) {
                result.push(val[j]);
            }
        } else if (val) {
            result.push(val);
        }
    }
    return result;
};
const itemOmit = function(arr, keys) {
    if (getType(arr) !== 'array') return [];
    if (!keys || keys.length === 0) return arr;

    const omitMap = {};
    for (let i = 0; i < keys.length; i++) {
        omitMap[keys[i]] = true;
    }

    return arr.map(function(item) {
        if (item == null || typeof item !== 'object') return item;
        const result = {};
        for (const k in item) {
            if (item.hasOwnProperty(k) && !omitMap[k]) {
                result[k] = item[k];
            }
        }
        return result;
    });
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// itemOmit - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
const keys = createFlatArrayFromValues(data.kys, "value");
return out(itemOmit(value, keys));
// ===============================================================================
// itemOmit(...) – Apply Mode
// ===============================================================================
/*
return function(arr) {
    const keys = createFlatArrayFromValues(data.kys, "value");
    return out(itemOmit(arr, keys));
};
*/


___TESTS___

scenarios:
  - name: '[example] Remove single property'
    code: |-
      /* @display
      Source Array: [
          {name: 'Shirt', price: 10, internalId: 'abc'},
          {name: 'Pants', price: 20, internalId: 'def'}
      ]
      Properties to Remove: [{value: 'internalId'}]
      @output
      [
          {name: 'Shirt', price: 10},
          {name: 'Pants', price: 20}
      ]
      */
      const src = [
          {name: 'Shirt', price: 10, internalId: 'abc'},
          {name: 'Pants', price: 20, internalId: 'def'}
      ];
      const kys = [{value: 'internalId'}];
      const mockData = {
          src: src,
          kys: kys};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {name: 'Shirt', price: 10},
          {name: 'Pants', price: 20}
      ]);
  - name: '[example] Remove multiple properties'
    code: |-
      /* @display
      Source Array: [
          {name: 'Shirt', price: 10, cost: 5, internalId: 'abc'},
          {name: 'Pants', price: 20, cost: 8, internalId: 'def'}
      ]
      Properties to Remove: [{value: 'cost'}, {value: 'internalId'}]
      @output
      [
          {name: 'Shirt', price: 10},
          {name: 'Pants', price: 20}
      ]
      */
      const src = [
          {name: 'Shirt', price: 10, cost: 5, internalId: 'abc'},
          {name: 'Pants', price: 20, cost: 8, internalId: 'def'}
      ];
      const kys = [{value: 'cost'}, {value: 'internalId'}];
      const mockData = {
          src: src,
          kys: kys};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {name: 'Shirt', price: 10},
          {name: 'Pants', price: 20}
      ]);
  - name: Non-existent property is ignored
    code: |-
      const src = [
          {name: 'Shirt', price: 10}
      ];
      const mockData = {
          src: src,
          kys: [{value: 'nonExistent'}]
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
  - name: Empty keys returns original array
    code: |-
      const src = [
          {name: 'Shirt', price: 10}
      ];
      const mockData = {
          src: src,
          kys: []
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
      const mockData = {
          src: null,
          kys: [{value: 'internalId'}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(null);
      }
      assertThat(variableResult).isEqualTo([]);
  - name: Preserves items with null values for non-omitted properties
    code: |-
      const src = [
          {name: 'Shirt', price: null, internalId: 'abc'},
          {name: 'Pants', price: 20, internalId: 'def'}
      ];
      const mockData = {
          src: src,
          kys: [{value: 'internalId'}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {name: 'Shirt', price: null},
          {name: 'Pants', price: 20}
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
