___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getGaMeasurementIds",
  "description": "Extracts all GA4 Measurement IDs from analytics storage. Returns an array of active GA4 property IDs found on the page.",
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
        "name": "cookieOptions",
        "displayName": "Custom Cookie Configuration",
        "groupStyle": "ZIPPY_CLOSED",
        "subParams": [
          {
            "type": "TEXT",
            "name": "pfx",
            "displayName": "Cookie Prefix (optional)",
            "simpleValueType": true,
            "help": "💾 Custom cookie prefix if GA uses non-standard cookie names.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e: \u003cem\u003e\"xyz\"\u003c/em\u003e"
          },
          {
            "type": "TEXT",
            "name": "dom",
            "displayName": "Cookie Domain (optional)",
            "simpleValueType": true,
            "help": "💾 Custom cookie domain for reading GA cookies.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eDomain\u003c/strong\u003e: \u003cem\u003e\"example.com\"\u003c/em\u003e, \u003cem\u003e\".example.com\"\u003c/em\u003e"
          },
          {
            "type": "TEXT",
            "name": "pth",
            "displayName": "Cookie Path (optional)",
            "simpleValueType": true,
            "help": "💾 Custom cookie path for reading GA cookies.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003ePath\u003c/strong\u003e: \u003cem\u003e\"/\"\u003c/em\u003e, \u003cem\u003e\"/app\"\u003c/em\u003e"
          }
        ],
        "help": "⚙️ Optional custom cookie configuration. Only needed if your GA implementation uses non-default cookie settings."
      }
    ],
    "help": "Extracts all GA4 Measurement IDs from analytics storage. Returns an array of measurement IDs for all active GA4 properties on the page.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSingle GA4 property\u003c/em\u003e***\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\"G-SSCHVBCL1B\"]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMultiple GA4 properties\u003c/em\u003e***\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\"G-SSCHVBCL1B\", \"G-ABCD123456\"]\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., \u003ccode\u003eval =\u003e val.split('.')[0]\u003c/code\u003e for first part only, \u003ccode\u003eval =\u003e 'CID:' + val\u003c/code\u003e for formatting). Useful for transformations or formatting."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Extracts available GA4 Measurement IDs from analytics storage
 * 
 * @param {string} [data.pfx] - Optional custom cookie prefix (e.g., "xyz")
 * @param {string} [data.dom] - Optional custom cookie domain (e.g., "google.com")
 * @param {string} [data.pth] - Optional custom cookie path (e.g., "/")
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 * 
 * @returns {Array|undefined} Array of Measurement IDs found (e.g., ["G-ABC123", "G-XYZ789"])
 *
 * @framework ggLowCodeGTMKit
 */
const readAnalyticsStorage = require('readAnalyticsStorage');

const getGaMeasurementIds = function(cookiePrefix, cookieDomain, cookiePath) {
    let cookieOptions;
    
    if (cookiePrefix || cookieDomain || cookiePath) {
        cookieOptions = {};
        if (cookiePrefix) cookieOptions.cookie_prefix = cookiePrefix;
        if (cookieDomain) cookieOptions.cookie_domain = cookieDomain;
        if (cookiePath) cookieOptions.cookie_path = cookiePath;
    }
    
    const analyticsData = readAnalyticsStorage(cookieOptions);
    
    if (!analyticsData || !analyticsData.sessions || analyticsData.sessions.length === 0) {
        return undefined;
    }
    
    const measurementIds = [];
    for (let i = 0; i < analyticsData.sessions.length; i++) {
        const session = analyticsData.sessions[i];
        if (session.measurement_id) {
            measurementIds.push(session.measurement_id);
        }
    }
    
    return measurementIds.length > 0 ? measurementIds : undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

return out(getGaMeasurementIds(data.pfx, data.dom, data.pth));


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_analytics_storage",
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
