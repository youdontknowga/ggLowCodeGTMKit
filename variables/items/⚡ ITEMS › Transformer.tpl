___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "⚡ ITEMS › Transformer",
  "description": "Maps each \u003cem\u003eitem\u003c/em\u003e in an \u003cem\u003earray of objects\u003c/em\u003e to a new \u003cem\u003eobject\u003c/em\u003e with a fixed set of key/value pairs. Supports optional type conversion and default values for falsy properties.",
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
        "help": "💾 The array of objects to map.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray of objects\u003c/strong\u003e: \u003cem\u003e{{ecommerce.items}}\u003c/em\u003e"
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "map",
        "displayName": "Property Mapping",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Source Property",
            "name": "val",
            "type": "TEXT",
            "isUnique": false,
            "valueHint": "e.g. id"
          },
          {
            "defaultValue": "",
            "displayName": "Output Key",
            "name": "key",
            "type": "TEXT",
            "valueHint": "e.g. item_id"
          },
          {
            "defaultValue": "non",
            "displayName": "Default (if falsy)",
            "name": "def",
            "type": "SELECT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ],
            "selectItems": [
              {
                "value": "non",
                "displayValue": "None (passthrough)"
              },
              {
                "value": "emp",
                "displayValue": "Empty String"
              },
              {
                "value": "zer",
                "displayValue": "Zero (Number)"
              }
            ],
            "macrosInSelect": true
          },
          {
            "defaultValue": "non",
            "displayName": "Type Conversion",
            "name": "typ",
            "type": "SELECT",
            "selectItems": [
              {
                "value": "non",
                "displayValue": "None"
              },
              {
                "value": "str",
                "displayValue": "String"
              },
              {
                "value": "num",
                "displayValue": "Number"
              },
              {
                "value": "int",
                "displayValue": "Integer"
              }
            ]
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "Advanced Settings",
        "displayName": "Advanced Settings",
        "groupStyle": "ZIPPY_OPEN_ON_PARAM",
        "subParams": [
          {
            "type": "CHECKBOX",
            "name": "kup",
            "checkboxText": "Keep unmapped properties from source object",
            "simpleValueType": true,
            "help": "☑️ When enabled, properties not listed in the mapping table are preserved in the output object."
          },
          {
            "type": "CHECKBOX",
            "name": "kor",
            "checkboxText": "Keep original key when renaming",
            "simpleValueType": true,
            "help": "☑️ When enabled, the original property name is preserved alongside the renamed key in the output object."
          }
        ]
      }
    ],
    "help": "Maps each item in an array to a new object with a fixed set of key/value pairs. Supports type conversion and default values.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBasic property mapping\u003c/em\u003e***\u003cbr\u003eInput Array: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{name: \u003cstrong\u003e'John', age: 30},\u003c/strong\u003e\u003cbr\u003e{name: \u003cstrong\u003e'Jane', age: 25}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003eProperty Mapping: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{val: \u003cstrong\u003e'name', key: 'userName', typ: 'non', def: 'non'},\u003c/strong\u003e\u003cbr\u003e{val: \u003cstrong\u003e'age',  key: 'userAge',  typ: 'non', def: 'non'}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\n          {userName: 'John', userAge: 30},\n          {userName: 'Jane', userAge: 25}\n      ]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eWith type conversion\u003c/em\u003e***\u003cbr\u003eInput Array: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{price: \u003cstrong\u003e'10.7', quantity: '3', label: 42}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003eProperty Mapping: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{val: \u003cstrong\u003e'price',    key: 'price',    typ: 'num', def: 'non'},\u003c/strong\u003e\u003cbr\u003e{val: \u003cstrong\u003e'quantity', key: 'quantity', typ: 'int', def: 'non'},\u003c/strong\u003e\u003cbr\u003e{val: \u003cstrong\u003e'label',    key: 'label',    typ: 'str', def: 'non'}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\n          {price: 10.7, quantity: 3, label: '42'}\n      ]\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input array before internal logic (e.g., filter items, normalize values). Internal transformations will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., \u003ccode\u003earr =\u003e arr.filter(x =\u003e x.id)\u003c/code\u003e, \u003ccode\u003earr =\u003e arr.length\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Maps each object in an array of objects to a new object with a fixed set of key/value pairs,
 * with optional type conversion and default values for missing or falsy properties.
 * Supports keeping unmapped properties and preserving original keys when renaming.
 *
 * @param {Array} data.src - Array of objects to map.
 * @param {Array<{val: string, key: string, typ: 'non'|'str'|'num'|'int', def: 'non'|'emp'|'zer'}>} data.map - Mapping table.
 * @param {boolean} [data.kup] - Keep unmapped properties from source object.
 * @param {boolean} [data.kor] - Keep original key when renaming.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 *
 * @returns {Array} Array of new objects with mapped properties.
 * Note: falsy values (null, undefined, '', 0, false) trigger the default value if one is set.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');
const makeString = require('makeString');
const makeNumber = require('makeNumber');
const makeInteger = require('makeInteger');

