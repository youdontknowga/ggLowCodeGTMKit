___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "extractPathname()",
  "description": "Extracts the pathname from a given \u003cem\u003eURL\u003c/em\u003e. Returns \u003cem\u003eundefined\u003c/em\u003e if the input is invalid or no pathname is present.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract pathname\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://example.com/path/to/page\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e/path/to/page\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRoot path returns /\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://example.com/\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e/\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: URL"
      }
    ],
    "help": "Extracts the pathname from a URL.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract pathname\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://example.com/path/to/page\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e/path/to/page\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRoot path returns /\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://example.com/\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e/\u003c/strong\u003e"
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
 * Extracts the pathname from a given URL.
 *
 * @param {string} data.src - The URL to extract the pathname from.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before extracting.
 * 
 * @returns {string|undefined} The pathname from the URL, or undefined if the input is invalid.
 *
 * @framework ggLowCodeGTMKit
 */

const parseUrl = require('parseUrl');

const extractPathname = function(url) {
    const parsed = parseUrl(url);
    return parsed && parsed.pathname || undefined;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// extractPathname - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(extractPathname(value));
*/
// ===============================================================================
// extractPathname() – Apply Mode
// ===============================================================================
return function(value) {
   return out(extractPathname(value));
};


___TESTS___

scenarios:
  - name: '[example] Extract pathname'
    code: |-
      /* @display
      Value to Process: https://example.com/path/to/page
      @output
      /path/to/page
      */
      const src = "https://example.com/path/to/page";
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
      assertThat(variableResult).isEqualTo("/path/to/page");
  - name: '[example] Root path returns /'
    code: |-
      /* @display
      Value to Process: https://example.com/
      @output
      /
      */
      const src = "https://example.com/";
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
      assertThat(variableResult).isEqualTo("/");
  - name: URL with query parameters - extracts pathname without query
    code: |
      const src = "https://example.com/search?q=test&lang=en";
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
      assertThat(variableResult).isEqualTo("/search");
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
