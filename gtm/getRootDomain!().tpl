___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getRootDomain!()",
  "description": "Detect the root domain where cookies can be set by testing progressively higher domain levels (e.g., returns example.com from sub.example.com)",
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
        "help": "This function takes no parameters. It automatically detects the root domain from the current page."
      },
      {
        "type": "LABEL",
        "name": "No Parameters",
        "displayName": "🌐 This function takes no parameters - uses current page hostname"
      }
    ],
    "help": "Determines the root domain of the current page by testing cookie access at each domain level. The result is cached for performance.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eStandard domain\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://www.shop.example.com/products\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\"example.com\"\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCountry code TLD\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://www.shop.example.co.uk/products\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\"example.co.uk\"\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSubdomain\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ehttps://blog.shop.example.com/posts\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\"example.com\"\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e💡 \u003cstrong\u003eUse cases:\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ Setting cross-subdomain cookies\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ Cross-domain tracking configuration\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ Linker parameter domain setting\u003cbr\u003e\u003cbr\u003e⚡ \u003cstrong\u003ePerformance:\u003c/strong\u003e Result is cached in templateStorage after first call."
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
        "help": "⚙️ Optional function to apply to the root domain before returning it (e.g., \u003ccode\u003ed \u003d\u003e \u0027.\u0027 + d\u003c/code\u003e to add leading dot for cookies, \u003ccode\u003ed \u003d\u003e d.toUpperCase()\u003c/code\u003e). Useful for formatting."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Determines the root domain of the current hostname by attempting to set a test cookie at each level.
 * Uses templateStorage to cache the result for performance.
 *
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 * 
 * @returns {string} The root domain where cookies can be set (e.g., "example.com").
 *
 * @author David Vallejo
 * @see https://bit.ly/4jXILvT
 * @modified Caching and framework adaptation
 *
 * @framework ggLowCodeGTMKit
 */
const templateStorage = require('templateStorage');
const setCookie = require('setCookie');
const getCookieValues = require('getCookieValues');
const getUrl = require('getUrl');

const getRootDomain = function() {
    const cached = templateStorage.getItem('rd');
    if (cached) {
        return cached;
    }
    
    const testCookie = '_gtm_rd';
    let hostname = getUrl('host');
    let candidate = null;
    
    if (hostname.substring(0, 4) === 'www.') {
        hostname = hostname.substring(4);
    }
    
    const parts = hostname.split('.');
    
    for (let i = 1; i <= parts.length; i++) {
        candidate = parts.slice(-i).join('.');
        
        setCookie(testCookie, 't', {
            'domain': candidate,
            'path': '/',
            'max-age': 1,
            'secure': true
        });
        
        if (getCookieValues(testCookie).length > 0) {
            setCookie(testCookie, '', {
                'domain': candidate,
                'path': '/',
                'max-age': 0,
                'secure': true
            });
            
            templateStorage.setItem('rd', candidate);
            return candidate;
        }
    }
    
    templateStorage.setItem('rd', hostname);
    return hostname;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// getRootDomain - Direct mode
// ===============================================================================
/*
return out(getRootDomain());
*/
// ===============================================================================
// getRootDomain! – Apply Mode
// ===============================================================================
return function() {
   return out(getRootDomain());
};


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "gtmTestCookie"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtmTestCookie"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
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
  },
  {
    "instance": {
      "key": {
        "publicId": "access_template_storage",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
