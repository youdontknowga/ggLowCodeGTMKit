___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "endsWith(...)",
  "description": "Checks if the given \u003cem\u003estring\u003c/em\u003e ends with the specified substring. Returns \u003cem\u003etrue\u003c/em\u003e if match found, \u003cem\u003efalse\u003c/em\u003e otherwise.",
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
        "name": "trm",
        "displayName": "Search Term",
        "simpleValueType": true,
        "help": "🔍   The substring to check if it is at the end of the source.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "Checks if the given \u003cem\u003estring\u003c/em\u003e ends with the specified substring. Returns \u003cem\u003etrue\u003c/em\u003e if match found, \u003cem\u003efalse\u003c/em\u003e otherwise.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString ends with match\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello world\u003cbr\u003eSearch Term: world\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match at end\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello world\u003cbr\u003eSearch Term: hello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNull input returns false\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: null\u003cbr\u003eSearch Term: test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
    "help": "Checks if the given \u003cem\u003estring\u003c/em\u003e ends with the specified substring. Returns \u003cem\u003etrue\u003c/em\u003e if match found, \u003cem\u003efalse\u003c/em\u003e otherwise.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString ends with match\u003c/em\u003e***\u003cbr\u003eString To Check: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003eSearch Term: \u003cstrong\u003eworld\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match at end\u003c/em\u003e***\u003cbr\u003eString To Check: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003eSearch Term: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNull input returns false\u003c/em\u003e***\u003cbr\u003eString To Check: \u003cstrong\u003enull\u003c/strong\u003e\u003cbr\u003eSearch Term: \u003cstrong\u003etest\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
* Checks if the given string ends with the specified substring.
* 
* @param {any} data.src - The string or value to check.
* @param {string} data.trm - The substring to check if it is at the end of src.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before checking.
* 
* @returns {boolean} Returns true if the src ends with the term, otherwise returns false.
*
* @framework ggLowCodeGTMKit
*/
const endsWith = function(searchData, searchTerm) {
   if (searchData == null || typeof searchTerm !== 'string') {
       return false;
   }
   const searchDataString = searchData.toString();
   return searchDataString.substring(searchDataString.length - searchTerm.length) === searchTerm;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// endsWith - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(endsWith(value, data.trm));
*/
// ===============================================================================
// endsWith(...) – Apply Mode
// ===============================================================================
return function(value, searchTerm) {
   searchTerm = data.rp1 ? data.trm : searchTerm;
   return out(endsWith(value, searchTerm));
};


___TESTS___

scenarios:
  - name: '[example] String ends with match'
    code: |-
      /* @display
      Value to Process: hello world
      Search Term: world
      @output
      true
      */
      const src = 'hello world';
      const trm = 'world';
      const mockData = {
          src: src,
          trm: trm,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, trm);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] No match at end'
    code: |-
      /* @display
      Value to Process: hello world
      Search Term: hello
      @output
      false
      */
      const src = 'hello world';
      const trm = 'hello';
      const mockData = {
          src: src,
          trm: trm,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, trm);
      }
      assertThat(variableResult).isFalse();
  - name: Empty string with empty term - should return true
    code: |-
      const src = '';
      const trm = '';
      const mockData = {
          src: src,
          trm: trm,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, trm);
      }
      assertThat(variableResult).isTrue();
  - name: Number ending with specified digits - should return true
    code: |-
      const src = 12345;
      const trm = '45';
      const mockData = {
          src: src,
          trm: trm,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, trm);
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
      const trm = 'test';
      const mockData = {
          src: src,
          trm: trm,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, trm);
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
