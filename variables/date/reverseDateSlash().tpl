___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "reverseDateSlash()",
  "description": "Reverse a date \u003cem\u003estring\u003c/em\u003e between \"dd/mm/yyyy\" and \"yyyy/mm/dd\" formats using slash separators.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReverse dd/mm/yyyy\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e25/12/2024\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e2024/12/25\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReverse yyyy/mm/dd\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e2025/01/01\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e01/01/2025\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Date String"
      }
    ],
    "help": "Reverses a date string between \"dd/mm/yyyy\" and \"yyyy/mm/dd\" formats.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReverse dd/mm/yyyy\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e25/12/2024\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e2024/12/25\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReverse yyyy/mm/dd\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e2025/01/01\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e01/01/2025\u003c/strong\u003e"
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
* Reverse a date string between "dd/mm/yyyy" and "yyyy/mm/dd" formats.
* 
* @param {string} data.src - The date string to reverse, using slash separators.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before reversing.
* 
* @returns {string|undefined} The reversed date string, or undefined if the input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const reverseDateSlash = function(date) {
   if (typeof date === 'string') {
       const parts = date.split('/');
       if (parts.length === 3) {
           return parts.reverse().join('/');
       }
   }
   return undefined;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// reverseDateSlash - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(reverseDateSlash(value));
*/
// ===============================================================================
// reverseDateSlash() – Apply Mode
// ===============================================================================
return function(value) {
  return out(reverseDateSlash(value));
};


___TESTS___

scenarios:
  - name: '[example] Reverse dd/mm/yyyy'
    code: |-
      /* @display
      Value to Process: 25/12/2024
      @output
      2024/12/25
      */
      const src = "25/12/2024";
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
      assertThat(variableResult).isEqualTo("2024/12/25");
  - name: '[example] Reverse yyyy/mm/dd'
    code: |-
      /* @display
      Value to Process: 2025/01/01
      @output
      01/01/2025
      */
      const src = "2025/01/01";
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
      assertThat(variableResult).isEqualTo("01/01/2025");
  - name: Valid date with leading zeros - reverses correctly
    code: |-
      const src = "05/03/1999";
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
      assertThat(variableResult).isEqualTo("1999/03/05");
  - name: Invalid format without slashes - returns undefined
    code: |
      const src = "2024-12-25";
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
  - name: Invalid format with wrong number of parts - returns undefined
    code: |-
      const src = "25/12";
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
