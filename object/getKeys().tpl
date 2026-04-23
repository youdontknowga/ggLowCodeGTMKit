___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getKeys()",
  "description": "Returns an \u003cem\u003earray\u003c/em\u003e of a given object\u0027s own enumerable property names in the same order that a for...in... loop would. If the input value is not an object, it will be coerced to an object.",
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
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet object keys\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['name', 'age', 'city']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty object returns empty\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Object To Process"
      }
    ],
    "help": "Returns an \u003cem\u003earray\u003c/em\u003e of an object's own keys.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet object keys\u003c/em\u003e***\u003cbr\u003eobj: \u003cstrong\u003e{name: 'John', age: 30, city: 'Paris'}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['name', 'age', 'city']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty object returns empty\u003c/em\u003e***\u003cbr\u003eobj: \u003cstrong\u003e{}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., arr =\u003e arr.sort(), arr =\u003e arr.filter(key =\u003e key.length \u003e 3) for filtering). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Retrieves the keys of an object.
 *
 * @param {Object} data.obj - The object whose keys are to be retrieved.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform obj before extracting keys.
 * 
 * @returns {Array} An array of the keys of the provided object.
 *
 * @framework ggLowCodeGTMKit
 */
const Object = require('Object');

const getKeys = function(objectInput) {
    return Object.keys(objectInput);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// getKeys - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedObject = applyCast(data.pre, data.obj);
return out(getKeys(processedObject));
*/
// ===============================================================================
// getKeys() – Apply Mode
// ===============================================================================
return function(value) {
   return out(getKeys(value));
};


___TESTS___

scenarios:
  - name: '[example] Get object keys'
    code: |-
      /* @display
      obj: {name: 'John', age: 30, city: 'Paris'}
      @output
      ['name', 'age', 'city']
      */
      const obj = {name: 'John', age: 30, city: 'Paris'};
      const mockData = {
          obj: obj
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj);
      }
      assertThat(variableResult).isEqualTo(['name', 'age', 'city']);
  - name: Object with single key - should return array with one key
    code: |-
      const obj = {id: 123};
      const mockData = {
          obj: obj
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj);
      }
      assertThat(variableResult).isEqualTo(['id']);
  - name: '[example] Empty object returns empty'
    code: |-
      /* @display
      obj: {}
      @output
      []
      */
      const obj = {};
      const mockData = {
          obj: obj
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj);
      }
      assertThat(variableResult).isEqualTo([]);
  - name: Object with numeric keys - should return array of string keys
    code: |-
      const obj = {0: 'zero', 1: 'one', 2: 'two'};
      const mockData = {
          obj: obj
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj);
      }
      assertThat(variableResult).isEqualTo(['0', '1', '2']);
  - name: Nested object - should return only top-level keys
    code: |-
      const obj = {user: {name: 'Alice'}, settings: {theme: 'dark'}};
      const mockData = {
          obj: obj
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj);
      }
      assertThat(variableResult).isEqualTo(['user', 'settings']);
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
