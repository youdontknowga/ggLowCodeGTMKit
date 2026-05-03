___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "encodeUri",
  "description": "Encodes an entire URI (Uniform Resource Identifier), converting special characters into percent-encoded equivalents while preserving common URI delimiters in the input \u003cem\u003estring\u003c/em\u003e.",
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
        "displayName": "URI To Encode",
        "simpleValueType": true,
        "help": "💾   The URI to encode with percent-encoding for special characters.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Encodes a URI, preserving characters that have special meaning.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEncode spaces in URI\u003c/em\u003e***\u003cbr\u003eURI To Encode: \u003cstrong\u003ehttps://example.com/path with spaces\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps://example.com/path%20with%20spaces\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eClean URI unchanged\u003c/em\u003e***\u003cbr\u003eURI To Encode: \u003cstrong\u003ehttps://example.com/page\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps://example.com/page\u003c/strong\u003e"
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
 * Encodes an entire URI (Uniform Resource Identifier), converting special characters into percent-encoded equivalents.
 * 
 * @param {string} data.src - The URI to encode.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before encoding.
 * 
 * @returns {string} The encoded URI with special characters converted to percent-encoded equivalents.
 *
 * @framework ggLowCodeGTMKit
 */
const encodeUri = require('encodeUri');

const encodeUriFunction = function(uri) {
    return encodeUri(uri);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// encodeUriFunction - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(encodeUriFunction(value));
// ===============================================================================
// encodeUriFunction() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(encodeUriFunction(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Encode spaces in URI'
    code: |-
      /* @display
      URI To Encode: https://example.com/path with spaces
      @output
      https://example.com/path%20with%20spaces
      */
      const src = 'https://example.com/path with spaces';
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
      assertThat(variableResult).isEqualTo('https://example.com/path%20with%20spaces');
  - name: URI with special characters - should encode special chars
    code: |
      const src = 'https://example.com/search?q=hello&name=John Doe';
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
      assertThat(variableResult).isEqualTo('https://example.com/search?q=hello&name=John%20Doe');
  - name: URI with non-ASCII characters - should encode Unicode
    code: |-
      const src = 'https://example.com/français';
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
      assertThat(variableResult).isEqualTo('https://example.com/fran%C3%A7ais');
  - name: '[example] Clean URI unchanged'
    code: |-
      /* @display
      URI To Encode: https://example.com/page
      @output
      https://example.com/page
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
      assertThat(variableResult).isEqualTo('https://example.com/page');
  - name: URI with hash and query parameters - should preserve structure
    code: |-
      const src = 'https://example.com/path?query=test#fragment';
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
      assertThat(variableResult).isEqualTo('https://example.com/path?query=test#fragment');
  - name: Non-string input - should handle gracefully
    code: |-
      const src = null;
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
      assertThat(variableResult).isEqualTo('null');
  - name: Object input - should convert to string and encode
    code: |-
      const src = {key: 'value'};
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
      assertThat(variableResult).isEqualTo('%5Bobject%20Object%5D');
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
