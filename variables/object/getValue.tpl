___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getValue",
  "description": "Retrieves a value from an \u003cem\u003eobject\u003c/em\u003e using a single \u003cem\u003ekey\u003c/em\u003e. For single-level access only. Use \u003cstrong\u003egetValueByPath\u003c/strong\u003e for nested object access.",
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
        "name": "obj",
        "displayName": "Object",
        "simpleValueType": true,
        "help": "💾   The object to retrieve the value from.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "key",
        "displayName": "Key",
        "simpleValueType": true,
        "help": "💾   The key of the value to retrieve.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Returns the value of a property from an \u003cem\u003eobject\u003c/em\u003e by key.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet existing key value\u003c/em\u003e***\u003cbr\u003eObject: \u003cstrong\u003e{name: 'John', age: 30, city: 'Paris'}\u003c/strong\u003e\u003cbr\u003eKey: \u003cstrong\u003ename\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMissing key returns undefined\u003c/em\u003e***\u003cbr\u003eObject: \u003cstrong\u003e{name: 'John', age: 30}\u003c/strong\u003e\u003cbr\u003eKey: \u003cstrong\u003eemail\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the object before internal logic (e.g., parse JSON string to object, normalize structure). Internal transformations will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., val =\u003e val || 'default', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Retrieves a value from an object using a key.
 * 
 * @param {Object} data.obj - The object to retrieve the value from.
 * @param {string} data.key - The key of the value to retrieve.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform obj before processing.
 * 
 * @returns {*} The value at the specified key, or undefined if not found.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const getValue = function(obj, key) {
  if (getType(obj) !== 'object' || obj === null) {
    return undefined;
  }
  return obj[key];
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// getValue - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedObj = applyCast(data.pre, data.obj);
return out(getValue(processedObj, data.key));
// ===============================================================================
// getValue(...) – Apply Mode
// ===============================================================================
/*
return function(value, key) {
   key = data.rp1 ? data.key : key;
   return out(getValue(value, key));
};
*/


___TESTS___

scenarios:
  - name: '[example] Get existing key value'
    code: |-
      /* @display
      Object: {name: 'John', age: 30, city: 'Paris'}
      Key: name
      @output
      John
      */
      const obj = {name: 'John', age: 30, city: 'Paris'};
      const key = 'name';
      const mockData = {
          obj: obj,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key);
      }
      assertThat(variableResult).isEqualTo('John');
  - name: '[example] Missing key returns undefined'
    code: |-
      /* @display
      Object: {name: 'John', age: 30}
      Key: email
      @output
      undefined
      */
      const obj = {name: 'John', age: 30};
      const key = 'email';
      const mockData = {
          obj: obj,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key);
      }
      assertThat(variableResult).isUndefined();
  - name: Object with numeric value - should return number
    code: |-
      const obj = {id: 123, count: 456};
      const key = 'count';
      const mockData = {
          obj: obj,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key);
      }
      assertThat(variableResult).isEqualTo(456);
  - name: Object with boolean value - should return boolean
    code: |-
      const obj = {isActive: true, isDeleted: false};
      const key = 'isActive';
      const mockData = {
          obj: obj,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key);
      }
      assertThat(variableResult).isTrue();
  - name: Object with array value - should return array
    code: |-
      const obj = {items: [1, 2, 3], tags: ['a', 'b']};
      const key = 'items';
      const mockData = {
          obj: obj,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key);
      }
      assertThat(variableResult).isEqualTo([1, 2, 3]);
  - name: Object with nested object value - should return nested object
    code: |-
      const obj = {user: {name: 'John', age: 30}};
      const key = 'user';
      const mockData = {
          obj: obj,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key);
      }
      assertThat(variableResult).isEqualTo({name: 'John', age: 30});
  - name: Empty object - should return undefined
    code: |-
      const obj = {};
      const key = 'anything';
      const mockData = {
          obj: obj,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key);
      }
      assertThat(variableResult).isUndefined();
  - name: Non-object input (string) - should return undefined
    code: |-
      const obj = 'not an object';
      const key = 'name';
      const mockData = {
          obj: obj,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key);
      }
      assertThat(variableResult).isUndefined();
  - name: Object with undefined value explicitly set - should return undefined
    code: |-
      const obj = {name: 'John', age: undefined};
      const key = 'age';
      const mockData = {
          obj: obj,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key);
      }
      assertThat(variableResult).isUndefined();
  - name: Object with null value - should return null
    code: |-
      const obj = {name: 'John', address: null};
      const key = 'address';
      const mockData = {
          obj: obj,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key);
      }
      assertThat(variableResult).isNull();
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
