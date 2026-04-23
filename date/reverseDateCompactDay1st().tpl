___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "reverseDateCompactDay1st()",
  "description": "Reverse a compact date \u003cem\u003estring\u003c/em\u003e from \"ddmmyyyy\" to \"yyyymmdd\" format with no separators.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReverse ddmmyyyy to yyyymmdd\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e25122024\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e20241225\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid length returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e2512202\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Compact Date String"
      }
    ],
    "help": "Reverses a compact date string from \"ddmmyyyy\" to \"yyyymmdd\" format.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReverse ddmmyyyy to yyyymmdd\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e25122024\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e20241225\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid length returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e2512202\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., date =\u003e date.substring(0,4) for year only, val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Reverse a compact date string from "ddmmyyyy" to "yyyymmdd".
* 
* @param {string} data.src - The compact date string with no separators, starting with day.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before reversing.
* 
* @returns {string|undefined} The reversed date string, or undefined if the input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const reverseDateCompactDay1st = function(date) {
   if (typeof date !== 'string' || date.length !== 8) { return undefined; }
   const day = date.substring(0, 2);
   const month = date.substring(2, 4);
   const year = date.substring(4, 8);
   return year + month + day;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// reverseDateCompactDay1st - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(reverseDateCompactDay1st(value));
*/
// ===============================================================================
// reverseDateCompactDay1st() – Apply Mode
// ===============================================================================
return function(value) {
  return out(reverseDateCompactDay1st(value));
};


___TESTS___

scenarios:
  - name: '[example] Reverse ddmmyyyy to yyyymmdd'
    code: |-
      /* @display
      Value to Process: 25122024
      @output
      20241225
      */
      const src = "25122024";
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
      assertThat(variableResult).isEqualTo("20241225");
  - name: Valid date with leading zeros - reverses correctly
    code: |-
      const src = "01012025";
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
      assertThat(variableResult).isEqualTo("20250101");
  - name: Valid date end of year - reverses correctly
    code: |-
      const src = "31121999";
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
      assertThat(variableResult).isEqualTo("19991231");
  - name: '[example] Invalid length returns undefined'
    code: |-
      /* @display
      Value to Process: 2512202
      @output
      undefined
      */
      const src = "2512202";
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
      assertThat(variableResult).isUndefined();
  - name: Non-string input - returns undefined
    code: |-
      const src = 25122024;
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
