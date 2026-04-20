___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "countDigits()",
  "description": "Returns the number of digits in the provided \u003cem\u003enumber\u003c/em\u003e. Useful for evaluating the length of numeric values.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSingle digit returns 1\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCount digits in large number\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e123456\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e6\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Number To Count"
      }
    ],
    "help": "Returns the number of digits in the provided \u003cem\u003enumber\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSingle digit returns 1\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCount digits in large number\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e123456\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e6\u003c/strong\u003e"
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
* Converts input data to a number and returns the number of digits.
* 
* @param {number|string} data.src - A value that will be converted to a number.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before counting.
* 
* @returns {number} The count of digits in the converted number.
*
* @framework ggLowCodeGTMKit
*/
const Math = require('Math');
const makeNumber = require('makeNumber');

const countDigits = function(number) {
   let num = makeNumber(number);
   if (num !== num) { return undefined; } // NaN check
   let count = 1;
   while (num >= 10) {
       num = Math.floor(num / 10);
       count++;
   }
   return count;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// countDigits - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(countDigits(value));
*/
// ===============================================================================
// countDigits() – Apply Mode
// ===============================================================================
return function(value) {
  return out(countDigits(value));
};


___TESTS___

scenarios:
  - name: '[example] Single digit returns 1'
    code: |-
      /* @display
      Value to Process: 5
      @output
      1
      */
      const src = 5;
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
      assertThat(variableResult).isEqualTo(1);
  - name: Two digit number - returns 2
    code: |-
      const src = 42;
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
      assertThat(variableResult).isEqualTo(2);
  - name: '[example] Count digits in large number'
    code: |-
      /* @display
      Value to Process: 123456
      @output
      6
      */
      const src = 123456;
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
      assertThat(variableResult).isEqualTo(6);
  - name: String number - converts and counts digits
    code: |-
      const src = "9876";
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
      assertThat(variableResult).isEqualTo(4);
  - name: Decimal number - counts digits before decimal point
    code: |-
      const src = 123.456;
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
      assertThat(variableResult).isEqualTo(3);
  - name: Invalid input - returns undefined
    code: |-
      const src = "not a number";
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
