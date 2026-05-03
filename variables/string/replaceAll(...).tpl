___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "replaceAll(...)",
  "description": "Replaces \u003cstrong\u003eall\u003c/strong\u003e occurrences of a pattern in a \u003cem\u003estring\u003c/em\u003e with a replacement value, useful for comprehensive text substitutions and data cleaning operations.",
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
        "name": "pat",
        "displayName": "Pattern to Replace",
        "simpleValueType": true,
        "help": "💾 The pattern to search for in the string. All occurrences will be replaced.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "rep",
        "displayName": "Replacement Value",
        "simpleValueType": true,
        "help": "💾 The replacement value to use. Use empty string to remove the pattern.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp2",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReplace all occurrences\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello world hello universe hello\u003cbr\u003ePattern to Replace: hello\u003cbr\u003eReplacement Value: hi\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehi world hi universe hi\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove all dashes\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: a-b-c-d-e\u003cbr\u003ePattern to Replace: -\u003cbr\u003eReplacement Value: \u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eabcde\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns original\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 12345\u003cbr\u003ePattern to Replace: 2\u003cbr\u003eReplacement Value: 9\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12345\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Input String: chained callback parameter"
      }
    ],
    "help": "Replaces all occurrences of a pattern in a \u003cem\u003estring\u003c/em\u003e with a replacement value. Useful for comprehensive text substitutions and data cleaning operations.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReplace all occurrences\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world hello universe hello\u003c/strong\u003e\u003cbr\u003ePattern to Replace: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003eReplacement Value: \u003cstrong\u003ehi\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehi world hi universe hi\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove all dashes\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ea-b-c-d-e\u003c/strong\u003e\u003cbr\u003ePattern to Replace: \u003cstrong\u003e-\u003c/strong\u003e\u003cbr\u003eReplacement Value: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eabcde\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns original\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003ePattern to Replace: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003eReplacement Value: \u003cstrong\u003e9\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12345\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result string before returning it (e.g., \u003ccode\u003estr =\u003e str.toUpperCase()\u003c/code\u003e, \u003ccode\u003estr =\u003e str.trim()\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Replaces all occurrences of a pattern in a string with a replacement value.
 * 
 * @param {string} data.src - The input string where replacement will occur.
 * @param {string} data.pat - The pattern to search for in the string.
 * @param {string} data.rep - The replacement value to use.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before replacement.
 * 
 * @returns {string} The string with all occurrences of the pattern replaced.
 *
 * @framework ggLowCodeGTMKit
 */
const replaceAll = function(input, pattern, replacement) {
    if (typeof input === 'string' && typeof pattern === 'string' && typeof replacement === 'string') {
        let result = input;
        let index = result.indexOf(pattern);
        while (index !== -1) {
            result = result.substring(0, index) + replacement + result.substring(index + pattern.length);
            index = result.indexOf(pattern, index + replacement.length);
        }
        return result;
    }
    return input;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// replaceAll - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedInput = applyCast(data.pre, data.src);
return out(replaceAll(processedInput, data.pat, data.rep));
*/
// ===============================================================================
// replaceAll(...) – Apply Mode
// ===============================================================================
return function(input, pattern, replacement) {
   return out(replaceAll(input, data.pat, data.rep ));
};


___TESTS___

scenarios:
  - name: '[example] Replace all occurrences'
    code: |-
      /* @display
      Value to Process: hello world hello universe hello
      Pattern to Replace: hello
      Replacement Value: hi
      @output
      hi world hi universe hi
      */
      const src = 'hello world hello universe hello';
      const pat = 'hello';
      const rep = 'hi';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo('hi world hi universe hi');
  - name: '[example] Remove all dashes'
    code: |-
      /* @display
      Value to Process: a-b-c-d-e
      Pattern to Replace: -
      Replacement Value: 
      @output
      abcde
      */
      const src = 'a-b-c-d-e';
      const pat = '-';
      const rep = '';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo('abcde');
  - name: Test pattern not found returns original string
    code: |-
      const src = 'hello world';
      const pat = 'goodbye';
      const rep = 'farewell';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo('hello world');
  - name: Test replacing with longer string
    code: |-
      const src = 'aa aa aa';
      const pat = 'aa';
      const rep = 'bbbb';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo('bbbb bbbb bbbb');
  - name: '[example] Non-string input returns original'
    code: |-
      /* @display
      Value to Process: 12345
      Pattern to Replace: 2
      Replacement Value: 9
      @output
      12345
      */
      const src = 12345;
      const pat = '2';
      const rep = '9';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo(12345);
  - name: Test with non-string pattern returns original string
    code: |-
      const src = 'hello world';
      const pat = 123;
      const rep = 'test';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo('hello world');
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
