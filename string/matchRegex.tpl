___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "matchRegex",
  "description": "Matches a \u003cem\u003estring\u003c/em\u003e against a regular expression pattern and returns the matches, useful for extracting specific patterns and capture groups from text.",
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
        "name": "ptn",
        "displayName": "Regular Expression Pattern",
        "simpleValueType": true,
        "help": "🔍 The regular expression pattern to match in the string.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString (regex pattern)\u003c/strong\u003e: \u003cem\u003e\"^abc\"\u003c/em\u003e, \u003cem\u003e\"\\d+\"\u003c/em\u003e, \u003cem\u003e\"(\\w+)\"\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e⚠️ \u003cstrong\u003eEscaping note:\u003c/strong\u003e In this UI field, use single backslash (e.g., \u003ccode\u003e\\d+\u003c/code\u003e for digits). GTM automatically handles the escaping."
      }
    ],
    "help": "Matches a \u003cem\u003estring\u003c/em\u003e against a regular expression pattern. Returns an array with the match and any captured groups, or \u003cem\u003enull\u003c/em\u003e if no match found.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSimple digit match\u003c/em\u003e***\u003cbr\u003eString to Search: \u003cstrong\u003eHello world 123\u003c/strong\u003e\u003cbr\u003eRegular Expression Pattern: \u003cstrong\u003e\\\\d+\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e123\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmail capture groups\u003c/em\u003e***\u003cbr\u003eString to Search: \u003cstrong\u003eEmail: user@example.com\u003c/strong\u003e\u003cbr\u003eRegular Expression Pattern: \u003cstrong\u003e(\\\\w+)@(\\\\w+\\\\.\\\\w+)\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003euser@example.com\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns null\u003c/em\u003e***\u003cbr\u003eString to Search: \u003cstrong\u003eHello world\u003c/strong\u003e\u003cbr\u003eRegular Expression Pattern: \u003cstrong\u003e\\\\d+\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003enull\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the string before matching (e.g., normalize case, trim whitespace)."
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
        "help": "⚙️ Optional function to apply to the result array before returning it (e.g., \u003ccode\u003earr =\u003e arr[0]\u003c/code\u003e to get full match only, \u003ccode\u003earr =\u003e arr[1]\u003c/code\u003e to get first captured group, \u003ccode\u003earr =\u003e arr !== null\u003c/code\u003e for boolean). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Matches the provided string against the given regular expression pattern.
 * 
 * @param {string} data.src - The string to search within.
 * @param {string} data.ptn - The regular expression pattern to match in the string.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before matching.
 * 
 * @returns {Array|null} An array containing the matches if found, or null if no match is found.
 *
 * @framework ggLowCodeGTMKit
 */
const matchRegex = function(stringToMatch, regexPattern) {
    if (typeof stringToMatch !== 'string' || typeof regexPattern !== 'string') {
        return null;
    }
    return stringToMatch.match(regexPattern);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// matchRegex - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedString = applyCast(data.pre, data.src);
return out(matchRegex(processedString, data.ptn));
// ===============================================================================
// matchRegex(...) – Apply Mode
// ===============================================================================
/*
return function(stringToMatch, regexPattern) {
   return out(matchRegex(stringToMatch, data.ptn));
};
*/


___TESTS___

scenarios:
  - name: '[example] Simple digit match'
    code: |-
      /* @display
      String to Search: Hello world 123
      Regular Expression Pattern: \\d+
      @output
      123
      */
      const src = 'Hello world 123';
      const ptn = '\\d+';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult[0]).isEqualTo('123');
  - name: '[example] Email capture groups'
    code: |
      /* @display
      String to Search: Email: user@example.com
      Regular Expression Pattern: (\\w+)@(\\w+\\.\\w+)
      @output
      user@example.com
      */
      const src = 'Email: user@example.com';
      const ptn = '(\\w+)@(\\w+\\.\\w+)';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult[0]).isEqualTo('user@example.com');
      assertThat(variableResult[1]).isEqualTo('user');
      assertThat(variableResult[2]).isEqualTo('example.com');
  - name: Test matching word at start of string
    code: |-
      const src = 'Hello world';
      const ptn = '^Hello';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult[0]).isEqualTo('Hello');
  - name: Test matching word at end of string
    code: |
      const src = 'Hello world';
      const ptn = 'world$';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult[0]).isEqualTo('world');
  - name: Test with special characters
    code: |-
      const src = 'Price: $19.99';
      const ptn = '\\$\\d+\\.\\d+';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult[0]).isEqualTo('$19.99');
  - name: Test with whitespace pattern
    code: |-
      const src = 'hello   world';
      const ptn = '\\s+';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult[0]).isEqualTo('   ');
  - name: Test with non-string input returns null
    code: |-
      const src = 12345;
      const ptn = '\\d+';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isNull();
  - name: Test with null string returns null
    code: |
      const src = null;
      const ptn = 'test';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isNull();
  - name: Test with empty pattern
    code: |-
      const src = 'hello world';
      const ptn = '';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult[0]).isEqualTo('');
  - name: '[example] No match returns null'
    code: |
      /* @display
      String to Search: Hello world
      Regular Expression Pattern: \\d+
      @output
      null
      */
      const src = 'Hello world';
      const ptn = '\\d+';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isNull();
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
