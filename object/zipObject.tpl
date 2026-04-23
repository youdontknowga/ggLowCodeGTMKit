___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "zipObject",
  "description": "Creates an object from two arrays: one for keys and one for values. If there are more values than keys, extra keys are auto-generated using the provided prefix.",
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
        "displayName": "Keys Array",
        "simpleValueType": true,
        "help": "💾 Array of property names that will become object keys.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e: \u003cem\u003e[\"name\", \"age\", \"city\"]\u003c/em\u003e"
      },
      {
        "type": "TEXT",
        "name": "val",
        "displayName": "Values Array",
        "simpleValueType": true,
        "help": "💾 Array of values corresponding to each key. If shorter than keys array, remaining keys will have undefined values.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e: \u003cem\u003e[\"John\", 30, \"Paris\"]\u003c/em\u003e"
      }
    ],
    "help": "Creates an \u003cem\u003eobject\u003c/em\u003e from parallel arrays of keys and values.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eZip keys and values\u003c/em\u003e***\u003cbr\u003eKeys Array: \u003cstrong\u003e['name', 'age', 'city']\u003c/strong\u003e\u003cbr\u003eValues Array: \u003cstrong\u003e['John', 30, 'Paris']\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{name: 'John', age: 30, city: 'Paris'}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty arrays return empty\u003c/em\u003e***\u003cbr\u003eKeys Array: \u003cstrong\u003e[]\u003c/strong\u003e\u003cbr\u003eValues Array: \u003cstrong\u003e[]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{}\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the keys array before creating the object (e.g., normalize keys, filter out invalid keys)."
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
 * Creates an object from two arrays: one of property names and one of corresponding values.
 *
 * @param {Array} data.src - Array of property names (keys).
 * @param {Array} data.val - Array of corresponding values.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {Object} An object composed of the given keys and values.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const zipObject = function(keys, values) {
    if (getType(keys) !== 'array' || getType(values) !== 'array') {
        return {};
    }
    
    const result = {};
    const length = keys.length;
    
    for (let i = 0; i < length; i++) {
        const key = keys[i];
        if (key !== null && key !== undefined) {
            result[key] = i < values.length ? values[i] : undefined;
        }
    }
    
    return result;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// zipObject - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(zipObject(value, data.val));
// ===============================================================================
// zipObject(...) – Apply Mode
// ===============================================================================
/*
return function(keys, values) {
   values = data.rp1 ? data.val : values;
   return out(zipObject(keys, values));
};
*/


___TESTS___

scenarios:
  - name: '[example] Zip keys and values'
    code: |-
      /* @display
      Keys Array: ['name', 'age', 'city']
      Values Array: ['John', 30, 'Paris']
      @output
      {name: 'John', age: 30, city: 'Paris'}
      */
      const src = ['name', 'age', 'city'];
      const val = ['John', 30, 'Paris'];
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo({name: 'John', age: 30, city: 'Paris'});
  - name: Test with values array shorter than keys
    code: |-
      const src = ['a', 'b', 'c', 'd'];
      const val = [1, 2];
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult.a).isEqualTo(1);
      assertThat(variableResult.b).isEqualTo(2);
      assertThat(variableResult.c).isUndefined();
      assertThat(variableResult.d).isUndefined();
  - name: Test with keys array shorter than values
    code: |-
      const src = ['x', 'y'];
      const val = [10, 20, 30, 40];
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo({x: 10, y: 20});
  - name: '[example] Empty arrays return empty'
    code: |-
      /* @display
      Keys Array: []
      Values Array: []
      @output
      {}
      */
      const src = [];
      const val = [];
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo({});
  - name: Test with null key (should skip)
    code: |
      const src = ['a', null, 'b'];
      const val = [1, 2, 3];
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo({a: 1, b: 3});
  - name: Test with undefined key (should skip)
    code: |-
      const src = ['a', undefined, 'b'];
      const val = [1, 2, 3];
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo({a: 1, b: 3});
  - name: Test with non-array keys returns empty object
    code: |-
      const src = 'not an array';
      const val = [1, 2, 3];
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo({});
  - name: Test with non-array values returns empty object
    code: |
      const src = ['a', 'b', 'c'];
      const val = 'not an array';
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo({});
  - name: Test with mixed value types
    code: |-
      const src = ['string', 'number', 'boolean', 'null', 'object'];
      const val = ['text', 42, true, null, {nested: 'value'}];
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult.string).isEqualTo('text');
      assertThat(variableResult.number).isEqualTo(42);
      assertThat(variableResult.boolean).isTrue();
      assertThat(variableResult.null).isNull();
      assertThat(variableResult.object.nested).isEqualTo('value');
  - name: Test with duplicate keys (last one wins)
    code: |-
      const src = ['key', 'key', 'key'];
      const val = [1, 2, 3];
      const mockData = {
          src: src,
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo({key: 3});
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
