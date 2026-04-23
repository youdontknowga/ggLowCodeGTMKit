___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "falsyTo",
  "description": "Replaces falsy values (\u003cem\u003efalse\u003c/em\u003e, \u003cem\u003e0\u003c/em\u003e, \u003cem\u003e\"\"\u003c/em\u003e, \u003cem\u003enull\u003c/em\u003e, \u003cem\u003eundefined\u003c/em\u003e, \u003cem\u003eNaN\u003c/em\u003e) with a default value. Returns the original if truthy, otherwise returns the default.",
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
        "help": "💾   The value to check for falsy values.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "def",
        "displayName": "Default Value",
        "simpleValueType": true,
        "help": "💾   The default value to return if the source value is falsy.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e"
      }
    ],
    "help": "Replaces falsy values (false, 0, \"\", null, undefined, NaN) with a default value. Returns the original if truthy, otherwise returns the default.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTruthy value returns original\u003c/em\u003e***\u003cbr\u003eValue To Check: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003eDefault Value: \u003cstrong\u003edefault\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty string returns default\u003c/em\u003e***\u003cbr\u003eValue To Check: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003eDefault Value: \u003cstrong\u003edefault\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003edefault\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNull returns default\u003c/em\u003e***\u003cbr\u003eValue To Check: \u003cstrong\u003enull\u003c/strong\u003e\u003cbr\u003eDefault Value: \u003cstrong\u003efallback\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efallback\u003c/strong\u003e"
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
 * Replaces falsy values with a specific default value.
 * 
 * @param {any} data.src - The value to check.
 * @param {any} data.def - The default value to return if the value is falsy.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before checking.
 * 
 * @returns {any} Returns the original value if it's truthy, otherwise returns the default value.
 *
 * @framework ggLowCodeGTMKit
 */
const falsyTo = function(value, defaultValue) {
   return value || defaultValue;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// falsyTo - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(falsyTo(value, data.def));
// ===============================================================================
// falsyTo(...) – Apply Mode
// ===============================================================================
/*
return function(value, defaultValue) {
  defaultValue = data.rp1 ? data.def : defaultValue;
  return out(falsyTo(value, defaultValue));
};
*/


___TESTS___

scenarios:
  - name: '[example] Truthy value returns original'
    code: |-
      /* @display
      Value To Check: hello
      Default Value: default
      @output
      hello
      */
      const src = 'hello';
      const def = 'default';
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
      assertThat(variableResult).isEqualTo('hello');
  - name: '[example] Empty string returns default'
    code: |-
      /* @display
      Value To Check: 
      Default Value: default
      @output
      default
      */
      const src = '';
      const def = 'default';
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
      assertThat(variableResult).isEqualTo('default');
  - name: '[example] Null returns default'
    code: |-
      /* @display
      Value To Check: null
      Default Value: fallback
      @output
      fallback
      */
      const src = null;
      const def = 'fallback';
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
      assertThat(variableResult).isEqualTo('fallback');
  - name: Falsy value (undefined) - should return default
    code: |
      const src = undefined;
      const def = 'fallback';
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
      assertThat(variableResult).isEqualTo('fallback');
  - name: Falsy value (0) - should return default
    code: |
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
      assertThat(variableResult).isEqualTo(100);
  - name: Falsy value (false) - should return default
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
      assertThat(variableResult).isEqualTo(true);
  - name: Truthy number - should return original
    code: |-
      const src = 42;
      const def = 0;
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
      assertThat(variableResult).isEqualTo(42);
  - name: Truthy object - should return original
    code: |-
      const src = {key: 'value'};
      const def = {};
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
      assertThat(variableResult).isEqualTo({key: 'value'});
  - name: Empty array (truthy) - should return original
    code: |-
      const src = [];
      const def = ['default'];
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
      assertThat(variableResult).isEqualTo([]);
  - name: String with spaces (truthy) - should return original
    code: |-
      const src = '   ';
      const def = 'trimmed';
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
      assertThat(variableResult).isEqualTo('   ');
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
