___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "wrapInArray",
  "description": "Wraps the provided input into a new \u003cem\u003earray\u003c/em\u003e and returns the \u003cem\u003earray\u003c/em\u003e with the input as the only element.",
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
        "displayName": "Value To Wrap",
        "simpleValueType": true,
        "help": "💾   The value to be wrapped into an array."
      }
    ],
    "help": "Wraps the provided input into a new \u003cem\u003earray\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eWrap string\u003c/em\u003e***\u003cbr\u003eValue To Wrap: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\"hello\"]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eWrap number\u003c/em\u003e***\u003cbr\u003eValue To Wrap: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[42]\u003c/strong\u003e"
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
* Wraps the provided input into a new array and returns the array.
* 
* @param {any} data.src - The value to be wrapped into the array.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before wrapping.
* 
* @returns {Array} The new array containing the input value as the only element.
*
* @framework ggLowCodeGTMKit
*/
const wrapInArray = function(input) {
   const result = [];
   result.push(input);
   return result;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// wrapInArray - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(wrapInArray(value));

// ===============================================================================
// wrapInArray() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(wrapInArray(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Wrap string'
    code: |-
      /* @display
      Value To Wrap: hello
      @output
      ["hello"]
      */
      const src = "hello";
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
      assertThat(variableResult).isEqualTo(["hello"]);
  - name: '[example] Wrap number'
    code: |-
      /* @display
      Value To Wrap: 42
      @output
      [42]
      */
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
      assertThat(variableResult).isEqualTo([42]);
  - name: Object value - wraps in array
    code: |-
      const src = {name: "John", age: 30};
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
      assertThat(variableResult).isEqualTo([{name: "John", age: 30}]);
  - name: Null value - wraps null in array
    code: |-
      const src = null;
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
      assertThat(variableResult).isEqualTo([null]);
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
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
