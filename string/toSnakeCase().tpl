___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "toSnakeCase()",
  "description": "Converts a \u003cem\u003estring\u003c/em\u003e to snake_case format by replacing underscores, spaces, and hyphens with single underscores and converting to lowercase, or \u003cem\u003eundefined\u003c/em\u003e if invalid.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSpaces to snake_case\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehello world test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello_world_test\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eHyphens to snake_case\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehello-world-test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello_world_test\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String To Convert"
      }
    ],
    "help": "Converts a \u003cem\u003estring\u003c/em\u003e to snake_case format. Returns \u003cem\u003eundefined\u003c/em\u003e if the input is not a valid string.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSpaces to snake_case\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello_world_test\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eHyphens to snake_case\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello-world-test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello_world_test\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toUpperCase(), str =\u003e str.replace(/^_/, '') to remove leading underscores). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Converts a string to snake_case format.
* 
* @param {string} data.src - The string to convert to snake_case.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {string|undefined} The string in snake_case format, or undefined if the input is not a valid string.
*
* @framework ggLowCodeGTMKit
*/
const toSnakeCase = function(string) {
   if (typeof string === 'string') {
       const pattern = "[_\\s-]+";
       const replacement = '_';
       
       const replaceAllWithRegex = function(input, pattern, replacement) {
           if (typeof input !== 'string' || typeof pattern !== 'string' || typeof replacement !== 'string') {
               return input;
           } 
           let result = input;
           let lastIndex = 0;
           
           while (lastIndex < result.length) {
               const remainingStr = result.substring(lastIndex);
               const matchObj = remainingStr.match(pattern);
               if (matchObj === null) {
                   break;
               }
           
               const actualMatchIndex = lastIndex + (matchObj.index || 0);
               
               result = result.substring(0, actualMatchIndex) + 
                        replacement + 
                        result.substring(actualMatchIndex + matchObj[0].length);
               lastIndex = actualMatchIndex + replacement.length;
           }
           return result;
       }; 
    
       
       let result = replaceAllWithRegex(string, pattern, replacement);
       
       result = result.toLowerCase();
       return result;
   }
   return undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// toSnakeCase - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(toSnakeCase(value));
*/
// ===============================================================================
// toSnakeCase() – Apply Mode
// ===============================================================================
return function(value) {
  return out(toSnakeCase(value));
};


___TESTS___

scenarios:
  - name: '[example] Spaces to snake_case'
    code: |-
      /* @display
      Value to Process: hello world test
      @output
      hello_world_test
      */
      const src = 'hello world test';
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
      assertThat(variableResult).isEqualTo('hello_world_test');
  - name: '[example] Hyphens to snake_case'
    code: |-
      /* @display
      Value to Process: hello-world-test
      @output
      hello_world_test
      */
      const src = 'hello-world-test';
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
      assertThat(variableResult).isEqualTo('hello_world_test');
  - name: Mixed case string with multiple separators - should convert to snake_case
    code: |-
      const src = 'Hello World-Test_Case';
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
      assertThat(variableResult).isEqualTo('hello_world_test_case');
  - name: Already in snake_case - should remain unchanged
    code: |-
      const src = 'hello_world_test';
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
      assertThat(variableResult).isEqualTo('hello_world_test');
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
