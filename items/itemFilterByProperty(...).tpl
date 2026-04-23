___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "itemFilterByProperty(...)",
  "description": "Filters an array of \u003cem\u003eobjects\u003c/em\u003e (items) returning only those where the specified property matches the provided value or satisfies a predicate function.",
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
        "name": "prp",
        "displayName": "Property Name",
        "simpleValueType": true,
        "help": "💾   Property name to check in each object.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "val",
        "displayName": "Match Value (Optional)",
        "simpleValueType": true,
        "help": "🎯   The value that the property must equal to be included, or a predicate function (e.g. x =\u003e x \u003e 50).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e \u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eFunction\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp2",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFilter by value\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: [{cat: \"A\", v: 1}, {cat: \"B\", v: 2}]\u003cbr\u003eProperty Name: cat\u003cbr\u003eMatch Value: A\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[{cat: \"A\", v: 1}]\u003c/strong\u003e"
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
            "checkboxText": "⚡Use runtime parameter for: Property Name",
            "simpleValueType": true
          },
          {
            "type": "CHECKBOX",
            "name": "rp2",
            "checkboxText": "⚡Use runtime parameter for: Match Value",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Filters an array of items, keeping only the objects that match the specified property and value.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFilter by value\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[{cat: \"A\", v: 1}, {cat: \"B\", v: 2}]\u003c/strong\u003e\u003cbr\u003eProperty Name: \u003cstrong\u003ecat\u003c/strong\u003e\u003cbr\u003eMatch Value: \u003cstrong\u003eA\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[{cat: \"A\", v: 1}]\u003c/strong\u003e"
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
 * Filters an array of objects (items) returning only those where the specified property matches the provided value or satisfies a predicate function.
 *
 * @param {Array} data.src - Array of objects to filter.
 * @param {string} data.prp - Property name to check.
 * @param {any|Function} [data.val] - The expected value of the property, or a predicate function (e.g. x => x > 50).
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {Array} Filtered array of objects.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const itemFilterByProperty = function(items, property, predicate) {
    if (getType(items) !== 'array') return [];
  
    const safePredicate = function(val) {
        return getType(val) === 'function' ? val : function(x) { return val === x; };
    };

    const check = safePredicate(predicate);

    return items.filter(function(item) {
        if (!item || item[property] === undefined) return false;
        return check(item[property]);
    });
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// itemFilterByProperty - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(itemFilterByProperty(value, data.prp, data.val));
*/

// ===============================================================================
// itemFilterByProperty(...) - Apply Mode
// ===============================================================================
return function(value, property, predicate) {
   property = data.rp1 ? data.prp : property;
   predicate = data.rp2 ? data.val : predicate;
   return out(itemFilterByProperty(value, property, predicate));
};

___TESTS___

scenarios:
  - name: '[example] Filter by value'
    code: |
      /* @display
      Items (Array of Objects): [{cat: "A", v: 1}, {cat: "B", v: 2}]
      Property Name: cat
      Match Value (Optional): A
      @output
      [{cat: "A", v: 1}]
      */
      const src = [{cat: "A", v: 1}, {cat: "B", v: 2}];
      const prp = "cat";
      const val = "A";
      const mockData = { src: src, prp: prp, val: val, rp1: false, rp2: false };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp, val);
      }
      assertThat(variableResult).isEqualTo([{cat: "A", v: 1}]);
  - name: '[example] Filter with a predicate function'
    code: |
      /* @display
      Items (Array of Objects): [{name: "Shirt", price: 30}, {name: "Jacket", price: 120}, {name: "Hat", price: 15}]
      Property Name: price
      Match Value (Optional): x => x > 50
      @output
      [{name: "Jacket", price: 120}]
      */
      const src = [{name: "Shirt", price: 30}, {name: "Jacket", price: 120}, {name: "Hat", price: 15}];
      const prp = "price";
      const val = function(x) { return x > 50; };
      const mockData = { src: src, prp: prp, val: val, rp1: false, rp2: false };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp, val);
      }
      assertThat(variableResult).isEqualTo([{name: "Jacket", price: 120}]);
  - name: Empty array returns empty
    code: |-
      const src = [];
      const prp = "name";
      const val = "test";
      const mockData = { src: src, prp: prp, val: val, rp1: false, rp2: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, prp, val);
      assertThat(variableResult).isEqualTo([]);
setup: |-
  const mode = 'apply';
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 

___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
