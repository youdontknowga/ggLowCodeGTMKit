___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "decodeUri()",
  "description": "Decodes an entire URI (Uniform Resource Identifier), reversing percent-encoding for special URI characters in the input \u003cem\u003estring\u003c/em\u003e.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDecode %20 to spaces\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://example.com/path%20with%20spaces\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps://example.com/path with spaces\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNull returns empty string\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003enull\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: URI To Decode"
      }
    ],
    "help": "Decodes a URI by replacing percent-encoded characters.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDecode %20 to spaces\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://example.com/path%20with%20spaces\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps://example.com/path with spaces\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNull returns empty string\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003enull\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\u003c/strong\u003e"
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
* Decodes an entire URI (Uniform Resource Identifier), reversing percent-encoding for special URI characters.
* 
* @param {string} data.src - The URI to decode, which may contain percent-encoded characters.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before decoding.
* 
* @returns {string} The decoded URI.
*
* @framework ggLowCodeGTMKit
*/
const decodeUri = require('decodeUri');

const decodeUriFunction = function(uri) {
    if (uri == null) {
        return '';
    }
    const stringValue = typeof uri === 'string' ? uri : uri.toString();
    return decodeUri(stringValue);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// decodeUriFunction - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(decodeUriFunction(value));
*/
// ===============================================================================
// decodeUriFunction() – Apply Mode
// ===============================================================================
return function(value) {
    return out(decodeUriFunction(value));
};


___TESTS___

scenarios:
  - name: '[example] Decode %20 to spaces'
    code: |-
      /* @display
      Value to Process: https://example.com/path%20with%20spaces
      @output
      https://example.com/path with spaces
      */
      const src = "https://example.com/path%20with%20spaces";
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
      assertThat(variableResult).isEqualTo("https://example.com/path with spaces");
  - name: URI with encoded non-reserved characters - decodes them
    code: |-
      const src = "https://example.com/hello%20world%21";
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
      assertThat(variableResult).isEqualTo("https://example.com/hello world!");
  - name: URI without encoding - returns unchanged
    code: |
      const src = "https://example.com/simple/path";
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
      assertThat(variableResult).isEqualTo("https://example.com/simple/path");
  - name: '[example] Null returns empty string'
    code: |-
      /* @display
      Value to Process: null
      */
      const src = null;
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
  - name: URI with both reserved and non-reserved encoded characters - shows difference
    code: |-
      const src = "https://example.com/path%20name%3Fquery%3Dvalue%26key%3Dtest%21";
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
      assertThat(variableResult).isEqualTo("https://example.com/path name%3Fquery%3Dvalue%26key%3Dtest!");
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
