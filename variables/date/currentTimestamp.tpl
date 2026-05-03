___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "currentTimestamp",
  "categories": [
    "UTILITY",
    "TAG_MANAGEMENT"
  ],
  "description": "Returns the current timestamp in \u003cem\u003emilliseconds\u003c/em\u003e since epoch (January 1, 1970, 00:00:00 UTC).",
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
    "help": "Returns the current timestamp in milliseconds since epoch.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReturns current timestamp\u003c/em\u003e***\u003cbr\u003e\u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\u003c/strong\u003e"
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Returns the current timestamp in milliseconds.
* 
* 
* @returns {number} The current timestamp in milliseconds since epoch.
*
* @framework ggLowCodeGTMKit
*/
const getTimestampMillis = require('getTimestampMillis');

// ===============================================================================
// currentTimestamp - Direct mode
// ===============================================================================

return getTimestampMillis();


___TESTS___

scenarios:
- name: '[example] Returns current timestamp'
  code: |-
    // Call runCode to run the template's code.
    let variableResult = runCode();

    // Validate that the result of runCode is defined.
    assertThat(variableResult).isDefined();


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
