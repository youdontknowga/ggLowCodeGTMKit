___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "pick(...)",
  "description": "Creates a new object by selecting only the properties whose keys match the value fields from a list. If a value is an array, all its elements are included.",
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
        "name": "kys",
        "displayName": "Properties to Pick",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Property Name",
            "name": "value",
            "type": "TEXT"
          }
        ],
        "help": "💾 List of property names to pick from the source object. Only properties that exist in the source will be included.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e: property name\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray of strings\u003c/strong\u003e: for multiple properties at once\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePick single property\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePick multiple properties\u003c/em\u003e***",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template."
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Source Object"
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
            "checkboxText": "⚡Use runtime parameter for: Keys Array",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Returns a new \u003cem\u003eobject\u003c/em\u003e with only the specified keys.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePick single property\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{name: 'John', age: 30, city: 'Paris', country: 'France'}\u003c/strong\u003e\u003cbr\u003eProperties to Pick: \u003cstrong\u003e[{value: 'name'}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePick multiple properties\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{id: 1, name: 'Product', price: 99, stock: 50, category: 'electronics'}\u003c/strong\u003e\u003cbr\u003eProperties to Pick: \u003cstrong\u003e[{value: 'name'}, {value: 'price'}, {value: 'category'}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eProduct\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result object before returning it (e.g., \u003ccode\u003eobj =\u003e JSON.stringify(obj)\u003c/code\u003e, \u003ccode\u003eobj =\u003e Object.freeze(obj)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Creates a new object composed of selected properties from the source object.
 *
 * @param {Object} data.src - The source object.
 * @param {Array} data.kys - Array of objects with property names to pick.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {Object} A new object with only the selected properties.
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
const pick = function(object, keys) {
    const result = {};
    
    if (object == null || typeof object !== 'object') {
        return result;
    }
    
    for (let i = 0; i < keys.length; i++) {
        const key = keys[i];
        if (object.hasOwnProperty(key)) {
            result[key] = object[key];
        }
    }
    
    return result;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// pick - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
const keys = createFlatArrayFromValues(data.kys, "value");
return out(pick(value, keys));
*/
// ===============================================================================
// pick(...) – Apply Mode
// ===============================================================================

return function(object, keys) {
   keys = data.rp1 ? createFlatArrayFromValues(data.kys, "value") : keys;
   return out(pick(object, keys));
};


___TESTS___

scenarios:
  - name: '[example] Pick single property'
    code: |-
      /* @display
      Value to Process: {name: 'John', age: 30, city: 'Paris', country: 'France'}
      Properties to Pick: [{value: 'name'}]
      @output
      John
      */
      const src = {name: 'John', age: 30, city: 'Paris', country: 'France'};
      const kys = [{value: 'name'}];
      const mockData = {
          src: src,
          kys: kys,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ['name']);
      }
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isUndefined();
      assertThat(variableResult.city).isUndefined();
  - name: '[example] Pick multiple properties'
    code: |-
      /* @display
      Value to Process: {id: 1, name: 'Product', price: 99, stock: 50, category: 'electronics'}
      Properties to Pick: [{value: 'name'}, {value: 'price'}, {value: 'category'}]
      @output
      Product
      */
      const src = {id: 1, name: 'Product', price: 99, stock: 50, category: 'electronics'};
      const kys = [{value: 'name'}, {value: 'price'}, {value: 'category'}];
      const mockData = {
          src: src,
          kys: kys,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ['name', 'price', 'category']);
      }
      assertThat(variableResult.name).isEqualTo('Product');
      assertThat(variableResult.price).isEqualTo(99);
      assertThat(variableResult.category).isEqualTo('electronics');
      assertThat(variableResult.id).isUndefined();
      assertThat(variableResult.stock).isUndefined();
  - name: Test picking non-existent properties
    code: |-
      const src = {name: 'John', age: 30};
      const kys = [{value: 'email'}, {value: 'phone'}];
      const mockData = {
          src: src,
          kys: kys,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ['email', 'phone']);
      }
      assertThat(variableResult).isEqualTo({});
  - name: Test with array of keys in value property
    code: |-
      const src = {a: 1, b: 2, c: 3, d: 4, e: 5};
      const kys = [{value: ['a', 'c', 'e']}];
      const mockData = {
          src: src,
          kys: kys,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ['a', 'c', 'e']);
      }
      assertThat(variableResult.a).isEqualTo(1);
      assertThat(variableResult.c).isEqualTo(3);
      assertThat(variableResult.e).isEqualTo(5);
      assertThat(variableResult.b).isUndefined();
      assertThat(variableResult.d).isUndefined();
  - name: Test with empty keys array
    code: |-
      const src = {name: 'John', age: 30, city: 'Paris'};
      const kys = [];
      const mockData = {
          src: src,
          kys: kys,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, []);
      }
      assertThat(variableResult).isEqualTo({});
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
