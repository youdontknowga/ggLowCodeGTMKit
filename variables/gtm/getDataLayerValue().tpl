___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getDataLayerValue()",
  "description": "Retrieves a value from the GTM dataLayer using GTM\u0027s API (works with any dataLayer name). Supports dot notation to access nested properties and array indices.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTop-level variable\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNested variable\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e99.99\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Variable Name",
        "displayName": "🔗 Chained callback parameter: DataLayer Variable Name"
      }
    ],
    "help": "Retrieves a value from the GTM dataLayer by variable name.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTop-level variable\u003c/em\u003e***\u003cbr\u003edlVariableName: \u003cstrong\u003euserId\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNested variable\u003c/em\u003e***\u003cbr\u003edlVariableName: \u003cstrong\u003eecommerce.purchase.value\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e99.99\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it.\u003cbr\u003e\u003cbr\u003e\nSupported formats:\u003cbr\u003e\n  \u0026nbsp; \u0026nbsp;\u0026nbsp;✓ Function\u003cbr\u003e\u003cbr\u003e\n___________\u003cbr\u003e\n✏️   \u003cem\u003eExamples\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\n\u003cstrong\u003e{{toCamelCase()}}\u003c/strong\u003e - convert string to camelCase\u003cbr\u003e\n\u003cstrong\u003e{{undefinedTo(\"x\")}}\u003c/strong\u003e - convert undefined value to \"x\"\u003cbr\u003e\n\u003cstrong\u003e{{filter(GreaterThan(10))}}\u003c/strong\u003e - keep values greater than 10"
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Retrieves a value from the dataLayer
 * 
 * @param {string} data.dlVariableName - The dataLayer variable name to retrieve (supports dot notation)
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform variable name before retrieval.
 * 
 * @returns {*} The value from the dataLayer, or undefined if not found
 *
 * @framework ggLowCodeGTMKit
 */
const copyFromDataLayer = require('copyFromDataLayer');

const getDataLayerValue = function(variableName) {
    if (!variableName) {
        return undefined;
    }
    return copyFromDataLayer(variableName);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// getDataLayerValue - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const variableName = applyCast(data.pre, data.dlVariableName);
return out(getDataLayerValue(variableName));
*/
// ===============================================================================
// getDataLayerValue() – Apply Mode
// ===============================================================================
return function(variableName) {
   return out(getDataLayerValue(variableName));
};


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
  }
]


___TESTS___

scenarios:
  - name: '[example] Top-level variable'
    code: |-
      /* @display
      dlVariableName: userId
      @output
      12345
      */
      mock('copyFromDataLayer', key => {
          if (key === 'userId') return '12345';
          return undefined;
      });

      const mockData = {
          dlVariableName: 'userId',
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('userId');
      }
      assertThat(variableResult).isEqualTo('12345');
  - name: '[example] Nested variable'
    code: |-
      /* @display
      dlVariableName: ecommerce.purchase.value
      @output
      99.99
      */
      mock('copyFromDataLayer', key => {
          if (key === 'ecommerce.purchase.value') return 99.99;
          return undefined;
      });

      const mockData = {
          dlVariableName: 'ecommerce.purchase.value',
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('ecommerce.purchase.value');
      }
      assertThat(variableResult).isEqualTo(99.99);
  - name: Test undefined variable returns undefined
    code: |-
      mock('copyFromDataLayer', key => {
          return undefined;
      });

      const mockData = {
          dlVariableName: 'nonexistent',
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('nonexistent');
      }
      assertThat(variableResult).isUndefined();
  - name: Test empty variable name returns undefined
    code: |
      const mockData = {
          dlVariableName: '',
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('');
      }
      assertThat(variableResult).isUndefined();
  - name: Test with output function transformation
    code: |-
      mock('copyFromDataLayer', key => {
          if (key === 'greeting') return 'hello';
          return undefined;
      });

      const mockData = {
          dlVariableName: 'greeting',
          out: function(val) { return val.toUpperCase(); },
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func('greeting');
      }
      assertThat(variableResult).isEqualTo('HELLO');
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
  const mode = 'apply';
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
