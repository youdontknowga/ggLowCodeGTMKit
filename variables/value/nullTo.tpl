___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "nullTo",
  "description": "Replaces \u003cem\u003enull\u003c/em\u003e with a specific default value. Returns the original value if it\u0027s not \u003cem\u003enull\u003c/em\u003e, otherwise returns the default value.",
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
        "displayName": "Value To Check",
        "simpleValueType": true,
        "help": "💾   The value to check for \u003cem\u003enull\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "def",
        "displayName": "Default Value",
        "simpleValueType": true,
        "help": "💾   The default value to return if the source value is null.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e"
      }
    ],
    "help": "Replaces \u003cem\u003enull\u003c/em\u003e values with a default. Non-null values pass through unchanged.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString passes through\u003c/em\u003e***\u003cbr\u003eValue To Check: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003eDefault Value: \u003cstrong\u003edefault\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNull returns default\u003c/em\u003e***\u003cbr\u003eValue To Check: \u003cstrong\u003enull\u003c/strong\u003e\u003cbr\u003eDefault Value: \u003cstrong\u003edefault\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003edefault\u003c/strong\u003e"
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
 * Replaces null with a specific default value.
 * 
 * @param {any} data.src - The value to check.
 * @param {any} data.def - The default value to return if the value is null.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before checking.
 * 
 * @returns {any} Returns the original value if it's not null, otherwise returns the default value.
 *
 * @framework ggLowCodeGTMKit
 */
const nullTo = function(value, defaultValue) {
    return value === null ? defaultValue : value;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// nullTo - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(nullTo(value, data.def));
// ===============================================================================
// nullTo(...) – Apply Mode
// ===============================================================================
/*
return function(value, defaultValue) {
   defaultValue = data.rp1 ? data.def : defaultValue;
   return out(nullTo(value, defaultValue));
};
*/


___TESTS___

scenarios:
  - name: Undefined value - returns original value
    code: |-
      const src = undefined;
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
      assertThat(variableResult).isUndefined();
  - name: '[example] String passes through'
    code: |-
      /* @display
      Value To Check: hello
      Default Value: default
      @output
      hello
      */
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
  - name: '[example] Null returns default'
    code: |+
      /* @display
      Value To Check: null
      Default Value: default
      @output
      default
      */
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
      assertThat(variableResult).isEqualTo("default");

  - name: False value - returns original false value
    code: |-
      const src = false;
      const def = true;
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
      assertThat(variableResult).isFalse();
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
