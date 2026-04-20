___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "applyChain",
  "description": "Applies a list of functions sequentially to an input value, where each \u003cem\u003efunction\u003c/em\u003e receives the result of the previous \u003cem\u003efunction\u003c/em\u003e as its input.",
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
        "help": "💾   The initial value to which the functions will be applied.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e"
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "lst",
        "displayName": "Functions",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Functions List to Apply in Chain",
            "name": "func",
            "type": "TEXT"
          }
        ]
      }
    ],
    "help": "Applies a chain of functions sequentially to a value.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSingle function chain\u003c/em\u003e***\u003cbr\u003eInput Value: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003elst: \u003cstrong\u003e[{func: x =\u003e x * 2}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e20\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMultiple function chain\u003c/em\u003e***\u003cbr\u003eInput Value: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003elst: \u003cstrong\u003e[{func: x =\u003e x * 2}, {func: x =\u003e x + 10}, {func: x =\u003e x / 5}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e4\u003c/strong\u003e"
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Applies a list of functions sequentially to an input value.
* 
* @param {*} data.src - The initial value to which the functions will be applied.
* @param {Array} data.lst - An array of function objects to be applied sequentially.
* 
* @returns {*} The result after all functions have been applied to the input.
*
* @framework ggLowCodeGTMKit
*/

const applyChain = function(input, functionList) {
   return functionList.reduce((acc, fnObj) => {
       if (typeof fnObj.func === 'function') {
           return fnObj.func(acc);
       }
       return acc;
   }, input);
};

// ===============================================================================
// applyChain - Direct mode only
// ===============================================================================
return applyChain(data.src, data.lst);

// ===============================================================================
// applyChain(...) – Apply Mode
// ===============================================================================
/*
return function(input) {
   return applyChain(input, data.lst) ;
};
*/


___TESTS___

scenarios:
  - name: '[example] Single function chain'
    code: |-
      /* @display
      Input Value: 10
      Functions: [{func: x => x * 2}]
      @output
      20
      */
      const src = 10;
      const lst = [{func: x => x * 2}];
      const mockData = {
          src: src,
          lst: lst
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(20);
  - name: '[example] Multiple function chain'
    code: |-
      /* @display
      Input Value: 5
      Functions: [{func: x => x * 2}, {func: x => x + 10}, {func: x => x / 5}]
      @output
      4
      */
      const src = 5;
      const lst = [{func: x => x * 2}, {func: x => x + 10}, {func: x => x / 5}];
      const mockData = {
          src: src,
          lst: lst
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(4);
  - name: Empty function list returns original value
    code: |-
      const src = "hello";
      const lst = [];
      const mockData = {
          src: src,
          lst: lst
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("hello");
  - name: Function list with invalid function object - skips invalid and continues
    code: |-
      const src = 100;
      const lst = [{func: x => x - 50}, {func: "not a function"}, {func: x => x * 2}];
      const mockData = {
          src: src,
          lst: lst
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(100);
  - name: String transformation chain - applies string operations
    code: |-
      const src = "  HELLO  ";
      const lst = [{func: x => x.trim()}, {func: x => x.toLowerCase()}, {func: x => x + " world"}];
      const mockData = {
          src: src,
          lst: lst
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("hello world");
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
