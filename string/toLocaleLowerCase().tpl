___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "toLocaleLowerCase()",
  "description": "Converts the input value to locale lowercase \u003cem\u003estring\u003c/em\u003e, or returns \u003cem\u003eundefined\u003c/em\u003e if the input is not a valid \u003cem\u003estring\u003c/em\u003e.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSimple uppercase\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eHELLO WORLD\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eLocale-aware lowercase\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eHeLLo WoRLd\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String To Convert"
      }
    ],
    "help": "Converts the input value to locale lowercase \u003cem\u003estring\u003c/em\u003e, or returns \u003cem\u003eundefined\u003c/em\u003e if the input is not a valid string.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSimple uppercase\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eHELLO WORLD\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eLocale-aware lowercase\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eHeLLo WoRLd\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.substring(0, 10), str =\u003e '\u003e\u003e ' + str). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Converts the input value to locale lowercase.
* 
* @param {any} data.src - The value to be converted to locale lowercase.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {string|undefined} The locale lowercase string, or undefined if the input is not a valid string.
*
* @framework ggLowCodeGTMKit
*/
const toLocaleLowerCase = function(string) {
   return typeof string === 'string' ? string.toLocaleLowerCase() : undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// toLocaleLowerCase - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(toLocaleLowerCase(value));
*/
// ===============================================================================
// toLocaleLowerCase() – Apply Mode
// ===============================================================================
return function(value) {
  return out(toLocaleLowerCase(value));
};


___TESTS___

scenarios:
  - name: '[example] Simple uppercase'
    code: |-
      /* @display
      Value to Process: HELLO WORLD
      @output
      hello world
      */
      const src = 'HELLO WORLD';
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
  - name: '[example] Locale-aware lowercase'
    code: |-
      /* @display
      Value to Process: HeLLo WoRLd
      @output
      hello world
      */
      const src = 'HeLLo WoRLd';
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
  - name: Already lowercase string - should remain lowercase
    code: |-
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
  - name: '[example] Non-string input returns undefined'
    code: |-
      /* @display
      Value to Process: 12345
      @output
      undefined
      */
      const src = 12345;
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
