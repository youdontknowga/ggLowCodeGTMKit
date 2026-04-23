___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "extractHashParams",
  "description": "Parses the fragment(hash) params of a \u003cem\u003eURL\u003c/em\u003e and returns an \u003cem\u003eobject\u003c/em\u003eof key-value pairs with decoded parameters.",
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
        "help": "💾   The URL to parse fragment parameters from."
      }
    ],
    "help": "Extracts key-value parameters from a URL hash fragment.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract hash parameters\u003c/em\u003e***\u003cbr\u003eURL: \u003cstrong\u003ehttps://example.com/page#param1=value1\u0026param2=value2\u0026param3=test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{param1: \"value1\", param2: \"value2\", param3: \"test\"}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo hash returns empty object\u003c/em\u003e***\u003cbr\u003eURL: \u003cstrong\u003ehttps://example.com/page?query=value\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{}\u003c/strong\u003e"
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
 * Parses the fragment(hash) params of a URL and returns an object of key-value pairs.
 *
 * @param {string} data.src - The URL to parse fragment parameters from.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before parsing.
 * 
 * @returns {Object<string, string>} An object with decoded key-value pairs from the fragment.
 *
 * @framework ggLowCodeGTMKit
 */

const parseUrl = require('parseUrl');
const decodeUriComponent = require('decodeUriComponent');

const extractHashParams = function(url) {
    if (typeof url !== 'string') return {};
    const parsed = parseUrl(url);
    if (parsed === undefined) return undefined;
    if (!parsed || !parsed.hash) return {};
    const raw = parsed.hash.charAt(0) === '#' ? parsed.hash.slice(1) : parsed.hash;
    if (!raw) return {};
    const pairs = raw.split('&');
    const result = {};
    for (let i = 0; i < pairs.length; i++) {
        const pair = pairs[i];
        if (!pair) continue;
        const eqIndex = pair.indexOf('=');
        const key = eqIndex >= 0 ? pair.slice(0, eqIndex) : pair;
        const value = eqIndex >= 0 ? pair.slice(eqIndex + 1) : '';
        if (key) {
            result[decodeUriComponent(key)] = decodeUriComponent(value);
        }
    }
    return result;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// extractHashParams - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(extractHashParams(value));

// ===============================================================================
// extractHashParams() – Apply Mode: runtime parameter
// ===============================================================================
/*
return function(value) {
   return out(extractHashParams(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Extract hash parameters'
    code: |+
      /* @display
      URL: https://example.com/page#param1=value1&param2=value2&param3=test
      @output
      {param1: "value1", param2: "value2", param3: "test"}
      */
      const src = "https://example.com/page#param1=value1&param2=value2&param3=test";
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
      assertThat(variableResult).isEqualTo({param1: "value1", param2: "value2", param3: "test"});

  - name: URL with encoded hash parameters - decodes properly
    code: |
      const src = "https://example.com#name=John%20Doe&email=test%40example.com";
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
      assertThat(variableResult).isEqualTo({name: "John Doe", email: "test@example.com"});
  - name: '[example] No hash returns empty object'
    code: |-
      /* @display
      URL: https://example.com/page?query=value
      @output
      {}
      */
      const src = "https://example.com/page?query=value";
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
      assertThat(variableResult).isEqualTo({});
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
  - name: URL with empty hash - returns empty object
    code: |-
      const src = "https://example.com/page#";
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
      assertThat(variableResult).isEqualTo({});
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
