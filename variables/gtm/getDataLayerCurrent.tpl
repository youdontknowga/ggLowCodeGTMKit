___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getDataLayerCurrent",
  "description": "Retrieves the current \u003cem\u003edataLayer\u003c/em\u003e event \u003cem\u003eobject\u003c/em\u003e from \u003cem\u003ewindow.dataLayer\u003c/em\u003e, or a first-level property value if specified.",
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
    "help": "Gets the current dataLayer object for a specific event or a property value from it.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFull object by event\u003c/em\u003e***\u003cbr\u003etemplateStorage: \u003cstrong\u003e{\u003c/strong\u003e\u003cbr\u003egetItem: \u003cstrong\u003efunction(key) { return storage[key]; },\u003c/strong\u003e\u003cbr\u003esetItem: \u003cstrong\u003efunction(key, value) { storage[key] = value; }\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e}\u003c/strong\u003e\u003cbr\u003eReturn Type: \u003cstrong\u003efob\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003epage_view\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eProperty value by event\u003c/em\u003e***\u003cbr\u003etemplateStorage: \u003cstrong\u003e{\u003c/strong\u003e\u003cbr\u003egetItem: \u003cstrong\u003efunction(key) { return storage[key]; },\u003c/strong\u003e\u003cbr\u003esetItem: \u003cstrong\u003efunction(key, value) { storage[key] = value; }\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e}\u003c/strong\u003e\u003cbr\u003eReturn Type: \u003cstrong\u003edlv', key: 'page\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003een\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it.\u003cbr\u003e\u003cbr\u003e\nSupported formats:\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;✓ \u003cem\u003eFunction\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\n_____________\u003cbr\u003e\n✏️\u0026nbsp;\u0026nbsp;\u003cem\u003eExamples\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\n\u003cem\u003e{{toCamelCase()}}\u003c/em\u003e - convert string to camelCase\u003cbr\u003e\n\u003cem\u003e{{undefinedTo(\"x\")}}\u003c/em\u003e - convert undefined value to \"x\"\u003cbr\u003e\n\u003cem\u003e{{filter(GreaterThan(10))}}\u003c/em\u003e - keep values greater than 10"
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Retrieves the current dataLayer event object or a specific property by gtm.uniqueEventId.
 * Searches up to 2 levels deep to handle wrapped structures.
 *
 * @param {string} [data.add] - Mode: "fob" for full object, "dlv" for dataLayer variable.
 * @param {string} [data.key] - Property name to extract (when add="dlv").
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * @returns {Object|*} Full object (or {}) when fob, property value (or undefined) when dlv.
 *
 * @framework ggLowCodeGTMKit
 */
const copyFromDataLayer = require('copyFromDataLayer');
const copyFromWindow = require('copyFromWindow');
const templateStorage = require('templateStorage');

const CACHE_KEY = 'dlEvt';
const EVENT_ID_KEY = 'gtm.uniqueEventId';
const gtmId = copyFromDataLayer(EVENT_ID_KEY);

