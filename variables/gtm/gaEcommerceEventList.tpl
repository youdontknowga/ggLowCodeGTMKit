___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "gaEcommerceEventList",
  "description": "Provides an array containing all standard GA4 ecommerce event names as defined in the official Google Analytics 4 specification.",
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
    "help": "Returns an\u003cem\u003e array\u003c/em\u003e of all Google Analytics 4 ecommerce event names as defined in the GA4 specification. Useful for validation, filtering, or conditional logic based on ecommerce events.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOutput\u003c/em\u003e***\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\"add_payment_info\", \"add_shipping_info\", \"add_to_cart\", \"add_to_wishlist\", \"begin_checkout\", \"purchase\", \"refund\", \"remove_from_cart\", \"select_item\", \"select_promotion\", \"view_cart\", \"view_item\", \"view_item_list\", \"view_promotion\"]\u003c/strong\u003e"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Returns a list of Google Analytics 4 ecommerce event names.
* 
*
* @returns {Array} Array of GA4 ecommerce event name strings.
*
* @framework ggLowCodeGTMKit
*/
const gaEcommerceEventList = [
  'add_payment_info',
  'add_shipping_info',
  'add_to_cart',
  'add_to_wishlist',
  'begin_checkout',
  'purchase',
  'refund',
  'remove_from_cart',
  'select_item',
  'select_promotion',
  'view_cart',
  'view_item',
  'view_item_list',
  'view_promotion'
];
return gaEcommerceEventList;


___TESTS___

scenarios: []


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
