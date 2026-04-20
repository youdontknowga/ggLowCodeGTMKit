___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "parseUrlComponents()",
  "description": "Parses a full URL \u003cem\u003estring\u003c/em\u003e into its component parts (protocol, host, port, path, query, fragment, etc.), useful for extracting specific URL elements and analyzing web addresses.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse complete URL\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://example.com:8080/path/to/page?query=test\u0026foo=bar#section\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps:\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse simple URL\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttp://test.com/page\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttp:\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: URL"
      }
    ],
    "help": "Parses a URL into its individual components (protocol, host, pathname, search, hash).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse complete URL\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://example.com:8080/path/to/page?query=test\u0026foo=bar#section\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps:\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse simple URL\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttp://test.com/page\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttp:\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., obj =\u003e obj.hostname, obj =\u003e obj.protocol + '//' + obj.host for extracting specific components). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Parses a full URL string into its component parts (protocol, host, port, path, query, fragment, etc.).
* 
* @param {string} data.src - The full URL to parse (e.g., "https://example.com/page?x=1#top").
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before parsing.
* 
* @returns {Object} An object containing the parsed components of the URL.
*
* @framework ggLowCodeGTMKit
*/

const parseUrl = require('parseUrl');

const parseUrlComponents = function(url) {
   return parseUrl(url);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// parseUrlComponents - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedUrl = applyCast(data.pre, data.src);
return out(parseUrlComponents(processedUrl));
*/
// ===============================================================================
// parseUrlComponents() – Apply Mode
// ===============================================================================
return function(value) {
   return out(parseUrlComponents(value));
};


___TESTS___

scenarios:
  - name: '[example] Parse complete URL'
    code: |
      /* @display
      Value to Process: https://example.com:8080/path/to/page?query=test&foo=bar#section
      @output
      https:
      */
      const src = 'https://example.com:8080/path/to/page?query=test&foo=bar#section';
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
      assertThat(variableResult.protocol).isEqualTo('https:');
      assertThat(variableResult.host).isEqualTo('example.com:8080');
      assertThat(variableResult.pathname).isEqualTo('/path/to/page');
  - name: '[example] Parse simple URL'
    code: |-
      /* @display
      Value to Process: http://test.com/page
      @output
      http:
      */
      const src = 'http://test.com/page';
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
      assertThat(variableResult.protocol).isEqualTo('http:');
      assertThat(variableResult.hostname).isEqualTo('test.com');
      assertThat(variableResult.pathname).isEqualTo('/page');
  - name: URL with query string only - should parse query parameters
    code: |
      const src = 'https://example.com/?name=john&age=30';
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
      assertThat(variableResult.hostname).isEqualTo('example.com');
      assertThat(variableResult.search).isEqualTo('?name=john&age=30');
  - name: URL with fragment only - should parse fragment
    code: |-
      const src = 'https://docs.example.com/guide#introduction';
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
      assertThat(variableResult.hostname).isEqualTo('docs.example.com');
      assertThat(variableResult.hash).isEqualTo('#introduction');
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
