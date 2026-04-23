___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "toJsonString",
  "description": "Converts the input into a \u003cem\u003eJSON string\u003c/em\u003e. If the value cannot be parsed, the method will return \u003cem\u003eundefined\u003c/em\u003e.",
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
        "name": "inp",
        "displayName": "Input Value",
        "simpleValueType": true,
        "help": "💾   The JavaScript object or value to convert to JSON."
      }
    ],
    "help": "Converts the input into a JSON \u003cem\u003estring\u003c/em\u003e. If the value cannot be parsed, returns \u003cem\u003eundefined\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eObject to JSON\u003c/em\u003e***\u003cbr\u003einp: \u003cstrong\u003e{name: \"John\", age: 30}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{\"name\":\"John\",\"age\":30}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eArray to JSON\u003c/em\u003e***\u003cbr\u003einp: \u003cstrong\u003e[1, 2, 3, \"test\"]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[1,2,3,\"test\"]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString to JSON\u003c/em\u003e***\u003cbr\u003einp: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\"hello\"\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., clean object properties, add metadata). Internal transformations will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.replace(/\"/g, \"'\") for quote replacement, str =\u003e btoa(str) for base64 encoding). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Converts a JavaScript object or value into a JSON string.
 *
 * @param {any} data.inp - The JavaScript object or value to be converted into a JSON string.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform inp before conversion.
 * 
 * @returns {string|undefined} A JSON string representation of the input value. Returns undefined if the value cannot be parsed (e.g. the object has a cycle).
 *
 * @framework ggLowCodeGTMKit
 */

const JSON = require('JSON');

const toJsonString = function(input) {
    return JSON.stringify(input);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// toJsonString - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedInput = applyCast(data.pre, data.inp);
return out(toJsonString(processedInput));
// ===============================================================================
// toJsonString() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(toJsonString(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Object to JSON'
    code: |-
      /* @display
      Input Value: {name: "John", age: 30}
      @output
      {"name":"John","age":30}
      */
      const inp = {name: "John", age: 30};
      const mockData = {
          inp: inp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(inp);
      }
      assertThat(variableResult).isEqualTo('{"name":"John","age":30}');
  - name: '[example] Array to JSON'
    code: |-
      /* @display
      Input Value: [1, 2, 3, "test"]
      @output
      [1,2,3,"test"]
      */
      const inp = [1, 2, 3, "test"];
      const mockData = {
          inp: inp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(inp);
      }
      assertThat(variableResult).isEqualTo('[1,2,3,"test"]');
  - name: '[example] String to JSON'
    code: |-
      /* @display
      Input Value: hello
      @output
      "hello"
      */
      const inp = "hello";
      const mockData = {
          inp: inp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(inp);
      }
      assertThat(variableResult).isEqualTo('"hello"');
  - name: Number value - converts to JSON string
    code: |-
      const inp = 42;
      const mockData = {
          inp: inp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(inp);
      }
      assertThat(variableResult).isEqualTo('42');
  - name: Nested object - converts complex structure to JSON string
    code: |-
      const inp = {user: {profile: {name: "Alice", tags: ["admin", "user"]}}};
      const mockData = {
          inp: inp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(inp);
      }
      assertThat(variableResult).isEqualTo('{"user":{"profile":{"name":"Alice","tags":["admin","user"]}}}');
  - name: Object with function property - function is omitted from JSON
    code: |-
      const inp = {name: "John", getName: function(val) { return val.name; }};
      const mockData = {
          inp: inp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(inp);
      }
      assertThat(variableResult).isEqualTo('{"name":"John"}');
  - name: Undefined as standalone value - returns undefined
    code: |-
      const inp = undefined;
      const mockData = {
          inp: inp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(inp);
      }
      assertThat(variableResult).isUndefined();
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
