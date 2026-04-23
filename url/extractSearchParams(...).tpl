___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "extractSearchParams(...)",
  "description": "Extracts the search parameters from a \u003cem\u003eURL\u003c/em\u003e as an \u003cem\u003eobject\u003c/em\u003e (paramnames: values), or specific value if key provided. Returns  \u003cem\u003e{}\u003c/em\u003e if no params, \u003cem\u003eundefined\u003c/em\u003e if invalid.",
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
        "checkboxText": "Extract Specific Parameter",
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
            "name": "key",
            "displayName": "Parameter Key",
            "simpleValueType": true,
            "help": "💾   The specific query parameter key to extract (e.g., 'utm_source', 'id'). If provided, returns only the value of this parameter instead of the entire object.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract all parameters\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: https://example.com?foo=bar\u0026baz=qux\u003cbr\u003eParameter Key: undefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{foo: 'bar', baz: 'qux'}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract specific parameter\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: https://example.com?foo=bar\u0026baz=qux\u003cbr\u003eParameter Key: foo\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ebar\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: URL"
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
            "checkboxText": "⚡Use runtime parameter for: Parameter Key",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Extracts query parameters from a URL as key-value pairs or a specific parameter.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract all parameters\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://example.com?foo=bar\u0026baz=qux\u003c/strong\u003e\u003cbr\u003ekey: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{foo: 'bar', baz: 'qux'}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract specific parameter\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://example.com?foo=bar\u0026baz=qux\u003c/strong\u003e\u003cbr\u003ekey: \u003cstrong\u003efoo\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ebar\u003c/strong\u003e"
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
 * Extracts the searchParams from a given URL, optionally filtering for a specific parameter.
 *
 * @param {string} data.src - The URL to extract the searchParams from.
 * @param {string} [data.key] - Optional specific query parameter key to extract.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before extracting.
 * 
 * @returns {Object<string, (string|Array)>|string|Array|undefined} The searchParams object, specific parameter value, or undefined if invalid.
 *
 * @framework ggLowCodeGTMKit
 */
const parseUrl = require('parseUrl');
const extractSearchParams = function(url, key) {
    const parsed = parseUrl(url);
    if (!parsed || !parsed.searchParams) {
        return undefined;
    }
    if (key !== undefined && key !== null && key !== '') {
        return parsed.searchParams[key];
    }
    return parsed.searchParams;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// extractSearchParams - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(extractSearchParams(value, data.key));
*/
// ===============================================================================
// extractSearchParams(...) – Apply Mode
// ===============================================================================
return function(value, key) {
  key = data.rp1 ? data.key : key;
  return out(extractSearchParams(value, key));
};


___TESTS___

scenarios:
  - name: '[example] Extract all parameters'
    code: |-
      /* @display
      Value to Process: https://example.com?foo=bar&baz=qux
      key: undefined
      @output
      {foo: 'bar', baz: 'qux'}
      */
      const src = 'https://example.com?foo=bar&baz=qux';
      const key = undefined;
      const mockData = {
          src: src,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isEqualTo({foo: 'bar', baz: 'qux'});
  - name: '[example] Extract specific parameter'
    code: |-
      /* @display
      Value to Process: https://example.com?foo=bar&baz=qux
      key: foo
      @output
      bar
      */
      const src = 'https://example.com?foo=bar&baz=qux';
      const key = 'foo';
      const mockData = {
          src: src,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isEqualTo('bar');
  - name: Extract non-existent parameter
    code: |-
      const src = 'https://example.com?foo=bar&baz=qux';
      const key = 'nonexistent';
      const mockData = {
          src: src,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isEqualTo(undefined);
  - name: URL without search parameters
    code: |-
      const src = 'https://example.com';
      const key = undefined;
      const mockData = {
          src: src,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isEqualTo({});
  - name: Extract parameter with duplicate values (array)
    code: |-
      const src = 'https://example.com?tag=red&tag=blue&tag=green';
      const key = 'tag';
      const mockData = {
          src: src,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isEqualTo(['red', 'blue', 'green']);
  - name: Invalid URL
    code: |-
      const src = 'not-a-valid-url';
      const key = undefined;
      const mockData = {
          src: src,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isEqualTo(undefined);
  - name: Empty key parameter (should return all params)
    code: |-
      const src = 'https://example.com?foo=bar&baz=qux';
      const key = '';
      const mockData = {
          src: src,
          key: key,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isEqualTo({foo: 'bar', baz: 'qux'});
  - name: UI-bound mode with static key
    code: |-
      const src = 'https://example.com?utm_source=google&utm_medium=cpc';
      const key = 'ignored';
      const mockData = {
          src: src,
          key: 'utm_source',
          rp1: true
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, key);
      }
      assertThat(variableResult).isEqualTo('google');
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