const getDefault = function(defCode, originalValue) {
    if (defCode === 'emp') return '';
    if (defCode === 'zer') return 0;
    return originalValue; // 'non' — passthrough
};
const itemMapProperties = function(arr, mappings, keepUnmapped, keepOriginal) {
    return arr.map(function(item) {
        if (!item) return {};
        const obj = {};

        // build a map of source keys that are being renamed
        // to exclude them from unmapped copy if not keeping original
        const renamedKeys = {};
        mappings.forEach(function(pair) {
            if (pair.val && pair.key && pair.val !== pair.key) {
                renamedKeys[pair.val] = true;
            }
        });

        // copy unmapped properties first
        if (keepUnmapped) {
            const mappedSourceKeys = {};
            mappings.forEach(function(pair) {
                if (pair.val) mappedSourceKeys[pair.val] = true;
            });
            for (const k in item) {
                if (item.hasOwnProperty(k) && !mappedSourceKeys[k]) {
                    obj[k] = item[k];
                }
            }
            // if keeping original, also copy renamed source keys
            if (keepOriginal) {
                for (const k in renamedKeys) {
                    if (item.hasOwnProperty(k)) {
                        obj[k] = item[k];
                    }
                }
            }
        }

        // apply mappings
        mappings.forEach(function(pair) {
            var raw = item[pair.val];
            var value = raw ? raw : getDefault(pair.def, raw);
            if (pair.typ === 'str') value = makeString(value);
            else if (pair.typ === 'num') value = makeNumber(value);
            else if (pair.typ === 'int') value = makeInteger(value);
            obj[pair.key] = value;

            // keep original key when renaming
            if (keepOriginal && pair.val !== pair.key) {
                obj[pair.val] = item[pair.val];
            }
        });

        return obj;
    });
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// itemMapProperties - Direct mode
// ===============================================================================
const sourceArray = getType(data.src) === 'array' ? data.src : [];
const pairs = data.map || [];
const keepUnmapped = !!data.kup;
const keepOriginal = !!data.kor;

const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, sourceArray);
return out(itemMapProperties(value, pairs, keepUnmapped, keepOriginal));
// ===============================================================================
// itemMapProperties - Apply mode
// ===============================================================================
/*
return function(arr) {
    const pairs = data.map || [];
    const keepUnmapped = !!data.kup;
    const keepOriginal = !!data.kor;
    return out(itemMapProperties(arr, pairs, keepUnmapped, keepOriginal));
};
*/


___TESTS___

scenarios:
  - name: '[example] Basic property mapping'
    code: |-
      /* @display
      Input Array: [
          {name: 'John', age: 30},
          {name: 'Jane', age: 25}
      ]
      Property Mapping: [
              {val: 'name', key: 'userName', typ: 'non', def: 'non'},
              {val: 'age',  key: 'userAge',  typ: 'non', def: 'non'}
          ]
      @output
      [
          {userName: 'John', userAge: 30},
          {userName: 'Jane', userAge: 25}
      ]
      */
      const src = [
          {name: 'John', age: 30},
          {name: 'Jane', age: 25}
      ];
      const map = [
              {val: 'name', key: 'userName', typ: 'non', def: 'non'},
              {val: 'age',  key: 'userAge',  typ: 'non', def: 'non'}
          ];
      const mockData = {
          src: src,
          map: map};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {userName: 'John', userAge: 30},
          {userName: 'Jane', userAge: 25}
      ]);
  - name: Keep unmapped properties (kup)
    code: |
      const src = [
          {name: 'John', age: 30, city: 'Paris'}
      ];
      const mockData = {
          src: src,
          kup: true,
          map: [
              {val: 'name', key: 'userName', typ: 'non', def: 'non'}
          ]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {userName: 'John', age: 30, city: 'Paris'}
      ]);
  - name: Keep original key when renaming (kor)
    code: |-
      const src = [
          {name: 'John', age: 30}
      ];
      const mockData = {
          src: src,
          kor: true,
          map: [
              {val: 'name', key: 'userName', typ: 'non', def: 'non'}
          ]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {userName: 'John', name: 'John'}
      ]);
  - name: Keep unmapped + keep original
    code: |-
      const src = [
          {name: 'John', age: 30, city: 'Paris'}
      ];
      const mockData = {
          src: src,
          kup: true,
          kor: true,
          map: [
              {val: 'name', key: 'userName', typ: 'non', def: 'non'}
          ]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {userName: 'John', name: 'John', age: 30, city: 'Paris'}
      ]);
  - name: '[example] With type conversion'
    code: |-
      /* @display
      Input Array: [
          {price: '10.7', quantity: '3', label: 42}
      ]
      Property Mapping: [
              {val: 'price',    key: 'price',    typ: 'num', def: 'non'},
              {val: 'quantity', key: 'quantity', typ: 'int', def: 'non'},
              {val: 'label',    key: 'label',    typ: 'str', def: 'non'}
          ]
      @output
      [
          {price: 10.7, quantity: 3, label: '42'}
      ]
      */
      const src = [
          {price: '10.7', quantity: '3', label: 42}
      ];
      const map = [
              {val: 'price',    key: 'price',    typ: 'num', def: 'non'},
              {val: 'quantity', key: 'quantity', typ: 'int', def: 'non'},
              {val: 'label',    key: 'label',    typ: 'str', def: 'non'}
          ];
      const mockData = {
          src: src,
          map: map};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {price: 10.7, quantity: 3, label: '42'}
      ]);
  - name: Falsy default (zer)
    code: |-
      const src = [
          {price: null, quantity: 0}
      ];
      const mockData = {
          src: src,
          map: [
              {val: 'price',    key: 'price',    typ: 'non', def: 'zer'},
              {val: 'quantity', key: 'quantity', typ: 'non', def: 'zer'}
          ]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([
          {price: 0, quantity: 0}
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
