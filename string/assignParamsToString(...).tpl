___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "assignParamsToString(...)",
  "description": "Adds or replaces parameters in a query or fragment string. By default adds only missing parameters. Supports overwrite mode and case-insensitive matching.",
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
        "name": "prm",
        "displayName": "Parameters to Assign",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Parameter Name",
            "name": "key",
            "type": "TEXT"
          },
          {
            "defaultValue": "",
            "displayName": "Parameter Value",
            "name": "val",
            "type": "TEXT"
          }
        ],
        "help": "📋 Parameters to add or replace in the string. Behavior depends on the Overwrite Mode setting below.",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "ovr",
        "simpleValueType": true,
        "help": "☑️ If enabled, replaces existing parameters with new values. If disabled, only adds parameters that don't already exist (default behavior).",
        "checkboxText": "Overwrite Mode",
        "enablingConditions": []
      },
      {
        "type": "CHECKBOX",
        "name": "cas",
        "simpleValueType": true,
        "help": "☑️ If enabled, parameter name comparison will ignore letter casing (e.g. utm_source = UTM_SOURCE).",
        "checkboxText": "Case-Insensitive Matching",
        "enablingConditions": []
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Assigns or replaces parameters in a query or fragment \u003cem\u003estring\u003c/em\u003e. In default mode, only adds missing parameters. In overwrite mode, replaces existing parameters with new values.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAdd missing parameters\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e\"?name=john\u0026age=25\" + {city: \"paris\"}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\"?name=john\u0026age=25\u0026city=paris\"\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBuild from empty string\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e\"?\" + {name: \"john\", city: \"paris\"}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\"?name=john\u0026city=paris\"\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Parameter String"
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
            "checkboxText": "⚡Use runtime parameter for: Parameters to Assign",
            "simpleValueType": true
          }
        ]
      }
    ],
     "help": "Assigns or replaces parameters in a query or fragment string. In default mode, only adds missing parameters. In overwrite mode, replaces existing parameters with new values.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAdd missing parameters\u003c/em\u003e***\u003cbr\u003eParameter String: \u003cstrong\u003e?page=home\u003c/strong\u003e\u003cbr\u003eParameters to Assign: \u003cstrong\u003e[{key: \"utm_source\", val: \"website\"}, {key: \"utm_medium\", val: \"organic\"}]\u003c/strong\u003e\u003cbr\u003eCase-Insensitive Matching: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e?page=home\u0026utm_source=website\u0026utm_medium=organic\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBuild from empty string\u003c/em\u003e***\u003cbr\u003eParameter String: \u003cstrong\u003e?\u003c/strong\u003e\u003cbr\u003eParameters to Assign: \u003cstrong\u003e[{key: \"utm_source\", val: \"website\"}, {key: \"utm_medium\", val: \"organic\"}]\u003c/strong\u003e\u003cbr\u003eCase-Insensitive Matching: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e?utm_source=website\u0026utm_medium=organic\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result string before returning it (e.g., \u003ccode\u003estr =\u003e str.toUpperCase()\u003c/code\u003e, \u003ccode\u003estr =\u003e encodeURIComponent(str)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Assigns or replaces parameters in a query or fragment string.
 * 
 * @param {string} data.src - A string starting with "?" or "#" (e.g. "?a=1&b=2").
 * @param {Array<Object>} data.prm - Array of objects with key and val properties.
 * @param {boolean} data.ovr - If true, replaces existing params; if false, only adds missing ones.
 * @param {boolean} data.cas - Optional flag to enable case-insensitive matching.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function.
 * 
 * @returns {string} The resulting query string with parameters updated or added.
 *
 * @framework ggLowCodeGTMKit
 */
const decodeUriComponent = require('decodeUriComponent');
const encodeUriComponent = require('encodeUriComponent');
const makeTableMap = require('makeTableMap');

