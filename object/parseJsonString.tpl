___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "parseJsonString",
  "description": "Takes a JSON string as input and returns the corresponding JavaScript \u003cem\u003eobject\u003c/em\u003e or value. Return \u003cem\u003eundefined\u003c/em\u003e if the \u003cem\u003estring\u003c/em\u003e is not a valid JSON format.",
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
        "displayName": "JSON String",
        "simpleValueType": true,
        "help": "💾   The JSON string to parse into an object."
      }
    ],
    "help": "Parses a JSON string into a JavaScript value.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse JSON object\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{\"name\": \"John\", \"age\": 30}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParse JSON array\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[1, 2, 3, \"test\"]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e4\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the JSON string before internal logic (e.g., trim whitespace, replace characters). Internal transformations will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., obj =\u003e obj.data for nested extraction, obj =\u003e Object.keys(obj) for keys only). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Parses the provided JSON string into a JavaScript object.
 *
 * @param {string} data.src - The JSON string that needs to be parsed into an object.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform inp before parsing.
 * 
 * @returns {any|undefined} Returns the JavaScript object or value parsed from the JSON string, undefined if the string is not a valid JSON.
 *
 * @framework ggLowCodeGTMKit
 */

const JSON = require('JSON');
const parseJsonString = function(input) {
   if (input == null || input == "undefined" || input == "null" || input === "" || typeof input === "function") return undefined;
    return JSON.parse(input);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// parseJsonString - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedInput = applyCast(data.pre, data.src);
return out(parseJsonString(processedInput));

// ===============================================================================
// parseJsonString() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(parseJsonString(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Parse JSON object'
    code: |-
      /* @display
      Value to Process: {"name": "John", "age": 30}
      @output
      John
      */
      const src = '{"name": "John", "age": 30}';
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
      assertThat(variableResult.name).isEqualTo("John");
  - name: '[example] Parse JSON array'
    code: |-
      /* @display
      Value to Process: [1, 2, 3, "test"]
      @output
      4
      */
      const src = '[1, 2, 3, "test"]';
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
      assertThat(variableResult.length).isEqualTo(4);
  - name: Valid JSON string
    code: |-
      const src = '"hello world"';
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
      assertThat(variableResult).isEqualTo("hello world");
  - name: Valid JSON number
    code: |-
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
  - name: Valid JSON boolean
    code: |-
      const src = 'true';
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
  - name: Invalid JSON syntax - should return undefined
    code: |-
      const src = '{name: "John"}';
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
      assertThat(variableResult).isUndefined();
  - name: Empty string - should return undefined
    code: |-
      const src = "";
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
      assertThat(variableResult).isUndefined();
  - name: Null - should return undefined
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
      assertThat(variableResult).isUndefined();
  - name: Stringified undefined - should return undefined
    code: |-
      const src =  "undefined";
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
      assertThat(variableResult).isUndefined();
  - name: Stringified null - should return undefined
    code: |-
      const src =  "null";
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
      assertThat(variableResult).isUndefined();
  - name: Function - should return undefined
    code: |-
      const src = function(){return 4;};
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
      assertThat(variableResult).isUndefined();
  - name: Valid number
    code: |-
      const src = 44;
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
      assertThat(variableResult).isEqualTo(44);
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
