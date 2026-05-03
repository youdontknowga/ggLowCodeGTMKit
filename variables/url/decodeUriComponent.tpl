___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "decodeUriComponent",
  "description": "Decodes a URI component, such as a query parameter or a path segment. This function converts percent-encoded characters back into their original form but leaves delimiters like \u0026, \u003d, and ? intact.",
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
        "displayName": "URI Component To Decode",
        "simpleValueType": true,
        "help": "💾   The URI component to decode, which may contain percent-encoded characters.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Decodes a URI component by replacing percent-encoded characters.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDecode spaces\u003c/em\u003e***\u003cbr\u003eURI Component To Decode: \u003cstrong\u003ehello%20world\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDecode special characters\u003c/em\u003e***\u003cbr\u003eURI Component To Decode: \u003cstrong\u003euser%40example.com\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003euser@example.com\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert object to string, normalize format). Internal transformations such as string handling will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toLowerCase(), val =\u003e val + ' decoded' for string modifications). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Decodes a URI component by reversing percent-encoding for special characters.
 * 
 * @param {string} data.src - The URI component to decode (e.g., a query parameter or path segment).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before decoding.
 * 
 * @returns {string} The decoded URI component with percent-encoded characters converted back to their original form.
 *
 * @framework ggLowCodeGTMKit
 */
const decodeUriComponent = require('decodeUriComponent');

const decodeUriComponentFunction = function(uriComponent) {
      if (uriComponent == null) {
        return '';
    }
    const stringValue = typeof uriComponent === 'string' ? uriComponent : uriComponent.toString();
    return decodeUriComponent(stringValue);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// decodeUriComponent - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(decodeUriComponentFunction(value));
// ===============================================================================
// decodeUriComponent() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(decodeUriComponentFunction(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Decode spaces'
    code: |-
      /* @display
      URI Component To Decode: hello%20world
      @output
      hello world
      */
      const src = "hello%20world";
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
      assertThat(variableResult).isEqualTo("hello world");
  - name: '[example] Decode special characters'
    code: |-
      /* @display
      URI Component To Decode: user%40example.com
      @output
      user@example.com
      */
      const src = "user%40example.com";
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
      assertThat(variableResult).isEqualTo("user@example.com");
  - name: Encoded query parameters - decodes ampersand and equals
    code: |-
      const src = "key%3Dvalue%26other%3Ddata";
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
      assertThat(variableResult).isEqualTo("key=value&other=data");
  - name: String without encoding - returns unchanged
    code: |-
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
  - name: Non string input - return it stringified
    code: |-
      const src = {};
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
      assertThat(variableResult).isEqualTo("[object Object]");
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
