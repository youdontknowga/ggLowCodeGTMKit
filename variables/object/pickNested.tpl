___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "pickNested",
  "description": "Creates a new object by selecting only the properties whose keys match the value fields from a list. If a value is an array, all its elements are included.",
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
        "help": "💾 The source object to pick nested properties from.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject variable\u003c/strong\u003e: \u003cem\u003e{{myObject}}\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject literal\u003c/strong\u003e: \u003cem\u003e{user: {name: \"John\", age: 30}}\u003c/em\u003e"
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "keys",
        "displayName": "Property Paths to Pick",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Path",
            "name": "value",
            "type": "TEXT"
          }
        ],
        "help": "💾 Array of nested property paths to pick from the source object. Use dot notation for nested properties (e.g., \u003cem\u003e\"user.profile.name\"\u003c/em\u003e).\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNested path\u003c/strong\u003e: \u003cem\u003e\"user.name\"\u003c/em\u003e, \u003cem\u003e\"settings.theme.color\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eTop-level\u003c/strong\u003e: \u003cem\u003e\"status\"\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePick nested properties\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDeep nested pick\u003c/em\u003e***",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      }
    ],
    "help": "Picks properties from a nested \u003cem\u003eobject\u003c/em\u003e using dot-notation paths.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePick nested properties\u003c/em\u003e***\u003cbr\u003eSource Object: \u003cstrong\u003e{user: {name: \"John\", age: 30}, status: \"active\"}\u003c/strong\u003e\u003cbr\u003ekeys: \u003cstrong\u003e[{value: \"user.name\"}, {value: \"status\"}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDeep nested pick\u003c/em\u003e***\u003cbr\u003eSource Object: \u003cstrong\u003e{user: {profile: {address: {city: \"Paris\", zip: \"75001\"}}, role: \"admin\"}}\u003c/strong\u003e\u003cbr\u003ekeys: \u003cstrong\u003e[{value: \"user.profile.address.city\"}, {value: \"user.role\"}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eParis\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the object before checking (e.g., normalize object structure, parse JSON)."
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
        "help": "⚙️ Optional function to apply to the result object before returning it (e.g., \u003ccode\u003eobj =\u003e JSON.stringify(obj)\u003c/code\u003e, \u003ccode\u003eobj =\u003e Object.keys(obj).length\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Creates a new object composed of selected nested properties using paths.
 *
 * @param {Object} data.src - The source object.
 * @param {Array} data.keys - Array of objects with path strings to pick (e.g., "user.profile.name").
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {Object} A new object containing only the specified nested properties.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');
const createFlatArrayFromValues = function(list, property) {
    const result = [];
    if (!list) return result;
    for (let i = 0; i < list.length; i++) {
        const val = list[i][property];
        if (getType(val) === 'array') {
            for (let j = 0; j < val.length; j++) {
                result.push(val[j]);
            }
        } else if (val) {
            result.push(val);
        }
    }
    return result;
};
const pickNested = function(object, paths) {
    const result = {};
    if (object == null || typeof object !== 'object') return result;
    
    for (let i = 0; i < paths.length; i++) {
        const path = paths[i];
        const segments = path.split('.');
        let src = object;
        let valid = true;

        for (let j = 0; j < segments.length - 1; j++) {
            const key = segments[j];
            if (src == null || typeof src !== 'object' || !src.hasOwnProperty(key)) {
                valid = false;
                break;
            }
            src = src[key];
        }

        if (valid) {
            const lastKey = segments[segments.length - 1];
            if (src != null && typeof src === 'object' && src.hasOwnProperty(lastKey)) {
                // Only now write to result
                let dst = result;
                for (let j = 0; j < segments.length - 1; j++) {
                    const key = segments[j];
                    if (dst[key] === undefined || typeof dst[key] !== 'object') {
                        dst[key] = {};
                    }
                    dst = dst[key];
                }
                dst[lastKey] = src[lastKey];
            }
        }
    }
    
    return result;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// pickNested - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
const paths = createFlatArrayFromValues(data.keys, "value");
return out(pickNested(value, paths));
// ===============================================================================
// pickNested(...) – Apply Mode
// ===============================================================================
/*
return function(object, paths) {
   paths = data.rp1 ? createFlatArrayFromValues(data.keys, "value") : paths;
   return out(pickNested(object, paths));
};
*/


___TESTS___

scenarios:
  - name: '[example] Pick nested properties'
    code: |-
      /* @display
      Source Object: {user: {name: "John", age: 30}, status: "active"}
      keys: [{value: "user.name"}, {value: "status"}]
      @output
      John
      */
      const src = {user: {name: "John", age: 30}, status: "active"};
      const keys = [{value: "user.name"}, {value: "status"}];
      const mockData = {
          src: src,
          keys: keys,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ["user.name", "status"]);
      }
      assertThat(variableResult.user.name).isEqualTo("John");
      assertThat(variableResult.status).isEqualTo("active");
  - name: '[example] Deep nested pick'
    code: |
      /* @display
      Source Object: {user: {profile: {address: {city: "Paris", zip: "75001"}}, role: "admin"}}
      keys: [{value: "user.profile.address.city"}, {value: "user.role"}]
      @output
      Paris
      */
      const src = {user: {profile: {address: {city: "Paris", zip: "75001"}}, role: "admin"}};
      const keys = [{value: "user.profile.address.city"}, {value: "user.role"}];
      const mockData = {
          src: src,
          keys: keys,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ["user.profile.address.city", "user.role"]);
      }
      assertThat(variableResult.user.profile.address.city).isEqualTo("Paris");
      assertThat(variableResult.user.role).isEqualTo("admin");
  - name: Handle non-existent paths returns empty or partial object
    code: |
      const src = {user: {name: "John"}, status: "active"};
      const keys = [{value: "user.email"}, {value: "missing.path"}];
      const mockData = {
          src: src,
          keys: keys,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ["user.email", "missing.path"]);
      }
      assertThat(variableResult.user).isUndefined();
  - name: Pick multiple properties at same nesting level
    code: |-
      const src = {settings: {theme: "dark", language: "en", notifications: true}};
      const keys = [{value: "settings.theme"}, {value: "settings.language"}];
      const mockData = {
          src: src,
          keys: keys,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ["settings.theme", "settings.language"]);
      }
      assertThat(variableResult.settings.theme).isEqualTo("dark");
      assertThat(variableResult.settings.language).isEqualTo("en");
      assertThat(variableResult.settings.notifications).isUndefined();
  - name: Invalid input returns empty object
    code: |-
      const src = null;
      const keys = [{value: "user.name"}];
      const mockData = {
          src: src,
          keys: keys,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ["user.name"]);
      }
      assertThat(variableResult.user).isUndefined();
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
