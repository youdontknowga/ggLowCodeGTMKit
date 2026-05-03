___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "omitParamsFromString(...)",
  "description": "Remove specific parameters from a query or fragment string. Matching can be case-insensitive.",
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
        "name": "kys",
        "displayName": "Parameters to Omit",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Parameter Name",
            "name": "key",
            "type": "TEXT"
          }
        ],
        "help": "💾 List of parameter names to remove from the string.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove tracking parameters\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eClean hash fragment\u003c/em\u003e***",
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
        "name": "ci",
        "checkboxText": "Case insensitive matching",
        "simpleValueType": true,
        "help": "⚙️ Enable to match parameter names regardless of case (e.g., \"FBCLID\" matches \"fbclid\")."
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
        "displayName": "🔗 Chained callback parameter: Query String or Fragment"
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
            "checkboxText": "⚡Use runtime parameter for: Parameters to Omit",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Removes specified parameters from a query \u003cem\u003estring\u003c/em\u003e or fragment. Useful for cleaning URLs by removing tracking parameters like fbclid, gclid, or PII.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove tracking parameters\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e?utm_source=google\u0026fbclid=123\u0026gclid=456\u0026utm_medium=cpc\u003c/strong\u003e\u003cbr\u003ekeys: \u003cstrong\u003e['fbclid', 'gclid']\u003c/strong\u003e\u003cbr\u003eParameters to Omit: \u003cstrong\u003e[{key: 'fbclid'}, {key: 'gclid'}]\u003c/strong\u003e\u003cbr\u003eCase insensitive matching: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e?utm_source=google\u0026utm_medium=cpc\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eClean hash fragment\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e#section=intro\u0026debug=true\u0026id=123\u003c/strong\u003e\u003cbr\u003ekeys: \u003cstrong\u003e['debug']\u003c/strong\u003e\u003cbr\u003eParameters to Omit: \u003cstrong\u003e[{key: 'debug'}]\u003c/strong\u003e\u003cbr\u003eCase insensitive matching: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e#section=intro\u0026id=123\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Filters a query string or fragment to exclude specified parameters.
 *
 * @param {string} data.src - A string starting with "?" or "#" to filter (e.g., "?a=1&b=2").
 * @param {Array} data.kys - Array of objects with parameter names to exclude.
 * @param {boolean} [data.ci] - Optional flag to enable case-insensitive matching.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function.
 * 
 * @returns {string} A filtered parameter string excluding the matching key-value pairs.
 *
 * @framework ggLowCodeGTMKit
 */
const decodeUriComponent = require('decodeUriComponent');
const encodeUriComponent = require('encodeUriComponent');
const getType = require('getType');
const Object = require('Object');

const createFlatArrayFromValues = function(list, property) {
    const result = [];
    if (!list) return result;
    for (let i = 0; i < list.length; i++) {
        const val = list[i][property];
        if (getType(val) === 'array') {
            for (let j = 0; j < val.length; j++) {
                result.push(val[j]);
            }
        } else if (val) {
            result.push(val);
        }
    }
    return result;
};

