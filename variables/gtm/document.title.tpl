___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "document.title",
  "description": "Returns the value of \u003cstrong\u003edocument.title\u003c/strong\u003e.",
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
        "type": "LABEL",
        "name": "No Parameters",
        "displayName": "🌐 This function takes no parameters."
      }
    ],
    "help": "Returns the current page \u003cem\u003etitle\u003c/em\u003e from the document. This function retrieves the title tag content of the current page.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePage title\u003c/em\u003e***\u003cbr\u003e↪️ Output: \u003cstrong\u003e\"Welcome to My Website\"\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str \u003d\u003e str.toLowerCase() for lowercase, str \u003d\u003e str.substring(0, 50) to truncate). Useful for chaining transformations on the output."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Returns the page title.
 * 
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 * 
 * @returns {string|null} The page title, or null if not found.
 *
 * @framework ggLowCodeGTMKit
 */
const readTitle = require('readTitle');

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// getPageTitle - Direct mode
// ===============================================================================
return out(readTitle());


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_title",
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
