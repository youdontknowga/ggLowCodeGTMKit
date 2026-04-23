___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "countWordsInString()",
  "description": "Counts the number of non-empty words in a given \u003cem\u003estring\u003c/em\u003e. Note: Text should be sanitized first to remove HTML tags and normalize whitespace for accurate word counting.",
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
        "help": "Counts the number of non-empty words in a given \u003cem\u003estring\u003c/em\u003e. Note: text should be sanitized first to remove HTML tags and normalize whitespace for accurate word counting.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSimple sentence\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehello world test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMultiple spaces between words\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehello   world   test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Sanitized Text"
      }
    ],
    "help": "Counts the number of non-empty words in a given \u003cem\u003estring\u003c/em\u003e. Note: text should be sanitized first to remove HTML tags and normalize whitespace for accurate word counting.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSimple sentence\u003c/em\u003e***\u003cbr\u003eSanitized Text: \u003cstrong\u003ehello world test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMultiple spaces between words\u003c/em\u003e***\u003cbr\u003eSanitized Text: \u003cstrong\u003ehello   world   test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns undefined\u003c/em\u003e***\u003cbr\u003eSanitized Text: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
 * Counts the number of non-empty words in a given string. Note: Text should be sanitized first to remove HTML tags and normalize whitespace for accurate word counting.
 * 
 * @param {string} data.src - The sanitized text string to analyze.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before counting.
 * 
 * @returns {number|undefined} The number of words in the string, or undefined if input is not a string.
 *
 * @framework ggLowCodeGTMKit
 */
const countWordsInString = function(sanitizedText) {
    if (typeof sanitizedText !== 'string') { return undefined; }
    
    return sanitizedText.split(' ').filter(word => word.length > 0).length;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// countWordsInString - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(countWordsInString(value));
*/

// ===============================================================================
// countWordsInString() – Apply Mode
// ===============================================================================
return function(value) {
   return out(countWordsInString(value));
};


___TESTS___

scenarios:
  - name: '[example] Simple sentence'
    code: |-
      /* @display
      Value to Process: hello world test
      @output
      3
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
      assertThat(variableResult).isEqualTo(3);
  - name: String with single word - should return 1
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
      assertThat(variableResult).isEqualTo(1);
  - name: Empty string - should return 0
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
      assertThat(variableResult).isEqualTo(0);
  - name: String with only spaces - should return 0
    code: |-
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
      assertThat(variableResult).isEqualTo(0);
  - name: '[example] Multiple spaces between words'
    code: |-
      /* @display
      Value to Process: hello   world   test
      @output
      3
      */
      const src = 'hello   world   test';
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
      assertThat(variableResult).isEqualTo(3);
  - name: String with leading and trailing spaces - should return 2
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
      assertThat(variableResult).isEqualTo(2);
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
  - name: Non-string input (array) - should return undefined
    code: |-
      const src = ['hello', 'world'];
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
