___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "itemUniqByProperty",
  "description": "Removes duplicate \u003cem\u003eobjects\u003c/em\u003e from an \u003cem\u003earray\u003c/em\u003e based on a property value. Keeps the first occurrence of each unique value.",
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
        "help": "\ud83d\udcbe   Array of objects to deduplicate.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;\u2713 \u003cstrong\u003eArray\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "prp",
        "displayName": "Property Name",
        "simpleValueType": true,
        "help": "\ud83d\udcbe   The property to check for uniqueness (e.g. item_id, item_name).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;\u2713 \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Removes duplicate objects from an array based on a property value. Keeps the first occurrence.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDeduplicate by item_id\u003c/em\u003e***\u003cbr\u003eItems: \u003cstrong\u003e[{item_id: \"A\", price: 10}, {item_id: \"B\", price: 20}, {item_id: \"A\", price: 30}]\u003c/strong\u003e\u003cbr\u003eProperty Name: \u003cstrong\u003eitem_id\u003c/strong\u003e\u003cbr\u003e\u2197\ufe0f Output: \u003cstrong\u003e[{item_id: \"A\", price: 10}, {item_id: \"B\", price: 20}]\u003c/strong\u003e"
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
 * Removes duplicate objects from an array based on a property value.
 * Keeps the first occurrence of each unique value.
 *
 * @param {Array} data.src - Array of objects to deduplicate.
 * @param {string} data.prp - The property to check for uniqueness.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {Array} A new array with duplicates removed based on the specified property.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const itemUniqByProperty = function(items, property) {
    if (getType(items) !== 'array') return [];
    if (typeof property !== 'string') return items;

    const seen = {};
    const result = [];
    for (var i = 0; i < items.length; i++) {
        const item = items[i];
        if (item == null || typeof item !== 'object') continue;
        const key = item[property];
        const keyStr = typeof key === 'undefined' ? '__undefined__' : '' + key;
        if (!seen.hasOwnProperty(keyStr)) {
            seen[keyStr] = true;
            result.push(item);
        }
    }
    return result;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// itemUniqByProperty - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(itemUniqByProperty(value, data.prp));

// ===============================================================================
// itemUniqByProperty(...) - Apply Mode
// ===============================================================================
/*
return function(value, property) {
   property = data.rp1 ? data.prp : property;
   return out(itemUniqByProperty(value, property));
};
*/


___TESTS___

scenarios:
  - name: '[example] Deduplicate by item_id'
    code: |
      /* @display
      Items (Array of Objects): [{item_id: "A", price: 10}, {item_id: "B", price: 20}, {item_id: "A", price: 30}]
      Property Name: item_id
      @output
      [{item_id: "A", price: 10}, {item_id: "B", price: 20}]
      */
      const src = [{item_id: "A", price: 10}, {item_id: "B", price: 20}, {item_id: "A", price: 30}];
      const prp = "item_id";
      const mockData = { src: src, prp: prp, rp1: false };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo([{item_id: "A", price: 10}, {item_id: "B", price: 20}]);
  - name: '[example] No duplicates'
    code: |
      /* @display
      Items (Array of Objects): [{name: "Shirt", price: 10}, {name: "Hat", price: 20}]
      Property Name: name
      @output
      [{name: "Shirt", price: 10}, {name: "Hat", price: 20}]
      */
      const src = [{name: "Shirt", price: 10}, {name: "Hat", price: 20}];
      const prp = "name";
      const mockData = { src: src, prp: prp, rp1: false };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo([{name: "Shirt", price: 10}, {name: "Hat", price: 20}]);
  - name: All duplicates - keeps first only
    code: |-
      const src = [{id: 1, v: "a"}, {id: 1, v: "b"}, {id: 1, v: "c"}];
      const mockData = { src: src, prp: "id", rp1: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, "id");
      assertThat(variableResult).isEqualTo([{id: 1, v: "a"}]);
  - name: Empty array returns empty
    code: |-
      const mockData = { src: [], prp: "id", rp1: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)([], "id");
      assertThat(variableResult).isEqualTo([]);
  - name: Null src returns empty array
    code: |-
      const mockData = { src: null, prp: "id", rp1: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(null, "id");
      assertThat(variableResult).isEqualTo([]);
  - name: Items with missing property are kept (once)
    code: |-
      const src = [{id: 1}, {name: "no-id"}, {id: 2}, {color: "red"}];
      const mockData = { src: src, prp: "id", rp1: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, "id");
      assertThat(variableResult).isEqualTo([{id: 1}, {name: "no-id"}, {id: 2}]);
  - name: Numeric string coercion - treats 1 and "1" as same
    code: |-
      const src = [{id: 1, v: "num"}, {id: "1", v: "str"}];
      const mockData = { src: src, prp: "id", rp1: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, "id");
      assertThat(variableResult).isEqualTo([{id: 1, v: "num"}]);
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
