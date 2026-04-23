___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "toStartCase",
  "description": "Converts a \u003cem\u003estring\u003c/em\u003e to Start Case format by replacing underscores, spaces, and hyphens with single spaces and capitalizing the first letter of each word, or \u003cem\u003eundefined\u003c/em\u003e if invalid.",
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
        "displayName": "String To Convert",
        "simpleValueType": true,
        "help": "💾   The string to convert to Start Case format.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Converts a \u003cem\u003estring\u003c/em\u003e to Start Case format by capitalizing the first letter of each word. Returns \u003cem\u003eundefined\u003c/em\u003e if the input is not a valid string.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eUnderscores to Start Case\u003c/em\u003e***\u003cbr\u003eString To Convert: \u003cstrong\u003ehello_world_test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello World Test\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eHyphens to Start Case\u003c/em\u003e***\u003cbr\u003eString To Convert: \u003cstrong\u003ehello-world-test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello World Test\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns undefined\u003c/em\u003e***\u003cbr\u003eString To Convert: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert object to string, normalize case). Internal transformations such as case handling will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str + ' €', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Converts a string to Start Case format.
* 
* @param {string} data.src - The string to convert to Start Case.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {string|undefined} The string in Start Case format, or undefined if the input is not a valid string.
*
* @framework ggLowCodeGTMKit
*/
const toStartCase = function(string) {
   if (typeof string === 'string') {
       const pattern = "[_\\s-]+";
       const replacement = ' ';
       
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
       result = result.trim();
       result = result.toLowerCase().split(' ')
           .map(word => {
               if (word.length === 0) return word;
               return word[0].toUpperCase() + word.substring(1);
           })
           .join(' ');
       
       return result;
   }
   return undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// toStartCase - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(toStartCase(value));
// ===============================================================================
// toStartCase() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(toStartCase(value));
};
*/


___TESTS___

scenarios:
  - name: Lowercase string with spaces - should convert to Start Case
    code: |-
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
      assertThat(variableResult).isEqualTo('Hello World Test');
  - name: '[example] Underscores to Start Case'
    code: |-
      /* @display
      String To Convert: hello_world_test
      @output
      Hello World Test
      */
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
      assertThat(variableResult).isEqualTo('Hello World Test');
  - name: '[example] Hyphens to Start Case'
    code: |-
      /* @display
      String To Convert: hello-world-test
      @output
      Hello World Test
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
      assertThat(variableResult).isEqualTo('Hello World Test');
  - name: Mixed case string with multiple separators - should convert to Start Case
    code: |-
      const src = 'hello_WORLD-test case';
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
      assertThat(variableResult).isEqualTo('Hello World Test Case');
  - name: '[example] Non-string input returns undefined'
    code: |-
      /* @display
      String To Convert: 12345
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
