___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "omit",
  "description": "Creates a new object by removing all properties whose keys match the values in a provided list. If a value is an array, all its elements will be excluded.",
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
        "displayName": "Source Object",
        "simpleValueType": true,
        "help": "💾 The source object to omit properties from.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject variable\u003c/strong\u003e: \u003cem\u003e{{myObject}}\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject literal\u003c/strong\u003e"
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "kys",
        "displayName": "Properties to Omit",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Property Name",
            "name": "value",
            "type": "TEXT"
          }
        ],
        "help": "💾 List of property names to exclude from the result object. All other properties will be included.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e: property name\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray of strings\u003c/strong\u003e: for multiple properties at once\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOmit single property\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOmit multiple properties\u003c/em\u003e***"
      }
    ],
    "help": "Returns a new \u003cem\u003eobject\u003c/em\u003e with specified keys removed.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOmit single property\u003c/em\u003e***\u003cbr\u003eSource Object: \u003cstrong\u003e{name: 'John', age: 30, city: 'Paris'}\u003c/strong\u003e\u003cbr\u003eProperties to Omit: \u003cstrong\u003e[{value: 'age'}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOmit multiple properties\u003c/em\u003e***\u003cbr\u003eSource Object: \u003cstrong\u003e{a: 1, b: 2, c: 3, d: 4}\u003c/strong\u003e\u003cbr\u003eProperties to Omit: \u003cstrong\u003e[{value: 'b'}, {value: 'd'}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the source object before omitting properties (e.g., normalize object structure, parse JSON)."
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
        "help": "⚙️ Optional function to apply to the result object before returning it (e.g., \u003ccode\u003eobj =\u003e JSON.stringify(obj)\u003c/code\u003e, \u003ccode\u003eobj =\u003e Object.freeze(obj)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Creates a new object by omitting specified properties from the source object.
 *
 * @param {Object} data.src - The source object.
 * @param {Array} data.kys - Array of objects with property names to omit.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {Object} A new object without the specified properties.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const createFlatArrayFromValues = function(list, property) {
    const result = [];
    for (let i = 0; i < list.length; i++) {
        const val = list[i][property];
        if (getType(val) === 'array') {
            for (let j = 0; j < val.length; j++) {
                result.push(val[j]);
            }
        } else {
            result.push(val);
        }
    }
    return result;
};

const omit = function(object, keysToOmit) {
    const result = {};
    
    if (object == null || typeof object !== 'object') {
        return result;
    }
    
    for (let key in object) {
        if (object.hasOwnProperty(key) && keysToOmit.indexOf(key) === -1) {
            result[key] = object[key];
        }
    }
    
    return result;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// omit - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
const keys = createFlatArrayFromValues(data.kys, "value");
return out(omit(value, keys));
// ===============================================================================
// omit(...) – Apply Mode
// ===============================================================================
/*
return function(object, keys) {
   keys = data.rp1 ? createFlatArrayFromValues(data.kys, "value") : keys;
   return out(omit(object, keys));
};
*/


___TESTS___

scenarios:
  - name: '[example] Omit single property'
    code: |-
      /* @display
      Source Object: {name: 'John', age: 30, city: 'Paris'}
      Properties to Omit: [{value: 'age'}]
      @output
      John
      */
      const src = {name: 'John', age: 30, city: 'Paris'};
      const kys = [{value: 'age'}];
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
          variableResult = func(src, ['age']);
      }
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.city).isEqualTo('Paris');
      assertThat(variableResult.age).isUndefined();
  - name: '[example] Omit multiple properties'
    code: |-
      /* @display
      Source Object: {a: 1, b: 2, c: 3, d: 4}
      Properties to Omit: [{value: 'b'}, {value: 'd'}]
      @output
      1
      */
      const src = {a: 1, b: 2, c: 3, d: 4};
      const kys = [{value: 'b'}, {value: 'd'}];
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
          variableResult = func(src, ['b', 'd']);
      }
      assertThat(variableResult.a).isEqualTo(1);
      assertThat(variableResult.c).isEqualTo(3);
      assertThat(variableResult.b).isUndefined();
      assertThat(variableResult.d).isUndefined();
  - name: Test omitting non-existent property
    code: |
      const src = {name: 'John', age: 30};
      const kys = [{value: 'city'}];
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
          variableResult = func(src, ['city']);
      }
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo(30);
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
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo(30);
      assertThat(variableResult.city).isEqualTo('Paris');
  - name: Test with array of keys in value property
    code: |-
      const src = {a: 1, b: 2, c: 3, d: 4};
      const kys = [{value: ['a', 'c']}];
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
          variableResult = func(src, ['a', 'c']);
      }
      assertThat(variableResult.b).isEqualTo(2);
      assertThat(variableResult.d).isEqualTo(4);
      assertThat(variableResult.a).isUndefined();
      assertThat(variableResult.c).isUndefined();
  - name: Test with null object returns empty object
    code: |-
      const src = null;
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
      assertThat(variableResult).isEqualTo({});
  - name: Test with undefined object returns empty object
    code: |-
      const src = undefined;
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
      assertThat(variableResult).isEqualTo({});
  - name: Test with non-object input returns empty object
    code: |-
      const src = 'not an object';
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
      assertThat(variableResult).isEqualTo({});
  - name: Test omitting all properties
    code: |-
      const src = {a: 1, b: 2};
      const kys = [{value: 'a'}, {value: 'b'}];
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
          variableResult = func(src, ['a', 'b']);
      }
      assertThat(variableResult).isEqualTo({});
  - name: Test with nested object values preserved
    code: |-
      const src = {name: 'John', address: {city: 'Paris', zip: '75001'}, age: 30};
      const kys = [{value: 'age'}];
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
          variableResult = func(src, ['age']);
      }
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.address.city).isEqualTo('Paris');
      assertThat(variableResult.address.zip).isEqualTo('75001');
      assertThat(variableResult.age).isUndefined();
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
