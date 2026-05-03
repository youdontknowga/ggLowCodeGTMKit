___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "extractPasword()",
  "description": "Extracts the password from a given \u003cem\u003eURL\u003c/em\u003e. Returns \u003cem\u003eundefined\u003c/em\u003e if the input is invalid or no password is present.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract password\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://user:pass123@example.com/path\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003epass123\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo password returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://example.com/path\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: URL"
      }
    ],
    "help": "Extracts the password from a URL with authentication credentials.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract password\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://user:pass123@example.com/path\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003epass123\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo password returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://example.com/path\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
 * Extracts the password from a given URL.
 *
 * @param {string} data.src - The URL to extract the password from.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before extracting.
 * 
 * @returns {string|undefined} The password from the URL, or undefined if the input is invalid.
 *
 * @framework ggLowCodeGTMKit
 */

const parseUrl = require('parseUrl');

const extractPassword = function(url) {
    const parsed = parseUrl(url);
    return parsed && parsed.password || undefined;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// extractPassword - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(extractPassword(value));
*/
// ===============================================================================
// extractPassword() – Apply Mode
// ===============================================================================
return function(value) {
   return out(extractPassword(value));
};


___TESTS___

scenarios:
  - name: '[example] Extract password'
    code: |-
      /* @display
      Value to Process: https://user:pass123@example.com/path
      @output
      pass123
      */
      const src = 'https://user:pass123@example.com/path';
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
      assertThat(variableResult).isEqualTo('pass123');
  - name: URL with complex password - should extract URL-encoded password
    code: |-
      const src = 'ftp://admin:P@ssw0rd!@ftp.example.com/files';
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
      assertThat(variableResult).isEqualTo('P%40ssw0rd!');
  - name: '[example] No password returns undefined'
    code: |-
      /* @display
      Value to Process: https://example.com/path
      @output
      undefined
      */
      const src = 'https://example.com/path';
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
      assertThat(variableResult).isUndefined();
  - name: URL with username only (no password) - should return undefined
    code: |
      const src = 'https://user@example.com/path';
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
      assertThat(variableResult).isUndefined();
  - name: Invalid URL - should return undefined
    code: |-
      const src = 'not a valid url';
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
      assertThat(variableResult).isUndefined();
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
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
