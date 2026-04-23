___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "trimEnd(...)",
  "description": "Trims whitespace or specified characters from the \u003cstrong\u003eend\u003c/strong\u003e of a \u003cem\u003estring\u003c/em\u003e, removing trailing characters as specified.",
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
        "type": "CHECKBOX",
        "name": "add",
        "checkboxText": "Trim Custom Character(s) (whitespace by default)",
        "simpleValueType": true,
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
        "name": "opt",
        "displayName": "",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "TEXT",
            "name": "chr",
            "displayName": "Characters To Remove",
            "simpleValueType": true,
            "help": "🔤   The characters to remove from the end (used when custom characters is enabled, default is whitespace). Each character is considered independently. \u003cbr\u003e\u003cbr\u003e\u003cem\u003e↳If characters like yi are specified, then both y and i will be removed from the end of the string, regardless of the order or frequency of occurrence.\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
            "enablingConditions": [
              {
                "paramName": "rp1",
                "paramValue": true,
                "type": "NOT_EQUALS"
              }
            ]
          }
        ],
        "enablingConditions": [
          {
            "paramName": "add",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTrim custom characters\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello world...\u003cbr\u003eCharacters To Remove: .\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString with trailing dots\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: test123!!!\u003cbr\u003eCharacters To Remove: !123\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etest\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string returns empty string\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 12345\u003cbr\u003eCharacters To Remove: undefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String To Trim"
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
            "checkboxText": "⚡Use runtime parameter for: Characters To Remove",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Trims whitespace or specified characters from the end of a \u003cem\u003estring\u003c/em\u003e, removing trailing characters as specified.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTrim custom characters\u003c/em\u003e***\u003cbr\u003eString To Trim: \u003cstrong\u003ehello world...\u003c/strong\u003e\u003cbr\u003eCharacters To Remove: \u003cstrong\u003e.\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eString with trailing dots\u003c/em\u003e***\u003cbr\u003eString To Trim: \u003cstrong\u003etest123!!!\u003c/strong\u003e\u003cbr\u003eCharacters To Remove: \u003cstrong\u003e!123\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etest\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string returns empty string\u003c/em\u003e***\u003cbr\u003eString To Trim: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003eCharacters To Remove: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toUpperCase(), val =\u003e val + ' trimmed' for string modifications). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Trims whitespace or specified characters from the end of a string.
* 
* @param {string} data.src - The string to trim.
* @param {string} data.chr - The characters to remove (default is whitespace if not provided).
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before trimming.
* 
* @returns {string} The string with trailing whitespace or specified characters removed.
*
* @framework ggLowCodeGTMKit
*/

const trimEnd = function(string, chars) {
   const charsToTrim = chars !== undefined ? chars : " ";
   if (typeof string !== 'string') { return ""; }
   let endIndex = string.length;
   while (endIndex > 0 && charsToTrim.indexOf(string.charAt(endIndex - 1)) !== -1) {
       endIndex--;
   }
   return string.slice(0, endIndex);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// trimEnd - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(trimEnd(value, data.chr));
*/
// ===============================================================================
// trimEnd(...) – Apply Mode
// ===============================================================================
return function(value, chars) {
  chars = data.rp1 ? data.chr : chars;
  return out(trimEnd(value, chars));
};


___TESTS___

scenarios:
  - name: Trim trailing spaces
    code: |-
      const src = 'hello world   ';
      const chr = undefined;
      const mockData = {
          src: src,
          chr: chr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, chr);
      }
      assertThat(variableResult).isEqualTo('hello world');
  - name: Trim no trailing spaces
    code: |-
      const src = 'hello world';
      const chr = undefined;
      const mockData = {
          src: src,
          chr: chr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, chr);
      }
      assertThat(variableResult).isEqualTo('hello world');
  - name: '[example] Trim custom characters'
    code: |-
      /* @display
      Value to Process: hello world...
      chr: .
      @output
      hello world
      */
      const src = 'hello world...';
      const chr = '.';
      const mockData = {
          src: src,
          chr: chr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, chr);
      }
      assertThat(variableResult).isEqualTo('hello world');
  - name: '[example] String with trailing dots'
    code: |-
      /* @display
      Value to Process: test123!!!
      chr: !123
      @output
      test
      */
      const src = 'test123!!!';
      const chr = '!123';
      const mockData = {
          src: src,
          chr: chr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, chr);
      }
      assertThat(variableResult).isEqualTo('test');
  - name: Empty string
    code: |-
      const src = '';
      const chr = undefined;
      const mockData = {
          src: src,
          chr: chr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, chr);
      }
      assertThat(variableResult).isNotEqualTo(undefined);
  - name: String with mixed trailing characters
    code: |-
      const src = 'hello world... !!!';
      const chr = '. !';
      const mockData = {
          src: src,
          chr: chr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, chr);
      }
      assertThat(variableResult).isEqualTo('hello world');
  - name: '[example] Non-string returns empty string'
    code: |-
      /* @display
      Value to Process: 12345
      chr: undefined
      */
      const src = 12345;
      const chr = undefined;
      const mockData = {
          src: src,
          chr: chr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, chr);
      }
      assertThat(variableResult).isEqualTo('');
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
