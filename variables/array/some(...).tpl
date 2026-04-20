___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "some(...)",
  "description": "Returns true if at least one item in the \u003cem\u003earray\u003c/em\u003e satisfies the given predicate function. Returns false if no items pass or input is invalid.",
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
        "help": "💾   A predicate function that receives each value and returns true or false.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eFunction\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSome match predicate\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: [1, 2, 3, 4, 5]\u003cbr\u003ePredicate Function: function(x) { return x \u003e 3\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNone match predicate\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: [1, 2, 3]\u003cbr\u003ePredicate Function: function(x) { return x \u003e 10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
    "help": "Returns \u003cem\u003etrue\u003c/em\u003e if at least one item in the \u003cem\u003earray\u003c/em\u003e satisfies the given predicate function.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSome match predicate\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003ePredicate Function: \u003cstrong\u003efunction(x) { return x \u003e 3; }\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNone match predicate\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[1, 2, 3]\u003c/strong\u003e\u003cbr\u003ePredicate Function: \u003cstrong\u003efunction(x) { return x \u003e 10; }\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
* Returns true if at least one item in the array satisfies the given predicate function.
* 
* @param {Array} data.src - The array of values to test.
* @param {Function} data.prd - A predicate function that receives each value and returns true or false.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before testing.
* 
* @returns {boolean} True if at least one value passes the predicate, false otherwise or if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');

const some = function(arr, predicate) {
   if (getType(arr) !== 'array' || typeof predicate !== 'function') {
       return false;
   }
   return arr.some(predicate);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// some - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(some(value, data.prd));
*/
// ===============================================================================
// some(...) – Apply Mode
// ===============================================================================
return function(value, predicate) {
   predicate = data.rp1 ? data.prd : predicate;
   return out(some(value, predicate));
};


___TESTS___

scenarios:
  - name: '[example] Some match predicate'
    code: |-
      /* @display
      Value to Process: [1, 2, 3, 4, 5]
      Predicate Function: function(x) { return x > 3; }
      @output
      true
      */
      const src = [1, 2, 3, 4, 5];
      const prd = function(x) { return x > 3; };
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
  - name: '[example] None match predicate'
    code: |-
      /* @display
      Value to Process: [1, 2, 3]
      Predicate Function: function(x) { return x > 10; }
      @output
      false
      */
      const src = [1, 2, 3];
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
      assertThat(variableResult).isFalse();
  - name: Array with strings matching predicate - returns true
    code: |-
      const src = ["apple", "banana", "cherry"];
      const prd = function(x) { return x === "banana"; };
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
  - name: Empty array - returns false
    code: |-
      const src = [];
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
  - name: Non-array input - returns false
    code: |-
      const src = "not an array";
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
