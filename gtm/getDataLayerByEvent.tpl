___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getDataLayerByEvent",
  "description": "Retrieves the most recent matching event  \u003cem\u003edataLayer\u003c/em\u003e event \u003cem\u003eobject\u003c/em\u003e from \u003cem\u003ewindow.dataLayer\u003c/em\u003e, or a first-level property value if specified.",
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
        "name": "evt",
        "displayName": "Event Name",
        "simpleValueType": true,
        "help": "💾 The event name to search for in window.dataLayer.\u003cbr\u003e\u003cbr\u003e\nSupported formats:\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;✓ \u003cem\u003eString\u003c/em\u003e (e.g. \"page_view\", \"purchase, \"ecommerce.*\" )",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "rgx",
        "checkboxText": "Use regex matching for event name",
        "simpleValueType": true,
        "help": "🔎 Enable regex pattern matching (\u003cstrong\u003eecommerce.*\u003c/strong\u003e matches \"ecommerce_interaction\", \"ecommerce_purchase\", etc.)"
      },
      {
        "type": "SELECT",
        "name": "add",
        "displayName": "Return Type",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "fob",
            "displayValue": "Full Object"
          },
          {
            "value": "dlv",
            "displayValue": "DataLayer Variable"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "fob"
      },
      {
        "type": "TEXT",
        "name": "key",
        "displayName": "Property Key",
        "simpleValueType": true,
        "help": "💾 Property to extract. \u003cbr\u003e\u003cbr\u003e\nSupported formats:\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;✓ \u003cem\u003eString\u003c/em\u003e (e.g. \"page\", \"page_category, \"ecommerce\" )",
        "enablingConditions": [
          {
            "paramName": "add",
            "paramValue": "dlv",
            "type": "EQUALS"
          }
        ],
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      }
    ],
    "help": "Retrieves the current \u003cem\u003edataLayer\u003c/em\u003e event \u003cem\u003eobject\u003c/em\u003e from \u003cem\u003ewindow.dataLayer\u003c/em\u003e, or a first-level property value if specified. \u003cbr\u003e\u003cbr\u003e↪️ Full Object: event \u003cem\u003eobject\u003c/em\u003e or \u003cem\u003e{}\u003c/em\u003e if not found.\u003cbr\u003e↪️ DataLayer Variable: property value or \u003cem\u003eundefined\u003c/em\u003e if not found.\u003cbr\u003e\u003cbr\u003e⚡ Result is cached\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFull Object with regex\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eEvent: \"page_.*\" (regex)\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{event: \"page_view\", page: {...}, ...}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDataLayer Variable\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eEvent: \"page_view\", Key: \"page\"\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{page_language: \"en\", ...}\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cem\u003eFunction\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\u003cem\u003e{{toCamelCase()}}\u003c/em\u003e - convert string to camelCase\u003cbr\u003e\u003cem\u003e{{undefinedTo(\"x\")}}\u003c/em\u003e - convert undefined value to \"x\"\u003cbr\u003e\u003cem\u003e{{filter(GreaterThan(10))}}\u003c/em\u003e - keep values greater than 10"
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Retrieves the most recent occurrence of a given event in window.dataLayer or a specific property.
 * Searches up to 1 level deep to handle wrapped structures.
 *
 * @param {string} data.evt - The event name to search for (Direct mode).
 * @param {boolean} [data.rgx] - Use regex matching for event name. Default: exact match.
 * @param {string} [data.add] - Mode: "fob" for full object, "dlv" for dataLayer variable.
 * @param {string} [data.key] - Property name to extract (when add="dlv").
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * @returns {Object|*} Full object (or {}) when fob, property value (or undefined) when dlv.
 *
 * @framework ggLowCodeGTMKit
 */
const copyFromWindow = require('copyFromWindow');
const copyFromDataLayer = require('copyFromDataLayer');
const templateStorage = require('templateStorage');
const EVENT_ID_KEY = 'gtm.uniqueEventId';
const gtmId = copyFromDataLayer(EVENT_ID_KEY);
const getEventObjectByName = function(eventName, useRegex) {
    if (!gtmId || !eventName) return undefined;
    
    const CACHE_KEY = 'dlEvtByName';
    const cacheKey = CACHE_KEY + '_' + eventName + '_' + gtmId;
    const cache = templateStorage.getItem(cacheKey);
    if (cache && cache.obj !== undefined && cache.obj !== '') {
        return cache.obj;
    }
    
    const dataLayer = copyFromWindow('dataLayer');
    if (!dataLayer) return undefined;
    
    const cacheAndReturn = function(obj) {
        templateStorage.setItem(cacheKey, { obj: obj });
        return obj;
    };
    
    const eventMatches = function(evt) {
        if (!evt) return false;
        if (useRegex) {
            return evt.match(eventName);
        }
        return evt === eventName;
    };
    
    const findEventObject = function(item) {
        if (!item || typeof item !== 'object') return undefined;
        
        if (eventMatches(item.event)) {
            const itemId = item[EVENT_ID_KEY];
            if (itemId && itemId <= gtmId) {
                return item;
            }
        }
        
        for (let key in item) {
            if (!item.hasOwnProperty(key)) continue;
            const nested = item[key];
            if (nested && typeof nested === 'object' && eventMatches(nested.event)) {
                const nestedId = nested[EVENT_ID_KEY];
                if (nestedId && nestedId <= gtmId) {
                    return nested;
                }
            }
        }
        
        return undefined;
    };
    
    for (let i = dataLayer.length - 1; i >= 0; i--) {
        const item = dataLayer[i];
        if (!item) continue;
        
        const found = findEventObject(item);
        if (found) {
            return cacheAndReturn(found);
        }
    }
    
    return cacheAndReturn(undefined);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// getDataLayerByEvent - Direct mode
// ===============================================================================
const eventObject = getEventObjectByName(data.evt, data.rgx);
if (data.add === 'dlv') {
    return out(eventObject ? eventObject[data.key] : undefined);
} else {
    return out(eventObject || {});
}
// ===============================================================================
// getDataLayerByEvent(...) – Apply Mode
// ===============================================================================
/*
return function(eventName, key) {
    key = data.rp1 ? data.key : key;
    const eventObject = getEventObjectByName(eventName, data.rgx);
    
    if (data.add === 'dlv') {
        return out(eventObject ? eventObject[key] : undefined);
    } else {
        return out(eventObject || {});
    }
};
*/


___WEB_PERMISSIONS___

[
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
            "string": "any"
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
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
