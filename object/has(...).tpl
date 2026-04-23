___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "has(...)",
  "description": "Returns true if the provided object contains a direct property matching the specified key (top-level string keys only).",
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
        "name": "key",
        "displayName": "Property Key",
        "simpleValueType": true,
        "help": "💾 The name of the property to check for. Checks own properties only (not inherited from prototype).\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e: \u003cem\u003e\"name\"\u003c/em\u003e, \u003cem\u003e\"userId\"\u003c/em\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eKey exists returns true\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ename\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eKey missing returns false\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eemail\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Object to Check"
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
            "checkboxText": "⚡Use runtime parameter for: Property Key",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Checks if an \u003cem\u003eobject\u003c/em\u003e has a specific key.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eKey exists returns true\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{name: \"John\", age: 30}\u003c/strong\u003e\u003cbr\u003eProperty Key: \u003cstrong\u003ename\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eKey missing returns false\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{name: \"John\", age: 30}\u003c/strong\u003e\u003cbr\u003eProperty Key: \u003cstrong\u003eemail\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
 * Checks if an object contains a top-level own property with the given key.
 *
 * @param {Object} data.src - The object to check.
 * @param {string} data.key - The name of the property to check for.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before checking.
 * 
 * @returns {boolean} Returns true if the object has the specified key (regardless of value).
 *
 * @framework ggLowCodeGTMKit
 */
const has = function(obj, key) {
    if (obj == null || typeof obj !== 'object' || typeof key !== 'string') {
        return false;
    }
    return obj.hasOwnProperty(key);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// has - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(has(value, data.key));
*/
// ===============================================================================
// has(...) – Apply Mode
// ===============================================================================
return function(obj, key) {
   key = data.rp1 ? data.key : key;
   return out(has(obj, key));
};


___TESTS___

scenarios:
  - name: '[example] Key exists returns true'
    code: |-
      /* @display
      Value to Process: {name: "John", age: 30}
      Property Key: name
      @output
      true
      */
      const src = {name: "John", age: 30};
      const key = "name";
      const mockData = {
          src: src,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] Key missing returns false'
    code: |-
      /* @display
      Value to Process: {name: "John", age: 30}
      Property Key: email
      @output
      false
      */
      const src = {name: "John", age: 30};
      const key = "email";
      const mockData = {
          src: src,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isFalse();
  - name: Null object returns false
    code: |-
      const src = null;
      const key = "name";
      const mockData = {
          src: src,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isFalse();
  - name: Non-string key returns false
    code: |-
      const src = {name: "John", age: 30};
      const key = 123;
      const mockData = {
          src: src,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isFalse();
  - name: Object has key with undefined value
    code: |-
      const src = {name: "John", age: undefined};
      const key = "age";
      const mockData = {
          src: src,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isTrue();
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
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
