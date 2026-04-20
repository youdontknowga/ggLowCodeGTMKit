___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "toUpperFirst()",
  "description": "Converts the first character of a \u003cem\u003estring\u003c/em\u003e to uppercase and leaves the rest of the \u003cem\u003estring\u003c/em\u003e unchanged.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCapitalize first letter\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAlready capitalized\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSingle character\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ea\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eA\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String To Convert"
      }
    ],
    "help": "Converts the first character of a \u003cem\u003estring\u003c/em\u003e to uppercase and leaves the rest unchanged.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCapitalize first letter\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAlready capitalized\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSingle character\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ea\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eA\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toUpperCase(), str =\u003e str + '!' for string modifications). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Converts the first character of a string to uppercase and leaves the rest of the string unchanged.
 *
 * @param {string} data.src - The string to modify.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {string} The string with the first character converted to uppercase.
 *
 * @framework ggLowCodeGTMKit
 */

const toUpperFirst = function(string) {
    if (typeof string !== 'string' || string.length === 0) {
        return "";
    }
    return string.charAt(0).toUpperCase() + string.slice(1);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// toUpperFirst - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(toUpperFirst(value));
*/
// ===============================================================================
// toUpperFirst() – Apply Mode
// ===============================================================================
return function(value) {
   return out(toUpperFirst(value));
};


___TESTS___

scenarios:
  - name: '[example] Capitalize first letter'
    code: |-
      /* @display
      Value to Process: hello world
      @output
      Hello world
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
      assertThat(variableResult).isEqualTo('Hello world');
  - name: '[example] Already capitalized'
    code: |-
      /* @display
      Value to Process: Hello World
      @output
      Hello World
      */
      const src = 'Hello World';
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
      assertThat(variableResult).isEqualTo('Hello World');
  - name: All uppercase - should return unchanged
    code: |-
      const src = 'HELLO';
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
      assertThat(variableResult).isEqualTo('HELLO');
  - name: '[example] Single character'
    code: |-
      /* @display
      Value to Process: a
      @output
      A
      */
      const src = 'a';
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
      assertThat(variableResult).isEqualTo('A');
  - name: Empty string - should return empty string
    code: |-
      const src = '';
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
      assertThat(variableResult).isEqualTo('');
  - name: Object input - should return empty string
    code: |-
      const src = {name: 'test'};
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
      assertThat(variableResult).isEqualTo('');
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
