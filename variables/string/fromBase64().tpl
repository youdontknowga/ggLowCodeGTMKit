___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "fromBase64()",
  "description": "Decodes a Base64-encoded \u003cem\u003estring\u003c/em\u003e into its original representation, reversing the Base64 encoding process.",
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
        "help": "Decodes a Base64-encoded \u003cem\u003estring\u003c/em\u003e into its original representation, reversing the Base64 encoding process.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDecode simple Base64 string\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eSGVsbG8gV29ybGQ=\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBase64 with special characters\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eVGVzdCAxMjMhQCM=\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eTest 123!@#\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Base64 String"
      }
    ],
    "help": "Decodes a Base64-encoded \u003cem\u003estring\u003c/em\u003e into its original representation, reversing the Base64 encoding process.\n\u003cbr\u003e_____________________________________________\u003cbr\u003e✏️ \u003cem\u003eExample\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\nBase64 string: \u003cstrong\u003eSGVsbG8gV29ybGQ=\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e\n↪️ Output: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDecode simple Base64 string\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eSGVsbG8gV29ybGQ=\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBase64 with special characters\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eVGVzdCAxMjMhQCM=\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eTest 123!@#\u003c/strong\u003e"
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
 * Decodes a Base64-encoded string into its original representation.
 * 
 * @param {string} data.src - A Base64-encoded string to decode.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before decoding.
 * 
 * @returns {string} The decoded string or data from the provided Base64-encoded input.
 *
 * @framework ggLowCodeGTMKit
 */
const fromBase64 = require('fromBase64');

const decodeBase64 = function(base64EncodedString) {
      if (typeof base64EncodedString !== 'string' ) {
        return undefined;
    }
    return fromBase64(base64EncodedString);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// decodeBase64 - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(decodeBase64(value));
*/
// ===============================================================================
// decodeBase64() – Apply Mode
// ===============================================================================
return function(value) {
   return out(decodeBase64(value));
};


___TESTS___

scenarios:
  - name: '[example] Decode simple Base64 string'
    code: |-
      /* @display
      Value to Process: SGVsbG8gV29ybGQ=
      @output
      Hello World
      */
      const src = "SGVsbG8gV29ybGQ=";
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
      assertThat(variableResult).isEqualTo("Hello World");
  - name: '[example] Base64 with special characters'
    code: |-
      /* @display
      Value to Process: VGVzdCAxMjMhQCM=
      @output
      Test 123!@#
      */
      const src = "VGVzdCAxMjMhQCM=";
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
      assertThat(variableResult).isEqualTo("Test 123!@#");
  - name: Base64 with padding - handles padding correctly
    code: |-
      const src = "VGVzdA==";
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
      assertThat(variableResult).isEqualTo("Test");
  - name: Base64 encoded number - decodes to string representation
    code: |-
      const src = "MTIzNDU=";
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
      assertThat(variableResult).isEqualTo("12345");
  - name: Base64 with URL-safe characters - decodes properly
    code: |-
      const src = "R29vZ2xlIFRhZyBNYW5hZ2Vy";
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
      assertThat(variableResult).isEqualTo("Google Tag Manager");
  - name: Invalid Base64 string - returns undefined
    code: |-
      const src = "Not@Valid#Base64!";
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
      assertThat(variableResult).isUndefined();
  - name: Invalid input- returns undefined
    code: |-
      const src = function() { return;};
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
      assertThat(variableResult).isUndefined();
  - name: empty string - returns empty string
    code: |-
      const src = '';
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
      assertThat(variableResult).isEqualTo('');
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
