___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "extractHostname()",
  "description": "Extracts the hostname from a given \u003cem\u003eURL\u003c/em\u003e. Returns \u003cem\u003eundefined\u003c/em\u003e if the input is invalid or no hostname is present.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eHostname without port\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://example.com:8080/page\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eexample.com\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFull hostname with subdomain\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://www.subdomain.example.com/page\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ewww.subdomain.example.com\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: URL"
      }
    ],
    "help": "Extracts the hostname from a URL (without port).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eHostname without port\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://example.com:8080/page\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eexample.com\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFull hostname with subdomain\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://www.subdomain.example.com/page\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ewww.subdomain.example.com\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., hostname =\u003e hostname.toLowerCase() for normalization, hostname =\u003e hostname.split('.').slice(-2).join('.') to extract domain). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Extracts the hostname from a given URL.
 *
 * @param {string} data.src - The URL to extract the hostname from.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before extracting.
 * 
 * @returns {string|undefined} The hostname from the URL, or undefined if the input is invalid.
 *
 * @framework ggLowCodeGTMKit
 */

const parseUrl = require('parseUrl');

const extractHostname = function(url) {
    const parsed = parseUrl(url);
    return parsed && parsed.hostname || undefined;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// extractHostname - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(extractHostname(value));
*/
// ===============================================================================
// extractHostname() – Apply Mode
// ===============================================================================
return function(value) {
   return out(extractHostname(value));
};


___TESTS___

scenarios:
  - name: '[example] Hostname without port'
    code: |-
      /* @display
      Value to Process: https://example.com:8080/page
      @output
      example.com
      */
      const src = 'https://example.com:8080/page';
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
      assertThat(variableResult).isEqualTo('example.com');
  - name: URL without port - should extract hostname
    code: |-
      const src = 'https://example.com/page';
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
      assertThat(variableResult).isEqualTo('example.com');
  - name: '[example] Full hostname with subdomain'
    code: |-
      /* @display
      Value to Process: https://www.subdomain.example.com/page
      @output
      www.subdomain.example.com
      */
      const src = 'https://www.subdomain.example.com/page';
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
      assertThat(variableResult).isEqualTo('www.subdomain.example.com');
  - name: URL with query, hash and port - should extract hostname only
    code: |-
      const src = 'https://example.com:3000/path?query=test#section';
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
      assertThat(variableResult).isEqualTo('example.com');
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
