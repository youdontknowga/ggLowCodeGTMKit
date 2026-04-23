___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "extract(...)",
  "description": "Extracts from a \u003cem\u003estring\u003c/em\u003e using \u003cem\u003eregex\u003c/em\u003e. Returns first capture group if present, otherwise full match. Returns \u003cem\u003eundefined\u003c/em\u003eif no match found.",
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
        "name": "rex",
        "displayName": "Regex Pattern",
        "simpleValueType": true,
        "help": "💾   A regular expression pattern used for extraction.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003eThe \u003cem\u003eRegex Pattern\u003c/em\u003e input allows the definition of the regular expression to test for matches in the provided parameter. \u003cstrong\u003eIn this environment, a single backslash (\\) is permitted within the regular expression.\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eSupports capturing groups, but does not support flag groups (e.g., (?i) for case-insensitivity).\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eThe regular expression is case-sensitive by default.\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e\u003cem\u003eExample Patterns:\u003cbr\u003e\\d: Matches any digit (0-9).\u003cbr\u003e\\w: Matches any word character (letters, digits, and underscores).\u003cbr\u003e\\s: Matches any whitespace character (spaces, tabs, etc.).\u003c/em\u003e",
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
        "help": "Extracts from a \u003cem\u003estring\u003c/em\u003e using regex. Returns first capture group if present, otherwise full match. Returns \u003cem\u003eundefined\u003c/em\u003e if no match found.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract numbers from string\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: Hello World 123\u003cbr\u003eRegex Pattern: \\\\d+\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e123\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 12345\u003cbr\u003eRegex Pattern: \\\\d+\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGA cookie CID extraction\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eGA1.1.790863531.1759168565\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e790863531.1759168565\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String To Extract From"
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
            "checkboxText": "⚡Use runtime parameter for: Regex Pattern",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Extracts from a \u003cem\u003estring\u003c/em\u003e using \u003cem\u003eregex\u003c/em\u003e. Returns first capture group if present, otherwise full match. Returns \u003cem\u003eundefined\u003c/em\u003eif no match found.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract numbers from string\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eHello World 123\u003c/strong\u003e\u003cbr\u003eRegex Pattern: \u003cstrong\u003e\\\\d+\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e123\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003eRegex Pattern: \u003cstrong\u003e\\\\d+\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGA cookie CID extraction\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eGA1.1.790863531.1759168565\u003c/strong\u003e\u003cbr\u003eRegex Pattern: \u003cstrong\u003e\\\\d+\\\\.\\\\d+\\\\.(\\\\d+\\\\.\\\\d+)$\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e790863531.1759168565\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toUpperCase(), val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Matches the provided string against the given regular expression pattern.
 * 
 * @param {string} data.src - The string to search within.
 * @param {string} data.rex - The regular expression pattern to match in the string.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before matching.
 * 
 * @returns {string|undefined} The first capture group if present, otherwise the full match. Returns undefined if no match is found or input is invalid.
 *
 * @framework ggLowCodeGTMKit
 */

const matchRegex = function(stringToMatch, regexPattern) {
   if (typeof stringToMatch !== 'string' || typeof regexPattern !== 'string') { 
       return undefined; 
   }
   const match = stringToMatch.match(regexPattern);
   if (match === null) return undefined;
   // Return captured group if exists, otherwise full match
   return match[1] !== undefined ? match[1] : match[0];
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// matchRegex - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(matchRegex(value, data.rex));
*/
// ===============================================================================
// matchRegex(...) – Apply Mode
// ===============================================================================
return function(value, regexPattern) {
  regexPattern = data.rp1 ? data.rex : regexPattern;
  return out(matchRegex(value, regexPattern));
};


___TESTS___

scenarios:
  - name: '[example] Extract numbers from string'
    code: |-
      /* @display
      Value to Process: Hello World 123
      Regex Pattern: \\d+
      @output
      123
      */
      const src = 'Hello World 123';
      const rex = '\\d+';
      const mockData = {
          src: src,
          rex: rex,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rex);
      }
      assertThat(variableResult).isEqualTo('123');
  - name: Email pattern match
    code: |-
      const src = 'Contact us at support@example.com for help';
      const rex = '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}';
      const mockData = {
          src: src,
          rex: rex,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rex);
      }
      assertThat(variableResult).isEqualTo('support@example.com');
  - name: No match found
    code: |-
      const src = 'Hello World';
      const rex = '\\d+';
      const mockData = {
          src: src,
          rex: rex,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rex);
      }
      assertThat(variableResult).isEqualTo(undefined);
  - name: Word pattern match
    code: |-
      const src = 'The quick brown fox';
      const rex = '\\bquick\\b';
      const mockData = {
          src: src,
          rex: rex,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rex);
      }
      assertThat(variableResult).isEqualTo('quick');
  - name: '[example] Non-string input returns undefined'
    code: |-
      /* @display
      Value to Process: 12345
      Regex Pattern: \\d+
      @output
      undefined
      */
      const src = 12345;
      const rex = '\\d+';
      const mockData = {
          src: src,
          rex: rex,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rex);
      }
      assertThat(variableResult).isEqualTo(undefined);
  - name: Invalid regex pattern (non-string)
    code: |-
      const src = 'Hello World 123';
      const rex = 123;
      const mockData = {
          src: src,
          rex: rex,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rex);
      }
      assertThat(variableResult).isEqualTo(undefined);
  - name: Empty string input
    code: |-
      const src = '';
      const rex = '\\d+';
      const mockData = {
          src: src,
          rex: rex,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rex);
      }
      assertThat(variableResult).isEqualTo(undefined);
  - name: UI-bound mode with static regex
    code: |-
      const src = 'Price: $99.99 only';
      const rex = 'ignored-pattern';
      const mockData = {
          src: src,
          rex: '\\$\\d+\\.\\d+',
          rp1: true
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rex);
      }
      assertThat(variableResult).isEqualTo('$99.99');
  - name: Multiple matches (returns first)
    code: |-
      const src = 'abc123def456ghi789';
      const rex = '\\d+';
      const mockData = {
          src: src,
          rex: rex,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rex);
      }
      assertThat(variableResult).isEqualTo('123');
  - name: Case-sensitive pattern
    code: |-
      const src = 'Hello WORLD hello';
      const rex = 'hello';
      const mockData = {
          src: src,
          rex: rex,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rex);
      }
      assertThat(variableResult).isEqualTo('hello');
  - name: '[example] GA cookie CID extraction'
    code: |-
      /* @display
      Value to Process: GA1.1.790863531.1759168565
      Regex Pattern: \\d+\\.\\d+\\.(\\d+\\.\\d+)$
      @output
      790863531.1759168565
      */
      const src = 'GA1.1.790863531.1759168565';
      const rex = '\\d+\\.\\d+\\.(\\d+\\.\\d+)$';
      const mockData = {
          src: src,
          rex: rex,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rex);
      }
      assertThat(variableResult).isEqualTo('790863531.1759168565');
  - name: Capture group extraction - Email username only
    code: |-
      const src = 'Contact support@example.com for help';
      const rex = '([a-zA-Z0-9._%+-]+)@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}';
      const mockData = {
          src: src,
          rex: rex,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, rex);
      }
      assertThat(variableResult).isEqualTo('support');
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
