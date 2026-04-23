___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "completeUrl()",
  "description": "Completes relative URLs to absolute URLs based on the current page. Handles root-relative, parent-relative, hash links, and query links.",
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
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAbsolute URL unchanged\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://google.com/search\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps://google.com/search\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eProtocol-relative URL completed\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e//cdn.example.com/image.jpg\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps://cdn.example.com/image.jpg\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: URL to Complete"
      }
    ],
    "help": "Completes partial URLs with the current page context.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAbsolute URL unchanged\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehttps://google.com/search\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps://google.com/search\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eProtocol-relative URL completed\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e//cdn.example.com/image.jpg\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehttps://cdn.example.com/image.jpg\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the completed URL before returning it (e.g., \u003ccode\u003eurl =\u003e url.toLowerCase()\u003c/code\u003e, \u003ccode\u003eurl =\u003e url.split('?')[0]\u003c/code\u003e to remove query string). Useful for chaining transformations."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Completes a relative URL to an absolute URL based on the current page.
 * 
 * @param {string} data.src - The URL to complete (can be relative or absolute).
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function.
 * 
 * @returns {string|undefined} The completed absolute URL, or the original if already absolute.
 *
 * @framework ggLowCodeGTMKit
 */
const getUrl = require('getUrl');

const completeUrl = function(url) {
    if (!url || typeof url !== 'string') {
        return undefined;
    }
    
    const protocol = getUrl('protocol');
    const domain = getUrl('host');
    const path = getUrl('path');
    const query = getUrl('query');
    const fullQuery = query ? '?' + query : '';
    
    if (url.indexOf('://') > 0 && url.indexOf('://') < 10) {
        return url;
    }
   
    if (url.indexOf('//') === 0) {
        return protocol + ':' + url;
    }
    
    if (url.indexOf('#') === 0) {
        return protocol + '://' + domain + path + fullQuery + url;
    }
    
    if (url.indexOf('?') === 0) {
        return protocol + '://' + domain + path + url;
    }
    
    if (url.indexOf('/') === 0) {
        return protocol + '://' + domain + url;
    }
    
    if (url.indexOf('../') === 0) {
        const parts = url.split('../');
        const pathParts = path.split('/');
        
        if (pathParts[pathParts.length - 1] !== '') {
            pathParts.pop();
        }
        
        for (let i = 0; i < parts.length - 1; i++) {
            pathParts.pop();
        }
        
        return protocol + '://' + domain + pathParts.join('/') + '/' + parts[parts.length - 1];
    }
    
    let relativePath = url;
    if (url.indexOf('./') === 0) {
        relativePath = url.substring(2);
    }
    
    const pathParts = path.split('/');
    pathParts.pop();
    const basePath = pathParts.join('/');
    
    return protocol + '://' + domain + basePath + '/' + relativePath;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// completeUrl - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const url = applyCast(data.pre, data.src);
return out(completeUrl(url));
*/
// ===============================================================================
// completeUrl() – Apply Mode
// ===============================================================================
return function(url) {
   return out(completeUrl(url));
};


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
  - name: '[example] Absolute URL unchanged'
    code: |-
      /* @display
      Value to Process: https://google.com/search
      @output
      https://google.com/search
      */
      mock('getUrl', function(component) {
          if (component === 'protocol') return 'https';
          if (component === 'host') return 'www.example.com';
          if (component === 'path') return '/products/shoes/details.html';
          if (component === 'query') return 'ref=home';
          return '';
      });

      const src = 'https://google.com/search';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://google.com/search');
  - name: '[example] Protocol-relative URL completed'
    code: |-
      /* @display
      Value to Process: //cdn.example.com/image.jpg
      @output
      https://cdn.example.com/image.jpg
      */
      mock('getUrl', function(component) {
          if (component === 'protocol') return 'https';
          if (component === 'host') return 'www.example.com';
          if (component === 'path') return '/products/shoes/details.html';
          if (component === 'query') return '';
          return '';
      });

      const src = '//cdn.example.com/image.jpg';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://cdn.example.com/image.jpg');
  - name: Test hash link completes with current page
    code: |
      mock('getUrl', function(component) {
          if (component === 'protocol') return 'https';
          if (component === 'host') return 'www.example.com';
          if (component === 'path') return '/products/shoes/details.html';
          if (component === 'query') return 'ref=home';
          return '';
      });

      const src = '#reviews';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://www.example.com/products/shoes/details.html?ref=home#reviews');
  - name: Test root-relative URL
    code: |
      mock('getUrl', function(component) {
          if (component === 'protocol') return 'https';
          if (component === 'host') return 'www.example.com';
          if (component === 'path') return '/products/shoes/details.html';
          if (component === 'query') return '';
          return '';
      });

      const src = '/about/contact.html';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://www.example.com/about/contact.html');
  - name: Test parent-relative URL with point and slash
    code: |+
      mock('getUrl', function(component) {
          if (component === 'protocol') return 'https';
          if (component === 'host') return 'www.example.com';
          if (component === 'path') return '/products/shoes/details.html';
          if (component === 'query') return '';
          return '';
      });

      const src = '../boots/index.html';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://www.example.com/products/boots/index.html');

  - name: Test current-relative URL without point and slash
    code: |
      mock('getUrl', function(component) {
          if (component === 'protocol') return 'https';
          if (component === 'host') return 'www.example.com';
          if (component === 'path') return '/products/shoes/details.html';
          if (component === 'query') return '';
          return '';
      });

      const src = 'sandals.html';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo('https://www.example.com/products/shoes/sandals.html');
  - name: Test invalid input returns undefined
    code: |-
      const src = null;
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isUndefined();
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
