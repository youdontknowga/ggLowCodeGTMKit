___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "assignDefaults",
  "description": "Assigns default values from the second \u003cem\u003eobject\u003c/em\u003e to the first. Only properties that are \u003cem\u003eundefined\u003c/em\u003e in the base \u003cem\u003eobject\u003c/em\u003e will be assigned.",
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
        "help": "💾   The base object with initial values."
      },
      {
        "type": "TEXT",
        "name": "def",
        "displayName": "Default Values",
        "simpleValueType": true,
        "help": "💾   An object containing default values to assign where undefined."
      }
    ],
    "help": "Fills in missing properties from a defaults \u003cem\u003eobject\u003c/em\u003e. Existing values are preserved.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFill missing properties\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{name: \"John\", age: 30}\u003c/strong\u003e\u003cbr\u003edef: \u003cstrong\u003e{age: 25, city: \"Paris\", country: \"France\"}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{name: \"John\", age: 30, city: \"Paris\", country: \"France\"}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExisting values preserved\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{name: \"Alice\", age: 40, city: \"London\"}\u003c/strong\u003e\u003cbr\u003edef: \u003cstrong\u003e{name: \"Bob\", age: 25, city: \"Paris\"}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{name: \"Alice\", age: 40, city: \"London\"}\u003c/strong\u003e"
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
 * Assigns default values from the second object to the first.
 * 
 * @param {Object} data.src - The base object with initial values.
 * @param {Object} data.def - An object containing default values.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before merging.
 * 
 * @returns {Object} A new object with default values assigned where needed.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const assignDefaults = function(sourceObject, defaultsObject) {
    const result = {};
    if (getType(sourceObject) === 'object') {
        for (let key in sourceObject) {
            result[key] = sourceObject[key];
        }
    }
    if (getType(defaultsObject) === 'object') {
        for (let key in defaultsObject) {
            if (result[key] === undefined) {
                result[key] = defaultsObject[key];
            }
        }
    }
    return result;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// assignDefaults - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(assignDefaults(value, data.def));
// ===============================================================================
// assignDefaults(...) – Apply Mode
// ===============================================================================
/*
return function(value, defaultsObject) {
   defaultsObject = data.rp1 ? data.def : defaultsObject;
   return out(assignDefaults(value, defaultsObject));
};
*/


___TESTS___

scenarios:
  - name: '[example] Fill missing properties'
    code: |
      /* @display
      Value to Process: {name: "John", age: 30}
      def: {age: 25, city: "Paris", country: "France"}
      @output
      {name: "John", age: 30, city: "Paris", country: "France"}
      */
      const src = {name: "John", age: 30};
      const def = {age: 25, city: "Paris", country: "France"};
      const mockData = {
          src: src,
          def: def,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, def);
      }
      assertThat(variableResult).isEqualTo({name: "John", age: 30, city: "Paris", country: "France"});
  - name: Empty base object - returns all defaults
    code: |-
      const src = {};
      const def = {key: "value", number: 123};
      const mockData = {
          src: src,
          def: def,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, def);
      }
      assertThat(variableResult).isEqualTo({key: "value", number: 123});
  - name: '[example] Existing values preserved'
    code: |
      /* @display
      Value to Process: {name: "Alice", age: 40, city: "London"}
      def: {name: "Bob", age: 25, city: "Paris"}
      @output
      {name: "Alice", age: 40, city: "London"}
      */
      const src = {name: "Alice", age: 40, city: "London"};
      const def = {name: "Bob", age: 25, city: "Paris"};
      const mockData = {
          src: src,
          def: def,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, def);
      }
      assertThat(variableResult).isEqualTo({name: "Alice", age: 40, city: "London"});
  - name: Non-object source - returns only defaults
    code: |
      const src = "not an object";
      const def = {key: "value"};
      const mockData = {
          src: src,
          def: def,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, def);
      }
      assertThat(variableResult).isEqualTo({key: "value"});
  - name: Both non-objects - returns empty object
    code: |-
      const src = null;
      const def = undefined;
      const mockData = {
          src: src,
          def: def,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, def);
      }
      assertThat(variableResult).isEqualTo({});
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
