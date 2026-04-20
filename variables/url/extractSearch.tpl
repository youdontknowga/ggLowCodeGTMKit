___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "extractSearch",
  "description": "Extracts the search from a given \u003cem\u003eURL\u003c/em\u003e. Returns \u003cem\u003eundefined\u003c/em\u003e if the input is invalid or no search is present.",
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
        "displayName": "URL",
        "simpleValueType": true,
        "help": "💾   The URL to extract the search from.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Extracts the query string from a URL.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract query string\u003c/em\u003e***\u003cbr\u003eURL: \u003cstrong\u003ehttps://example.com/page?name=John\u0026age=30\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e?name=John\u0026age=30\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo query returns undefined\u003c/em\u003e***\u003cbr\u003eURL: \u003cstrong\u003ehttps://example.com/page\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
 * Extracts the search from a given URL.
 *
 * @param {string} data.src - The URL to extract the search from.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before extracting.
 * 
 * @returns {string|undefined} The search from the URL, or undefined if the input is invalid.
 *
 * @framework ggLowCodeGTMKit
 */

const parseUrl = require('parseUrl');

const extractSearch = function(url) {
    const parsed = parseUrl(url);
    return parsed && parsed.search || undefined;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// extractSearch - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(extractSearch(value));

// ===============================================================================
// extractSearch() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(extractSearch(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Extract query string'
    code: |-
      /* @display
      URL: https://example.com/page?name=John&age=30
      @output
      ?name=John&age=30
      */
      const src = 'https://example.com/page?name=John&age=30';
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
      assertThat(variableResult).isEqualTo('?name=John&age=30');
  - name: '[example] No query returns undefined'
    code: |-
      /* @display
      URL: https://example.com/page
      @output
      undefined
      */
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
      assertThat(variableResult).isUndefined();
  - name: Test URL with empty search parameter returns undefined
    code: |
      const src = 'https://example.com/page?';
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
  - name: Test URL with fragment and search
    code: |-
      const src = 'https://example.com/page?query=test#section';
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
      assertThat(variableResult).isEqualTo('?query=test');
  - name: Test with invalid URL returns undefined
    code: |-
      const src = 'not-a-valid-url';
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
