___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "gaLeadGenerationEventList",
  "description": "Provides an array containing all standard GA4 Lead Generation event names as defined in the official Google Analytics 4 specification.",
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
        "name": "No Parameters",
        "displayName": "🌐 This function takes no parameters."
      }
    ],
    "help": "Returns an \u003cem\u003earray\u003c/em\u003e of Google Analytics 4 Lead Generation event names. Useful for tracking and validating lead funnel stages from generation through conversion.\u003cbr\u003e___________\u003cbr\u003e✏️ \u003cem\u003eExample\u003c/em\u003e\u003cbr\u003eOutput:\u003cbr\u003e\u003cstrong\u003e[\"generate_lead\", \"qualify_lead\", \"disqualify_lead\", \"working_lead\", \"close_convert_lead\", \"close_unconvert_lead\"]\u003c/strong\u003e"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Returns a list of Google Analytics 4 Lead Generation event names.
* 
*
* @returns {Array} Array of GA4 ecommerce event name strings.
*
* @framework ggLowCodeGTMKit
*/
const gaLeadGenerationEventList = [
  'generate_lead',
  'qualify_lead',
  'disqualify_lead',
  'working_lead',
  'close_convert_lead',
  'close_unconvert_lead'
];
return gaLeadGenerationEventList;


___TESTS___

scenarios: []


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