const omitParamsFromString = function(input, keys, caseInsensitive) {
    if (!input || !keys || keys.length === 0) {
        return input || '';
    }
    
    const omitMap = {};
    for (let i = 0; i < keys.length; i++) {
        const key = keys[i];
        if (typeof key === 'string') {
            omitMap[caseInsensitive ? key.toLowerCase() : key] = true;
        }
    }
    
    if (Object.keys(omitMap).length === 0) {
        return input;
    }
    
    const hasPrefix = input.charAt(0) === '?' || input.charAt(0) === '#';
    const prefix = hasPrefix ? input.charAt(0) : '';
    const raw = hasPrefix ? input.slice(1) : input;
    
    if (!raw) {
        return prefix;
    }
    
    const filteredPairs = [];
    const pairs = raw.split('&');
    
    for (let i = 0; i < pairs.length; i++) {
        const pair = pairs[i];
        if (!pair) continue;
        
        const eqIndex = pair.indexOf('=');
        const key = eqIndex >= 0 ? pair.slice(0, eqIndex) : pair;
        const lookupKey = caseInsensitive ? key.toLowerCase() : key;
        
        if (!omitMap[lookupKey]) {
            if (eqIndex >= 0) {
                const value = pair.slice(eqIndex + 1);
                const decodedValue = decodeUriComponent(value);
                filteredPairs.push(key + '=' + encodeUriComponent(decodedValue));
            } else {
                filteredPairs.push(key);
            }
        }
    }
    
    const result = filteredPairs.join('&');
    return result ? (prefix + result) : prefix;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// omitParamsFromString - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const input = applyCast(data.pre, data.src);
const keys = createFlatArrayFromValues(data.kys, "key");
return out(omitParamsFromString(input, keys, data.ci));
*/
// ===============================================================================
// omitParamsFromString(...) – Apply Mode
// ===============================================================================
return function(input, keys) {
   keys = data.rp1 ? createFlatArrayFromValues(data.kys, "key") : keys;
   return out(omitParamsFromString(input, keys, data.ci));
};


___TESTS___

scenarios:
  - name: Test omit single parameter
    code: |-
      const src = '?utm_source=google&utm_medium=cpc&fbclid=123';
      const keys = ['fbclid'];
      const mockData = {
          src: src,
          kys: [{key: 'fbclid'}],
          ci: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, keys);
      }
      assertThat(variableResult).isEqualTo('?utm_source=google&utm_medium=cpc');
  - name: '[example] Remove tracking parameters'
    code: |
      /* @display
      Value to Process: ?utm_source=google&fbclid=123&gclid=456&utm_medium=cpc
      keys: ['fbclid', 'gclid']
      Parameters to Omit: [{key: 'fbclid'}, {key: 'gclid'}]
      Case insensitive matching: false
      @output
      ?utm_source=google&utm_medium=cpc
      */
      const src = '?utm_source=google&fbclid=123&gclid=456&utm_medium=cpc';
      const keys = ['fbclid', 'gclid'];
      const mockData = {
          src: src,
          kys: [{key: 'fbclid'}, {key: 'gclid'}],
          ci: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, keys);
      }
      assertThat(variableResult).isEqualTo('?utm_source=google&utm_medium=cpc');
  - name: Test case insensitive matching
    code: |-
      const src = '?UTM_SOURCE=google&FBCLID=123';
      const keys = ['fbclid'];
      const mockData = {
          src: src,
          kys: [{key: 'fbclid'}],
          ci: true
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, keys);
      }
      assertThat(variableResult).isEqualTo('?UTM_SOURCE=google');
  - name: '[example] Clean hash fragment'
    code: |-
      /* @display
      Value to Process: #section=intro&debug=true&id=123
      keys: ['debug']
      Parameters to Omit: [{key: 'debug'}]
      Case insensitive matching: false
      @output
      #section=intro&id=123
      */
      const src = '#section=intro&debug=true&id=123';
      const keys = ['debug'];
      const kys = [{key: 'debug'}];
      const mockData = {
          src: src,
          kys: kys,
          ci: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, keys);
      }
      assertThat(variableResult).isEqualTo('#section=intro&id=123');
  - name: Test empty input returns empty string
    code: |-
      const src = '';
      const keys = ['fbclid'];
      const mockData = {
          src: src,
          kys: [{key: 'fbclid'}],
          ci: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, keys);
      }
      assertThat(variableResult).isEqualTo('');
  - name: Test no keys returns original input
    code: |-
      const src = '?utm_source=google&fbclid=123';
      const mockData = {
          src: src,
          kys: [],
          ci: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, []);
      }
      assertThat(variableResult).isEqualTo('?utm_source=google&fbclid=123');
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
