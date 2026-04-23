___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "padStart(...)",
  "description": "Pad a \u003cem\u003estring\u003c/em\u003e or \u003cem\u003enumber\u003c/em\u003e from the left with a specific character to ensure it reaches a defined total length.",
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
        "name": "len",
        "displayName": "Target Length",
        "simpleValueType": true,
        "help": "💾   The final desired length of the output string.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e",
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
        "name": "chr",
        "displayName": "Pad Character",
        "simpleValueType": true,
        "help": "💾   The character to use for padding (default is \"0\").\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePad number with leading zeros\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 123\u003cbr\u003eTarget Length: 5\u003cbr\u003ePad Character: 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e00123\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString already exceeds target length\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello world\u003cbr\u003eTarget Length: 5\u003cbr\u003ePad Character: 0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePad with custom character\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 42\u003cbr\u003eTarget Length: 6\u003cbr\u003ePad Character: *\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e****42\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String To Pad"
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
            "checkboxText": "⚡Use runtime parameter for: Target Length",
            "simpleValueType": true
          },
          {
            "type": "CHECKBOX",
            "name": "rp2",
            "checkboxText": "⚡Use runtime parameter for: Pad Character",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Pad a \u003cem\u003estring\u003c/em\u003e or number from the left with a specific character to ensure it reaches a defined total length, useful for formatting values.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePad number with leading zeros\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e123\u003c/strong\u003e\u003cbr\u003eTarget Length: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003ePad Character: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e00123\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString already exceeds target length\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003eTarget Length: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003ePad Character: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePad with custom character\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003eTarget Length: \u003cstrong\u003e6\u003c/strong\u003e\u003cbr\u003ePad Character: \u003cstrong\u003e*\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e****42\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toUpperCase(), val =\u003e val + ' formatted' for string modifications). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Pads the start of a string with a given character until it reaches the desired length.
 * 
 * @param {string|number} data.src - The input string or number to pad.
 * @param {number} data.len - The final desired length of the output string.
 * @param {string} data.chr - The character to use for padding (default is "0").
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before padding.
 * 
 * @returns {string} The padded string.
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');
const padStart = function(input, targetLength, padChar) {
    if (input === null || input === undefined) return '';
    
    const pad = (padChar !== undefined && padChar !== null && padChar !== '') ? padChar : '0';
    const inputStr = input.toString();
    const len = makeNumber(targetLength);
    
    if (typeof len !== 'number' || len < 0) return inputStr;
    
    const padNeeded = len - inputStr.length;
    if (padNeeded <= 0) return inputStr;
    
    let padding = '';
    for (let i = 0; i < padNeeded; i++) {
        padding += pad;
    }
    return padding + inputStr;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// padStart - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(padStart(value, data.len, data.chr));
*/
// ===============================================================================
// padStart(...) – Apply Mode
// ===============================================================================
return function(value, targetLength, padChar) {
   targetLength = data.rp1 ? data.len : targetLength;
   padChar = data.rp2 ? data.chr : padChar;
   return out(padStart(value, targetLength, padChar));
};


___TESTS___

scenarios:
  - name: '[example] Pad number with leading zeros'
    code: |-
      /* @display
      Value to Process: 123
      Target Length: 5
      Pad Character: 0
      @output
      00123
      */
      const src = 123;
      const len = 5;
      const chr = '0';
      const mockData = {
          src: src,
          len: len,
          chr: chr,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, len, chr);
      }
      assertThat(variableResult).isEqualTo('00123');
  - name: Pad string with spaces to length 10 - should pad with spaces
    code: |-
      const src = 'hello';
      const len = 10;
      const chr = ' ';
      const mockData = {
          src: src,
          len: len,
          chr: chr,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, len, chr);
      }
      assertThat(variableResult).isEqualTo('     hello');
  - name: '[example] String already exceeds target length'
    code: |
      /* @display
      Value to Process: hello world
      Target Length: 5
      Pad Character: 0
      @output
      hello world
      */
      const src = 'hello world';
      const len = 5;
      const chr = '0';
      const mockData = {
          src: src,
          len: len,
          chr: chr,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, len, chr);
      }
      assertThat(variableResult).isEqualTo('hello world');
  - name: '[example] Pad with custom character'
    code: |-
      /* @display
      Value to Process: 42
      Target Length: 6
      Pad Character: *
      @output
      ****42
      */
      const src = '42';
      const len = 6;
      const chr = '*';
      const mockData = {
          src: src,
          len: len,
          chr: chr,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, len, chr);
      }
      assertThat(variableResult).isEqualTo('****42');
  - name: Empty string with padding - should create padding only
    code: |-
      const src = '';
      const len = 3;
      const chr = 'x';
      const mockData = {
          src: src,
          len: len,
          chr: chr,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, len, chr);
      }
      assertThat(variableResult).isEqualTo('xxx');
  - name: Object input - should convert to string then pad
    code: |-
      const src = {name: 'test'};
      const len = 20;
      const chr = '-';
      const mockData = {
          src: src,
          len: len,
          chr: chr,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, len, chr);
      }
      assertThat(variableResult).isEqualTo('-----[object Object]');
  - name: Undefined input - should return empty stringUntitled test 8
    code: |-
      const src = undefined;
      const len = 5;
      const chr = '0';
      const mockData = {
          src: src,
          len: len,
          chr: chr,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, len, chr);
      }
      assertThat(variableResult).isEqualTo('');
  - name: Null input - should return empty string
    code: |-
      const src = null;
      const len = 5;
      const chr = '0';
      const mockData = {
          src: src,
          len: len,
          chr: chr,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, len, chr);
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
