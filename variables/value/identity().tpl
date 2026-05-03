___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "identity()",
  "description": "Returns the source value as-is, acting as a passthrough function. Useful for applying output transformations or in pipelines where you need to preserve the original value.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString passthrough\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNumber passthrough\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Value"
      }
    ],
    "help": "Returns the input value unchanged. Useful as a passthrough function.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString passthrough\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNumber passthrough\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., val =\u003e typeof val, val =\u003e JSON.stringify(val) for string conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Returns the source value as-is.
* 
* @param {*} data.src - The input value to return.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before returning.
* 
* @returns {*} Returns the input src, optionally transformed by out.
*
* @framework ggLowCodeGTMKit
*/
const identity = function(value) {
   return value;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// identity - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(identity(value));
*/
// ===============================================================================
// identity() – Apply Mode
// ===============================================================================
return function(value) {
  return out(identity(value));
};


___TESTS___

scenarios:
  - name: '[example] String passthrough'
    code: |-
      /* @display
      Value to Process: hello world
      @output
      hello world
      */
      const src = 'hello world';
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
      assertThat(variableResult).isEqualTo('hello world');
  - name: '[example] Number passthrough'
    code: |-
      /* @display
      Value to Process: 42
      @output
      42
      */
      const src = 42;
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
  - name: Object input - should return unchanged
    code: |-
      const src = {name: 'John', age: 30};
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
      assertThat(variableResult).isEqualTo({name: 'John', age: 30});
  - name: Boolean input - should return unchanged
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
      assertThat(variableResult).isTrue();
  - name: Null input - should return null
    code: |
      const src = null;
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
      assertThat(variableResult).isNull();
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
