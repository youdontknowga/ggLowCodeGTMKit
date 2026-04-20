___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "trim()",
  "description": "Trims any leading or trailing whitespace from a valid \u003cem\u003estring\u003c/em\u003e and handles edge cases by returning an empty string\u003cem\u003e\"\"\u003c/em\u003e when the input is not a valid \u003cem\u003estring\u003c/em\u003e.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTrim leading and trailing spaces\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e  hello   world  \u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello   world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOnly spaces returns empty string\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e     \u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string returns empty string\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e123\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String To Process"
      }
    ],
    "help": "Trims any leading or trailing whitespace from a valid \u003cem\u003estring\u003c/em\u003e. Returns an empty string when the input is not a valid string.\u003cbr\u003e_____________________________________________\u003cbr\u003e✏️ \u003cem\u003eTrim whitespace\u003c/em\u003e\u003cbr\u003e\u003cbr\u003eInput: \u003cstrong\u003e\"   Hello World   \"\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\"Hello World\"\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTrim leading and trailing spaces\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello   world\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello   world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOnly spaces returns empty string\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string returns empty string\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e123\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toUpperCase(), val =\u003e val + ' trimmed' for string modifications). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Trims whitespace from both ends of a string.
* 
* @param {any} data.src - The value to be converted to a string.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before trimming.
* 
* @returns {string} The string representation of the input with whitespace trimmed, or an empty string.
*
* @framework ggLowCodeGTMKit
*/
const trim = function(string) {
   return typeof string === 'string' ? string.trim() : "";
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// trim - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(trim(value));
*/
// ===============================================================================
// trim() – Apply Mode
// ===============================================================================
return function(value) {
  return out(trim(value));
};


___TESTS___

scenarios:
  - name: Trim both ends
    code: |-
      const src = '  hello world  ';
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
  - name: String with only leading spaces - should trim start
    code: |-
      const src = '   hello';
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
      assertThat(variableResult).isEqualTo('hello');
  - name: String with only trailing spaces - should trim end
    code: |-
      const src = 'hello   ';
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
      assertThat(variableResult).isEqualTo('hello');
  - name: String with no whitespace - should return same string
    code: |-
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
      assertThat(variableResult).isEqualTo('hello');
  - name: '[example] Trim leading and trailing spaces'
    code: |-
      /* @display
      Value to Process:   hello   world  
      @output
      hello   world
      */
      const src = '  hello   world  ';
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
      assertThat(variableResult).isEqualTo('hello   world');
  - name: '[example] Only spaces returns empty string'
    code: |-
      /* @display
      Value to Process:      
      */
      const src = '     ';
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
  - name: Trim tabs and newlines
    code: |-
      const src = '\t\nhello\t\n';
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
      assertThat(variableResult).isEqualTo('hello');
  - name: '[example] Non-string returns empty string'
    code: |-
      /* @display
      Value to Process: 123
      */
      const src = 123;
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
  - name: Non-string input (null) - should return empty string
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
      assertThat(variableResult).isEqualTo('');
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
