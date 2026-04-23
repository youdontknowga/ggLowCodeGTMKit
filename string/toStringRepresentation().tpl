___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "toStringRepresentation()",
  "description": "Converts the provided value to its string representation. If the value is \u003cem\u003enull\u003c/em\u003e, it returns the string \"null\". If the value is \u003cem\u003eundefined\u003c/em\u003e, it returns the string \"undefined\".",
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
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNumber to string\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNull returns \"null\"\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003enull\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003enull\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eUndefined returns \"undefined\"\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Value To Convert"
      }
    ],
    "help": "Converts the provided value to its \u003cem\u003estring\u003c/em\u003e representation. Returns the string \u003cem\u003e\"null\"\u003c/em\u003e for null and \u003cem\u003e\"undefined\"\u003c/em\u003e for undefined.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNumber to string\u003c/em\u003e***\u003cbr\u003eval: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNull returns \\\"null\\\"\u003c/em\u003e***\u003cbr\u003eval: \u003cstrong\u003enull\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003enull\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eUndefined returns \\\"undefined\\\"\u003c/em\u003e***\u003cbr\u003eval: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toUpperCase(), str =\u003e str.trim() for whitespace removal). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Converts a value to a string.
 *
 * @param {any} data.val - The value to convert to a string.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform val before conversion.
 * 
 * @returns {string} The string representation of the value, or "null" or "undefined" if the value is null or undefined.
 *
 * @framework ggLowCodeGTMKit
 */

const toStringRepresentation = function(value) {
    if (value === null) { return 'null'; }
    if (value === undefined) { return 'undefined'; }
    return value.toString();
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// toStringRepresentation - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedValue = applyCast(data.pre, data.val);
return out(toStringRepresentation(processedValue));
*/
// ===============================================================================
// toStringRepresentation() – Apply Mode
// ===============================================================================
return function(value) {
   return out(toStringRepresentation(value));
};


___TESTS___

scenarios:
  - name: '[example] Number to string'
    code: |-
      /* @display
      val: 42
      @output
      42
      */
      const val = 42;
      const mockData = {
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(val);
      }
      assertThat(variableResult).isEqualTo("42");
  - name: Boolean true to string - returns true string
    code: |
      const val = true;
      const mockData = {
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(val);
      }
      assertThat(variableResult).isEqualTo("true");
  - name: Boolean false to string - returns false string
    code: |-
      const val = false;
      const mockData = {
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(val);
      }
      assertThat(variableResult).isEqualTo("false");
  - name: Array to string - converts array to comma-separated string
    code: |-
      const val = [1, 2, 3];
      const mockData = {
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(val);
      }
      assertThat(variableResult).isEqualTo("1,2,3");
  - name: Object to string - converts object to string representation
    code: |-
      const val = {key: "value"};
      const mockData = {
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(val);
      }
      assertThat(variableResult).isEqualTo("[object Object]");
  - name: '[example] Null returns \"null\"'
    code: |-
      /* @display
      val: null
      @output
      null
      */
      const val = null;
      const mockData = {
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(val);
      }
      assertThat(variableResult).isEqualTo("null");
  - name: '[example] Undefined returns \"undefined\"'
    code: |-
      /* @display
      val: undefined
      @output
      undefined
      */
      const val = undefined;
      const mockData = {
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(val);
      }
      assertThat(variableResult).isEqualTo("undefined");
  - name: Empty string - returns empty string
    code: |-
      const val = "";
      const mockData = {
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(val);
      }
      assertThat(variableResult).isEqualTo("");
  - name: Zero number - converts to 0 string
    code: |-
      const val = 0;
      const mockData = {
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(val);
      }
      assertThat(variableResult).isEqualTo("0");
  - name: Negative number - converts to string with minus sign
    code: |-
      const val = -123;
      const mockData = {
          val: val,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(val);
      }
      assertThat(variableResult).isEqualTo("-123");
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'apply';
  // ==========================================================a=========================================
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
