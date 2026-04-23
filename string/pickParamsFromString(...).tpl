___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "pickParamsFromString(...)",
  "description": "Extract specific parameters from a query or fragment string, with optional case-insensitive matching.",
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
        "displayName": "Parameters to Keep",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Parameter Name",
            "name": "key",
            "type": "TEXT"
          }
        ],
        "help": "💾 List of parameter names to keep. All other parameters will be removed.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eKeep only UTM parameters\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePick from hash fragment\u003c/em\u003e***",
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
        "help": "⚙️ Enable to match parameter names regardless of case (e.g., \"UTM_SOURCE\" matches \"utm_source\")."
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
            "checkboxText": "⚡Use runtime parameter for: Parameters to Keep",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Keeps only specified parameters from a query \u003cem\u003estring\u003c/em\u003e or fragment, removing all others. Useful for preserving UTM parameters while stripping tracking IDs.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eKeep only UTM parameters\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e?utm_source=google\u0026fbclid=123\u0026gclid=456\u0026utm_medium=cpc\u003c/strong\u003e\u003cbr\u003ekeys: \u003cstrong\u003e['utm_source', 'utm_medium']\u003c/strong\u003e\u003cbr\u003eParameters to Keep: \u003cstrong\u003e[{key: 'utm_source'}, {key: 'utm_medium'}]\u003c/strong\u003e\u003cbr\u003eCase insensitive matching: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e?utm_source=google\u0026utm_medium=cpc\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePick from hash fragment\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e#section=intro\u0026debug=true\u0026id=123\u003c/strong\u003e\u003cbr\u003ekeys: \u003cstrong\u003e['section', 'id']\u003c/strong\u003e\u003cbr\u003eParameters to Keep: \u003cstrong\u003e[{key: 'section'}, {key: 'id'}]\u003c/strong\u003e\u003cbr\u003eCase insensitive matching: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e#section=intro\u0026id=123\u003c/strong\u003e"
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
 * Filters a query string or fragment to keep only specified parameters.
 *
 * @param {string} data.src - A string starting with "?" or "#" to filter (e.g., "?a=1&b=2").
 * @param {Array} data.kys - Array of objects with parameter names to keep.
 * @param {boolean} [data.ci] - Optional flag to enable case-insensitive matching.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function.
 * 
 * @returns {string} A filtered parameter string containing only the matching key-value pairs.
 *
 * @framework ggLowCodeGTMKit
 */
const decodeUriComponent = require('decodeUriComponent');
const encodeUriComponent = require('encodeUriComponent');
const getType = require('getType');

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

const pickParamsFromString = function(input, keys, caseInsensitive) {
    if (!input) {
        return '';
    }
    
    if (!keys || keys.length === 0) {
        return input.charAt(0) === '?' || input.charAt(0) === '#' ? input.charAt(0) : '';
    }
    
    const pickMap = {};
    for (let i = 0; i < keys.length; i++) {
        const key = keys[i];
        if (typeof key === 'string') {
            pickMap[caseInsensitive ? key.toLowerCase() : key] = true;
        }
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
        
        if (pickMap[lookupKey]) {
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
// pickParamsFromString - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const input = applyCast(data.pre, data.src);
const keys = createFlatArrayFromValues(data.kys, "key");
return out(pickParamsFromString(input, keys, data.ci));
*/
// ===============================================================================
// pickParamsFromString(...) – Apply Mode
// ===============================================================================
return function(input, keys) {
   keys = data.rp1 ? createFlatArrayFromValues(data.kys, "key") : keys;
   return out(pickParamsFromString(input, keys, data.ci));
};


___TESTS___

scenarios:
  - name: Test pick single parameter
    code: |
      const src = '?utm_source=google&utm_medium=cpc&fbclid=123';
      const keys = ['utm_source'];
      const mockData = {
          src: src,
          kys: [{key: 'utm_source'}],
          ci: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, keys);
      }
      assertThat(variableResult).isEqualTo('?utm_source=google');
  - name: '[example] Keep only UTM parameters'
    code: |-
      /* @display
      Value to Process: ?utm_source=google&fbclid=123&gclid=456&utm_medium=cpc
      keys: ['utm_source', 'utm_medium']
      Parameters to Keep: [{key: 'utm_source'}, {key: 'utm_medium'}]
      Case insensitive matching: false
      @output
      ?utm_source=google&utm_medium=cpc
      */
      const src = '?utm_source=google&fbclid=123&gclid=456&utm_medium=cpc';
      const keys = ['utm_source', 'utm_medium'];
      const kys = [{key: 'utm_source'}, {key: 'utm_medium'}];
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
      assertThat(variableResult).isEqualTo('?utm_source=google&utm_medium=cpc');
  - name: Test case insensitive matching
    code: |-
      const src = '?UTM_SOURCE=google&FBCLID=123';
      const keys = ['utm_source'];
      const mockData = {
          src: src,
          kys: [{key: 'utm_source'}],
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
  - name: '[example] Pick from hash fragment'
    code: |
      /* @display
      Value to Process: #section=intro&debug=true&id=123
      keys: ['section', 'id']
      Parameters to Keep: [{key: 'section'}, {key: 'id'}]
      Case insensitive matching: false
      @output
      #section=intro&id=123
      */
      const src = '#section=intro&debug=true&id=123';
      const keys = ['section', 'id'];
      const mockData = {
          src: src,
          kys: [{key: 'section'}, {key: 'id'}],
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
      const keys = ['utm_source'];
      const mockData = {
          src: src,
          kys: [{key: 'utm_source'}],
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
  - name: Test no keys returns prefix only
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
      assertThat(variableResult).isEqualTo('?');
  - name: Test parameter not found returns prefix only
    code: |-
      const src = '?utm_source=google&utm_medium=cpc';
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
      assertThat(variableResult).isEqualTo('?');
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
