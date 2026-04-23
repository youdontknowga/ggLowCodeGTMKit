___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "slice(...)",
  "description": "Extract and return a portion of a \u003cem\u003estring\u003c/em\u003e or \u003cem\u003earray\u003c/em\u003e starting from the provided starting index and optional ending index.",
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
        "name": "sta",
        "displayName": "Start Index",
        "simpleValueType": true,
        "help": "▶️   The starting index where to begin the slice.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "name": "end",
        "displayName": "End Index",
        "simpleValueType": true,
        "help": "⏹️   The index where to end the slice (optional, defaults to the end of the string/array).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract substring\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: Hello World\u003cbr\u003eStart Index: 0\u003cbr\u003eEnd Index: 5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNegative index slices from end\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: abcdef\u003cbr\u003eStart Index: -3\u003cbr\u003eEnd Index: undefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003edef\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Data To Slice"
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
            "checkboxText": "⚡Use runtime parameter for: Start Index",
            "simpleValueType": true
          },
          {
            "type": "CHECKBOX",
            "name": "rp2",
            "checkboxText": "⚡Use runtime parameter for: End Index",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Extract and return a portion of a \u003cem\u003estring\u003c/em\u003e or \u003cem\u003earray\u003c/em\u003e starting from the provided starting index and optional ending index.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract substring\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003eStart Index: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003eEnd Index: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNegative index slices from end\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eabcdef\u003c/strong\u003e\u003cbr\u003eStart Index: \u003cstrong\u003e-3\u003c/strong\u003e\u003cbr\u003eEnd Index: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003edef\u003c/strong\u003e"
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
* Extract and return a portion of a string or array starting from the provided starting index and optional ending index.
* 
* @param {string|Array} data.src - The string or array to slice.
* @param {number|string} data.sta - The starting index where to begin the slice.
* @param {number|string} data.end - The index where to end the slice (optional, defaults to the end of the string/array).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before slicing.
* 
* @returns {any} Returns a string or array containing the sliced portion, or undefined if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');
const makeNumber = require('makeNumber');

const slice = function(searchData, start, end) {
   const startNum = makeNumber(start);
   if (searchData == null || startNum !== startNum) { return undefined; }
   if (!(getType(searchData) === 'array' || getType(searchData) === 'string')) { 
       return undefined;
   }
   const endNum = end === undefined ? searchData.length : makeNumber(end);
   return searchData.slice(startNum, endNum);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// slice - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(slice(value, data.sta, data.end));
*/
// ===============================================================================
// slice(...) – Apply Mode
// ===============================================================================
return function(value, start, end) {
   start = data.rp1 ? data.sta : start;
   end = data.rp2 ? data.end : end;
   return out(slice(value, start, end));
};


___TESTS___

scenarios:
  - name: '[example] Extract substring'
    code: |-
      /* @display
      Value to Process: Hello World
      Start Index: 0
      End Index: 5
      @output
      Hello
      */
      const src = "Hello World";
      const sta = 0;
      const end = 5;
      const mockData = {
          src: src,
          sta: sta,
          end: end,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sta, end);
      }
      assertThat(variableResult).isEqualTo("Hello");
  - name: Array slice with start and end - returns subarray
    code: |-
      const src = [1, 2, 3, 4, 5];
      const sta = 1;
      const end = 4;
      const mockData = {
          src: src,
          sta: sta,
          end: end,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sta, end);
      }
      assertThat(variableResult).isEqualTo([2, 3, 4]);
  - name: String slice with only start - slices to end
    code: |-
      const src = "Testing";
      const sta = 2;
      const end = undefined;
      const mockData = {
          src: src,
          sta: sta,
          end: end,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sta, end);
      }
      assertThat(variableResult).isEqualTo("sting");
  - name: '[example] Negative index slices from end'
    code: |
      /* @display
      Value to Process: abcdef
      Start Index: -3
      End Index: undefined
      @output
      def
      */
      const src = "abcdef";
      const sta = -3;
      const end = undefined;
      const mockData = {
          src: src,
          sta: sta,
          end: end,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sta, end);
      }
      assertThat(variableResult).isEqualTo("def");
  - name: Invalid input - returns undefined
    code: |-
      const src = 12345;
      const sta = 0;
      const end = 2;
      const mockData = {
          src: src,
          sta: sta,
          end: end,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sta, end);
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
