___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "itemMapProperty(...)",
  "description": "Transforms a single \u003cem\u003eproperty\u003c/em\u003e in every object of an \u003cem\u003earray\u003c/em\u003e using a callback function. All other properties are preserved unchanged.",
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
        "type": "CHECKBOX",
        "name": "rp1",
        "checkboxText": "Replace Property Name with template value",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "☑️ When enabled, uses the template-configured property name instead of the runtime argument."
      },
      {
        "type": "TEXT",
        "name": "prp",
        "displayName": "Property Name",
        "simpleValueType": true,
        "help": "💾   The property to transform in each object.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "rp2",
        "checkboxText": "Replace Transform Function with template value",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "☑️ When enabled, uses the template-configured transform function instead of the runtime argument."
      },
      {
        "type": "TEXT",
        "name": "fn",
        "displayName": "Transform Function",
        "simpleValueType": true,
        "help": "🎯   A function that receives the current property value and returns the new value (e.g. x =\u003e x * 1.2).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eFunction\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp2",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      }
    ],
    "help": "Transforms a single property in every item of an array using a callback function.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eApply 20%% markup to price\u003c/em\u003e***\u003cbr\u003eItems: \u003cstrong\u003e[{name: \"Shirt\", price: 100}, {name: \"Hat\", price: 50}]\u003c/strong\u003e\u003cbr\u003eProperty Name: \u003cstrong\u003eprice\u003c/strong\u003e\u003cbr\u003eTransform Function: \u003cstrong\u003efunction(x) { return x * 1.2; }\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[{name: \"Shirt\", price: 120}, {name: \"Hat\", price: 60}]\u003c/strong\u003e"
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
 * Transforms a single property in every object of an array using a callback function.
 * All other properties are preserved unchanged.
 *
 * @param {Array} data.src - Array of objects to transform.
 * @param {string} data.prp - The property name to transform.
 * @param {Function} data.fn - A function that receives the property value and returns the new value.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Apply-mode specific parameters:
 * @param {boolean} [data.rp1] - Use template property name instead of runtime argument.
 * @param {boolean} [data.rp2] - Use template transform function instead of runtime argument.
 * 
 * @returns {Array} Array of objects with the specified property transformed.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const itemMapProperty = function(items, property, transform) {
    if (getType(items) !== 'array') return [];
    if (typeof transform !== 'function') return items;

    return items.map(function(item) {
        if (!item || item[property] === undefined) return item;
        const result = {};
        for (var k in item) {
            if (item.hasOwnProperty(k)) result[k] = item[k];
        }
        result[property] = transform(item[property]);
        return result;
    });
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// itemMapProperty(...) - Apply Mode
// ===============================================================================
return function(value, property, transform) {
   property = data.rp1 ? data.prp : property;
   transform = data.rp2 ? data.fn : transform;
   return out(itemMapProperty(value, property, transform));
};


___TESTS___

scenarios:
  - name: '[example] Apply 20% markup to price'
    code: |
      /* @display
      Items (Array of Objects): [{name: "Shirt", price: 100}, {name: "Hat", price: 50}]
      Property Name: price
      Transform Function: function(x) { return x * 1.2; }
      @output
      [{name: "Shirt", price: 120}, {name: "Hat", price: 60}]
      */
      const src = [{name: "Shirt", price: 100}, {name: "Hat", price: 50}];
      const prp = "price";
      const fn = function(x) { return x * 1.2; };
      const mockData = { src: src, prp: prp, fn: fn, rp1: false, rp2: false };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp, fn);
      }
      assertThat(variableResult).isEqualTo([{name: "Shirt", price: 120}, {name: "Hat", price: 60}]);
  - name: '[example] Convert names to uppercase'
    code: |
      /* @display
      Items (Array of Objects): [{name: "shirt", color: "blue"}, {name: "hat", color: "red"}]
      Property Name: name
      Transform Function: function(x) { return x.toUpperCase(); }
      @output
      [{name: "SHIRT", color: "blue"}, {name: "HAT", color: "red"}]
      */
      const src = [{name: "shirt", color: "blue"}, {name: "hat", color: "red"}];
      const prp = "name";
      const fn = function(x) { return x.toUpperCase(); };
      const mockData = { src: src, prp: prp, fn: fn, rp1: false, rp2: false };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp, fn);
      }
      assertThat(variableResult).isEqualTo([{name: "SHIRT", color: "blue"}, {name: "HAT", color: "red"}]);
  - name: Empty array returns empty
    code: |-
      const src = [];
      const prp = "price";
      const fn = function(x) { return x * 2; };
      const mockData = { src: src, prp: prp, fn: fn, rp1: false, rp2: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, prp, fn);
      assertThat(variableResult).isEqualTo([]);
  - name: Missing property is skipped
    code: |-
      const src = [{name: "Shirt", price: 100}, {name: "Hat"}];
      const prp = "price";
      const fn = function(x) { return x * 2; };
      const mockData = { src: src, prp: prp, fn: fn, rp1: false, rp2: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, prp, fn);
      assertThat(variableResult).isEqualTo([{name: "Shirt", price: 200}, {name: "Hat"}]);
  - name: Non-function transform returns items unchanged
    code: |-
      const src = [{name: "Shirt", price: 100}];
      const prp = "price";
      const fn = "notAFunction";
      const mockData = { src: src, prp: prp, fn: fn, rp1: false, rp2: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, prp, fn);
      assertThat(variableResult).isEqualTo([{name: "Shirt", price: 100}]);
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
