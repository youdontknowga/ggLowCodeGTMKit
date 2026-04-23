___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "regexTableLookupAll",
  "description": "Performs pattern matching against a \u003cem\u003estring\u003c/em\u003e using a table of regex patterns and returns an \u003cem\u003earray\u003c/em\u003e of all corresponding values for matching patterns.",
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
        "help": "💾 The input string to match against regex patterns.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
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
        "help": "📋 Table of regex patterns and their corresponding return values. All matching patterns will be returned in an array.\u003cbr\u003e\u003cbr\u003e⚠️ \u003cstrong\u003eEscaping note:\u003c/strong\u003e In the regex pattern column, use single backslash (e.g., \u003ccode\u003e\\d+\u003c/code\u003e for digits). GTM automatically handles the escaping.\u003cbr\u003e\u003cbr\u003eExample:\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Pattern: \u003ccode\u003eHello\u003c/code\u003e → Value: \u003ccode\u003egreeting\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Pattern: \u003ccode\u003e\\d+\u003c/code\u003e → Value: \u003ccode\u003enumber\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMultiple regex matches\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e/products/category/shoes\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSingle regex match\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e/home/\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "def",
        "displayName": "No Match Handler (optional)",
        "simpleValueType": true,
        "help": "💾 Value to return or function to call when no pattern matches.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eDefault value\u003c/strong\u003e: \u003cem\u003e[]\u003c/em\u003e, \u003cem\u003e[\"unknown\"]\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eCallback function\u003c/strong\u003e: \u003cem\u003estr =\u003e [\"No match for: \" + str]\u003c/em\u003e"
      }
    ],
    "help": "Matches a value against a table of regex patterns and returns all matching results.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMultiple regex matches\u003c/em\u003e***\u003cbr\u003eInput String: \u003cstrong\u003e/products/category/shoes\u003c/strong\u003e\u003cbr\u003eRegex Pattern Table: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{rex: \u003cstrong\u003e'/products/', val: 'Products Section'},\u003c/strong\u003e\u003cbr\u003e{rex: \u003cstrong\u003e'/category/', val: 'Category Page'},\u003c/strong\u003e\u003cbr\u003e{rex: \u003cstrong\u003e'/shoes', val: 'Shoes'},\u003c/strong\u003e\u003cbr\u003e{rex: \u003cstrong\u003e'/admin/', val: 'Admin'}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e3\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSingle regex match\u003c/em\u003e***\u003cbr\u003eInput String: \u003cstrong\u003e/home/\u003c/strong\u003e\u003cbr\u003eRegex Pattern Table: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{rex: \u003cstrong\u003e'^/home/?$', val: 'Home Page'},\u003c/strong\u003e\u003cbr\u003e{rex: \u003cstrong\u003e'/products/', val: 'Products'},\u003c/strong\u003e\u003cbr\u003e{rex: \u003cstrong\u003e'/about/', val: 'About'}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the string before pattern matching (e.g., normalize case, clean whitespace)."
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
        "help": "⚙️ Optional function to apply to the result array before returning it (e.g., \u003ccode\u003earr =\u003e arr.join(',')\u003c/code\u003e to concatenate, \u003ccode\u003earr =\u003e arr.length\u003c/code\u003e for count, \u003ccode\u003earr =\u003e arr[0]\u003c/code\u003e for first match only). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Performs pattern matching against a string using a table of regex patterns and returns an array of all corresponding values for matching patterns.
 * 
 * @param {string} data.src - The input string to match against the regex patterns.
 * @param {Array} data.tbl - Array of objects with 'rex' and 'val' properties for regex matching.
 * @param {*|Function} [data.def] - Optional default value or callback function to handle cases when no pattern matches.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before matching.
 * 
 * @returns {Array|any} An array of values associated with all matching patterns, or the result of the default handler if no matches are found.
 *
 * @framework ggLowCodeGTMKit
 */
