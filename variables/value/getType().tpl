___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getType()",
  "description": "Returns the type of the given value as a \u003cem\u003estring\u003c/em\u003e (e.g., \"string\", \"number\", \"object\", \"array\", \"boolean\", \"function\", \"null\", \"undefined\").",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString type\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003estring\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNumber type\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003enumber\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eObject type\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eobject\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Value To Check"
      }
    ],
    "help": "Returns the type of the provided value as a \u003cem\u003estring\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString type\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003estring\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNumber type\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003enumber\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eObject type\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{key: 'value'}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eobject\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., type =\u003e type.toUpperCase(), type =\u003e type === 'array' for boolean check). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Returns the type of the given value.
 *
 * @param {any} data.src - The value whose type is to be evaluated.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before checking type.
 * 
 * @returns {string} The type of the value (e.g., "string", "number", "object", "array" etc.).
 *
 * @framework ggLowCodeGTMKit
 */

const getType = require('getType');

const getTypeOf = function(input) {
    return getType(input);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// getTypeOf - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(getTypeOf(value));
*/
// ===============================================================================
// getTypeOf() – Apply Mode
// ===============================================================================
return function(value) {
   return out(getTypeOf(value));
};


___TESTS___

scenarios:
  - name: '[example] String type'
    code: |-
      /* @display
      Value to Process: hello
      @output
      string
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
      assertThat(variableResult).isEqualTo('string');
  - name: '[example] Number type'
    code: |-
      /* @display
      Value to Process: 42
      @output
      number
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
      assertThat(variableResult).isEqualTo('number');
  - name: Boolean type - should return boolean
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
      assertThat(variableResult).isEqualTo('boolean');
  - name: '[example] Object type'
    code: |
      /* @display
      Value to Process: {key: 'value'}
      @output
      object
      */
      const src = {key: 'value'};
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
      assertThat(variableResult).isEqualTo('object');
  - name: Array type - should return array
    code: |-
      const src = [1, 2, 3];
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
      assertThat(variableResult).isEqualTo('array');
  - name: Function type - should return function
    code: |-
      const src = function() { return 42; };
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
      assertThat(variableResult).isEqualTo('function');
  - name: Null type - should return null
    code: |-
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
      assertThat(variableResult).isEqualTo('null');
  - name: Undefined type - should return undefined
    code: |-
      const src = undefined;
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
      assertThat(variableResult).isEqualTo('undefined');
  - name: NaN type - should return number
    code: |-
      const src = 0/0;
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
      assertThat(variableResult).isEqualTo('number');
  - name: Infinity type - should return number
    code: |-
      const src = 1/0;
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
      assertThat(variableResult).isEqualTo('number');
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
