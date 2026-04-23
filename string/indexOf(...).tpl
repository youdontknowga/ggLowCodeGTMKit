___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "indexOf(...)",
  "description": "Returns the index of the first occurrence of a specified value in a \u003cem\u003estring\u003c/em\u003e or \u003cem\u003earray\u003c/em\u003e. Returns -1 if not found.",
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
        "name": "elm",
        "displayName": "Search Element",
        "simpleValueType": true,
        "help": "💾   The element to search for in the string or array.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "frm",
        "displayName": "▶️ From Index",
        "simpleValueType": true,
        "help": "💾   The position at which to start the search (default is 0).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp2",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFind index in string\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello world\u003cbr\u003eSearch Element: o\u003cbr\u003e▶️ From Index: 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e4\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNot found returns -1\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello world\u003cbr\u003eSearch Element: z\u003cbr\u003e▶️ From Index: 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e-1\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Source Content (String or Array)"
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
            "checkboxText": "⚡Use runtime parameter for: Search Element",
            "simpleValueType": true
          },
          {
            "type": "CHECKBOX",
            "name": "rp2",
            "checkboxText": "⚡Use runtime parameter for: From Index",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Returns the index of the first occurrence of a value in a \u003cem\u003estring\u003c/em\u003e or \u003cem\u003earray\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFind index in string\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003eSearch Element: \u003cstrong\u003eo\u003c/strong\u003e\u003cbr\u003e▶️ From Index: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e4\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNot found returns -1\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003eSearch Element: \u003cstrong\u003ez\u003c/strong\u003e\u003cbr\u003e▶️ From Index: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e-1\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., idx =\u003e idx \u003e= 0 ? 'found' : 'not found', idx =\u003e idx + 1 for 1-based indexing). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Returns the index of the first occurrence of a specified value in a string or an array.
* 
* @param {string|Array} data.src - The string or array to search.
* @param {any} data.elm - The element to search for in the string or array.
* @param {number|string} data.frm - The position at which to start the search (default is 0).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before searching.
* 
* @returns {number} The index of the first occurrence of the search element, or -1 if not found.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');
const makeNumber = require('makeNumber');
const indexOf = function(input, searchElement, fromIndex) {
   const fromIdx = fromIndex !== undefined ? makeNumber(fromIndex) : 0;
   if (!(getType(input) === 'array' || getType(input) === 'string') || 
       typeof fromIdx !== 'number' || 
       fromIdx < 0) { 
       return -1;
   }
   return input.indexOf(searchElement, fromIdx);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// indexOf - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(indexOf(value, data.elm, data.frm));
*/
// ===============================================================================
// indexOf(...) – Apply Mode
// ===============================================================================
return function(value, searchElement, fromIndex) {
  searchElement = data.rp1 ? data.elm : searchElement;
  fromIndex = data.rp2 ? data.frm : fromIndex;
  return out(indexOf(value, searchElement, fromIndex));
};


___TESTS___

scenarios:
  - name: '[example] Find index in string'
    code: |-
      /* @display
      Value to Process: hello world
      Search Element: o
      ▶️ From Index: 0
      @output
      4
      */
      const src = 'hello world';
      const elm = 'o';
      const frm = 0;
      const mockData = {
          src: src,
          elm: elm,
          frm: frm,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, elm, frm);
      }
      assertThat(variableResult).isEqualTo(4);
  - name: '[example] Not found returns -1'
    code: |-
      /* @display
      Value to Process: hello world
      Search Element: z
      ▶️ From Index: 0
      @output
      -1
      */
      const src = 'hello world';
      const elm = 'z';
      const frm = 0;
      const mockData = {
          src: src,
          elm: elm,
          frm: frm,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, elm, frm);
      }
      assertThat(variableResult).isEqualTo(-1);
  - name: String with fromIndex specified - should search from that position
    code: |-
      const src = 'hello world';
      const elm = 'o';
      const frm = 5;
      const mockData = {
          src: src,
          elm: elm,
          frm: frm,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, elm, frm);
      }
      assertThat(variableResult).isEqualTo(7);
  - name: Array with matching element - should return index
    code: |-
      const src = [1, 2, 3, 4, 5];
      const elm = 3;
      const frm = 0;
      const mockData = {
          src: src,
          elm: elm,
          frm: frm,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, elm, frm);
      }
      assertThat(variableResult).isEqualTo(2);
  - name: Array with element not found - should return -1
    code: |-
      const src = [1, 2, 3, 4, 5];
      const elm = 10;
      const frm = 0;
      const mockData = {
          src: src,
          elm: elm,
          frm: frm,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, elm, frm);
      }
      assertThat(variableResult).isEqualTo(-1);
  - name: Array with fromIndex specified - should search from that position
    code: |-
      const src = ['a', 'b', 'c', 'b', 'd'];
      const elm = 'b';
      const frm = 2;
      const mockData = {
          src: src,
          elm: elm,
          frm: frm,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, elm, frm);
      }
      assertThat(variableResult).isEqualTo(3);
  - name: String with fromIndex as string - should convert and use it
    code: |
      const src = 'hello world';
      const elm = 'o';
      const frm = '5';
      const mockData = {
          src: src,
          elm: elm,
          frm: frm,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, elm, frm);
      }
      assertThat(variableResult).isEqualTo(7);
  - name: Array searching from middle position - should skip earlier occurrences
    code: |-
      const src = [1, 2, 3, 2, 5];
      const elm = 2;
      const frm = 2;
      const mockData = {
          src: src,
          elm: elm,
          frm: frm,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, elm, frm);
      }
      assertThat(variableResult).isEqualTo(3);
  - name: fromIndex beyond array length - should return -1
    code: |-
      const src = [1, 2, 3];
      const elm = 2;
      const frm = 10;
      const mockData = {
          src: src,
          elm: elm,
          frm: frm,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, elm, frm);
      }
      assertThat(variableResult).isEqualTo(-1);
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
