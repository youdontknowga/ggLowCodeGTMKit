___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "sanitizeTextAndRemoveHtml()",
  "description": "Sanitizes a \u003cem\u003estring\u003c/em\u003e by removing \u003cem\u003eHTML tags\u003c/em\u003e, replacing line breaks and tabs with spaces, collapsing multiple whitespace characters, and trimming leading/trailing whitespace.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove HTML tags\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e\u003cdiv\u003eHello \u003cstrong\u003eWorld\u003c/strong\u003e\u003c/div\u003e\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCollapse multiple spaces\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eHello    World     Test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello World Test\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Text To Sanitize"
      }
    ],
    "help": "Sanitizes a \u003cem\u003estring\u003c/em\u003e by removing HTML tags, replacing line breaks and tabs with spaces, collapsing multiple whitespace characters, and trimming leading/trailing whitespace.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove HTML tags\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e\u003cdiv\u003eHello \u003cstrong\u003eWorld\u003c/strong\u003e\u003c/div\u003e\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCollapse multiple spaces\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eHello    World     Test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello World Test\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toUpperCase(), str =\u003e str.toLowerCase() for case transformations). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Sanitizes a string by:
* - Removing HTML tags
* - Replacing line breaks and tabs with spaces
* - Collapsing multiple whitespace characters into a single space
* - Trimming leading/trailing whitespace
* 
* @param {string} data.src - The string to sanitize.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before sanitizing.
* 
* @returns {string|undefined} The cleaned string, or undefined if input is not a string.
*
* @framework ggLowCodeGTMKit
*/
const sanitizeTextAndRemoveHtml = function(input) {
   if (typeof input !== 'string') {
       return undefined;
   }
   const blockTags = ['div', 'p', 'br', 'li', 'td', 'th', 'section', 'article'];
   let noTags = '';
   let insideTag = false;
   let tagBuffer = '';
   for (let i = 0; i < input.length; i++) {
       const char = input[i];
       if (char === '<') {
           insideTag = true;
           tagBuffer = '';
           continue;
       }
       if (char === '>') {
           insideTag = false;
           const tagName = tagBuffer.toLowerCase().split(' ')[0].replace('/', '');
           if (blockTags.indexOf(tagName) !== -1) {
               noTags += ' ';
           }
           continue;
       }
       if (insideTag) {
           tagBuffer += char;
       } else {
           noTags += char;
       }
   }
   let cleaned = noTags.split('\n').join(' ')
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
// sanitizeTextAndRemoveHtml - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(sanitizeTextAndRemoveHtml(value));
*/
// ===============================================================================
// sanitizeTextAndRemoveHtml() – Apply Mode
// ===============================================================================
return function(value) {
  return out(sanitizeTextAndRemoveHtml(value));
};


___TESTS___

scenarios:
  - name: '[example] Remove HTML tags'
    code: |-
      /* @display
      Value to Process: <div>Hello <strong>World</strong></div>
      @output
      Hello World
      */
      const src = '<div>Hello <strong>World</strong></div>';
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
  - name: String with line breaks and tabs - should replace with spaces
    code: |-
      const src = 'Hello\n\tWorld\r\nTest';
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
  - name: '[example] Collapse multiple spaces'
    code: |-
      /* @display
      Value to Process: Hello    World     Test
      @output
      Hello World Test
      */
      const src = 'Hello    World     Test';
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
  - name: Complex HTML with block tags - should add spaces for block elements
    code: |-
      const src = '<p>First paragraph</p><div>Second block</div><br>Third line';
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
      assertThat(variableResult).isEqualTo('First paragraph Second block Third line');
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
