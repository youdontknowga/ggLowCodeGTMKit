___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "parseValue",
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
        "type": "TEXT",
        "name": "src",
        "displayName": "String To Parse",
        "simpleValueType": true,
        "help": "Parses a \u003cem\u003estring\u003c/em\u003e value into its native type (boolean, number, etc.).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse string to boolean\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eString To Parse: true\u003cbr\u003ejsn: false\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse string to number\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eString To Parse: 42\u003cbr\u003ejsn: false\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e"
      }
    ],
    "help": "Converts a \u003cem\u003estring\u003c/em\u003e representation back to its original data type (\u003cem\u003eboolean, number, null\u003c/em\u003e , etc.). Supports primitive types and optional \u003cem\u003eJSON\u003c/em\u003e parsing.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse string to boolean\u003c/em\u003e***\u003cbr\u003eString To Parse: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003eEnable JSON Parsing: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse string to number\u003c/em\u003e***\u003cbr\u003eString To Parse: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003eEnable JSON Parsing: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e"
  },
  {
    "type": "GROUP",
    "name": "opt",
    "displayName": "Advanced Setting",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "jsn",
        "checkboxText": "Enable JSON Parsing",
        "simpleValueType": true,
        "help": "☑️   If enabled, attempts to parse JSON-like strings for complex data types (objects, arrays)."
      }
    ]
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
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(parseValue(value, data.jsn));
// ===============================================================================
// parseValue(...) – Apply Mode
// ===============================================================================
/*
return function(value, enableJSONParsing) {
   enableJSONParsing = data.rp1 ? data.jsn : enableJSONParsing;
   return out(parseValue(value, enableJSONParsing));
};
*/


___TESTS___

scenarios:
  - name: '[example] Parse string to boolean'
    code: |-
      /* @display
      String To Parse: true
      Enable JSON Parsing: false
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
      String To Parse: 42
      Enable JSON Parsing: false
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
