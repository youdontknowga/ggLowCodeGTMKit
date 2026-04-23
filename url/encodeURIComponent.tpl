___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "encodeURIComponent",
  "description": "Encodes a URI component by converting special characters into percent-encoded equivalents. Used for individual URI components like query parameters or path segments in the input \u003cem\u003estring\u003c/em\u003e.",
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
        "displayName": "URI Component To Encode",
        "simpleValueType": true,
        "help": "💾   The URI component to encode (e.g., a query parameter or path segment).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Encodes a URI component, escaping special characters.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEncode spaces\u003c/em\u003e***\u003cbr\u003eURI Component To Encode: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello%20world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEncode special characters\u003c/em\u003e***\u003cbr\u003eURI Component To Encode: \u003cstrong\u003euser@example.com\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003euser%40example.com\u003c/strong\u003e"
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
 * Encodes a URI component by converting special characters into percent-encoded equivalents.
 * 
 * @param {string} data.src - The URI component to encode (e.g., a query parameter or path segment).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before encoding.
 * 
 * @returns {string} The encoded URI component with special characters converted to percent-encoded equivalents.
 *
 * @framework ggLowCodeGTMKit
 */
const encodeUriComponent = require('encodeUriComponent');

const encodeUriComponentFunction = function(uriComponent) {
    return encodeUriComponent(uriComponent);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// encodeUriComponentFunction - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(encodeUriComponentFunction(value));
// ===============================================================================
// encodeUriComponentFunction() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(encodeUriComponentFunction(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Encode spaces'
    code: |
      /* @display
      URI Component To Encode: hello world
      @output
      hello%20world
      */
      const src = "hello world";
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
      assertThat(variableResult).isEqualTo("hello%20world");
  - name: '[example] Encode special characters'
    code: |-
      /* @display
      URI Component To Encode: user@example.com
      @output
      user%40example.com
      */
      const src = "user@example.com";
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
      assertThat(variableResult).isEqualTo("user%40example.com");
  - name: String with query parameter characters - encodes ampersand and equals
    code: |
      const src = "key=value&other=data";
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
      assertThat(variableResult).isEqualTo("key%3Dvalue%26other%3Ddata");
  - name: String with only safe characters - returns unchanged
    code: |
      const src = "simple123";
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
      assertThat(variableResult).isEqualTo("simple123");
  - name: Empty string - returns empty string
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
      assertThat(variableResult).isEqualTo("");
  - name: Non string input - returns it stringified
    code: |-
      const src = 123;
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
      assertThat(variableResult).isEqualTo("123");
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
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
