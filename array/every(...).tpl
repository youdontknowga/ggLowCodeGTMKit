___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "every(...)",
  "description": "Returns true if \u003cstrong\u003eevery\u003c/strong\u003e item in the input \u003cem\u003earray\u003c/em\u003e satisfies the given predicate \u003cem\u003efunction\u003c/em\u003e. Returns \u003cem\u003efalse\u003c/em\u003e if any item fails or input is invalid.",
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
        "name": "prd",
        "displayName": "Predicate Function",
        "simpleValueType": true,
        "help": "⚖️   A predicate function that receives each value and returns true or false.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eFunction\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAll match predicate\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: [2, 4, 6, 8]\u003cbr\u003ePredicate Function: function(x) { return x % 2 === 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNot all match\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: [2, 4, 5, 8]\u003cbr\u003ePredicate Function: function(x) { return x % 2 === 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Array To Test"
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
            "checkboxText": "⚡Use runtime parameter for: Predicate Function",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Returns true if \u003cstrong\u003eevery\u003c/strong\u003e item in the input \u003cem\u003earray\u003c/em\u003e satisfies the given predicate \u003cem\u003efunction\u003c/em\u003e. Returns \u003cem\u003efalse\u003c/em\u003e if any item fails or input is invalid.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAll match predicate\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[2, 4, 6, 8]\u003c/strong\u003e\u003cbr\u003ePredicate Function: \u003cstrong\u003efunction(x) { return x % 2 === 0; }\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNot all match\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[2, 4, 5, 8]\u003c/strong\u003e\u003cbr\u003ePredicate Function: \u003cstrong\u003efunction(x) { return x % 2 === 0; }\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., bool =\u003e bool ? 'all pass' : 'some fail', val =\u003e !val for negation). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Returns true if every item in the input array satisfies the given predicate function.
* 
* @param {Array} data.src - The array of values to evaluate.
* @param {Function} data.prd - A predicate function that receives each value and returns true or false.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before evaluation.
* 
* @returns {boolean} True if all values pass the predicate, false otherwise or if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');
const every = function(arr, predicate) {
   if (getType(arr) !== 'array' || typeof predicate !== 'function') {
       return false;
   }
   return arr.every(predicate);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// every - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(every(value, data.prd));
*/
// ===============================================================================
// every(...) – Apply Mode
// ===============================================================================
return function(value, predicate) {
  predicate = data.rp1 ? data.prd : predicate;
  return out(every(value, predicate));
};


___TESTS___

scenarios:
  - name: '[example] All match predicate'
    code: |-
      /* @display
      Value to Process: [2, 4, 6, 8]
      Predicate Function: function(x) { return x % 2 === 0; }
      @output
      true
      */
      const src = [2, 4, 6, 8];
      const prd = function(x) { return x % 2 === 0; };
      const mockData = {
          src: src,
          prd: prd,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prd);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] Not all match'
    code: |-
      /* @display
      Value to Process: [2, 4, 5, 8]
      Predicate Function: function(x) { return x % 2 === 0; }
      @output
      false
      */
      const src = [2, 4, 5, 8];
      const prd = function(x) { return x % 2 === 0; };
      const mockData = {
          src: src,
          prd: prd,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prd);
      }
      assertThat(variableResult).isFalse();
  - name: Empty array - should return true
    code: |-
      const src = [];
      const prd = function(x) { return x > 10; };
      const mockData = {
          src: src,
          prd: prd,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prd);
      }
      assertThat(variableResult).isTrue();
      assertThat(variableResult).isNotEqualTo(undefined);
  - name: All strings pass length check - should return true
    code: |-
      const src = ['hello', 'world', 'test'];
      const prd = function(s) { return s.length > 3; };
      const mockData = {
          src: src,
          prd: prd,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prd);
      }
      assertThat(variableResult).isTrue();
  - name: Not all strings pass length check - should return false
    code: |-
      const src = ['hello', 'hi', 'world'];
      const prd = function(s) { return s.length > 3; };
      const mockData = {
          src: src,
          prd: prd,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prd);
      }
      assertThat(variableResult).isFalse();
  - name: Non-array input - should return false
    code: |-
      const src = 'not an array';
      const prd = function(x) { return x > 0; };
      const mockData = {
          src: src,
          prd: prd,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prd);
      }
      assertThat(variableResult).isFalse();
  - name: Null input - should return false
    code: |-
      const src = null;
      const prd = function(x) { return x > 0; };
      const mockData = {
          src: src,
          prd: prd,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prd);
      }
      assertThat(variableResult).isFalse();
  - name: Non-function predicate - should return false
    code: |-
      const src = [1, 2, 3];
      const prd = 'not a function';
      const mockData = {
          src: src,
          prd: prd,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prd);
      }
      assertThat(variableResult).isFalse();
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
