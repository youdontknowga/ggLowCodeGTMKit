___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "reverseDateCompactYear1st()",
  "description": "Reverse a compact date \u003cem\u003estring\u003c/em\u003e from \"yyyymmdd\" to \"ddmmyyyy\" format with no separators.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReverse yyyymmdd to ddmmyyyy\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e20241225\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e25122024\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eLeading zeros handled\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e20250101\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e01012025\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Compact Date String"
      }
    ],
    "help": "Reverse a compact date \u003cem\u003estring\u003c/em\u003e from \"yyyymmdd\" to \"ddmmyyyy\" format with no separators.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReverse yyyymmdd to ddmmyyyy\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e20241225\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e25122024\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eLeading zeros handled\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e20250101\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e01012025\u003c/strong\u003e"
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
* Reverse a compact date string from "yyyymmdd" to "ddmmyyyy".
* 
* @param {string} data.src - The compact date string with no separators, starting with year.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before reversing.
* 
* @returns {string|undefined} The reversed date string, or undefined if the input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const reverseDateCompactYear1st = function(date) {
   if (typeof date !== 'string' || date.length !== 8) { return undefined; }
   const year = date.substring(0, 4);
   const month = date.substring(4, 6);
   const day = date.substring(6, 8);
   return day + month + year;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// reverseDateCompactYear1st - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(reverseDateCompactYear1st(value));
*/
// ===============================================================================
// reverseDateCompactYear1st() – Apply Mode
// ===============================================================================
return function(value) {
  return out(reverseDateCompactYear1st(value));
};


___TESTS___

scenarios:
  - name: '[example] Reverse yyyymmdd to ddmmyyyy'
    code: |
      /* @display
      Value to Process: 20241225
      @output
      25122024
      */
      const src = "20241225";
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
      assertThat(variableResult).isEqualTo("25122024");
  - name: '[example] Leading zeros handled'
    code: |-
      /* @display
      Value to Process: 20250101
      @output
      01012025
      */
      const src = "20250101";
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
      assertThat(variableResult).isEqualTo("01012025");
  - name: Valid date end of year - reverses correctly
    code: |-
      const src = "19991231";
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
      assertThat(variableResult).isEqualTo("31121999");
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
