___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "apply",
  "description": "Applies a \u003cem\u003efunction\u003c/em\u003e to the input value and returns the result. Returns \u003cem\u003eundefined\u003c/em\u003e if the \u003cem\u003efunction\u003c/em\u003e is not valid.",
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
        "displayName": "Input Value",
        "simpleValueType": true,
        "help": "💾   The value that will be passed to the function.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "fnc",
        "displayName": "Function",
        "simpleValueType": true,
        "help": "⚙️   The function that will be applied to the input value.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eFunction\u003c/strong\u003e"
      }
    ],
    "help": "Applies a function to a value and returns the result.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eApply function to number\u003c/em\u003e***\u003cbr\u003eInput Value: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003eFunction: \u003cstrong\u003ex =\u003e x * 2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e20\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid function returns undefined\u003c/em\u003e***\u003cbr\u003eInput Value: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003eFunction: \u003cstrong\u003enot a function\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
* Applies a function to the input value and returns the result.
* 
* @param {*} data.src - The value that will be passed to the function.
* @param {function} data.fnc - The function that will be applied to the input value.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
* 
* @returns {*} The result of applying the function to the input value, or undefined if the function is not provided or not a valid function.
*
* @framework ggLowCodeGTMKit
*/
const apply = function(input, func) {
  if (typeof func !== 'function') { return undefined; }
  return func(input);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// apply - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedInput = applyCast(data.pre, data.src);
return out(apply(processedInput, data.fnc));


___TESTS___

scenarios:
  - name: '[example] Apply function to number'
    code: |-
      /* @display
      Input Value: 10
      Function: x => x * 2
      @output
      20
      */
      const src = 10;
      const fnc = x => x * 2;
      const mockData = {
          src: src,
          fnc: fnc,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc);
      }
      assertThat(variableResult).isEqualTo(20);
  - name: Valid function applied to string - returns transformed string
    code: |-
      const src = "hello";
      const fnc = str => str.toUpperCase();
      const mockData = {
          src: src,
          fnc: fnc,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc);
      }
      assertThat(variableResult).isEqualTo("HELLO");
  - name: Valid function applied to array - returns array length
    code: |-
      const src = [1, 2, 3, 4, 5];
      const fnc = arr => arr.length;
      const mockData = {
          src: src,
          fnc: fnc,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc);
      }
      assertThat(variableResult).isEqualTo(5);
  - name: '[example] Invalid function returns undefined'
    code: |-
      /* @display
      Input Value: 42
      Function: not a function
      @output
      undefined
      */
      const src = 42;
      const fnc = "not a function";
      const mockData = {
          src: src,
          fnc: fnc,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc);
      }
      assertThat(variableResult).isUndefined();
  - name: Undefined function - returns undefined
    code: |-
      const src = 100;
      const fnc = undefined;
      const mockData = {
          src: src,
          fnc: fnc,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, fnc);
      }
      assertThat(variableResult).isUndefined();
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