const getEventObject = function() {
    if (!gtmId) return undefined;
    
    const cache = templateStorage.getItem(CACHE_KEY);
    if (cache && cache.id === gtmId) {
        return cache.obj;
    }
    
    const dataLayer = copyFromWindow('dataLayer');
    if (!dataLayer) return undefined;
    
    const cacheAndReturn = function(obj) {
        templateStorage.setItem(CACHE_KEY, { id: gtmId, obj: obj });
        return obj;
    };
    
    const findEventObject = function(item) {
        if (!item || typeof item !== 'object') return undefined;
        
        if (item[EVENT_ID_KEY] === gtmId) {
            return item;
        }
        
        for (let key in item) {
            if (!item.hasOwnProperty(key)) continue;
            const nested = item[key];
            if (nested && typeof nested === 'object' && nested[EVENT_ID_KEY] === gtmId) {
                return nested;
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
        
        const itemId = item[EVENT_ID_KEY];
        if (itemId && itemId > gtmId) continue;
        if (itemId && itemId < gtmId) break;
    }
    
    return undefined;
};

const eventObject = getEventObject();
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// getDataLayerCurrent - Direct mode
// ===============================================================================
if (data.add === 'dlv') {
    return out(eventObject ? eventObject[data.key] : undefined);
} else {
  return out(eventObject || {});
}
// ===============================================================================
// getDataLayerCurrent() – Apply Mode
// ===============================================================================
/*
if (data.add === 'dlv') {
    return function(key) {
      return out(eventObject ? eventObject[key] : undefined);
    };
} else {
  return function() {
    return out(eventObject || {});
  };
}
*/


___WEB_PERMISSIONS___

[
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
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "gtm.uniqueEventId"
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

scenarios:
  - name: '[example] Full object by event'
    code: |-
      /* @display
      templateStorage: {
          getItem: function(key) { return storage[key]; },
          setItem: function(key, value) { storage[key] = value; }
      }
      Return Type: fob
      @output
      page_view
      */
      let storage = {};
      mock('copyFromDataLayer', function(key) {
          if (key === 'gtm.uniqueEventId') return 5;
          return undefined;
      });
      mock('copyFromWindow', function(key) {
          if (key === 'dataLayer') return [
              {event: 'page_view', page: {page_language: 'en'}, 'gtm.uniqueEventId': 5}
          ];
          return undefined;
      });
      const templateStorage = {
          getItem: function(key) { return storage[key]; },
          setItem: function(key, value) { storage[key] = value; }
      };

      const mockData = {add: 'fob'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func();
      }
      assertThat(variableResult.event).isEqualTo('page_view');
      assertThat(variableResult.page.page_language).isEqualTo('en');
  - name: Test Full Object mode with event not found returns empty object
    code: |
      let storage = {};
      mock('copyFromDataLayer', function(key) {
          if (key === 'gtm.uniqueEventId') return 99;
          return undefined;
      });
      mock('copyFromWindow', function(key) {
          if (key === 'dataLayer') return [
              {event: 'page_view', 'gtm.uniqueEventId': 5}
          ];
          return undefined;
      });
      const templateStorage = {
          getItem: function(key) { return storage[key]; },
          setItem: function(key, value) { storage[key] = value; }
      };


      const mockData = {add: 'fob'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func();
      }
      assertThat(variableResult).isEqualTo({});
  - name: '[example] Property value by event'
    code: |-
      /* @display
      templateStorage: {
          getItem: function(key) { return storage[key]; },
          setItem: function(key, value) { storage[key] = value; }
      }
      Return Type: dlv', key: 'page
      @output
      en
      */
      let storage = {};
      mock('copyFromDataLayer', function(key) {
          if (key === 'gtm.uniqueEventId') return 5;
          return undefined;
      });
      mock('copyFromWindow', function(key) {
          if (key === 'dataLayer') return [
              {event: 'page_view', page: {page_language: 'en', page_full_uri: '/'}, 'gtm.uniqueEventId': 5}
          ];
          return undefined;
      });
      const templateStorage = {
          getItem: function(key) { return storage[key]; },
          setItem: function(key, value) { storage[key] = value; }
      };


      const mockData = {add: 'dlv', key: 'page'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('page');
      }
      assertThat(variableResult.page_language).isEqualTo('en');
      assertThat(variableResult.page_full_uri).isEqualTo('/');
  - name: Test DataLayer Variable mode with event not found returns undefined
    code: |-
      let storage = {};
      mock('copyFromDataLayer', function(key) {
          if (key === 'gtm.uniqueEventId') return 99;
          return undefined;
      });
      mock('copyFromWindow', function(key) {
          if (key === 'dataLayer') return [
              {event: 'page_view', page: {page_language: 'en'}, 'gtm.uniqueEventId': 5}
          ];
          return undefined;
      });
      const templateStorage = {
          getItem: function(key) { return storage[key]; },
          setItem: function(key, value) { storage[key] = value; }
      };


      const mockData = {add: 'dlv', key: 'page'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('page');
      }
      assertThat(variableResult).isUndefined();
  - name: Test DataLayer Variable mode with key not found returns undefined
    code: |-
      let storage = {};
      mock('copyFromDataLayer', function(key) {
          if (key === 'gtm.uniqueEventId') return 5;
          return undefined;
      });
      mock('copyFromWindow', function(key) {
          if (key === 'dataLayer') return [
              {event: 'page_view', page: {page_language: 'en'}, 'gtm.uniqueEventId': 5}
          ];
          return undefined;
      });
      const templateStorage = {
          getItem: function(key) { return storage[key]; },
          setItem: function(key, value) { storage[key] = value; }
      };


      const mockData = {add: 'dlv', key: 'missing_key'};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('missing_key');
      }
      assertThat(variableResult).isUndefined();
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'direct';
  // ===================================================================================================
  // Derived flags
  // ===================================================================================================
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
