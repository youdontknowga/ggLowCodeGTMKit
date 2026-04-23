___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "hasNested(...)",
  "description": "Check if a nested property exists in an object using a dot-separated string or an array of keys.",
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
        "name": "pth",
        "displayName": "Property Path",
        "simpleValueType": true,
        "help": "💾 The path to the nested property. Can use dot notation or array format.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString (dot notation)\u003c/strong\u003e: \u003cem\u003e\"user.profile.name\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e: \u003cem\u003e[\"user\", \"profile\", \"name\"]\u003c/em\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNested property exists\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ea.b.c\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNested property missing\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ea.b.c\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Object to Check: chained callback parameter"
      },
      {
        "type": "GROUP",
        "name": "Advanced Settings",
        "displayName": "Advanced Settings",
        "groupStyle": "ZIPPY_OPEN_ON_PARAM",
        "subParams": [
          {
            "type": "CHECKBOX",
            "name": "rp1",
            "checkboxText": "⚡Use runtime parameter for: Property Path",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Checks if a nested property exists in an \u003cem\u003eobject\u003c/em\u003e using a path.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNested property exists\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{a: {b: {c: 'value'}}}\u003c/strong\u003e\u003cbr\u003eProperty Path: \u003cstrong\u003ea.b.c\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNested property missing\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{a: {b: {}}}\u003c/strong\u003e\u003cbr\u003eProperty Path: \u003cstrong\u003ea.b.c\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the boolean result before returning it (e.g., \u003ccode\u003eval =\u003e !val\u003c/code\u003e to invert, \u003ccode\u003eval =\u003e val ? 'exists' : 'missing'\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Checks if a nested property exists in an object using a path string or array.
 *
 * @param {Object} data.src - The object to check.
 * @param {string|string[]} data.pth - The path to the property (e.g., "a.b.c" or ["a", "b", "c"]).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before checking.
 * 
 * @returns {boolean} Returns true if the nested property exists, false otherwise.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const hasNested = function(obj, path) {
    if (getType(obj) !== 'object' || obj === null) {
        return false;
    }
    
    const pathParts = getType(path) === 'array' 
        ? path.map(function (part) { return part.toString(); }) 
        : path.split('.');
    
    let current = obj;
    let index = 0;
    const length = pathParts.length;
    
    while (current != null && index < length) {
        if (!current.hasOwnProperty(pathParts[index])) {
            return false;
        }
        current = current[pathParts[index++]];
    }
    
    return index === length;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// hasNested - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(hasNested(value, data.pth));
*/
// ===============================================================================
// hasNested(...) – Apply Mode
// ===============================================================================
return function(obj, path) {
   path = data.rp1 ? data.pth : path;
   return out(hasNested(obj, path));
};


___TESTS___

scenarios:
  - name: '[example] Nested property exists'
    code: |-
      /* @display
      Value to Process: {a: {b: {c: 'value'}}}
      Property Path: a.b.c
      @output
      true
      */
      const src = {a: {b: {c: 'value'}}};
      const pth = 'a.b.c';
      const mockData = {
          src: src,
          pth: pth,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] Nested property missing'
    code: |-
      /* @display
      Value to Process: {a: {b: {}}}
      Property Path: a.b.c
      @output
      false
      */
      const src = {a: {b: {}}};
      const pth = 'a.b.c';
      const mockData = {
          src: src,
          pth: pth,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth);
      }
      assertThat(variableResult).isFalse();
  - name: Test with array path format
    code: |-
      const src = {user: {profile: {name: 'John'}}};
      const pth = ['user', 'profile', 'name'];
      const mockData = {
          src: src,
          pth: pth,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth);
      }
      assertThat(variableResult).isTrue();
  - name: Test property exists with undefined value
    code: |-
      const src = {a: {b: {c: undefined}}};
      const pth = 'a.b.c';
      const mockData = {
          src: src,
          pth: pth,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth);
      }
      assertThat(variableResult).isTrue();
  - name: Test with non-object input returns false
    code: |-
      const src = 'not an object';
      const pth = 'a.b.c';
      const mockData = {
          src: src,
          pth: pth,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth);
      }
      assertThat(variableResult).isFalse();
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