const regexTableLookupAll = function(inputString, table, defaultOrCallback) {
    const test = function(stringToMatch, regexPattern) {
        return stringToMatch.search(regexPattern) !== -1;
    };
    
    const matches = [];
    
    for (var i = 0, len = table.length; i < len; i += 1) {
        if (test(inputString, table[i].rex)) {
            matches.push(table[i].val);
        }
    }
    
    // Handle no match case
    if (matches.length === 0) {
        if (typeof defaultOrCallback === 'function') {
            return defaultOrCallback(inputString);
        }
        if (defaultOrCallback !== undefined) {
            return defaultOrCallback;
        }
    }
    
    return matches;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// regexTableLookupAll - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(regexTableLookupAll(value, data.tbl, data.def));
// ===============================================================================
// regexTableLookupAll(...) – Apply Mode
// ===============================================================================
/*
return function(inputString) {
   return out(regexTableLookupAll(inputString, data.tbl, data.def));
};
*/


___TESTS___

scenarios:
  - name: '[example] Multiple regex matches'
    code: |-
      /* @display
      Input String: /products/category/shoes
      Regex Pattern Table: [
          {rex: '/products/', val: 'Products Section'},
          {rex: '/category/', val: 'Category Page'},
          {rex: '/shoes', val: 'Shoes'},
          {rex: '/admin/', val: 'Admin'}
      ]
      @output
      3
      */
      const src = "/products/category/shoes";
      const tbl = [
          {rex: '/products/', val: 'Products Section'},
          {rex: '/category/', val: 'Category Page'},
          {rex: '/shoes', val: 'Shoes'},
          {rex: '/admin/', val: 'Admin'}
      ];
      const mockData = {
          src: src,
          tbl: tbl
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult.length).isEqualTo(3);
      assertThat(variableResult[0]).isEqualTo('Products Section');
      assertThat(variableResult[1]).isEqualTo('Category Page');
      assertThat(variableResult[2]).isEqualTo('Shoes');
  - name: '[example] Single regex match'
    code: |-
      /* @display
      Input String: /home/
      Regex Pattern Table: [
          {rex: '^/home/?$', val: 'Home Page'},
          {rex: '/products/', val: 'Products'},
          {rex: '/about/', val: 'About'}
      ]
      @output
      1
      */
      const src = "/home/";
      const tbl = [
          {rex: '^/home/?$', val: 'Home Page'},
          {rex: '/products/', val: 'Products'},
          {rex: '/about/', val: 'About'}
      ];
      const mockData = {
          src: src,
          tbl: tbl
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult.length).isEqualTo(1);
      assertThat(variableResult[0]).isEqualTo('Home Page');
  - name: Test no matches with callback
    code: |-
      const src = "/unknown/path";
      const tbl = [
          {rex: '^/home/?$', val: 'Home Page'},
          {rex: '/products/', val: 'Products'}
      ];
      const def = function(str) { return ['No match for: ' + str]; };
      const mockData = {
          src: src,
          tbl: tbl,
          def: def
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult[0]).isEqualTo('No match for: /unknown/path');
  - name: Test no matches without callback returns empty array
    code: |-
      const src = "/unknown/path";
      const tbl = [
          {rex: '^/home/?$', val: 'Home Page'},
          {rex: '/products/', val: 'Products'}
      ];
      const mockData = {
          src: src,
          tbl: tbl
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult.length).isEqualTo(0);
  - name: Test all patterns match
    code: |-
      const src = "Product ID: 12345, Status: active";
      const tbl = [
          {rex: 'Product', val: 'Has Product'},
          {rex: '\\d+', val: 'Has Numbers'},
          {rex: 'Status', val: 'Has Status'},
          {rex: 'active', val: 'Is Active'}
      ];
      const mockData = {
          src: src,
          tbl: tbl
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult.length).isEqualTo(4);
      assertThat(variableResult[0]).isEqualTo('Has Product');
      assertThat(variableResult[3]).isEqualTo('Is Active');
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
