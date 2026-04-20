___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "entries",
  "description": "Retrieves the entries of an \u003cem\u003eobject\u003c/em\u003e (key-value pairs), returning an \u003cem\u003earray\u003c/em\u003e where each entry is a [key, value] pair. Non-object inputs will be coerced to \u003cem\u003eobjects\u003c/em\u003e.",
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
        "displayName": "Object To Process",
        "simpleValueType": true,
        "help": "💾   The object whose entries are to be retrieved. If the input is not an object, it will be coerced to an object.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny (will be coerced)\u003c/strong\u003e"
      }
    ],
    "help": "Returns an \u003cem\u003earray\u003c/em\u003e of [key, value] pairs from an object.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eObject to entries\u003c/em\u003e***\u003cbr\u003eObject To Process: \u003cstrong\u003e{name: 'John', age: '30', city: 'Paris'}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[['name', 'John'], ['age', '30'], ['city', 'Paris']]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty object returns empty\u003c/em\u003e***\u003cbr\u003eObject To Process: \u003cstrong\u003e{}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert object to string, normalize case). Internal transformations such as case handling will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str + ' €', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Retrieves the entries of an object (key-value pairs).
 * 
 * @param {Object} data.src - The object whose entries are to be retrieved.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before getting entries.
 * 
 * @returns {Array} An array of key-value pairs of the provided object, where each entry is an array [key, value].
 *
 * @framework ggLowCodeGTMKit
 */
const Object = require('Object');
const entries = function(objectInput) {
    return Object.entries(objectInput);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// entries - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(entries(value));
// ===============================================================================
// entries() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(entries(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Object to entries'
    code: |
      /* @display
      Object To Process: {name: 'John', age: '30', city: 'Paris'}
      @output
      [['name', 'John'], ['age', '30'], ['city', 'Paris']]
      */
      const src = {name: 'John', age: '30', city: 'Paris'};
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([['name', 'John'], ['age', '30'], ['city', 'Paris']]);
  - name: Object with numeric values - should return key-value pairs
    code: |-
      const src = {a: 1, b: 2, c: 3};
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([['a', 1], ['b', 2], ['c', 3]]);
  - name: Object with mixed value types - should return key-value pairs
    code: |
      const src = {name: 'Alice', count: 42, active: true};
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([['name', 'Alice'], ['count', 42], ['active', true]]);
  - name: '[example] Empty object returns empty'
    code: |-
      /* @display
      Object To Process: {}
      @output
      []
      */
      const src = {};
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([]);
  - name: Object with array values - should return key-value pairs with arrays
    code: |
      const src = {items: [1, 2, 3], tags: ['a', 'b']};
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([['items', [1, 2, 3]], ['tags', ['a', 'b']]]);
  - name: Object with nested object values - should return key-value pairs with nested objects
    code: |
      const src = {user: {name: 'Bob', age: 25}, settings: {theme: 'dark'}};
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([['user', {name: 'Bob', age: 25}], ['settings', {theme: 'dark'}]]);
  - name: Object with undefined values - should return key-value pairs with undefined
    code: |-
      const src = {key: undefined, key: 'defined', key: undefined};
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([['key', undefined], ['key', 'defined'], ['key', undefined]]);
  - name: Object with null values - should return key-value pairs with null
    code: |
      const src = {key: null, key: 'value', key: null};
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([['key', null], ['key', 'value'], ['key', null]]);
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
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
