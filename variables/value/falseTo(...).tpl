___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "falseTo(...)",
  "description": "Replaces \u003cem\u003efalse\u003c/em\u003e with a specific default value, useful for handling boolean conditions and providing fallback values when a condition evaluates to \u003cem\u003efalse\u003c/em\u003e.",
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
        "name": "def",
        "displayName": "Default Value",
        "simpleValueType": true,
        "help": "💾   The value to return if the input is \u003cem\u003efalse\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny type\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFalse returns default\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: false\u003cbr\u003eDefault Value: default\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003edefault\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTrue passes through\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: true\u003cbr\u003eDefault Value: default\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Value To Check"
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
            "checkboxText": "⚡Use runtime parameter for: Default Value",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Replaces \u003cem\u003efalse\u003c/em\u003e values with a default. Non-false values pass through unchanged.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFalse returns default\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eDefault Value: \u003cstrong\u003edefault\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003edefault\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTrue passes through\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003eDefault Value: \u003cstrong\u003edefault\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
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
 * Replaces false with a specific default value.
 * 
 * @param {any} data.src - The value to check.
 * @param {any} data.def - The default value to return if the value is false.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before checking.
 * 
 * @returns {any} Returns the original value if it's not false, otherwise returns the default value.
 *
 * @framework ggLowCodeGTMKit
 */
const falseTo = function(value, defaultValue) {
    return value === false ? defaultValue : value;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// falseTo - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(falseTo(value, data.def));
*/
// ===============================================================================
// falseTo(...) – Apply Mode
// ===============================================================================
return function(value, defaultValue) {
   defaultValue = data.rp1 ? data.def : defaultValue;
   return out(falseTo(value, defaultValue));
};


___TESTS___

scenarios:
  - name: '[example] False returns default'
    code: |-
      /* @display
      Value to Process: false
      Default Value: default
      @output
      default
      */
      const src = false;
      const def = "default";
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
      assertThat(variableResult).isEqualTo("default");
  - name: '[example] True passes through'
    code: |-
      /* @display
      Value to Process: true
      Default Value: default
      @output
      true
      */
      const src = true;
      const def = "default";
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
      assertThat(variableResult).isTrue();
  - name: String value - returns original value
    code: |
      const src = "hello";
      const def = "default";
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
      assertThat(variableResult).isEqualTo("hello");
  - name: Zero value - returns original zero value
    code: |-
      const src = 0;
      const def = 100;
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
      assertThat(variableResult).isEqualTo(0);
  - name: Null value - returns original null value
    code: |-
      const src = null;
      const def = "default";
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
      assertThat(variableResult).isNull();
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
