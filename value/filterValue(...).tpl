___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "filterValue(...)",
  "description": "Tests a value with a callback \u003cem\u003efunction\u003c/em\u003e. Returns the value if the test passes, \u003cem\u003eundefined\u003c/em\u003e otherwise. Useful for conditional value passing in \u003cem\u003efunction\u003c/em\u003e chains.",
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
        "name": "cbk",
        "displayName": "Test Function",
        "simpleValueType": true,
        "help": "Returns the value if it passes a test function, otherwise returns \u003cem\u003eundefined\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValue passes filter\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 42\u003cbr\u003eTest Function: x =\u003e typeof x === 'number'\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValue fails filter\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello\u003cbr\u003eTest Function: x =\u003e typeof x === 'number'\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValue passes filter\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValue fails filter\u003c/em\u003e***"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Value To Test"
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
            "checkboxText": "⚡Use runtime parameter for: Test Function",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Tests a value with a callback function and returns the value if it passes the test, otherwise returns undefined. Useful for conditional value filtering in function chains.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValue passes filter\u003c/em\u003e***\u003cbr\u003eValue To Test: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003eTest Function: \u003cstrong\u003ex =\u003e typeof x === 'number'\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValue fails filter\u003c/em\u003e***\u003cbr\u003eValue To Test: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003eTest Function: \u003cstrong\u003ex =\u003e typeof x === 'number'\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., x =\u003e x * 2 to double the value, x =\u003e x || 'default' to provide fallback). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Tests a single value using a callback function and returns the value if it passes.
 * 
 * @param {*} data.src - The value to test.
 * @param {Function} data.cbk - A function that receives the value and returns true to keep it, false to reject it.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before testing.
 * 
 * @returns {*|undefined} The original value if the callback returns true, otherwise undefined.
 *
 * @framework ggLowCodeGTMKit
 */
const filterValue = function(value, callback) {
   if (typeof callback !== 'function') {
       return undefined;
   }
   return callback(value) ? value : undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// filterValue - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedValue = applyCast(data.pre, data.src);
return out(filterValue(processedValue, data.cbk));
*/
// ===============================================================================
// filterValue(...) – Apply Mode
// ===============================================================================
return function(value, callback) {
  callback = data.rp1 ? data.cbk : callback;
  return out(filterValue(value, callback));
};


___TESTS___

scenarios:
  - name: '[example] Value passes filter'
    code: |-
      /* @display
      Value to Process: 42
      Test Function: x => typeof x === 'number'
      @output
      42
      */
      const src = 42;
      const cbk = x => typeof x === 'number';
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo(42);
  - name: '[example] Value fails filter'
    code: |
      /* @display
      Value to Process: hello
      Test Function: x => typeof x === 'number'
      @output
      undefined
      */
      const src = 'hello';
      const cbk = x => typeof x === 'number';
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo(undefined);
  - name: Value passes test - greater than threshold
    code: |
      const src = 15;
      const cbk = x => x > 10;
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo(15);
  - name: Undefined value check - passes
    code: |-
      const src = 'value';
      const cbk = x => x !== undefined;
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo('value');
  - name: Undefined value check - fails
    code: |-
      const src = undefined;
      const cbk = x => x !== undefined;
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo(undefined);
  - name: Invalid callback (not a function)
    code: |
      const src = 42;
      const cbk = 'not a function';
      const mockData = {
          src: src,
          cbk: cbk,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, cbk);
      }
      assertThat(variableResult).isEqualTo(undefined);
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
