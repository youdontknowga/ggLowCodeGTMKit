___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "startsWith(...)",
  "description": "Checks if the given \u003cem\u003estring\u003c/em\u003e starts with the specified substring. First ensures that the input is neither \u003cem\u003enull\u003c/em\u003e nor \u003cem\u003eundefined\u003c/em\u003e before performing the check.",
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
        "name": "str",
        "displayName": "Search Term",
        "simpleValueType": true,
        "help": "💾   The substring to check if it is at the start of the string.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString starts with match\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello world\u003cbr\u003eSearch Term: hello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match at start\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello world\u003cbr\u003eSearch Term: world\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNull input returns false\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: null\u003cbr\u003eSearch Term: test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String To Test"
      },
      {
        "type": "GROUP",
        "name": "Advanced Settings",
        "displayName": "Advanced Settings",
        "groupStyle": "ZIPPY_OPEN_ON_PARAM",
        "subParams": [
          {
            "type": "CHECKBOX",
            "name": "rp1",
            "checkboxText": "⚡Use runtime parameter for: Search Term",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Checks if the given \u003cem\u003estring\u003c/em\u003e starts with the specified substring. Returns \u003cem\u003etrue\u003c/em\u003e if match found, \u003cem\u003efalse\u003c/em\u003e otherwise.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString starts with match\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003eSearch Term: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match at start\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003eSearch Term: \u003cstrong\u003eworld\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNull input returns false\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003enull\u003c/strong\u003e\u003cbr\u003eSearch Term: \u003cstrong\u003etest\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., bool =\u003e bool ? 'yes' : 'no', val =\u003e !val for negation). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Checks if the given string starts with the specified substring.
 *
 * @param {any} data.src - The string or value to check.
 * @param {string} data.str - The substring to check if it is at the start of src.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before checking.
 * 
 * @returns {boolean} Returns true if the src starts with the str, otherwise returns false.
 *
 * @framework ggLowCodeGTMKit
 */
const startsWith = function(searchData, searchTerm) {
    if (searchData == null || typeof searchTerm !== 'string') {
        return false;
    }
    const searchDataString = searchData.toString();
    return searchDataString.substring(0, searchTerm.length) === searchTerm;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// startsWith - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(startsWith(value, data.str));
*/
// ===============================================================================
// startsWith(...) – Apply Mode
// ===============================================================================
return function(value, searchTerm) {
   searchTerm = data.rp1 ? data.str : searchTerm;
   return out(startsWith(value, searchTerm));
};


___TESTS___

scenarios:
  - name: '[example] String starts with match'
    code: |
      /* @display
      Value to Process: hello world
      Search Term: hello
      @output
      true
      */
      const src = 'hello world';
      const str = 'hello';
      const mockData = {
          src: src,
          str: str,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, str);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] No match at start'
    code: |-
      /* @display
      Value to Process: hello world
      Search Term: world
      @output
      false
      */
      const src = 'hello world';
      const str = 'world';
      const mockData = {
          src: src,
          str: str,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, str);
      }
      assertThat(variableResult).isFalse();
  - name: Empty string with empty term - should return true
    code: |-
      const src = '';
      const str = '';
      const mockData = {
          src: src,
          str: str,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, str);
      }
      assertThat(variableResult).isTrue();
  - name: Number starting with specified digits - should return true
    code: |
      const src = 12345;
      const str = '12';
      const mockData = {
          src: src,
          str: str,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, str);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] Null input returns false'
    code: |-
      /* @display
      Value to Process: null
      Search Term: test
      @output
      false
      */
      const src = null;
      const str = 'test';
      const mockData = {
          src: src,
          str: str,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, str);
      }
      assertThat(variableResult).isFalse();
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
