___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "extractPort()",
  "description": "Extracts the port from a given \u003cem\u003eURL\u003c/em\u003e. Returns \u003cem\u003eundefined\u003c/em\u003e if the input is invalid or no port is present.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract port number\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://example.com:8080/path\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e8080\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo port returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://example.com/path\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: URL"
      }
    ],
    "help": "Extracts the port number from a URL.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract port number\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://example.com:8080/path\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e8080\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo port returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://example.com/path\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
 * Extracts the port from a given URL.
 *
 * @param {string} data.src - The URL to extract the port from.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before extracting.
 * 
 * @returns {string|undefined} The port from the URL, or undefined if the input is invalid.
 *
 * @framework ggLowCodeGTMKit
 */

const parseUrl = require('parseUrl');

const extractPort = function(url) {
    const parsed = parseUrl(url);
    return parsed && parsed.port || undefined;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// extractPort - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(extractPort(value));
*/
// ===============================================================================
// extractPort() – Apply Mode
// ===============================================================================
return function(value) {
   return out(extractPort(value));
};


___TESTS___

scenarios:
  - name: '[example] Extract port number'
    code: |-
      /* @display
      Value to Process: https://example.com:8080/path
      @output
      8080
      */
      const src = "https://example.com:8080/path";
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
      assertThat(variableResult).isEqualTo("8080");
  - name: URL with non-standard port - extracts custom port
    code: |
      const src = "http://localhost:3000/api/data";
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
      assertThat(variableResult).isEqualTo("3000");
  - name: '[example] No port returns undefined'
    code: |-
      /* @display
      Value to Process: https://example.com/path
      @output
      undefined
      */
      const src = "https://example.com/path";
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
  - name: Invalid URL - returns undefined
    code: |-
      const src = "not-a-valid-url";
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
  - name: Empty string input - returns undefined
    code: |-
      const src = "";
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
