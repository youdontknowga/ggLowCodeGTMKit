___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "assignObjectsFromPairs",
  "description": "Assigns properties from two \u003cem\u003eobject\u003c/em\u003es into a new object. Properties from the second object override those from the first.",
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
        "displayName": "Base Object",
        "simpleValueType": true,
        "help": "💾   The base object to merge into.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "lb1",
        "displayName": "Properties to assign"
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "ext",
        "displayName": "",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Key",
            "name": "key",
            "type": "TEXT"
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "val",
            "type": "TEXT"
          }
        ],
        "help": "💾   An object whose properties will override or extend the base object.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMerge pair objects\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOverride existing keys\u003c/em\u003e***"
      }
    ],
    "help": "Merges key-value pair \u003cem\u003eobjects\u003c/em\u003e from a GTM table.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMerge pair objects\u003c/em\u003e***\u003cbr\u003eBase Object: \u003cstrong\u003e{name: 'John', age: 30}\u003c/strong\u003e\u003cbr\u003eext: \u003cstrong\u003e[{key: 'city', val: 'Paris'}, {key: 'country', val: 'France'}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOverride existing keys\u003c/em\u003e***\u003cbr\u003eBase Object: \u003cstrong\u003e{name: 'John', age: 30, city: 'London'}\u003c/strong\u003e\u003cbr\u003eext: \u003cstrong\u003e[{key: 'age', val: 35}, {key: 'city', val: 'Paris'}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e"
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
 * Assigns properties from two objects into a new object.
 * 
 * @param {Object} data.src - The base object.
 * @param {Object} data.ext - An object whose properties will override or extend the base object.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before merging.
 * 
 * @returns {Object} A new object containing properties from both inputs.
 *
 * @framework ggLowCodeGTMKit
 */
const makeTableMap = require('makeTableMap');

const assign = function(sourceObject, additionalObject) {
    // Copy all properties from additionalObject to sourceObject
    for (let key in additionalObject) {
        sourceObject[key] = additionalObject[key];
    }
    return sourceObject;
};

const toObjectPairs = function(simpleTable) {
    return makeTableMap(simpleTable, "key", "val");
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// assignObjectsFromPairs - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(assign(value, toObjectPairs(data.ext)));
// ===============================================================================
// assignObjectsFromPairs(...) – Apply Mode
// ===============================================================================
/*
return function(value, additionalObject) {
   additionalObject = data.rp1 ? data.ext : additionalObject;
   return out(assign(value, additionalObject));
};
*/


___TESTS___

scenarios:
  - name: '[example] Merge pair objects'
    code: |-
      /* @display
      Base Object: {name: 'John', age: 30}
      ext: [{key: 'city', val: 'Paris'}, {key: 'country', val: 'France'}]
      @output
      John
      */
      const src = {name: 'John', age: 30};
      const ext = [{key: 'city', val: 'Paris'}, {key: 'country', val: 'France'}];
      const mockData = {
          src: src,
          ext: ext,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, {city: 'Paris', country: 'France'});
      }
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo(30);
      assertThat(variableResult.city).isEqualTo('Paris');
      assertThat(variableResult.country).isEqualTo('France');
  - name: '[example] Override existing keys'
    code: |-
      /* @display
      Base Object: {name: 'John', age: 30, city: 'London'}
      ext: [{key: 'age', val: 35}, {key: 'city', val: 'Paris'}]
      @output
      John
      */
      const src = {name: 'John', age: 30, city: 'London'};
      const ext = [{key: 'age', val: 35}, {key: 'city', val: 'Paris'}];
      const mockData = {
          src: src,
          ext: ext,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, {age: 35, city: 'Paris'});
      }
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo(35);
      assertThat(variableResult.city).isEqualTo('Paris');
  - name: Test with empty additional object
    code: |-
      const src = {name: 'John', age: 30};
      const ext = [];
      const mockData = {
          src: src,
          ext: ext,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, {});
      }
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo(30);
  - name: Test with empty source object
    code: |-
      const src = {};
      const ext = [{key: 'status', val: 'active'}, {key: 'role', val: 'admin'}];
      const mockData = {
          src: src,
          ext: ext,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, {status: 'active', role: 'admin'});
      }
      assertThat(variableResult.status).isEqualTo('active');
      assertThat(variableResult.role).isEqualTo('admin');
  - name: Test with mixed value types
    code: |-
      const src = {id: 1, enabled: true};
      const ext = [{key: 'name', val: 'Test'}, {key: 'count', val: 42}, {key: 'active', val: false}];
      const mockData = {
          src: src,
          ext: ext,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, {name: 'Test', count: 42, active: false});
      }
      assertThat(variableResult.id).isEqualTo(1);
      assertThat(variableResult.enabled).isTrue();
      assertThat(variableResult.name).isEqualTo('Test');
      assertThat(variableResult.count).isEqualTo(42);
      assertThat(variableResult.active).isFalse();
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
