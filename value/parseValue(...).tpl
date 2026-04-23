___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "parseValue(...)",
  "description": "Converts a \u003cem\u003estring\u003c/em\u003e representation back to its original data type (\u003cem\u003eboolean, number, null\u003c/em\u003e , etc.). Supports primitive types and optional \u003cem\u003eJSON\u003c/em\u003e parsing.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse string to boolean\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: true\u003cbr\u003ejsn: false\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse string to number\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 42\u003cbr\u003ejsn: false\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String To Parse"
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
            "checkboxText": "⚡Use runtime parameter for: JSON Parsing",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Parses a \u003cem\u003estring\u003c/em\u003e value into its native type (boolean, number, etc.).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse string to boolean\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003ejsn: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse string to number\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003ejsn: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., val =\u003e typeof val, val =\u003e JSON.stringify(val) for string conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Converts a string representation back to its original data type.
 * 
 * @param {string} data.src - The string to be converted back to its original value.
 * @param {boolean} data.jsn - If true, attempts to parse JSON-like strings.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
 * 
 * @returns {any} The original value corresponding to the string representation.
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');

const parseValue = function(value, enableJSONParsing) {
    if (typeof value !== 'string') { return value; }
    if (value === 'true') return true;
    if (value === 'false') return false;
    if (value === 'null') return null;
    if (value === 'undefined') return undefined;
    if (value === 'NaN') return 0/0;
    if (value === 'Infinity') return 1/0;
    if (value === '-Infinity') return -1/0;
    
    const number = makeNumber(value);
    if (typeof number === 'number' && number === number) return number;
    
    if (enableJSONParsing) {
        const JSON = require('JSON');
        if (JSON.parse(value) !== undefined) return JSON.parse(value);
    }
    
    return value;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// parseValue - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(parseValue(value, data.jsn));
*/
// ===============================================================================
// parseValue(...) – Apply Mode
// ===============================================================================
return function(value, enableJSONParsing) {
   enableJSONParsing = data.rp1 ? data.jsn : enableJSONParsing;
   return out(parseValue(value, enableJSONParsing));
};


___TESTS___

scenarios:
  - name: '[example] Parse string to boolean'
    code: |-
      /* @display
      Value to Process: true
      jsn: false
      @output
      true
      */
      const src = 'true';
      const jsn = false;
      const mockData = {
          src: src,
          jsn: jsn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, jsn);
      }
      assertThat(variableResult).isTrue();
  - name: String 'false' - should convert to boolean false
    code: |-
      const src = 'false';
      const jsn = false;
      const mockData = {
          src: src,
          jsn: jsn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, jsn);
      }
      assertThat(variableResult).isFalse();
  - name: '[example] Parse string to number'
    code: |-
      /* @display
      Value to Process: 42
      jsn: false
      @output
      42
      */
      const src = '42';
      const jsn = false;
      const mockData = {
          src: src,
          jsn: jsn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, jsn);
      }
      assertThat(variableResult).isEqualTo(42);
  - name: Non-parseable string - should return unchanged
    code: |-
      const src = 'hello world';
      const jsn = false;
      const mockData = {
          src: src,
          jsn: jsn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, jsn);
      }
      assertThat(variableResult).isEqualTo('hello world');
  - name: String 'null' - should convert to null
    code: |-
      const src = 'null';
      const jsn = false;
      const mockData = {
          src: src,
          jsn: jsn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, jsn);
      }
      assertThat(variableResult).isNull();
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
