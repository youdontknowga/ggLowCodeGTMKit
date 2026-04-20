___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getLocalStorage()",
  "description": "Retrieves a raw string value from localStorage and caches it during the current GTM event for performance optimization with \u003cem\u003estring\u003c/em\u003e key.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template."
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Storage Key"
      }
    ],
    "help": "Retrieves a raw string value from localStorage and caches it during the current GTM event for performance optimization with \u003cem\u003estring\u003c/em\u003e key.\n\u003cbr\u003e_____________________________________________\u003cbr\u003e✏️ \u003cem\u003eExample\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\nStorage key: \u003cstrong\u003e\"user_preferences\"\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e\n↪️ Output: \u003cstrong\u003e\"dark_mode=true\"\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExample 3\u003c/em\u003e***\u003cbr\u003e\u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\"dark_mode=true\"\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str + ' €', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Retrieves a raw string value from localStorage and caches it during the current GTM event.
* 
* @param {string} data.src - The key to look up in localStorage.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before lookup.
* 
* @returns {string|null|undefined} The raw string value from localStorage, or null/undefined if not found.
*
* @framework ggLowCodeGTMKit
*/
const localStorage = require('localStorage');
const templateStorage = require('templateStorage');
const copyFromDataLayer = require('copyFromDataLayer');

const getLocalStorage = function(key) {
   const gtmId = copyFromDataLayer('gtm.uniqueEventId');
   if (gtmId === templateStorage.get(key + gtmId)) {
       return templateStorage.get(key);
   }
   const rawValue = localStorage.get(key);
   templateStorage.set(key, rawValue);
   templateStorage.set(key + gtmId, gtmId);
   return rawValue;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// getLocalStorage - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(getLocalStorage(value));
*/
// ===============================================================================
// getLocalStorage() – Apply Mode
// ===============================================================================
return function(value) {
   return out(getLocalStorage(value));
};


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_local_storage",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
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
