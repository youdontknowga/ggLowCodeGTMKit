___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "hasLocalStorageKey",
  "description": "Check whether a specific key exists in localStorage.",
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
        "name": "key",
        "displayName": "Storage Key",
        "simpleValueType": true,
        "help": "💾   The key to check in localStorage.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Check whether a specific key exists in localStorage.\n\u003cbr\u003e_____________________________________________\u003cbr\u003e✏️ \u003cem\u003eExample\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\nStorage key: \u003cstrong\u003euserSettings\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e\n↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExample 3\u003c/em\u003e***\u003cbr\u003e\u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the key before internal logic (e.g., normalize case, add prefix). Internal transformations will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., val =\u003e val ? 'Exists' : 'Missing', val =\u003e !val for negation). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Checks whether a given key exists in localStorage.
 *
 * @param {string} data.key - The key to check in localStorage.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform key before checking.
 * 
 * @returns {boolean} True if the key exists in localStorage, false otherwise.
 *
 * @framework ggLowCodeGTMKit
 */

const localStorage = require('localStorage');

const hasLocalStorageKey = function(key) {
    return localStorage.get(key) !== null;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// hasLocalStorageKey - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedKey = applyCast(data.pre, data.key);
return out(hasLocalStorageKey(processedKey));
// ===============================================================================
// hasLocalStorageKey() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(hasLocalStorageKey(value));
};
*/


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
