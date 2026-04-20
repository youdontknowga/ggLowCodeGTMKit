___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "replaceFirst",
  "description": "Replaces the \u003cstrong\u003efirst\u003c/strong\u003e occurrence of a pattern in a \u003cem\u003estring\u003c/em\u003e with a replacement value, useful for simple text substitutions and data cleaning operations.",
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
        "displayName": "Input String",
        "simpleValueType": true,
        "help": "💾 The input string where replacement will occur.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "pat",
        "displayName": "Pattern to Replace",
        "simpleValueType": true,
        "help": "💾 The pattern to search for in the string. Supports both literal text and regex patterns.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString (literal)\u003c/strong\u003e: \u003cem\u003e\"Hello\"\u003c/em\u003e, \u003cem\u003e\"test\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString (regex pattern)\u003c/strong\u003e: \u003cem\u003e\"\\d+\"\u003c/em\u003e, \u003cem\u003e\"^start\"\u003c/em\u003e, \u003cem\u003e\"end$\"\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e⚠️ \u003cstrong\u003eEscaping note:\u003c/strong\u003e For regex patterns, use single backslash in this UI field (e.g., \u003ccode\u003e\\d+\u003c/code\u003e for digits). GTM automatically handles the escaping."
      },
      {
        "type": "TEXT",
        "name": "rep",
        "displayName": "Replacement Value",
        "simpleValueType": true,
        "help": "💾 The replacement value to use. Use empty string to remove the first match.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Replaces the \u003cstrong\u003efirst\u003c/strong\u003e occurrence of a pattern in a \u003cem\u003estring\u003c/em\u003e with a replacement value. Useful for simple text substitutions.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReplace first occurrence\u003c/em\u003e***\u003cbr\u003eInput String: \u003cstrong\u003ehello world hello\u003c/strong\u003e\u003cbr\u003ePattern to Replace: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003eReplacement Value: \u003cstrong\u003ehi\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehi world hello\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove first occurrence\u003c/em\u003e***\u003cbr\u003eInput String: \u003cstrong\u003etest123test456\u003c/strong\u003e\u003cbr\u003ePattern to Replace: \u003cstrong\u003etest\u003c/strong\u003e\u003cbr\u003eReplacement Value: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e123test456\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns original\u003c/em\u003e***\u003cbr\u003eInput String: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003ePattern to Replace: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003eReplacement Value: \u003cstrong\u003e9\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12345\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before replacement (e.g., normalize case, trim whitespace)."
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
        "help": "⚙️ Optional function to apply to the result string before returning it (e.g., \u003ccode\u003estr =\u003e str.toUpperCase()\u003c/code\u003e, \u003ccode\u003estr =\u003e str.trim()\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Replaces the first occurrence of a pattern in a string with a replacement value.
* 
* @param {string} data.src - The input string where replacement will occur.
* @param {string} data.pat - The pattern to search for in the string.
* @param {string} data.rep - The replacement value to use.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before replacement.
* 
* @returns {string} The string with the first occurrence of the pattern replaced.
*
* @framework ggLowCodeGTMKit
*/
const replaceFirst = function(input, pattern, replacement) {
   if (typeof input === 'string' && typeof pattern === 'string' && typeof replacement === 'string') {
       return input.replace(pattern, replacement);
   }
   return input;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// replaceFirst - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedInput = applyCast(data.pre, data.src);
return out(replaceFirst(processedInput, data.pat, data.rep));
// ===============================================================================
// replaceFirst(...) – Apply Mode
// ===============================================================================
/*
return function(value, pattern, replacement) {
   return out(replaceFirst(value, data.pat, data.rep));
};
*/


___TESTS___

scenarios:
  - name: '[example] Replace first occurrence'
    code: |
      /* @display
      Input String: hello world hello
      Pattern to Replace: hello
      Replacement Value: hi
      @output
      hi world hello
      */
      const src = 'hello world hello';
      const pat = 'hello';
      const rep = 'hi';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo('hi world hello');
  - name: Replace word in middle of string - should replace only first occurrence
    code: |-
      const src = 'the cat and the dog';
      const pat = 'the';
      const rep = 'a';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo('a cat and the dog');
  - name: '[example] Remove first occurrence'
    code: |-
      /* @display
      Input String: test123test456
      Pattern to Replace: test
      Replacement Value: 
      @output
      123test456
      */
      const src = 'test123test456';
      const pat = 'test';
      const rep = '';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo('123test456');
  - name: Pattern not found - should return original string
    code: |
      const src = 'hello world';
      const pat = 'xyz';
      const rep = 'abc';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo('hello world');
  - name: Empty string input - should return empty string
    code: |-
      const src = '';
      const pat = 'test';
      const rep = 'replace';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo('');
  - name: Replace special characters - should replace first occurrence
    code: |-
      const src = 'price: $10 and $20';
      const pat = '$';
      const rep = '€';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo('price: €10 and $20');
  - name: Replace with longer string - should work correctly
    code: |-
      const src = 'hi there';
      const pat = 'hi';
      const rep = 'hello';
      const mockData = {
          src: src,
          pat: pat,
          rep: rep
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo('hello there');
  - name: '[example] Non-string input returns original'
    code: |-
      /* @display
      Input String: 12345
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
          rep: rep
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pat, rep);
      }
      assertThat(variableResult).isEqualTo(12345);
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