const assignParamsToString = function(input, params, overwrite, caseInsensitive) {
    const inputStr = input || '';
    const paramsObj = params || {};
    const shouldOverwrite = !!overwrite;
    const caseSensitive = !!caseInsensitive;
    
    const hasPrefix = inputStr.charAt(0) === '?' || inputStr.charAt(0) === '#';
    const prefix = hasPrefix ? inputStr.charAt(0) : '';
    const raw = hasPrefix ? inputStr.slice(1) : inputStr;
    const existingParams = {};
    const pairs = raw ? raw.split('&') : [];
    
    for (let i = 0; i < pairs.length; i++) {
        const pair = pairs[i];
        if (!pair) continue;
        const eqIndex = pair.indexOf('=');
        const key = eqIndex >= 0 ? pair.slice(0, eqIndex) : pair;
        const lookupKey = caseSensitive ? key.toLowerCase() : key;
        existingParams[lookupKey] = true;
    }
    
    const resultPairs = shouldOverwrite ? [] : pairs.slice();
    
    for (let key in paramsObj) {
        if (paramsObj.hasOwnProperty(key)) {
            const lookupKey = caseSensitive ? key.toLowerCase() : key;
            if (!existingParams[lookupKey] || shouldOverwrite) {
                const encodedKey = encodeUriComponent(key);
                const encodedVal = encodeUriComponent(paramsObj[key] || '');
                resultPairs.push(encodedKey + '=' + encodedVal);
            }
        }
    }
    
    const result = resultPairs.join('&');
    return result ? (prefix + result) : prefix;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// assignParamsToString - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
const paramsObj = makeTableMap(data.prm, 'key', 'val');
return out(assignParamsToString(value, paramsObj, data.ovr, data.cas));
*/
// ===============================================================================
// assignParamsToString(...) – Apply Mode
// ===============================================================================
return function(value, params, overwrite, caseInsensitive) {
   params = data.rp1 ? makeTableMap(data.prm, 'key', 'val') : params;
   return out(assignParamsToString(value, params, data.ovr, data.cas));
};


___TESTS___

scenarios:
  - name: '[example] Add missing parameters'
    code: |
      /* @display
      Value to Process: ?page=home
      Parameters to Assign: [{key: "utm_source", val: "website"}, {key: "utm_medium", val: "organic"}]
      Case-Insensitive Matching: false
      @output
      ?page=home&utm_source=website&utm_medium=organic
      */
      const src = "?page=home";
      const prm = [{key: "utm_source", val: "website"}, {key: "utm_medium", val: "organic"}];
      const cas = false;
      const mockData = {
          src: src,
          prm: prm,
          cas: cas,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, {utm_source: "website", utm_medium: "organic"}, cas);
      }
      assertThat(variableResult).isEqualTo("?page=home&utm_source=website&utm_medium=organic");
  - name: Test with existing parameters - should not add duplicates
    code: |
      const src = "?utm_source=email&page=home";
      const prm = [{key: "utm_source", val: "website"}, {key: "utm_medium", val: "organic"}];
      const cas = false;
      const mockData = {
          src: src,
          prm: prm,
          cas: cas,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, {utm_source: "website", utm_medium: "organic"}, cas);
      }
      assertThat(variableResult).isEqualTo("?utm_source=email&page=home&utm_medium=organic");
  - name: Test with case-insensitive matching
    code: |
      const src = "?UTM_SOURCE=email&page=home";
      const prm = [{key: "utm_source", val: "website"}, {key: "utm_medium", val: "organic"}];
      const cas = true;
      const mockData = {
          src: src,
          prm: prm,
          cas: cas,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, {utm_source: "website", utm_medium: "organic"}, cas);
      }
      assertThat(variableResult).isEqualTo("?UTM_SOURCE=email&page=home&utm_medium=organic");
  - name: Test with fragment string (# prefix)
    code: |-
      const src = "#section=intro";
      const prm = [{key: "highlight", val: "true"}, {key: "view", val: "full"}];
      const cas = false;
      const mockData = {
          src: src,
          prm: prm,
          cas: cas,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, {highlight: "true", view: "full"}, cas);
      }
      assertThat(variableResult).isEqualTo("#section=intro&highlight=true&view=full");
  - name: '[example] Build from empty string'
    code: |
      /* @display
      Value to Process: ?
      Parameters to Assign: [{key: "utm_source", val: "website"}, {key: "utm_medium", val: "organic"}]
      Case-Insensitive Matching: false
      @output
      ?utm_source=website&utm_medium=organic
      */
      const src = "?";
      const prm = [{key: "utm_source", val: "website"}, {key: "utm_medium", val: "organic"}];
      const cas = false;
      const mockData = {
          src: src,
          prm: prm,
          cas: cas,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, {utm_source: "website", utm_medium: "organic"}, cas);
      }
      assertThat(variableResult).isEqualTo("?utm_source=website&utm_medium=organic");
  - name: Test with special characters requiring encoding
    code: |-
      const src = "?page=home";
      const prm = [{key: "redirect_url", val: "https://example.com/path?q=test"}, {key: "user name", val: "John Doe"}];
      const cas = false;
      const mockData = {
          src: src,
          prm: prm,
          cas: cas,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, {"redirect_url": "https://example.com/path?q=test", "user name": "John Doe"}, cas);
      }
      assertThat(variableResult).contains("redirect_url=https%3A%2F%2Fexample.com%2Fpath%3Fq%3Dtest");
      assertThat(variableResult).contains("user%20name=John%20Doe");
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
