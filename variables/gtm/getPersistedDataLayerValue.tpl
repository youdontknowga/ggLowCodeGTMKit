___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getPersistedDataLayerValue",
  "description": "Retrieves a value from the GTM dataLayer and persists it in localStorage across page loads. Returns the latest value or the last stored one. Supports dot notation for nested properties.",
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
        "displayName": "DataLayer Variable Name",
        "simpleValueType": true,
        "help": "💾 The name of the dataLayer variable to retrieve and persist.\u003cbr\u003e\u003cbr\u003e\nSupports dot notation for nested properties:\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eTop-level variable\u003c/strong\u003e: \u003cem\u003e\"userId\"\u003c/em\u003e, \u003cem\u003e\"eventName\"\u003c/em\u003e\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNested property\u003c/strong\u003e: \u003cem\u003e\"user.email\"\u003c/em\u003e, \u003cem\u003e\"ecommerce.purchase.value\"\u003c/em\u003e\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray index\u003c/strong\u003e: \u003cem\u003e\"products.0.name\"\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\nSupported formats:\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;✓ \u003cem\u003e\"String\"\u003c/em\u003e\u003cbr\u003e",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      }
    ],
    "help": "Retrieves a value from the GTM dataLayer and persists it across page loads. Returns the latest value when available, or the previously stored value if not. Supports dot notation for nested properties and array indices.\u003cbr\u003e\u003cbr\u003e\n↪️ Returns the current dataLayer value, the last stored value, or \u003cem\u003eundefined\u003c/em\u003e if none exists.\u003cbr\u003e\n_____________________________________________\u003cbr\u003e\n✏️ \u003cem\u003eExample - Value Available in dataLayer\u003c/em\u003e\u003cbr\u003e\n\u003cbr\u003eVariable Name: \u003cstrong\u003e\"userId\"\u003c/strong\u003e\u003cbr\u003e\nDataLayer: \u003cstrong\u003e{userId: \"12345\"}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e\n↪️ Output:\u003cstrong\u003e \"12345\"\u003c/strong\u003e\u003cbr\u003e\n_____________________________________________\u003cbr\u003e\n✏️ \u003cem\u003eExample - Fallback to Stored Value\u003c/em\u003e\u003cbr\u003e\n\u003cbr\u003eVariable Name: \u003cstrong\u003e\"userId\"\u003c/strong\u003e\u003cbr\u003e\nPrevious page stored value:\u003cstrong\u003e \"12345\"\u003c/strong\u003e\u003cbr\u003e\nDataLayer: \u003cstrong\u003e {}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e\n↪️ Output:\u003cstrong\u003e \"12345\"\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e"
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
        "help": "⚙️ Optional function to apply to the input before processing.\u003cbr\u003e\u003cbr\u003e\nSupported formats:\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;\u0026nbsp;✓ Function\u003cbr\u003e\u003cbr\u003e\n___________\u003cbr\u003e\n✏️ \u003cem\u003eExamples\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\n\u003cem\u003e{{toNumber()}}\u003c/em\u003e - convert input to number\u003cbr\u003e\n\u003cem\u003e{{toLowerCase()}}\u003c/em\u003e - convert input to lowercase\u003cbr\u003e\n\u003cem\u003e{{trim()}}\u003c/em\u003e - remove whitespace from input\u003cbr\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it.\u003cbr\u003e\u003cbr\u003e\nSupported formats:\u003cbr\u003e\n  \u0026nbsp; \u0026nbsp;\u0026nbsp;✓ Function\u003cbr\u003e\u003cbr\u003e\n___________\u003cbr\u003e\n✏️   \u003cem\u003eExamples\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\n\u003cem\u003e{{toCamelCase()}}\u003c/em\u003e - convert string to camelCase\u003cbr\u003e\n\u003cem\u003e{{undefinedTo(\"x\")}}\u003c/em\u003e - convert undefined value to \"x\"\u003cbr\u003e\n\u003cem\u003e{{filter(GreaterThan(10))}}\u003c/em\u003e - keep values greater than 10"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Retrieves a value from the dataLayer and persists it across page loads
 * 
 * @param {string} data.key - The dataLayer variable name to retrieve (supports dot notation)
 * @param {Function|string} [data.out] - Optional output handler
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor
 * 
 * @returns {*} The latest value, stored value, or undefined
 *
 * @framework ggLowCodeGTMKit
 */

const localStorage = require('localStorage');
const templateStorage = require('templateStorage');
const copyFromDataLayer = require('copyFromDataLayer');
const JSON = require('JSON');

const STORAGE_KEY = 'gtm-persistent-data';

const getPersistedDataLayerValue = function(key) {
  if (!key) {
    return undefined;
  }

  let cache = templateStorage.getItem(STORAGE_KEY);

  if (!cache) {
    const storedRaw = localStorage.getItem(STORAGE_KEY);
    cache = storedRaw ? JSON.parse(storedRaw) : {};
    templateStorage.setItem(STORAGE_KEY, cache);
  }

  const cachedValue = cache[key];
  const freshValue = copyFromDataLayer(key);

  if (freshValue !== undefined && freshValue !== cachedValue) {
    cache[key] = freshValue;
    localStorage.setItem(STORAGE_KEY, JSON.stringify(cache));
    return freshValue;
  }

  return freshValue !== undefined ? freshValue : cachedValue;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const variableName = applyCast(data.pre, data.key);
return out(getPersistedDataLayerValue(variableName));

// ===============================================================================
// Apply mode
// ===============================================================================
/*
return function(key) {
  return out(getPersistedDataLayerValue(applyCast(data.pre, key)));
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
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtm-persistent-data"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
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
  - name: '[example] Retrieve persisted userId'
    code: |-
      /* @display
      DataLayer Variable Name: userId
      DataLayer: {userId: "12345"}
      @output
      "12345"
      */
      mock('copyFromDataLayer', function(key) {
          if (key === 'userId') return '12345';
          return undefined;
      });
      mock('localStorage.getItem', function() { return null; });
      mock('localStorage.setItem', function() {});
      mock('templateStorage.getItem', function() { return null; });
      mock('templateStorage.setItem', function() {});

      const mockData = {
          key: 'userId'
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('userId');
      }
      assertThat(variableResult).isEqualTo('12345');
  - name: '[example] Fallback to stored value'
    code: |-
      /* @display
      DataLayer Variable Name: userId
      DataLayer: {} (empty)
      Previously stored: "12345"
      @output
      "12345"
      */
      mock('copyFromDataLayer', function() { return undefined; });
      mock('localStorage.getItem', function() { return '{"userId":"12345"}'; });
      mock('localStorage.setItem', function() {});
      mock('templateStorage.getItem', function() { return null; });
      mock('templateStorage.setItem', function() {});

      const mockData = {
          key: 'userId'
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('userId');
      }
      assertThat(variableResult).isEqualTo('12345');
  - name: Test empty key returns undefined
    code: |-
      mock('copyFromDataLayer', function() { return undefined; });
      mock('localStorage.getItem', function() { return null; });
      mock('localStorage.setItem', function() {});
      mock('templateStorage.getItem', function() { return null; });
      mock('templateStorage.setItem', function() {});

      const mockData = {
          key: ''
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('');
      }
      assertThat(variableResult).isUndefined();
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
