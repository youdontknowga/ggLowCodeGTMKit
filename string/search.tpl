___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "search",
  "description": "Returns the index of the first match, or -1 if no match is found. Simulates the behavior of String.prototype.search() using a regular expression literal.",
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
        "displayName": "String to Search",
        "simpleValueType": true,
        "help": "💾 The string to search within.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "rgx",
        "displayName": "Regular Expression Pattern",
        "simpleValueType": true,
        "help": "🔍 The regular expression pattern to search for. Returns the index of the first match.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString (regex pattern)\u003c/strong\u003e: \u003cem\u003e\"\\d+\"\u003c/em\u003e, \u003cem\u003e\"[a-z]+\"\u003c/em\u003e, \u003cem\u003e\"test\"\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e⚠️ \u003cstrong\u003eEscaping note:\u003c/strong\u003e In this UI field, use single backslash (e.g., \u003ccode\u003e\\d+\u003c/code\u003e for digits). GTM automatically handles the escaping."
      }
    ],
    "help": "Searches for a regular expression pattern in a \u003cem\u003estring\u003c/em\u003e and returns the index of the first match. Returns \u003cem\u003e-1\u003c/em\u003e if no match is found.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFind digit position\u003c/em\u003e***\u003cbr\u003eString to Search: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003eRegular Expression Pattern: \u003cstrong\u003eWorld\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e6\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns -1\u003c/em\u003e***\u003cbr\u003eString to Search: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003eRegular Expression Pattern: \u003cstrong\u003exyz\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e-1\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the string before searching (e.g., normalize case, trim whitespace)."
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
        "help": "⚙️ Optional function to apply to the result index before returning it (e.g., \u003ccode\u003eidx =\u003e idx !== -1\u003c/code\u003e for boolean check, \u003ccode\u003eidx =\u003e idx + 1\u003c/code\u003e for 1-based indexing). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Simulates the behavior of String.prototype.search() using a regular expression literal.
 *
 * @param {string} data.src - The string to search within.
 * @param {string} data.rgx - The regular expression pattern as a string.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before searching.
 * 
 * @returns {number} Returns the index of the first match, or -1 if no match is found.
 *
 * @framework ggLowCodeGTMKit
 */
const search = function(searchData, regexPattern) {
    if (typeof searchData !== 'string' || typeof regexPattern !== 'string') {
        return -1;
    }
    return searchData.search(regexPattern);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// search - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(search(value, data.rgx));
// ===============================================================================
// search(...) – Apply Mode
// ===============================================================================
/*
return function(searchData, regexPattern) {
   return out(search(searchData, data.rgx));
};
*/


___TESTS___

scenarios:
  - name: '[example] Find digit position'
    code: |-
      /* @display
      String to Search: Hello World
      Regular Expression Pattern: World
      @output
      6
      */
      const src = "Hello World";
      const rgx = "World";
      const mockData = {
          src: src,
          rgx: rgx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rgx);
      }
      assertThat(variableResult).isEqualTo(6);
  - name: String with pattern at beginning - returns 0
    code: |-
      const src = "test string";
      const rgx = "test";
      const mockData = {
          src: src,
          rgx: rgx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rgx);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: '[example] No match returns -1'
    code: |-
      /* @display
      String to Search: Hello World
      Regular Expression Pattern: xyz
      @output
      -1
      */
      const src = "Hello World";
      const rgx = "xyz";
      const mockData = {
          src: src,
          rgx: rgx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rgx);
      }
      assertThat(variableResult).isEqualTo(-1);
  - name: String with regex pattern - finds match using regex
    code: |-
      const src = "The year is 2024";
      const rgx = "\\d+";
      const mockData = {
          src: src,
          rgx: rgx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rgx);
      }
      assertThat(variableResult).isEqualTo(12);
  - name: Non-string input - returns -1
    code: |-
      const src = 12345;
      const rgx = "123";
      const mockData = {
          src: src,
          rgx: rgx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rgx);
      }
      assertThat(variableResult).isEqualTo(-1);
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
