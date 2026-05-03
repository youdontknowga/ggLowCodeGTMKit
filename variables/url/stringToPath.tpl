___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "stringToPath",
  "description": "Converts a \u003cem\u003estring\u003c/em\u003e to a property path \u003cem\u003earray\u003c/em\u003e using dot and bracket notation parsing. Supports quoted keys, array indices, and mixed notation.",
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
        "displayName": "Path to Property",
        "simpleValueType": true,
        "help": "💾   Property path using dot and bracket notation."
      }
    ],
    "help": "Converts a dot/bracket notation string into a path array.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDot notation to path\u003c/em\u003e***\u003cbr\u003ePath to Property: \u003cstrong\u003euser.name.first\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\"user\", \"name\", \"first\"]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBracket notation with index\u003c/em\u003e***\u003cbr\u003ePath to Property: \u003cstrong\u003eitems[0]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\"items\", \"0\"]\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert object to string, normalize case). Internal transformations such as case handling will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str + ' €', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Converts a string to a property path array.
 * 
 * @param {string} data.src - The string to convert to a property path array.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
 * 
 * @returns {Array} Returns the property path array, or empty array if input is invalid.
 * @author Lodash (https://lodash.com) - Original regex and parsing approach
 * @see https://github.com/lodash/lodash/blob/master/stringToPath.js
 * @modified by GwenG – Rewrote the full function to adapt to the ggLowCodeGTMKit framework
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const stringToPath = function(path) {
   if (getType(path) === 'array') return path;
   if (typeof path !== 'string') return [];
   if (path === '') return [];
   if (path.indexOf('[') === -1 && path.indexOf('\\') === -1) return path.split('.');
   
   const pathSegmentRegex = "[^.[\\]]+|\\[(?:(-?\\d+(?:\\.\\d+)?)|([\"'])((?:(?!\\2)[^\\\\]|\\\\.)*?)\\2)\\]";
   const escapedCharRegex = '\\\\(.)';
   let pathSegments = [];
   let unparsed = path;
   
   while (unparsed.charAt(0) === '.') {
       pathSegments.push('');
       unparsed = unparsed.slice(1);
   }
   
   while (unparsed.length > 0) {
       const segmentMatch = unparsed.match(pathSegmentRegex);
       if (!segmentMatch) {
           break;
       }
       const matchedSegment = segmentMatch[0];
       const numberIndex = segmentMatch[1];
       const quoteType = segmentMatch[2];
       const quotedKey = segmentMatch[3];
       
       if (quoteType && quotedKey) {
           let escapedQuotedKey = quotedKey;
           let unescapedKey = '';
           while (escapedQuotedKey.length > 0) {
               const escapeMatch = escapedQuotedKey.match(escapedCharRegex);
               if (!escapeMatch) {
                   unescapedKey += escapedQuotedKey;
                   break;
               }
               unescapedKey += escapedQuotedKey.substring(0, escapeMatch.index);
               unescapedKey += escapeMatch[1];
               escapedQuotedKey = escapedQuotedKey.substring(escapeMatch.index + escapeMatch[0].length);
           }
           pathSegments.push(unescapedKey);
       } else if (numberIndex) {
           const stringifiedIndex = numberIndex.toString();
           pathSegments.push(stringifiedIndex);
       } else if (matchedSegment) {
           pathSegments.push(matchedSegment);
       }
       unparsed = unparsed.substring(segmentMatch.index + matchedSegment.length);
   }
   
   let trailingDots = 0;
   let dotPosition = path.length - 1;
   while (dotPosition >= 0 && path.charAt(dotPosition) === '.') {
       trailingDots++;
       dotPosition--;
   }
   for (let dotIndex = 0; dotIndex < trailingDots; dotIndex++) {
       pathSegments.push('');
   }
   return pathSegments;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// stringToPath - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(stringToPath(value));
// ===============================================================================
// stringToPath() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(stringToPath(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Dot notation to path'
    code: |-
      /* @display
      Path to Property: user.name.first
      @output
      ["user", "name", "first"]
      */
      const src = "user.name.first";
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
      assertThat(variableResult).isEqualTo(["user", "name", "first"]);
  - name: '[example] Bracket notation with index'
    code: |-
      /* @display
      Path to Property: items[0]
      @output
      ["items", "0"]
      */
      const src = "items[0]";
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
      assertThat(variableResult).isEqualTo(["items", "0"]);
  - name: Mixed dot and bracket notation with numbers
    code: |-
      const src =  'companies[0].employees[5].address';
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
      assertThat(variableResult).isEqualTo(['companies', '0', 'employees', '5', 'address']);
  - name: Bracket notation with quoted strings containing dots
    code: |-
      const src =  'data["special.key"]["quoted.value"]';
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
      assertThat(variableResult).isEqualTo(['data', 'special.key', 'quoted.value']);
  - name: Path with leading dot
    code: |-
      const src =  '.config.settings';
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
      assertThat(variableResult).isEqualTo(['', 'config', 'settings']);
  - name: Multiple consecutive bracket notations
    code: |-
      const src =  'array[0][1][2]';
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
      assertThat(variableResult).isEqualTo(['array', '0', '1', '2']);
  - name: Path with consecutive dots (skips empty parts)
    code: |-
      const src = 'users..admin';
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
      assertThat(variableResult).isEqualTo(['users', '', 'admin']);
  - name: Path with unclosed bracket
    code: |-
      const src = 'test[invalid';
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
      assertThat(variableResult).isEqualTo(['test', 'invalid']);
  - name: Complex path with multiple notation types
    code: |-
      const src =  'complex[3].nested["key with spaces"][\'quotes\'][2][abc]';
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
      assertThat(variableResult).isEqualTo(['complex', '3', 'nested', 'key with spaces', 'quotes', '2', 'abc']);
  - name: Path with NaN inside brackets
    code: |-
      const src =  'deeply.nested[NaN].property';
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
      assertThat(variableResult).isEqualTo(['deeply', 'nested', 'NaN', 'property']);
  - name: Empty brackets between segments
    code: |-
      const src =  'edge[]case';
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
      assertThat(variableResult).isEqualTo(['edge', 'case']);
  - name: Extremely complex mixed path
    code: |+
      const src =  'a.very[0][\'complex\'].path.with["all"][42].possible[\'notations\'][].mixed[]together';
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
      assertThat(variableResult).isEqualTo(['a', 'very', '0', 'complex', 'path', 'with', 'all', '42', 'possible', 'notations', 'mixed', 'together']);

  - name: Multiple leading dots
    code: |-
      const src =  '..deeply.nested';
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
      assertThat(variableResult).isEqualTo(['','', 'deeply', 'nested']);
  - name: Escaped quotes in bracket notation
    code: |-
      const src =  'object["key with \"escaped\" quotes"]';
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
      assertThat(variableResult).isEqualTo(['object', '"key with "escaped" quotes"']);
  - name: Brackets inside quotes
    code: |-
      const src =  'data["[bracketed]"]';
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
      assertThat(variableResult).isEqualTo(['data', '[bracketed]']);
  - name: Floating point numbers in brackets
    code: |-
      const src =  'values[3.14][0.999]';
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
      assertThat(variableResult).isEqualTo(['values', '3.14', '0.999']);
  - name: Negative numbers in brackets
    code: |-
      const src =  'array[-1][-42]';
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
      assertThat(variableResult).isEqualTo(['array', '-1', '-42']);
  - name: Mixed quote types
    code: |-
      const src =  'obj["double"][\'"].single[\'"\'][mixed\'quotes]';
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
      assertThat(variableResult).isEqualTo(['obj', 'double', '\'"', 'single', '"', "mixed'quotes"]);
  - name: Just a string with no dots or brackets
    code: |-
      const src =  'justASimpleString';
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
      assertThat(variableResult).isEqualTo(['justASimpleString']);
  - name: Empty string
    code: |-
      const src =  '';
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
      assertThat(variableResult).isEqualTo([]);
  - name: String with just a dot
    code: |-
      const src =  '.';
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
      assertThat(variableResult).isEqualTo(['', '']);
  - name: Trailing dots
    code: |-
      const src =  'h....';
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
      assertThat(variableResult).isEqualTo(['h', '', '', '', '']);
  - name: Invalid input return empty array
    code: |-
      const src = {};
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
      assertThat(variableResult).isEqualTo([]);
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
