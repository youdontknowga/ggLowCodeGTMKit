___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "⚡ URL › Transformer",
  "description": "Transforms a URL by applying functions to its \u003cem\u003esearch parameters\u003c/em\u003e and \u003cem\u003ehash parameters\u003c/em\u003e independently, then reassembles the result into a clean URL string.",
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
        "displayName": "URL String",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "help": "💾 The full URL to transform (e.g., \"https://example.com/page?utm_source=fb&fbclid=abc#section\").\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eFull URL\u003c/strong\u003e: \u003cem\u003ehttps://example.com/page?q=1#top\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eRelative URL\u003c/strong\u003e: \u003cem\u003e/page?q=1#top\u003c/em\u003e"
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "sfn",
        "displayName": "Search Param Functions",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Apply Function",
            "name": "fn",
            "type": "TEXT",
            "valueHint": "e.g. {{Apply - omitParamsFromString}}"
          }
        ],
        "help": "📋 Apply-mode functions to run on the \u003cstrong\u003esearch parameters\u003c/strong\u003e (?key=value). Each function receives the search string (e.g. \"?utm_source=fb\u0026fbclid=abc\") and must return a transformed search string. Functions are applied sequentially — each receives the output of the previous one.\u003cbr\u003e\u003cbr\u003e\u003cem\u003eLeave empty to pass search params through unchanged.\u003c/em\u003e"
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "hfn",
        "displayName": "Hash Param Functions",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Apply Function",
            "name": "fn",
            "type": "TEXT",
            "valueHint": "e.g. {{Apply - assignParamsToString}}"
          }
        ],
        "help": "📋 Apply-mode functions to run on the \u003cstrong\u003ehash parameters\u003c/strong\u003e (#key=value). Each function receives the hash string (e.g. \"#section=intro\") and must return a transformed hash string. Functions are applied sequentially.\u003cbr\u003e\u003cbr\u003e\u003cem\u003eLeave empty to pass hash params through unchanged.\u003c/em\u003e"
      }
    ],
    "help": "Transforms a URL by applying functions to its search and hash parameters independently, then reassembles the result.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRemove fbclid from URL\u003c/em\u003e***\u003cbr\u003eURL String: \u003cstrong\u003ehttps://example.com/page?utm_source=fb\u0026fbclid=abc123\u003c/strong\u003e\u003cbr\u003eSearch Param Functions: \u003cstrong\u003e[{fn: {{Apply - omitParamsFromString}}}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps://example.com/page?utm_source=fb\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAdd UTM params and clean hash\u003c/em\u003e***\u003cbr\u003eURL String: \u003cstrong\u003ehttps://example.com/page?page=1#debug=true\u0026view=full\u003c/strong\u003e\u003cbr\u003eSearch Param Functions: \u003cstrong\u003e[{fn: {{Apply - assignParamsToString}}}]\u003c/strong\u003e\u003cbr\u003eHash Param Functions: \u003cstrong\u003e[{fn: {{Apply - omitParamsFromString}}}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps://example.com/page?page=1\u0026utm_source=website#view=full\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the URL string before parsing (e.g., trim whitespace, normalize protocol)."
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
        "help": "⚙️ Optional function to apply to the reassembled URL before returning it (e.g., encode, lowercase hostname)."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Transforms a URL by applying functions to its search and hash parameters
 * independently, then reassembles the result into a clean URL string.
 *
 * @param {string} data.src - The full URL to transform.
 * @param {Array<{fn: Function}>} [data.sfn] - Apply-functions for search params, applied sequentially.
 * @param {Array<{fn: Function}>} [data.hfn] - Apply-functions for hash params, applied sequentially.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before parsing.
 *
 * @returns {string} The reassembled URL with transformed search and hash parameters.
 *
 * @framework ggLowCodeGTMKit
 */
const parseUrl = require('parseUrl');

const applyFnPipeline = function(input, fnTable) {
    if (!fnTable || !fnTable.length) return input;
    let result = input;
    for (let i = 0; i < fnTable.length; i++) {
        const fn = fnTable[i].fn;
        if (typeof fn === 'function') {
            result = fn(result);
        }
    }
    return result;
};

const reassembleUrl = function(parsed, search, hash) {
    let url = '';

    if (parsed.protocol) {
        url += parsed.protocol + '//';
    }

    if (parsed.username) {
        url += parsed.username;
        if (parsed.password) {
            url += ':' + parsed.password;
        }
        url += '@';
    }

    if (parsed.hostname) {
        url += parsed.hostname;
        if (parsed.port) {
            url += ':' + parsed.port;
        }
    }

    if (parsed.pathname) {
        url += parsed.pathname;
    }

    if (search) {
        url += search;
    }

    if (hash) {
        url += hash;
    }

    return url;
};

