___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "toBase64",
  "description": "Converts a string to a Base64-encoded string , making it suitable for transmission or storage in contexts that require Base64 encoding (such as embedding binary data in text files).",
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
        "displayName": "String To Encode",
        "simpleValueType": true,
        "help": "💾   The string to encode.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Converts a \u003cem\u003estring\u003c/em\u003e to a Base64-encoded string, making it suitable for transmission or storage in contexts that require Base64 encoding.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEncode simple string\u003c/em\u003e***\u003cbr\u003eString To Encode: \u003cstrong\u003eHello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eSGVsbG8=\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEncode special characters\u003c/em\u003e***\u003cbr\u003eString To Encode: \u003cstrong\u003eHello@2024!\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eSGVsbG9AMjAyNCE=\u003c/strong\u003e"
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
 * Encodes a string into Base64 format.
 * 
 * @param {string} data.src - The string to be encoded into Base64 format.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform `src` before encoding.
 * 
 * @returns {string} The Base64-encoded string.
 *
 * @framework ggLowCodeGTMKit
 */
const toBase64 = require('toBase64');
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// toBase64 - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(toBase64(value));
// ===============================================================================
// toBase64() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(toBase64(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Encode simple string'
    code: |-
      /* @display
      String To Encode: Hello
      @output
      SGVsbG8=
      */
      const src = 'Hello';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('SGVsbG8=');
  - name: String with spaces - should encode to Base64
    code: |-
      const src = 'Hello World';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('SGVsbG8gV29ybGQ=');
  - name: '[example] Encode special characters'
    code: |
      /* @display
      String To Encode: Hello@2024!
      @output
      SGVsbG9AMjAyNCE=
      */
      const src = 'Hello@2024!';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('SGVsbG9AMjAyNCE=');
  - name: Empty string - should return Base64 representation of empty string
    code: |-
      const src = '';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('');
  - name: Numeric string - should encode to Base64
    code: |-
      const src = '12345';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('MTIzNDU=');
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
