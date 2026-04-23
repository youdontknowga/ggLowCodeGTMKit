___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "sanitizeTextLite",
  "description": "Sanitizes a \u003cem\u003estring\u003c/em\u003e by replacing line breaks and tabs with spaces, collapsing multiple whitespace characters into a single space, and trimming leading/trailing whitespace.",
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
        "displayName": "Text To Sanitize",
        "simpleValueType": true,
        "help": "💾   The string to sanitize and clean.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Sanitizes a \u003cem\u003estring\u003c/em\u003e by replacing line breaks and tabs with spaces, collapsing multiple whitespace characters into a single space, and trimming leading/trailing whitespace.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCollapse multiple spaces\u003c/em\u003e***\u003cbr\u003eText To Sanitize: \u003cstrong\u003eHello    world   test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello world test\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReplace line breaks and tabs\u003c/em\u003e***\u003cbr\u003eText To Sanitize: \u003cstrong\u003eLine1\\nLine2\\tTabbed\\rReturn\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eLine1 Line2 Tabbed Return\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns undefined\u003c/em\u003e***\u003cbr\u003eText To Sanitize: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., normalize encoding, convert to string). Internal transformations such as whitespace normalization will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toUpperCase(), val =\u003e val + ' cleaned' for string modifications). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Sanitizes a string by:
* - Replacing line breaks and tabs with spaces
* - Collapsing multiple whitespace characters into a single space
* - Trimming leading and trailing whitespace
* 
* @param {string} data.src - The string to sanitize.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before sanitizing.
* 
* @returns {string|undefined} The sanitized string or undefined if input is not a string.
*
* @framework ggLowCodeGTMKit
*/
const sanitizeTextLite = function(input) {
   if (typeof input !== 'string') {
       return undefined;
   }
   let cleaned = input.split('\n').join(' ')
                      .split('\r').join(' ')
                      .split('\t').join(' ');
   while (cleaned.indexOf('  ') !== -1) {
       cleaned = cleaned.split('  ').join(' ');
   }
   return cleaned.trim();
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// sanitizeTextLite - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(sanitizeTextLite(value));
// ===============================================================================
// sanitizeTextLite() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(sanitizeTextLite(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Collapse multiple spaces'
    code: |-
      /* @display
      Text To Sanitize: Hello    world   test
      @output
      Hello world test
      */
      const src = "Hello    world   test";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("Hello world test");
  - name: '[example] Replace line breaks and tabs'
    code: |
      /* @display
      Text To Sanitize: Line1\nLine2\tTabbed\rReturn
      @output
      Line1 Line2 Tabbed Return
      */
      const src = "Line1\nLine2\tTabbed\rReturn";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("Line1 Line2 Tabbed Return");
  - name: String with leading and trailing whitespace - trims edges
    code: |-
      const src = "   trimmed text   ";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("trimmed text");
  - name: String with mixed whitespace issues - sanitizes completely
    code: |-
      const src = "  Multiple\n\nlines  \t  and    spaces  ";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("Multiple lines and spaces");
  - name: '[example] Non-string input returns undefined'
    code: |-
      /* @display
      Text To Sanitize: 12345
      @output
      undefined
      */
      const src = 12345;
      const mockData = {
          src: src,
          rp1: false
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
