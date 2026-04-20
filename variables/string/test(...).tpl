___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "test(...)",
  "description": "Checks if a \u003cem\u003estring\u003c/em\u003e matches a specified regular expression (regex). Returns \u003cem\u003etrue\u003c/em\u003e if a match is found, otherwise \u003cem\u003efalse\u003c/em\u003e.",
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
        "name": "pat",
        "displayName": "Regular Expression Pattern",
        "simpleValueType": true,
        "help": "🔍 The regular expression pattern to test against the string.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString (regex pattern)\u003c/strong\u003e: \u003cem\u003e\"\\d+\"\u003c/em\u003e, \u003cem\u003e\"^test\"\u003c/em\u003e, \u003cem\u003e\"[a-z]+\"\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e⚠️ \u003cstrong\u003eEscaping note:\u003c/strong\u003e In this UI field, use single backslash (e.g., \u003ccode\u003e\\d+\u003c/code\u003e for digits). GTM automatically handles the escaping.",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePattern matches\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003estr: Hello World\u003cbr\u003eRegular Expression Pattern: World\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns false\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003estr: Hello World\u003cbr\u003eRegular Expression Pattern: xyz\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String to Test"
      }
    ],
    "help": "Tests whether a regular expression pattern matches a \u003cem\u003estring\u003c/em\u003e. Returns \u003cem\u003etrue\u003c/em\u003e if a match is found, \u003cem\u003efalse\u003c/em\u003e otherwise. Useful for validation and conditional logic.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePattern matches\u003c/em\u003e***\u003cbr\u003estr: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003eRegular Expression Pattern: \u003cstrong\u003eWorld\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns false\u003c/em\u003e***\u003cbr\u003estr: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003eRegular Expression Pattern: \u003cstrong\u003exyz\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the boolean result before returning it (e.g., \u003ccode\u003eval =\u003e !val\u003c/code\u003e to invert, \u003ccode\u003eval =\u003e val ? 'valid' : 'invalid'\u003c/code\u003e for string conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Tests whether a given regular expression pattern matches the string.
 *
 * @param {string} data.str - The string to search within.
 * @param {string} data.pat - The regular expression pattern to match in the string.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform str before matching.
 * 
 * @returns {boolean} Returns true if a match is found, false if no match is found.
 *
 * @framework ggLowCodeGTMKit
 */
const test = function(stringToMatch, regexPattern) {
    if (typeof stringToMatch !== 'string' || typeof regexPattern !== 'string') {
        return false;
    }
    return stringToMatch.search(regexPattern) !== -1;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// test - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedString = applyCast(data.pre, data.str);
return out(test(processedString, data.pat));
*/
// ===============================================================================
// test(...) – Apply Mode
// ===============================================================================
return function(stringToMatch, regexPattern) {
   return out(test(stringToMatch, data.pat));
};


___TESTS___

scenarios:
  - name: '[example] Pattern matches'
    code: |-
      /* @display
      String to Search: Hello World
      Regular Expression Pattern: World
      @output
      true
      */
      const str = "Hello World";
      const pat = "World";
      const mockData = {
          str: str,
          pat: pat,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(str, pat);
      }
      assertThat(variableResult).isTrue();
  - name: String with regex pattern match - returns true
    code: |-
      const str = "The year is 2024";
      const pat = "\\d+";
      const mockData = {
          str: str,
          pat: pat,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(str, pat);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] No match returns false'
    code: |-
      /* @display
      String to Search: Hello World
      Regular Expression Pattern: xyz
      @output
      false
      */
      const str = "Hello World";
      const pat = "xyz";
      const mockData = {
          str: str,
          pat: pat,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(str, pat);
      }
      assertThat(variableResult).isFalse();
  - name: Case sensitive pattern no match - returns false
    code: |-
      const str = "hello world";
      const pat = "HELLO";
      const mockData = {
          str: str,
          pat: pat,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(str, pat);
      }
      assertThat(variableResult).isFalse();
  - name: Empty pattern in string - returns true
    code: |-
      const str = "test string";
      const pat = "";
      const mockData = {
          str: str,
          pat: pat,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(str, pat);
      }
      assertThat(variableResult).isTrue();
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
