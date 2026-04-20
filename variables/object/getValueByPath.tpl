___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getValueByPath",
  "description": "Access a nested property using a dot-separated path. Supports array indices (e.g., user.profile.1.value), but does not support bracket notation (e.g., user[\"profile\"][1].value).",
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
        "displayName": "Source Object",
        "simpleValueType": true,
        "help": "💾 The object to retrieve the value from.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject variable\u003c/strong\u003e: \u003cem\u003e{{myObject}}\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject literal\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "path",
        "displayName": "Path",
        "simpleValueType": true,
        "help": "💾 The path to the value using dot notation or array format.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString (dot notation)\u003c/strong\u003e: \u003cem\u003e\"user.profile.name\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e: \u003cem\u003e[\"user\", \"profile\", \"name\"]\u003c/em\u003e"
      },
      {
        "type": "TEXT",
        "name": "def",
        "displayName": "Default Value",
        "simpleValueType": true,
        "help": "💾 The default value to return if the path doesn't exist in the object. If the path exists but the value is undefined, undefined will be returned instead of this default.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny type\u003c/strong\u003e: string, number, boolean, object, array"
      }
    ],
    "help": "Returns a value from a nested \u003cem\u003eobject\u003c/em\u003e using a dot-notation path.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet nested value\u003c/em\u003e***\u003cbr\u003eSource Object: \u003cstrong\u003e{user: {profile: {name: 'John'}}}\u003c/strong\u003e\u003cbr\u003ePath: \u003cstrong\u003euser.profile.name\u003c/strong\u003e\u003cbr\u003eDefault Value: \u003cstrong\u003eUnknown\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMissing path returns default\u003c/em\u003e***\u003cbr\u003eSource Object: \u003cstrong\u003e{user: {profile: {name: 'John'}}}\u003c/strong\u003e\u003cbr\u003ePath: \u003cstrong\u003euser.settings.theme\u003c/strong\u003e\u003cbr\u003eDefault Value: \u003cstrong\u003elight\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003elight\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the source object before retrieving the value (e.g., normalize object structure, add missing properties)."
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
        "help": "⚙️ Optional function to apply to the retrieved value before returning it (e.g., \u003ccode\u003eval =\u003e val.toString()\u003c/code\u003e, \u003ccode\u003eval =\u003e val || 'empty'\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Safely retrieves a nested value from an object using a path string or array.
 * 
 * @param {Object} data.obj - The object to retrieve the value from.
 * @param {string|string[]} data.path - The path to the value (e.g., "a.b.c" or ["a", "b", "c"]).
 * @param {any} data.def - The default value to return if the path doesn't exist.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform obj before processing.
 * 
 * @returns {*} The value at the nested path, or the default value if the path doesn't exist.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const getValueByPath = function(obj, path, defaultValue) {
  if (getType(obj) !== 'object' || obj === null) {
    return defaultValue;
  }
  
  const pathParts = getType(path) === 'array' ? path.map(function (part) { return part.toString(); }) : path.split('.');
  
  // Handle empty path - return the object itself
  if (pathParts.length === 0 || (pathParts.length === 1 && pathParts[0] === '')) {
    return obj;
  }
  
  let current = obj;
  let index = 0;
  const length = pathParts.length;
  
  while (current != null && index < length) {
    current = current[pathParts[index++]];
  }
  
  return index === length ? current : defaultValue;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// getValueByPath - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedObj = applyCast(data.pre, data.obj);
return out(getValueByPath(processedObj, data.path, data.def));
// ===============================================================================
// getValueByPath(...) – Apply Mode
// ===============================================================================
/*
return function(value, path, defaultValue) {
   path = data.rp1 ? data.path : path;
   defaultValue = data.rp2 ? data.def : defaultValue;
   return out(getValueByPath(value, path, defaultValue));
};
*/


___TESTS___

scenarios:
  - name: '[example] Get nested value'
    code: |
      /* @display
      Source Object: {user: {profile: {name: 'John'}}}
      Path: user.profile.name
      Default Value: Unknown
      @output
      John
      */
      const obj = {user: {profile: {name: 'John'}}};
      const path = 'user.profile.name';
      const def = 'Unknown';
      const mockData = {
          obj: obj,
          path: path,
          def: def,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, path, def);
      }
      assertThat(variableResult).isEqualTo('John');
  - name: '[example] Missing path returns default'
    code: |
      /* @display
      Source Object: {user: {profile: {name: 'John'}}}
      Path: user.settings.theme
      Default Value: light
      @output
      light
      */
      const obj = {user: {profile: {name: 'John'}}};
      const path = 'user.settings.theme';
      const def = 'light';
      const mockData = {
          obj: obj,
          path: path,
          def: def,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, path, def);
      }
      assertThat(variableResult).isEqualTo('light');
  - name: Test with array path notation
    code: |-
      const obj = {data: {items: [10, 20, 30]}};
      const path = ['data', 'items', '1'];
      const def = 0;
      const mockData = {
          obj: obj,
          path: path,
          def: def,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, path, def);
      }
      assertThat(variableResult).isEqualTo(20);
  - name: Test path exists but value is undefined - should return undefined not default
    code: |-
      const obj = {user: {profile: {name: undefined}}};
      const path = 'user.profile.name';
      const def = 'DefaultName';
      const mockData = {
          obj: obj,
          path: path,
          def: def,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, path, def);
      }
      assertThat(variableResult).isUndefined();
  - name: Test with null object returns default value
    code: |
      const obj = null;
      const path = 'user.name';
      const def = 'Fallback';
      const mockData = {
          obj: obj,
          path: path,
          def: def,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, path, def);
      }
      assertThat(variableResult).isEqualTo('Fallback');
  - name: Test with empty path returns the object itself
    code: |-
      const obj = {id: 123, name: 'Test'};
      const path = '';
      const def = 'Default';
      const mockData = {
          obj: obj,
          path: path,
          def: def,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, path, def);
      }
      assertThat(variableResult).isEqualTo(obj);
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
