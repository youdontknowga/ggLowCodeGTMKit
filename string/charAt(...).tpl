___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "charAt(...)",
  "description": "Returns the character at a specified index in a valid \u003cem\u003estring\u003c/em\u003e.",
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
        "name": "idx",
        "displayName": "Index",
        "simpleValueType": true,
        "help": "🔢   The index position of the character to retrieve.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
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
        "help": "Returns the character at a specified index in a valid \u003cem\u003estring\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCharacter at index 1\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003estr: Hello\u003cbr\u003eIndex: 1\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ee\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFirst character\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003estr: World\u003cbr\u003eIndex: 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eW\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex out of bounds\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003estr: Hello\u003cbr\u003eIndex: 10\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String"
      },
      {
        "type": "GROUP",
        "name": "Advanced Settings",
        "displayName": "Advanced Settings",
        "groupStyle": "ZIPPY_OPEN_ON_PARAM",
        "subParams": [
          {
            "type": "CHECKBOX",
            "name": "rp1",
            "checkboxText": "⚡Use runtime parameter for: Index",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Returns the character at a specified index in a valid \u003cem\u003estring\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCharacter at index 1\u003c/em\u003e***\u003cbr\u003estr: \u003cstrong\u003eHello\u003c/strong\u003e\u003cbr\u003eIndex: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ee\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFirst character\u003c/em\u003e***\u003cbr\u003estr: \u003cstrong\u003eWorld\u003c/strong\u003e\u003cbr\u003eIndex: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eW\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eIndex out of bounds\u003c/em\u003e***\u003cbr\u003estr: \u003cstrong\u003eHello\u003c/strong\u003e\u003cbr\u003eIndex: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., char =\u003e char.toUpperCase(), char =\u003e char.charCodeAt(0) for ASCII code). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Returns the character at a specified index in a valid string.
 * 
 * @param {string} data.str - The string to retrieve the character from.
 * @param {number} data.idx - The index of the character to retrieve.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform input before processing.
 * 
 * @returns {string} The character at the specified index.
 *
 * @framework ggLowCodeGTMKit
 */
const charAt = function(input, index) {
    if (typeof input !== 'string' || index < 0 || index >= input.length) {
        return '';
    }
    return input.charAt(index);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// charAt - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedStr = applyCast(data.pre, data.str);
return out(charAt(processedStr, data.idx));
*/
// ===============================================================================
// charAt(...) – Apply Mode
// ===============================================================================
return function(value, index) {
    index = data.rp1 ? data.idx : index;
    return out(charAt(value, index));
};


___TESTS___

scenarios:
  - name: '[example] Character at index 1'
    code: |-
      /* @display
      str: Hello
      Index: 1
      @output
      e
      */
      const str = 'Hello';
      const idx = 1;
      const mockData = {
          str: str,
          idx: idx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(str, idx);
      }
      assertThat(variableResult).isEqualTo('e');
  - name: '[example] First character'
    code: |-
      /* @display
      str: World
      Index: 0
      @output
      W
      */
      const str = 'World';
      const idx = 0;
      const mockData = {
          str: str,
          idx: idx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(str, idx);
      }
      assertThat(variableResult).isEqualTo('W');
  - name: Last character - should return last char
    code: |-
      const str = 'Test';
      const idx = 3;
      const mockData = {
          str: str,
          idx: idx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(str, idx);
      }
      assertThat(variableResult).isEqualTo('t');
  - name: '[example] Index out of bounds'
    code: |
      /* @display
      str: Hello
      Index: 10
      */
      const str = 'Hello';
      const idx = 10;
      const mockData = {
          str: str,
          idx: idx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(str, idx);
      }
      assertThat(variableResult).isEqualTo('');
  - name: Negative index - should return empty string
    code: |-
      const str = 'Hello';
      const idx = -1;
      const mockData = {
          str: str,
          idx: idx,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(str, idx);
      }
      assertThat(variableResult).isEqualTo('');
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
