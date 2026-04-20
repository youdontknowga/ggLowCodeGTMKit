___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "assignObjects",
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
        "help": "💾   The base object to merge into."
      },
      {
        "type": "TEXT",
        "name": "ext",
        "displayName": "Extension Object",
        "simpleValueType": true,
        "help": "💾   An object whose properties will override or extend the base object."
      }
    ],
    "help": "Merges two \u003cem\u003eobjects\u003c/em\u003e. Later properties override earlier ones.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMerge two objects\u003c/em\u003e***\u003cbr\u003eBase Object: \u003cstrong\u003e{name: \"John\", age: 30}\u003c/strong\u003e\u003cbr\u003eext: \u003cstrong\u003e{city: \"Paris\", country: \"France\"}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{name: \"John\", age: 30, city: \"Paris\", country: \"France\"}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOverride on conflict\u003c/em\u003e***\u003cbr\u003eBase Object: \u003cstrong\u003e{name: \"John\", age: 30, city: \"London\"}\u003c/strong\u003e\u003cbr\u003eext: \u003cstrong\u003e{city: \"Paris\", country: \"France\"}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{name: \"John\", age: 30, city: \"Paris\", country: \"France\"}\u003c/strong\u003e"
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
const getType = require('getType');

const assign = function(sourceObject, additionalObject) {
   const result = {};
   if (getType(sourceObject) === 'object') {
       for (let key in sourceObject) {
           result[key] = sourceObject[key];
       }
   }
   if (getType(additionalObject) === 'object') {
       for (let key in additionalObject) {
           result[key] = additionalObject[key];
       }
   }
   return result;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// assignObjects - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(assign(value, data.ext));
// ===============================================================================
// assignObjects(...) – Apply Mode
// ===============================================================================
/*
return function(value, additionalObject) {
   additionalObject = data.rp1 ? data.ext : additionalObject;
   return out(assign(value, additionalObject));
};
*/


___TESTS___

scenarios:
  - name: '[example] Merge two objects'
    code: |
      /* @display
      Base Object: {name: "John", age: 30}
      Extension Object: {city: "Paris", country: "France"}
      @output
      {name: "John", age: 30, city: "Paris", country: "France"}
      */
      const src = {name: "John", age: 30};
      const ext = {city: "Paris", country: "France"};
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
          variableResult = func(src, ext);
      }
      assertThat(variableResult).isEqualTo({name: "John", age: 30, city: "Paris", country: "France"});
  - name: '[example] Override on conflict'
    code: |
      /* @display
      Base Object: {name: "John", age: 30, city: "London"}
      Extension Object: {city: "Paris", country: "France"}
      @output
      {name: "John", age: 30, city: "Paris", country: "France"}
      */
      const src = {name: "John", age: 30, city: "London"};
      const ext = {city: "Paris", country: "France"};
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
          variableResult = func(src, ext);
      }
      assertThat(variableResult).isEqualTo({name: "John", age: 30, city: "Paris", country: "France"});
  - name: Empty source object - returns only extension properties
    code: |-
      const src = {};
      const ext = {key: "value", number: 123};
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
          variableResult = func(src, ext);
      }
      assertThat(variableResult).isEqualTo({key: "value", number: 123});
  - name: Empty extension object - returns only source properties
    code: |-
      const src = {name: "Alice", id: 42};
      const ext = {};
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
          variableResult = func(src, ext);
      }
      assertThat(variableResult).isEqualTo({name: "Alice", id: 42});
  - name: Both empty objects - returns empty object
    code: |-
      const src = {};
      const ext = {};
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
          variableResult = func(src, ext);
      }
      assertThat(variableResult).isEqualTo({});
  - name: Non-object source - handles invalid source
    code: |
      const src = "not an object";
      const ext = {key: "value"};
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
          variableResult = func(src, ext);
      }
      assertThat(variableResult).isEqualTo({key: "value"});
  - name: Non-object extension - handles invalid extension
    code: |
      const src = {name: "John"};
      const ext = "not an object";
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
          variableResult = func(src, ext);
      }
      assertThat(variableResult).isEqualTo({name: "John"});
  - name: Both non-objects - handles both invalid
    code: |-
      const src = null;
      const ext = undefined;
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
          variableResult = func(src, ext);
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
