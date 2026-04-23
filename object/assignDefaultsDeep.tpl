___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "assignDefaultsDeep",
  "description": "Recursively assign default values from one object to another. Nested properties are only filled in if they are undefined in the base object. Existing values are preserved.",
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
        "help": "💾 The base object to which defaults will be applied. Existing properties will not be overwritten.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject variable\u003c/strong\u003e: \u003cem\u003e{{myObject}}\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject literal\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "def",
        "displayName": "Defaults Object",
        "simpleValueType": true,
        "help": "💾 An object containing default values. Only properties that are undefined in the base object will be filled in, including nested properties.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject variable\u003c/strong\u003e: \u003cem\u003e{{defaultsObject}}\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject literal\u003c/strong\u003e"
      }
    ],
    "help": "Recursively fills in missing properties from a defaults \u003cem\u003eobject\u003c/em\u003e, deeply nested.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDeep fill missing\u003c/em\u003e***\u003cbr\u003eBase Object: \u003cstrong\u003e{name: \"John\", age: 30}\u003c/strong\u003e\u003cbr\u003eDefaults Object: \u003cstrong\u003e{name: \"Default\", age: 0, email: \"default@example.com\", role: \"user\"}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExisting values preserved\u003c/em\u003e***\u003cbr\u003eBase Object: \u003cstrong\u003e{status: \"active\", count: 5}\u003c/strong\u003e\u003cbr\u003eDefaults Object: \u003cstrong\u003e{status: \"inactive\", count: 0, type: \"default\"}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eactive\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the base object before applying defaults (e.g., normalize object structure, filter properties)."
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
 * Recursively assigns default values from one object to another.
 * Only properties that are `undefined` will be filled in, including nested ones.
 * 
 * @param {Object} data.src - The base object to assign defaults to.
 * @param {Object} data.def - An object containing default values.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {Object} A new object with deeply applied default values.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const defaultsDeep = function(target, defaults) {
    const result = {};
    // Copy or recurse from target
    for (let key in target) {
        if (getType(target[key]) === 'object' && getType(defaults[key]) === 'object') {
            result[key] = defaultsDeep(target[key], defaults[key]);
        } else {
            result[key] = target[key];
        }
    }
    // Fill in missing keys from defaults
    for (let key in defaults) {
        if (typeof result[key] === 'undefined') {
            result[key] = defaults[key];
        }
    }
    return result;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// defaultsDeep - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(defaultsDeep(value, data.def));
// ===============================================================================
// defaultsDeep(...) – Apply Mode
// ===============================================================================
/*
return function(targetObject, defaultsObject) {
   defaultsObject = data.rp1 ? data.def : defaultsObject;
   return out(defaultsDeep(targetObject, defaultsObject));
};
*/


___TESTS___

scenarios:
  - name: '[example] Deep fill missing'
    code: |-
      /* @display
      Base Object: {name: "John", age: 30}
      Defaults Object: {name: "Default", age: 0, email: "default@example.com", role: "user"}
      @output
      John
      */
      const src = {name: "John", age: 30};
      const def = {name: "Default", age: 0, email: "default@example.com", role: "user"};
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
      assertThat(variableResult.name).isEqualTo("John");
      assertThat(variableResult.age).isEqualTo(30);
      assertThat(variableResult.email).isEqualTo("default@example.com");
      assertThat(variableResult.role).isEqualTo("user");
  - name: Deeply nested defaults should be applied recursively
    code: |-
      const src = {user: {name: "John"}};
      const def = {user: {name: "Default", email: "default@example.com"}, settings: {theme: "dark"}};
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
      assertThat(variableResult.user.name).isEqualTo("John");
      assertThat(variableResult.user.email).isEqualTo("default@example.com");
      assertThat(variableResult.settings.theme).isEqualTo("dark");
  - name: '[example] Existing values preserved'
    code: |
      /* @display
      Base Object: {status: "active", count: 5}
      Defaults Object: {status: "inactive", count: 0, type: "default"}
      @output
      active
      */
      const src = {status: "active", count: 5};
      const def = {status: "inactive", count: 0, type: "default"};
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
      assertThat(variableResult.status).isEqualTo("active");
      assertThat(variableResult.count).isEqualTo(5);
      assertThat(variableResult.type).isEqualTo("default");
  - name: Multiple levels of nesting with partial defaults
    code: |-
      const src = {config: {api: {timeout: 5000}}};
      const def = {config: {api: {timeout: 3000, retries: 3}, cache: {enabled: true}}};
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
      assertThat(variableResult.config.api.timeout).isEqualTo(5000);
      assertThat(variableResult.config.api.retries).isEqualTo(3);
      assertThat(variableResult.config.cache.enabled).isEqualTo(true);
  - name: Empty source object should receive all defaults
    code: |-
      const src = {};
      const def = {name: "Default", age: 0, settings: {theme: "light"}};
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
      assertThat(variableResult.name).isEqualTo("Default");
      assertThat(variableResult.age).isEqualTo(0);
      assertThat(variableResult.settings.theme).isEqualTo("light");
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
