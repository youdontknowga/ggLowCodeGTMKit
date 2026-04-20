___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "buildUrlFromParts(...)",
  "description": "Builds a URL string from selected parts of a parsed URL object. Pick only the components you need: protocol, host, pathname, search, hash.",
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
        "displayName": "Parts to Include",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Part Name",
            "name": "part",
            "type": "SELECT",
            "selectItems": [
              {
                "value": "protocol",
                "displayValue": "protocol"
              },
              {
                "value": "username",
                "displayValue": "username"
              },
              {
                "value": "password",
                "displayValue": "password"
              },
              {
                "value": "host",
                "displayValue": "host"
              },
              {
                "value": "port",
                "displayValue": "port"
              },
              {
                "value": "pathname",
                "displayValue": "pathname"
              },
              {
                "value": "search",
                "displayValue": "search"
              },
              {
                "value": "hash",
                "displayValue": "hash"
              }
            ]
          }
        ],
        "help": "💾 List of URL parts to include in the output. Order doesn't matter - parts are assembled in standard URL order.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBuild complete URL\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBuild origin only\u003c/em\u003e***",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template."
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Parsed URL Object"
      }
    ],
    "help": "Builds a URL from individual components (protocol, host, path, search, hash).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBuild complete URL\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{\u003c/strong\u003e\u003cbr\u003eprotocol: \u003cstrong\u003e'https:',\u003c/strong\u003e\u003cbr\u003ehostname: \u003cstrong\u003e'example.com',\u003c/strong\u003e\u003cbr\u003eport: \u003cstrong\u003e'8080',\u003c/strong\u003e\u003cbr\u003epathname: \u003cstrong\u003e'/path/to/page',\u003c/strong\u003e\u003cbr\u003esearch: \u003cstrong\u003e'?foo=bar',\u003c/strong\u003e\u003cbr\u003ehash: \u003cstrong\u003e'#section'\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e}\u003c/strong\u003e\u003cbr\u003ekeys: \u003cstrong\u003e['protocol', 'host', 'port', 'pathname', 'search', 'hash']\u003c/strong\u003e\u003cbr\u003eParts to Include: \u003cstrong\u003e[{part: 'protocol'}, {part: 'host'}, {part: 'port'}, {part: 'pathname'}, {part: 'search'}, {part: 'hash'}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps://example.com:8080/path/to/page?foo=bar#section\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBuild origin only\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{\u003c/strong\u003e\u003cbr\u003eprotocol: \u003cstrong\u003e'https:',\u003c/strong\u003e\u003cbr\u003ehostname: \u003cstrong\u003e'example.com',\u003c/strong\u003e\u003cbr\u003epathname: \u003cstrong\u003e'/path',\u003c/strong\u003e\u003cbr\u003esearch: \u003cstrong\u003e'?foo=bar'\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e}\u003c/strong\u003e\u003cbr\u003ekeys: \u003cstrong\u003e['protocol', 'host']\u003c/strong\u003e\u003cbr\u003eParts to Include: \u003cstrong\u003e[{part: 'protocol'}, {part: 'host'}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps://example.com\u003c/strong\u003e"
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
 * Builds a URL string from selected parts of a parsed URL object.
 *
 * @param {Object} data.src - The parsed URL object (from parseUrl).
 * @param {Array} data.kys - Array of objects with parts to include: protocol, username, password, host, port, pathname, search, hash.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function.
 * 
 * @returns {string} A reconstructed URL with only the selected parts.
 *
 * @framework ggLowCodeGTMKit
 */
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

