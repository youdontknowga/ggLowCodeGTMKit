___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "regexTableLookupCallback(...)",
  "description": "Tests input string against a list of regex patterns and returns the value of the first match. Optionally handles non-matches with a default or callback.",
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
        "type": "SIMPLE_TABLE",
        "name": "tbl",
        "displayName": "Regex Pattern Table",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Regex Pattern",
            "name": "rex",
            "type": "TEXT"
          },
          {
            "defaultValue": "",
            "displayName": "Return Value",
            "name": "val",
            "type": "TEXT"
          }
        ],
        "help": "📋 Table of regex patterns and their corresponding return values. The first matching pattern wins.\u003cbr\u003e\u003cbr\u003e⚠️ \u003cstrong\u003eEscaping note:\u003c/strong\u003e In the regex pattern column, use single backslash (e.g., \u003ccode\u003e\\d+\u003c/code\u003e for digits). GTM automatically handles the escaping.\u003cbr\u003e\u003cbr\u003eExample:\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Pattern: \u003ccode\u003e^/home/?$\u003c/code\u003e → Value: \u003ccode\u003eHome Page\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Pattern: \u003ccode\u003e/products/\u003c/code\u003e → Value: \u003ccode\u003eProducts\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFirst matching pattern\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e/home/\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHome Page\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e/contact/\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "def",
        "displayName": "No Match Handler (optional)",
        "simpleValueType": true,
        "help": "💾 Value to return or function to call when no pattern matches.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eDefault value\u003c/strong\u003e: \u003cem\u003e\"unknown\"\u003c/em\u003e, \u003cem\u003e0\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eCallback function\u003c/strong\u003e: \u003cem\u003estr =\u003e \"No match for: \" + str\u003c/em\u003e"
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template."
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String to Match"
      }
    ],
    "help": "Matches a value against regex patterns and returns the callback result of the first match.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFirst matching pattern\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e/home/\u003c/strong\u003e\u003cbr\u003eRegex Pattern Table: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{rex: \u003cstrong\u003e'^/home/?$', val: 'Home Page'},\u003c/strong\u003e\u003cbr\u003e{rex: \u003cstrong\u003e'/products/', val: 'Products'}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003efunc: \u003cstrong\u003efunc\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eHome Page\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e/contact/\u003c/strong\u003e\u003cbr\u003eRegex Pattern Table: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{rex: \u003cstrong\u003e'^/home/?$', val: 'Home Page'},\u003c/strong\u003e\u003cbr\u003e{rex: \u003cstrong\u003e'/products/', val: 'Products'}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003efunc: \u003cstrong\u003efunc\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the matched value before returning it (e.g., \u003ccode\u003eval =\u003e val.toUpperCase()\u003c/code\u003e, \u003ccode\u003eval =\u003e 'Matched: ' + val\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Performs pattern matching against a string using a table of regex patterns and returns the corresponding value for the first match.
 * 
 * @param {string} data.src - The input string to match against the regex patterns.
 * @param {Array} data.tbl - Array of objects with 'rex' and 'val' properties for regex matching.
 * @param {Function} [data.func] - Optional callback function to handle cases when no pattern matches.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before matching.
 * 
 * @returns {string|any} The value associated with the first matching pattern, or the result of the callback function if no match is found.
 *
 * @framework ggLowCodeGTMKit
 */
const regexTableLookup = function(inputString, table, defaultOrCallback) {
    const test = function(stringToMatch, regexPattern) {
        return stringToMatch.search(regexPattern) !== -1;
    };
    
    for (var i = 0, len = table.length; i < len; i += 1) {
        if (test(inputString, table[i].rex)) {
            return table[i].val;
        }
    }
    
    if (typeof defaultOrCallback === 'function') {
        return defaultOrCallback(inputString);
    }
    
    return defaultOrCallback;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// regexTableLookupCallback - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(regexTableLookup(value, data.tbl, data.func));
*/
// ===============================================================================
// regexTableLookup(...) – Apply Mode
// ===============================================================================
return function(inputString) {
   return out(regexTableLookup(inputString, data.tbl, data.def));
};


___TESTS___

scenarios:
  - name: '[example] First matching pattern'
    code: |-
      /* @display
      Value to Process: /home/
      Regex Pattern Table: [
          {rex: '^/home/?$', val: 'Home Page'},
          {rex: '/products/', val: 'Products'}
      ]
      func: func
      @output
      Home Page
      */
      const src = '/home/';
      const tbl = [
          {rex: '^/home/?$', val: 'Home Page'},
          {rex: '/products/', val: 'Products'}
      ];
      const func = undefined;
      const mockData = {
          src: src,
          tbl: tbl,
          func: func,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const appliedFunc = runCode(mockData);
          variableResult = appliedFunc(src, tbl, func);
      }
      assertThat(variableResult).isEqualTo('Home Page');
  - name: Test second pattern matches when first doesn't
    code: |-
      const src = '/products/shoes';
      const tbl = [
          {rex: '^/home/?$', val: 'Home Page'},
          {rex: '/products/', val: 'Products'}
      ];
      const func = undefined;
      const mockData = {
          src: src,
          tbl: tbl,
          func: func,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tbl, func);
      }
      assertThat(variableResult).isEqualTo('Products');
  - name: No match returns result from no match handler function
    code: |2-
       
      const src = '/about/';
      const tbl = [
          {rex: '^/home/?$', val: 'Home Page'},
          {rex: '/products/', val: 'Products'}
      ];
      const def = function() { return 'Unknown Page'; };
      const mockData = {
          src: src,
          tbl: tbl,
          def: def
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const appliedFunc = runCode(mockData);
          variableResult = appliedFunc(src);
      }
      assertThat(variableResult).isEqualTo('Unknown Page');
  - name: '[example] No match returns undefined'
    code: |-
      /* @display
      Value to Process: /contact/
      Regex Pattern Table: [
          {rex: '^/home/?$', val: 'Home Page'},
          {rex: '/products/', val: 'Products'}
      ]
      func: func
      @output
      undefined
      */
      const src = '/contact/';
      const tbl = [
          {rex: '^/home/?$', val: 'Home Page'},
          {rex: '/products/', val: 'Products'}
      ];
      const func = undefined;
      const mockData = {
          src: src,
          tbl: tbl,
          func: func,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const appliedFunc = runCode(mockData);
          variableResult = appliedFunc(src, tbl, func);
      }
      assertThat(variableResult).isUndefined();
  - name: Test with numeric pattern matching
    code: |-
      const src = 'Product ID: 12345';
      const tbl = [
          {rex: '\\d{5}', val: 'Valid ID'},
          {rex: '\\d{3}', val: 'Short ID'}
      ];
      const func = undefined;
      const mockData = {
          src: src,
          tbl: tbl,
          func: func,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const appliedFunc = runCode(mockData);
          variableResult = appliedFunc(src, tbl, func);
      }
      assertThat(variableResult).isEqualTo('Valid ID');
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
