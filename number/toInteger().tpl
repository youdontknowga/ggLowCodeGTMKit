___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "toInteger()",
  "description": "Converts the input into an integer \u003cem\u003enumber\u003c/em\u003e, or returns \u003cem\u003eNaN\u003c/em\u003e if the input cannot be converted.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString to integer\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e123\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e123\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDecimal rounded to integer\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e45.89\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e46\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid returns NaN\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: not a number\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Value To Convert"
      }
    ],
    "help": "Converts the input into an \u003cem\u003einteger\u003c/em\u003e. Returns \u003cem\u003eNaN\u003c/em\u003e if invalid.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString to integer\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e123\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e123\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDecimal rounded to integer\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e45.89\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e46\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid returns NaN\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003enot a number\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\u003c/strong\u003e"
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
* Converts the input into an integer.
* 
* @param {any} data.src - The value to be converted into an integer.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {number} The converted integer value, or NaN if the input cannot be converted.
*
* @framework ggLowCodeGTMKit
*/
const makeInteger = require('makeInteger');

const toInteger = function(input) {
  if (input === "0") return 0; 
   return makeInteger(input) || 0/0;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// toInteger - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(toInteger(value));
*/
// ===============================================================================
// toInteger() – Apply Mode
// ===============================================================================
return function(value) {
  return out(toInteger(value));
};


___TESTS___

scenarios:
  - name: Valid integer - returns the integer
    code: |-
      const src = 42;
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(42);
  - name: '[example] String to integer'
    code: |-
      /* @display
      Value to Process: 123
      @output
      123
      */
      const src = "123";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(123);
  - name: '[example] Decimal rounded to integer'
    code: |
      /* @display
      Value to Process: 45.89
      @output
      46
      */
      const src = 45.89;
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(46);
  - name: Negative number - converts to negative integer
    code: |-
      const src = -78;
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(-78);
  - name: '[example] Invalid returns NaN'
    code: |-
      /* @display
      Value to Process: not a number
      */
      const src = "not a number";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isNaN();
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
