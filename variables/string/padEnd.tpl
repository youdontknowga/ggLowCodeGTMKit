___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "padEnd",
  "description": "Pad a \u003cem\u003estring\u003c/em\u003e or \u003cem\u003enumber\u003c/em\u003e from the right with a specific character to ensure it reaches a defined total length.",
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
        "displayName": "String To Pad",
        "simpleValueType": true,
        "help": "💾   The input string or number to pad.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "len",
        "displayName": "Target Length",
        "simpleValueType": true,
        "help": "🎯   The final desired length of the output string.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "chr",
        "displayName": "Pad Character",
        "simpleValueType": true,
        "help": "🔤   The character to use for padding (default is \"0\").\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Pad a \u003cem\u003estring\u003c/em\u003e or number from the right with a specific character to ensure it reaches a defined total length.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePad number with trailing zeros\u003c/em\u003e***\u003cbr\u003eString To Pad: \u003cstrong\u003e123\u003c/strong\u003e\u003cbr\u003eTarget Length: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003ePad Character: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12300\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString already exceeds target length\u003c/em\u003e***\u003cbr\u003eString To Pad: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003eTarget Length: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003ePad Character: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePad with custom character\u003c/em\u003e***\u003cbr\u003eString To Pad: \u003cstrong\u003e42\u003c/strong\u003e\u003cbr\u003eTarget Length: \u003cstrong\u003e6\u003c/strong\u003e\u003cbr\u003ePad Character: \u003cstrong\u003e*\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e42****\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert number to string, normalize format). Internal transformations such as string conversion will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toUpperCase(), val =\u003e val + ' formatted' for string modifications). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Pads the end of a string with a given character until it reaches the desired length.
* 
* @param {string|number} data.src - The input string or number to pad.
* @param {number|string} data.len - The final desired length of the output string.
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
const padEnd = function(input, targetLength, padChar) {
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
   return inputStr + padding;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// padEnd - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(padEnd(value, data.len, data.chr));
// ===============================================================================
// padEnd(...) – Apply Mode
// ===============================================================================
/*
return function(value, targetLength, padChar) {
   targetLength = data.rp1 ? data.len : targetLength;
   padChar = data.rp2 ? data.chr : padChar;
   return out(padEnd(value, targetLength, padChar));
};
*/


___TESTS___

scenarios:
  - name: '[example] Pad number with trailing zeros'
    code: |-
      /* @display
      String To Pad: 123
      Target Length: 5
      Pad Character: 0
      @output
      12300
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
      assertThat(variableResult).isEqualTo('12300');
  - name: Pad string with spaces to length 10 - should pad with spaces at end
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
      assertThat(variableResult).isEqualTo('hello     ');
  - name: '[example] String already exceeds target length'
    code: |-
      /* @display
      String To Pad: hello world
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
      String To Pad: 42
      Target Length: 6
      Pad Character: *
      @output
      42****
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
      assertThat(variableResult).isEqualTo('42****');
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
  - name: Object input - should convert to string then pad at end
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
      assertThat(variableResult).isEqualTo('[object Object]-----');
  - name: Undefined input - should return empty string
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