const transformUrl = function(url, searchFns, hashFns) {
    const parsed = parseUrl(url);
    if (!parsed) return url;

    const search = applyFnPipeline(parsed.search || '', searchFns);
    const hash = applyFnPipeline(parsed.hash || '', hashFns);

    return reassembleUrl(parsed, search, hash);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// ⚡ URL › Transformer - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(transformUrl(value, data.sfn, data.hfn));
// ===============================================================================
// ⚡ URL › Transformer – Apply Mode
// ===============================================================================
/*
return function(url) {
    return out(transformUrl(url, data.sfn, data.hfn));
};
*/


___TESTS___

scenarios:
  - name: '[example] Remove fbclid from URL'
    code: |
      /* @display
      URL String: https://example.com/page?utm_source=fb&fbclid=abc123
      Search Param Functions: [omitParamsFromString(fbclid)]
      @output
      https://example.com/page?utm_source=fb
      */
      const src = 'https://example.com/page?utm_source=fb&fbclid=abc123';
      const omitFbclid = function(searchStr) {
          // Simulates {{Apply - omitParamsFromString}} configured to omit fbclid
          const prefix = searchStr.charAt(0) === '?' ? '?' : '';
          const raw = prefix ? searchStr.slice(1) : searchStr;
          const pairs = raw.split('&');
          const kept = [];
          for (let i = 0; i < pairs.length; i++) {
              const eqIdx = pairs[i].indexOf('=');
              const key = eqIdx >= 0 ? pairs[i].slice(0, eqIdx) : pairs[i];
              if (key !== 'fbclid') kept.push(pairs[i]);
          }
          return kept.length ? prefix + kept.join('&') : prefix;
      };
      const mockData = {
          src: src,
          sfn: [{fn: omitFbclid}],
          hfn: []
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://example.com/page?utm_source=fb');
  - name: '[example] Add UTM params to URL'
    code: |
      /* @display
      URL String: https://example.com/page?page=1
      Search Param Functions: [assignParamsToString(utm_source=website&utm_medium=cpc)]
      @output
      https://example.com/page?page=1&utm_source=website&utm_medium=cpc
      */
      const src = 'https://example.com/page?page=1';
      const addUtm = function(searchStr) {
          // Simulates {{Apply - assignParamsToString}} adding UTM params
          const prefix = searchStr.charAt(0) === '?' ? '?' : '';
          const raw = prefix ? searchStr.slice(1) : searchStr;
          const parts = raw ? raw + '&utm_source=website&utm_medium=cpc' : 'utm_source=website&utm_medium=cpc';
          return prefix + parts;
      };
      const mockData = {
          src: src,
          sfn: [{fn: addUtm}],
          hfn: []
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://example.com/page?page=1&utm_source=website&utm_medium=cpc');
  - name: '[example] Transform both search and hash'
    code: |
      /* @display
      URL String: https://example.com/page?utm_source=fb&fbclid=abc#debug=true&view=full
      Search Param Functions: [omit fbclid]
      Hash Param Functions: [omit debug]
      @output
      https://example.com/page?utm_source=fb#view=full
      */
      const src = 'https://example.com/page?utm_source=fb&fbclid=abc#debug=true&view=full';
      const omitFbclid = function(str) {
          const prefix = str.charAt(0);
          const raw = (prefix === '?' || prefix === '#') ? str.slice(1) : str;
          const pairs = raw.split('&');
          const kept = [];
          for (let i = 0; i < pairs.length; i++) {
              const key = pairs[i].split('=')[0];
              if (key !== 'fbclid') kept.push(pairs[i]);
          }
          return kept.length ? prefix + kept.join('&') : prefix;
      };
      const omitDebug = function(str) {
          const prefix = str.charAt(0);
          const raw = (prefix === '?' || prefix === '#') ? str.slice(1) : str;
          const pairs = raw.split('&');
          const kept = [];
          for (let i = 0; i < pairs.length; i++) {
              const key = pairs[i].split('=')[0];
              if (key !== 'debug') kept.push(pairs[i]);
          }
          return kept.length ? prefix + kept.join('&') : prefix;
      };
      const mockData = {
          src: src,
          sfn: [{fn: omitFbclid}],
          hfn: [{fn: omitDebug}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://example.com/page?utm_source=fb#view=full');
  - name: '[example] Passthrough with no functions'
    code: |
      /* @display
      URL String: https://example.com/page?q=1#top
      Search Param Functions: (none)
      Hash Param Functions: (none)
      @output
      https://example.com/page?q=1#top
      */
      const src = 'https://example.com/page?q=1#top';
      const mockData = {
          src: src,
          sfn: [],
          hfn: []
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://example.com/page?q=1#top');
  - name: URL with no search params - functions still apply
    code: |
      const src = 'https://example.com/page#section';
      const addUtm = function(searchStr) {
          return searchStr ? searchStr + '&utm_source=test' : '?utm_source=test';
      };
      const mockData = {
          src: src,
          sfn: [{fn: addUtm}],
          hfn: []
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://example.com/page?utm_source=test#section');
  - name: Chained search functions (pipeline)
    code: |
      const src = 'https://example.com/?a=1&b=2&c=3';
      const omitB = function(str) {
          return str.replace('&b=2', '');
      };
      const addD = function(str) {
          return str + '&d=4';
      };
      const mockData = {
          src: src,
          sfn: [{fn: omitB}, {fn: addD}],
          hfn: []
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://example.com/?a=1&c=3&d=4');
  - name: URL with port and credentials preserved
    code: |
      const src = 'https://user:pass@example.com:8080/path?q=1#top';
      const mockData = {
          src: src,
          sfn: [],
          hfn: []
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://user:pass@example.com:8080/path?q=1#top');
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