const buildUrlFromParts = function(parts, partsToInclude) {
    if (!parts || typeof parts !== 'object') {
        return '';
    }
    
    if (!partsToInclude || partsToInclude.length === 0) {
        return '';
    }
    
    const includeMap = {};
    for (let i = 0; i < partsToInclude.length; i++) {
        includeMap[partsToInclude[i]] = true;
    }
    
    let url = '';
    
    if (includeMap.protocol && parts.protocol) {
        url += parts.protocol + '//';
    }
    
    if (includeMap.username && parts.username) {
        url += parts.username;
        if (includeMap.password && parts.password) {
            url += ':' + parts.password;
        }
        url += '@';
    }
    
    if (includeMap.host && parts.hostname) {
        url += parts.hostname;
        if (includeMap.port && parts.port) {
            url += ':' + parts.port;
        }
    }
    
    if (includeMap.pathname && parts.pathname) {
        url += parts.pathname;
    }
    
    if (includeMap.search && parts.search) {
        url += parts.search;
    }
    
    if (includeMap.hash && parts.hash) {
        url += parts.hash;
    }
    
    return url;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// buildUrlFromParts - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const parts = applyCast(data.pre, data.src);
const keys = createFlatArrayFromValues(data.kys, "part");
return out(buildUrlFromParts(parts, keys));
*/
// ===============================================================================
// buildUrlFromParts(...) – Apply Mode
// ===============================================================================
return function(parts, partsToInclude) {
   partsToInclude = createFlatArrayFromValues(data.kys, "part");
   return out(buildUrlFromParts(parts, partsToInclude));
};


___TESTS___

scenarios:
  - name: '[example] Build complete URL'
    code: |
      /* @display
      Value to Process: {
          protocol: 'https:',
          hostname: 'example.com',
          port: '8080',
          pathname: '/path/to/page',
          search: '?foo=bar',
          hash: '#section'
      }
      keys: ['protocol', 'host', 'port', 'pathname', 'search', 'hash']
      Parts to Include: [{part: 'protocol'}, {part: 'host'}, {part: 'port'}, {part: 'pathname'}, {part: 'search'}, {part: 'hash'}]
      @output
      https://example.com:8080/path/to/page?foo=bar#section
      */
      const src = {
          protocol: 'https:',
          hostname: 'example.com',
          port: '8080',
          pathname: '/path/to/page',
          search: '?foo=bar',
          hash: '#section'
      };
      const keys = ['protocol', 'host', 'port', 'pathname', 'search', 'hash'];
      const mockData = {
          src: src,
          kys: [{part: 'protocol'}, {part: 'host'}, {part: 'port'}, {part: 'pathname'}, {part: 'search'}, {part: 'hash'}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, keys);
      }
      assertThat(variableResult).isEqualTo('https://example.com:8080/path/to/page?foo=bar#section');
  - name: '[example] Build origin only'
    code: |
      /* @display
      Value to Process: {
          protocol: 'https:',
          hostname: 'example.com',
          pathname: '/path',
          search: '?foo=bar'
      }
      keys: ['protocol', 'host']
      Parts to Include: [{part: 'protocol'}, {part: 'host'}]
      @output
      https://example.com
      */
      const src = {
          protocol: 'https:',
          hostname: 'example.com',
          pathname: '/path',
          search: '?foo=bar'
      };
      const keys = ['protocol', 'host'];
      const mockData = {
          src: src,
          kys: [{part: 'protocol'}, {part: 'host'}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, keys);
      }
      assertThat(variableResult).isEqualTo('https://example.com');
  - name: Test build path only (pathname + search + hash)
    code: |
      const src = {
          protocol: 'https:',
          hostname: 'example.com',
          pathname: '/path/to/page',
          search: '?foo=bar',
          hash: '#section'
      };
      const keys = ['pathname', 'search', 'hash'];
      const mockData = {
          src: src,
          kys: [{part: 'pathname'}, {part: 'search'}, {part: 'hash'}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, keys);
      }
      assertThat(variableResult).isEqualTo('/path/to/page?foo=bar#section');
  - name: Test clean URL (no search, no hash)
    code: |
      const src = {
          protocol: 'https:',
          hostname: 'example.com',
          pathname: '/path/to/page',
          search: '?foo=bar',
          hash: '#section'
      };
      const keys = ['protocol', 'host', 'pathname'];
      const mockData = {
          src: src,
          kys: [{part: 'protocol'}, {part: 'host'}, {part: 'pathname'}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, keys);
      }
      assertThat(variableResult).isEqualTo('https://example.com/path/to/page');
  - name: Test with credentials
    code: |
      const src = {
          protocol: 'https:',
          username: 'user',
          password: 'pass',
          hostname: 'example.com',
          pathname: '/path'
      };
      const keys = ['protocol', 'username', 'password', 'host', 'pathname'];
      const mockData = {
          src: src,
          kys: [{part: 'protocol'}, {part: 'username'}, {part: 'password'}, {part: 'host'}, {part: 'pathname'}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, keys);
      }
      assertThat(variableResult).isEqualTo('https://user:pass@example.com/path');
  - name: Test empty parts returns empty string
    code: |+
      const src = {};
      const keys = ['protocol', 'host'];
      const mockData = {
          src: src,
          kys: [{part: 'protocol'}, {part: 'host'}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, keys);
      }
      assertThat(variableResult).isEqualTo('');

  - name: Test no keys returns empty string
    code: |-
      const src = {
          protocol: 'https:',
          hostname: 'example.com'
      };
      const mockData = {
          src: src,
          kys: []
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, []);
      }
      assertThat(variableResult).isEqualTo('');
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
