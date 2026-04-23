___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "toNumber",
  "description": "Converts the input into a \u003cem\u003enumber\u003c/em\u003e, or returns \u003cem\u003eNaN\u003c/em\u003e if the input cannot be converted.",
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
        "displayName": "Value To Convert",
        "simpleValueType": true,
        "help": "💾   The value to be converted into a number.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e"
      }
    ],
    "help": "Converts the input into a \u003cem\u003enumber\u003c/em\u003e, or returns \u003cem\u003eNaN\u003c/em\u003e if the input cannot be converted.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString to number\u003c/em\u003e***\u003cbr\u003eValue To Convert: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDecimal string to number\u003c/em\u003e***\u003cbr\u003eValue To Convert: \u003cstrong\u003e3.14\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3.14\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-numeric returns NaN\u003c/em\u003e***\u003cbr\u003eValue To Convert: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert object to string, normalize case). Internal transformations such as case handling will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str + ' €', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Converts the input into a number.
* 
* @param {any} data.src - The value to be converted into a number.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {number} The converted number, or NaN if the input cannot be converted.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const toNumber = function(input) {
   return makeNumber(input);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// toNumber - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(toNumber(value));

// ===============================================================================
// toNumber() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(toNumber(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] String to number'
    code: |-
      /* @display
      Value To Convert: 42
      @output
      42
      */
      const src = '42';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(42);
  - name: '[example] Decimal string to number'
    code: |-
      /* @display
      Value To Convert: 3.14
      @output
      3.14
      */
      const src = '3.14';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(3.14);
  - name: Already a number - should return unchanged
    code: |-
      const src = 100;
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(100);
  - name: Boolean true - should convert to 1
    code: |-
      const src = true;
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(1);
  - name: '[example] Non-numeric returns NaN'
    code: |-
      /* @display
      Value To Convert: hello
      */
      const src = 'hello';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isNaN();
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
