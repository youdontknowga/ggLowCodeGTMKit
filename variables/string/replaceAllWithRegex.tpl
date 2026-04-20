___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "replaceAllWithRegex",
  "description": "Replaces \u003cstrong\u003eall\u003c/strong\u003e occurrences matching a regular expression pattern in a \u003cem\u003estring\u003c/em\u003e with a replacement value.",
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
        "name": "ptn",
        "displayName": "Regular Expression Pattern",
        "simpleValueType": true,
        "help": "🔍 The regular expression pattern to search for in the string. All occurrences will be replaced.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e (regex pattern)\u003cbr\u003e\u003cbr\u003e⚠️ \u003cstrong\u003eEscaping note:\u003c/strong\u003e In this UI field, use single backslash (e.g., \u003ccode\u003e\\d+\u003c/code\u003e for digits). GTM automatically handles the escaping."
      },
      {
        "type": "TEXT",
        "name": "rep",
        "displayName": "Replacement Value",
        "simpleValueType": true,
        "help": "💾 The replacement value to use. Use empty string to remove matches.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Replaces all occurrences of a regular expression pattern in a \u003cem\u003estring\u003c/em\u003e with a replacement value. Useful for pattern-based text transformations and data cleaning.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMask all numbers\u003c/em\u003e***\u003cbr\u003eInput String: \u003cstrong\u003eOrder 123 and Order 456\u003c/strong\u003e\u003cbr\u003eRegular Expression Pattern: \u003cstrong\u003e\\\\d+\u003c/strong\u003e\u003cbr\u003eReplacement Value: \u003cstrong\u003eXXX\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eOrder XXX and Order XXX\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNormalize whitespace\u003c/em\u003e***\u003cbr\u003eInput String: \u003cstrong\u003ehello   world  test\u003c/strong\u003e\u003cbr\u003eRegular Expression Pattern: \u003cstrong\u003e\\\\s+\u003c/strong\u003e\u003cbr\u003eReplacement Value: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello world test\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result string before returning it (e.g., \u003ccode\u003estr =\u003e str.trim()\u003c/code\u003e, \u003ccode\u003estr =\u003e str.toUpperCase()\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Replaces all occurrences of a regular expression pattern in a string with a replacement value.
 * 
 * @param {string} data.src - The input string where replacement will occur.
 * @param {string} data.ptn - The regular expression pattern to search for in the string.
 * @param {string} data.rep - The replacement value to use.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before replacement.
 * 
 * @returns {string} The string with all occurrences of the regex pattern replaced.
 *
 * @framework ggLowCodeGTMKit
 */
const matchAll = function(stringToMatch, regexPattern) {
  const matches = [];
  let index = 0;
  while (index < stringToMatch.length) {
    const match = stringToMatch.substring(index).match(regexPattern);
    if (match) {
      matches.push(match[0]);
      index += match.index + match[0].length;
    } else {
      break;
    }
  }
  return matches.length > 0 ? matches : null;
};

const replaceAllWithRegex = function(input, pattern, replacement) {
    if (typeof input !== 'string' || typeof pattern !== 'string' || typeof replacement !== 'string') {
        return input;
    }
    
    const matches = matchAll(input, pattern);
    
    if (matches === null) {
        return input; // No matches found
    }
    
    let result = input;
  
    for (let i = 0; i < matches.length; i++) {
        result = result.replace(matches[i], replacement);
    }
    
    return result;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// replaceAllWithRegex - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedInput = applyCast(data.pre, data.src);
return out(replaceAllWithRegex(processedInput, data.ptn, data.rep));
// ===============================================================================
// replaceAllWithRegex(...) – Apply Mode
// ===============================================================================
/*
return function(input, pattern, replacement) {
   return out(replaceAllWithRegex(input, data.ptn, data.rep));
};
*/


___TESTS___

scenarios:
  - name: Test with non-string input returns original value
    code: |-
      const src = 12345;
      const ptn = '\\d';
      const rep = 'X';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isEqualTo(12345);
  - name: '[example] Mask all numbers'
    code: |
      /* @display
      Input String: Order 123 and Order 456
      Regular Expression Pattern: \\d+
      Replacement Value: XXX
      @output
      Order XXX and Order XXX
      */
      const src = 'Order 123 and Order 456';
      const ptn = '\\d+';
      const rep = 'XXX';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isEqualTo('Order XXX and Order XXX');
  - name: Test removing dollar signs
    code: |-
      const src = 'Price: $19.99, Cost: $9.99';
      const ptn = '\\$';
      const rep = '';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isEqualTo('Price: 19.99, Cost: 9.99');
  - name: '[example] Normalize whitespace'
    code: |-
      /* @display
      Input String: hello   world  test
      Regular Expression Pattern: \\s+
      Replacement Value:  
      @output
      hello world test
      */
      const src = 'hello   world  test';
      const ptn = '\\s+';
      const rep = ' ';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isEqualTo('hello world test');
  - name: Test replacing word characters
    code: |-
      const src = 'abc123def456';
      const ptn = '[a-z]+';
      const rep = '*';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isEqualTo('*123*456');
  - name: Test with no matches returns original string
    code: |-
      const src = 'hello world';
      const ptn = '\\d+';
      const rep = 'NUMBER';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isEqualTo('hello world');
  - name: Test replacing special characters with escape sequences
    code: |-
      const src = 'test.file.name.txt';
      const ptn = '\\.';
      const rep = '_';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isEqualTo('test_file_name_txt');
  - name: Test replacing emails with placeholder
    code: |-
      const src = 'Contact info@example.com or support@test.com';
      const ptn = '\\w+@\\w+\\.\\w+';
      const rep = '[EMAIL]';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isEqualTo('Contact [EMAIL] or [EMAIL]');
  - name: Test with non-string pattern returns original string
    code: |
      const src = 'hello world';
      const ptn = 123;
      const rep = 'X';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isEqualTo('hello world');
  - name: Test with non-string replacement returns original string
    code: |-
      const src = 'hello 123 world';
      const ptn = '\\d+';
      const rep = 999;
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isEqualTo('hello 123 world');
  - name: Test replacing line breaks
    code: |-
      const src = 'line1\nline2\nline3';
      const ptn = '\\n';
      const rep = ' ';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isEqualTo('line1 line2 line3');
  - name: Test case-insensitive pattern
    code: |-
      const src = 'Hello HELLO hello';
      const ptn = '[Hh][Ee][Ll][Ll][Oo]';
      const rep = 'Hi';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isEqualTo('Hi Hi Hi');
  - name: Test with null string returns original value
    code: |-
      const src = null;
      const ptn = '\\d+';
      const rep = 'X';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isNull();
  - name: Test with undefined string returns original value
    code: |-
      const src = undefined;
      const ptn = '\\d+';
      const rep = 'X';
      const mockData = {
          src: src,
          ptn: ptn,
          rep: rep,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn, rep);
      }
      assertThat(variableResult).isUndefined();
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
