___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "matchAll(...)",
  "description": "Finds all matches of a regular expression pattern in a \u003cem\u003estring\u003c/em\u003e, simulating the behavior of String.prototype.match() with the g flag. Useful for extracting multiple occurrences of patterns.",
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
        "name": "ptn",
        "displayName": "Regular Expression Pattern",
        "simpleValueType": true,
        "help": "🔍 The regular expression pattern to match in the string. All occurrences will be found.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e (regex pattern)\u003cbr\u003e\u003cbr\u003e⚠️ \u003cstrong\u003eEscaping note:\u003c/strong\u003e In this UI field, use single backslash (e.g., \u003ccode\u003e\\d+\u003c/code\u003e for digits). GTM automatically handles the escaping.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFind all occurrences\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello world hello universe hello\u003cbr\u003eRegular Expression Pattern: hello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['hello', 'hello', 'hello']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract all numbers\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: abc123def456ghi789\u003cbr\u003eRegular Expression Pattern: \\d+\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['123', '456', '789']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo matches returns null\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: hello world\u003cbr\u003eRegular Expression Pattern: goodbye\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String to Search"
      }
    ],
    "help": "Finds all matches of a pattern in a \u003cem\u003estring\u003c/em\u003e and returns them as an array. Returns \u003cem\u003enull\u003c/em\u003e if no matches are found.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFind all occurrences\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world hello universe hello\u003c/strong\u003e\u003cbr\u003eRegular Expression Pattern: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['hello', 'hello', 'hello']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract all numbers\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eabc123def456ghi789\u003c/strong\u003e\u003cbr\u003eRegular Expression Pattern: \u003cstrong\u003e\\\\d+\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['123', '456', '789']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo matches returns null\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003eRegular Expression Pattern: \u003cstrong\u003egoodbye\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003enull\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result array before returning it (e.g., \u003ccode\u003earr =\u003e arr.length\u003c/code\u003e to count matches, \u003ccode\u003earr =\u003e arr.join(',')\u003c/code\u003e to concatenate, \u003ccode\u003earr =\u003e arr || []\u003c/code\u003e to return empty array instead of null). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Simulates the behavior of String.prototype.match() with the g flag to find all matches.
 * 
 * @param {string} data.src - The string to search within.
 * @param {string} data.ptn - The regular expression pattern to match in the string.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before matching.
 * 
 * @returns {Array|null} An array of all matches if found, or null if no matches are found.
 *
 * @framework ggLowCodeGTMKit
 */
const matchAll = function(stringToMatch, regexPattern) {
    const matches = [];
    let index = 0;
    
    // Keep matching until no more matches are found
    while (index < stringToMatch.length) {
        // Find the next match starting from the current index
        const match = stringToMatch.substring(index).match(regexPattern);
        
        // If a match is found, add it to the result and update the index
        if (match) {
            matches.push(match[0]); // match[0] is the full match
            index += match.index + match[0].length; // Move index to the end of the match
        } else {
            break;
        }
    }
    
    return matches.length > 0 ? matches : null;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// matchAll - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedString = applyCast(data.pre, data.src);
return out(matchAll(processedString, data.ptn));
*/
// ===============================================================================
// matchAll(...) – Apply Mode
// ===============================================================================
return function(stringToMatch, regexPattern) {
   return out(matchAll(stringToMatch, data.ptn));
};


___TESTS___

scenarios:
  - name: '[example] Find all occurrences'
    code: |
      /* @display
      Value to Process: hello world hello universe hello
      Regular Expression Pattern: hello
      @output
      ['hello', 'hello', 'hello']
      */
      const src = 'hello world hello universe hello';
      const ptn = 'hello';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isEqualTo(['hello', 'hello', 'hello']);
  - name: '[example] Extract all numbers'
    code: |-
      /* @display
      Value to Process: abc123def456ghi789
      Regular Expression Pattern: \\d+
      @output
      ['123', '456', '789']
      */
      const src = 'abc123def456ghi789';
      const ptn = '\\d+';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isEqualTo(['123', '456', '789']);
  - name: Test with regex pattern for word characters
    code: |
      const src = 'one two three';
      const ptn = '\\w+';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isEqualTo(['one', 'two', 'three']);
  - name: Test with single match
    code: |-
      const src = 'hello world';
      const ptn = 'world';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isEqualTo(['world']);
  - name: Test with overlapping pattern possibilities (greedy matching)
    code: |-
      const src = 'aaa';
      const ptn = 'aa';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isEqualTo(['aa']);
  - name: Test with regex for email-like patterns
    code: |-
      const src = 'Contact us at info@example.com or support@test.com';
      const ptn = '\\w+@\\w+\\.\\w+';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isEqualTo(['info@example.com', 'support@test.com']);
  - name: Test with special characters in pattern
    code: |-
      const src = 'price: $10, cost: $20, total: $30';
      const ptn = '\\$\\d+';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isEqualTo(['$10', '$20', '$30']);
  - name: Test with whitespace pattern
    code: |-
      const src = 'hello   world  test';
      const ptn = '\\s+';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isEqualTo(['   ', '  ']);
  - name: Test with empty string returns null
    code: |
      const src = '';
      const ptn = 'test';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isNull();
  - name: Test with undefined pattern returns null
    code: |-
      const src = 'hello world';
      const ptn = undefined;
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isNull();
  - name: Test with invalid input returns null
    code: |
      const src = {};
      const ptn = '2';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isNull();
  - name: '[example] No matches returns null'
    code: |-
      /* @display
      Value to Process: hello world
      Regular Expression Pattern: goodbye
      @output
      null
      */
      const src = 'hello world';
      const ptn = 'goodbye';
      const mockData = {
          src: src,
          ptn: ptn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, ptn);
      }
      assertThat(variableResult).isNull();
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
