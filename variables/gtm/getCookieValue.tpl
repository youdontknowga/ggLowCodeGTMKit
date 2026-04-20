___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getCookieValue",
  "description": "Returns the first value of a cookie with the given \u003cem\u003ename\u003c/em\u003e, or all values if multiple is enabled.",
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
        "displayName": "Cookie Name",
        "simpleValueType": true,
        "help": "💾   The name of the cookie to retrieve values for.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Returns the first value of a cookie with the given \u003cem\u003ename\u003c/em\u003e, or all values if multiple is enabled.\n\u003cbr\u003e_____________________________________________\u003cbr\u003e✏️ \u003cem\u003eExample\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\nCookie name: \u003cstrong\u003esessionId\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e\n↪️ Output: \u003cstrong\u003eabc123\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExample 3\u003c/em\u003e***\u003cbr\u003e\u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eabc123\u003c/strong\u003e"
  },
  {
    "type": "GROUP",
    "name": "opt",
    "displayName": "Advanced Settings",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "dec",
        "checkboxText": "Decode values (optional)",
        "simpleValueType": true,
        "help": "☑️   Whether to decode the cookie values with JavaScript's decodeURIComponent().",
        "defaultValue": true
      },
      {
        "type": "CHECKBOX",
        "name": "mul",
        "checkboxText": "Return all values in an array instead of just the first one (optional)",
        "simpleValueType": true,
        "help": "☑️   When enabled, returns all cookie values as an array instead of just the first value."
      }
    ]
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert object to string, normalize case). Internal transformations such as case handling will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str + ' €', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Returns the first value of a cookie with the given name, or all values if multiple is enabled.
* 
* @param {string} data.src - The name of the cookie to retrieve values for.
* @param {boolean} [data.dec] - Optional parameter to specify whether to decode the cookie values.
* @param {boolean} [data.mul] - Optional parameter to return all values instead of just the first one.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
* 
* @returns {string|Array} The first cookie value (string) or all cookie values (array) if multiple is true.
*
* @framework ggLowCodeGTMKit
*/
const getCookieValues = require('getCookieValues');

const getValues = function(cookieName, decode, multiple) {
   let result = getCookieValues(cookieName, decode);
   if (multiple !== true && !!result) { return result[0]; }
   return result;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// getCookieValue - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedName = applyCast(data.pre, data.src);
return out(getValues(processedName, data.dec, data.mul));
// ===============================================================================
// getCookieValue(...) – Apply Mode
// ===============================================================================
/*
return function(value, decode, multiple) {
   decode = data.rp1 ? data.dec : decode;
   multiple = data.rp2 ? data.mul : multiple;
   return out(getValues(value, decode, multiple));
};
*/


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
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
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
