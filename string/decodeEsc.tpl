___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "decodeEsc",
  "description": "Converts %esc% placeholders to spaces. Useful for GTM fields that strip whitespace.",
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
        "help": "💾 The string containing escaped sequences to decode.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e: text with \u003ccode\u003e%esc%\u003c/code\u003e placeholders"
      }
    ],
    "help": "Decodes escaped sequences in a \u003cem\u003estring\u003c/em\u003e by replacing special placeholders with their actual characters. Currently supports \u003cem\u003e%esc%\u003c/em\u003e which is replaced with a space character.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSingle space placeholder\u003c/em\u003e***\u003cbr\u003eInput String: \u003cstrong\u003eHello%esc%World\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHello World\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMultiple consecutive placeholders\u003c/em\u003e***\u003cbr\u003eInput String: \u003cstrong\u003eName:%esc%%esc%%esc%John\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eName:   John\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the string before decoding (e.g., normalize text, extract substring)."
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
        "help": "⚙️ Optional function to apply to the decoded string before returning it (e.g., \u003ccode\u003estr =\u003e str.trim()\u003c/code\u003e, \u003ccode\u003estr =\u003e str.toUpperCase()\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Decodes escaped sequences in a string, replacing %esc% with spaces.
 * 
 * @param {string} data.src - The string containing escaped sequences.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before decoding.
 * 
 * @returns {string} The decoded string with %esc% replaced by spaces.
 *
 * @framework ggLowCodeGTMKit
 */
const decodeEsc = function(value) {
    if (typeof value !== 'string') {
        return value;
    }
    return value.split('%esc%').join(' ');
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// decodeEsc - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(decodeEsc(value));
// ===============================================================================
// decodeEsc() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(decodeEsc(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Single space placeholder'
    code: |-
      /* @display
      Input String: Hello%esc%World
      @output
      Hello World
      */
      const src = 'Hello%esc%World';
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
  - name: '[example] Multiple consecutive placeholders'
    code: |
      /* @display
      Input String: Name:%esc%%esc%%esc%John
      @output
      Name:   John
      */
      const src = 'Name:%esc%%esc%%esc%John';
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
      assertThat(variableResult).isEqualTo('Name:   John');
  - name: Test leading and trailing escape sequences
    code: |-
      const src = '%esc%padded%esc%';
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
      assertThat(variableResult).isEqualTo(' padded ');
  - name: Test string with no escape sequences
    code: |-
      const src = 'NoSpacesHere';
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
      assertThat(variableResult).isEqualTo('NoSpacesHere');
  - name: Test invalid input returns input
    code: |-
      const src = {};
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
      assertThat(variableResult).isEqualTo({});
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'direct';
  // ===================================================================================================
  // Derived flags
  // ===================================================================================================
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 


___NOTES___

Created on 22/03/2026, 20:24:12


