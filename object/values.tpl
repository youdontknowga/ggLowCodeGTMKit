___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "values",
  "description": "Retrieves the values of an \u003cem\u003eobject\u003c/em\u003e, returning an \u003cem\u003earray\u003c/em\u003e of all property values. Non-object inputs will be coerced to objects.",
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
        "help": "💾   The object whose values are to be retrieved. If the input is not an object, it will be coerced to an object.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny (will be coerced)\u003c/strong\u003e"
      }
    ],
    "help": "Returns an \u003cem\u003earray\u003c/em\u003e of an object's own values.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet object values\u003c/em\u003e***\u003cbr\u003eObject To Process: \u003cstrong\u003e{name: 'John', age: 30, city: 'Paris'}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['John', 30, 'Paris']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty object returns empty\u003c/em\u003e***\u003cbr\u003eObject To Process: \u003cstrong\u003e{}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
 * Retrieves the values of an object.
 * 
 * @param {Object} data.src - The object whose values are to be retrieved. If the input is not an object, it will be coerced to an object.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before getting values.
 * 
 * @returns {Array} An array of the values of the provided object.
 *
 * @framework ggLowCodeGTMKit
 */
const Object = require('Object');

const values = function(objectInput) {
    return Object.values(objectInput);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// values - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(values(value));

// ===============================================================================
// values() – Apply Mode: runtime parameter
// ===============================================================================
/*
return function(value) {
   return out(values(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Get object values'
    code: |-
      /* @display
      Object To Process: {name: 'John', age: 30, city: 'Paris'}
      @output
      ['John', 30, 'Paris']
      */
      const src = {name: 'John', age: 30, city: 'Paris'};
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
      assertThat(variableResult).isEqualTo(['John', 30, 'Paris']);
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
  - name: Object with array values - should return array of arrays
    code: |-
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
      assertThat(variableResult).isEqualTo([[1, 2, 3], ['a', 'b']]);
  - name: Object with nested object values - should return array of nested objects
    code: |-
      const src = {user: {name: 'John'}, config: {theme: 'dark'}};
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
      assertThat(variableResult).isEqualTo([{name: 'John'}, {theme: 'dark'}]);
  - name: Object with single property - should return array with single value
    code: |-
      const src = {key: 'value'};
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
      assertThat(variableResult).isEqualTo(['value']);
  - name: Object with numeric keys - should return array of values
    code: |-
      const src = {1: 'one', 2: 'two', 3: 'three'};
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
      assertThat(variableResult).isEqualTo(['one', 'two', 'three']);
  - name: String input - should return array of characters
    code: |-
      const src = 'hello';
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
      assertThat(variableResult).isEqualTo(['h', 'e', 'l', 'l', 'o']);
  - name: Array input - should return same array
    code: |-
      const src = ['a', 'b', 'c'];
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
      assertThat(variableResult).isEqualTo(['a', 'b', 'c']);
  - name: Number input - should return empty array
    code: |-
      const src = 123;
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
  - name: Object with mixed value types - should return array of mixed types
    code: |-
      const src = {a: 1, b: 'test', c: true};
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
      assertThat(variableResult).isEqualTo([1, 'test', true]);
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
