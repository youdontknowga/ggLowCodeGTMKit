___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "⚙️ GEN - COMMAND TABLE › Lazy (Advanced)",
  "description": "Builds a parameter \u003cem\u003eobject\u003c/em\u003e combining global and event-specific parameters. Supports \u003cem\u003edlv\u003c/em\u003e and \u003cem\u003elzv\u003c/em\u003e types — event parameters evaluate only when the input matches their pattern.",
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
        "name": "h1_OBJECT",
        "displayName": "____________________ \u003cbr\u003e \u0026nbsp;\u0026nbsp;\u0026nbsp\u0026nbsp🅾🅱🅹🅴🅲🆃\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp; \u003cbr\u003e ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
      },
      {
        "type": "CHECKBOX",
        "name": "agp",
        "checkboxText": "Add Global Parameter (not Lazy and shared)",
        "simpleValueType": true,
        "help": "✓ Include global parameters that are always added to the output object, regardless of event matching."
      },
      {
        "type": "CHECKBOX",
        "name": "aep",
        "checkboxText": "Add Event Parameter (Lazy)",
        "simpleValueType": true,
        "help": "✓ Include event-specific parameters that are only evaluated and added when the input variable matches."
      },
      {
        "type": "GROUP",
        "name": "globalParam",
        "displayName": "\u200B",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "LABEL",
            "name": "h2_Global Parameters",
            "displayName": "--------------------------------------------------------\u003cstrong\u003e Global Parameters\u0026nbsp;⬇\u003c/strong\u003e--------------------------------------------------------"
          },
          {
            "type": "SIMPLE_TABLE",
            "name": "gpm",
            "displayName": "",
            "simpleTableColumns": [
              {
                "defaultValue": "",
                "displayName": "Global Parameter",
                "name": "key",
                "type": "TEXT"
              },
              {
                "defaultValue": "",
                "displayName": "Value",
                "name": "val",
                "type": "TEXT"
              },
              {
                "defaultValue": "val",
                "displayName": "Process as",
                "name": "typ",
                "type": "SELECT",
                "selectItems": [
                  {
                    "value": "val",
                    "displayValue": "Value"
                  },
                  {
                    "value": "dlv",
                    "displayValue": "Data Layer Variable"
                  },
                  {
                    "value": "lzv",
                    "displayValue": "Lazy Variable"
                  }
                ]
              }
            ],
            "newRowButtonText": "+ Global Parameter",
            "help": "💾 Global parameters that are \u003cstrong\u003ealways included\u003c/strong\u003e in the output object.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eProcess as:\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• \u003cstrong\u003eValue\u003c/strong\u003e: Use as-is\u003cbr\u003e\u0026nbsp;\u0026nbsp;• \u003cstrong\u003eData Layer Variable\u003c/strong\u003e: Read from dataLayer using the value as path\u003cbr\u003e\u0026nbsp;\u0026nbsp;• \u003cstrong\u003eLazy Variable\u003c/strong\u003e: Evaluate function on execution"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "agp",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "eventParam",
        "displayName": "\u200B",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "LABEL",
            "name": "h2_Event Parameters",
            "displayName": "---------------------------------------------------------\u003cstrong\u003e Event Parameters\u0026nbsp;⬇\u003c/strong\u003e--------------------------------------------------------"
          },
          {
            "type": "TEXT",
            "name": "inp",
            "displayName": "Input Variable",
            "simpleValueType": true,
            "help": "🔍 The variable to match against event parameter input patterns.\u003cbr\u003e\u003cbr\u003eExample: \u003ccode\u003e{{Event Name}}\u003c/code\u003e or \u003ccode\u003e{{Page Type}}\u003c/code\u003e"
          },
          {
            "type": "CHECKBOX",
            "name": "urm",
            "checkboxText": "Use regex matching",
            "simpleValueType": true,
            "help": "Enable regex pattern matching for event parameter inputs. When unchecked, uses exact string matching."
          },
          {
            "type": "SIMPLE_TABLE",
            "name": "epm",
            "displayName": "",
            "simpleTableColumns": [
              {
                "defaultValue": "",
                "displayName": "Input Pattern",
                "name": "inp",
                "type": "TEXT"
              },
              {
                "defaultValue": "",
                "displayName": "Event Parameter",
                "name": "key",
                "type": "TEXT"
              },
              {
                "defaultValue": "",
                "displayName": "Value",
                "name": "val",
                "type": "TEXT"
              },
              {
                "defaultValue": "val",
                "displayName": "Process as",
                "name": "typ",
                "type": "SELECT",
                "selectItems": [
                  {
                    "value": "val",
                    "displayValue": "Value"
                  },
                  {
                    "value": "dlv",
                    "displayValue": "Data Layer Variable"
                  },
                  {
                    "value": "lzv",
                    "displayValue": "Lazy Variable"
                  }
                ]
              }
            ],
            "newRowButtonText": "+ Event Parameter",
            "help": "💾 Event-specific parameters that are \u003cstrong\u003eonly included\u003c/strong\u003e when the Input Pattern matches the Input Variable above.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eInput Pattern:\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Exact match (default): \u003ccode\u003e\"page_view\"\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Regex match (if enabled): \u003ccode\u003e\"^purchase.*\"\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eProcess as:\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• \u003cstrong\u003eValue\u003c/strong\u003e: Use as-is\u003cbr\u003e\u0026nbsp;\u0026nbsp;• \u003cstrong\u003eData Layer Variable\u003c/strong\u003e: Read from dataLayer\u003cbr\u003e\u0026nbsp;\u0026nbsp;• \u003cstrong\u003eLazy Variable\u003c/strong\u003e: Evaluate function on execution"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "aep",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      }
    ],
    "help": "Builds a parameter \u003cem\u003eobject\u003c/em\u003e combining global and event-specific parameters. Supports \u003cem\u003edlv\u003c/em\u003e and \u003cem\u003elzv\u003c/em\u003e types — event parameters evaluate only when the input matches their pattern.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGlobal parameters\u003c/em\u003e***\u003cbr\u003eAdd Global Parameter (not Lazy and shared): \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003eGlobal Parameters: \u003cstrong\u003e[...\u003c/strong\u003e\u003cbr\u003eAdd Event Parameter (Lazy): \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{tracker_id: 'UA-12345', send_page_view: 'true'}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEvent parameters match\u003c/em\u003e***\u003cbr\u003eAdd Global Parameter (not Lazy and shared): \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eAdd Event Parameter (Lazy): \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003eInput Variable: \u003cstrong\u003e{{Event}}\u003c/strong\u003e\u003cbr\u003eUse regex matching: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eEvent Parameters: \u003cstrong\u003e[...\u003c/strong\u003e\u003cbr\u003e//When Event === purchase\u003cbr\u003e↪️ Output: \u003cstrong\u003e{transaction_id: 'TX-123'}\u003c/strong\u003e"
  },
  {
    "type": "GROUP",
    "name": "Property Access",
    "displayName": "Property Access",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "TEXT",
        "name": "set",
        "displayName": "Setter Function (optional)",
        "simpleValueType": true,
        "help": "⚙️ Optional function to customize how values are assigned: \u003ccode\u003e(obj, key, value) =\u003e {...}\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eDefault behavior: \u003ccode\u003eobj[key] = value\u003c/code\u003e (shallow assignment).\u003cbr\u003e\u003cbr\u003eUse this for:\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Deep path assignment\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Validation before setting\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Custom assignment logic"
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
        "help": "⚙️ Optional function to transform the final object before returning it (e.g., \u003ccode\u003eobj =\u003e JSON.stringify(obj)\u003c/code\u003e, \u003ccode\u003eobj =\u003e Object.freeze(obj)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Creates a parameter object for tracker commands with global and event-specific parameters.
 * Event parameters are evaluated only when input matches the condition.
 * 
 * @param {boolean} data.agp - Whether to include global parameters.
 * @param {Array<{key: string, val: any, typ?: string}>} data.gpm - Global parameters (always included).
 * @param {boolean} data.aep - Whether to include event parameters.
 * @param {Array<{key: string, val: any, typ?: string, inp: string}>} data.epm - Event parameters with input matching.
 * @param {string} data.inp - Input variable to match against event parameters.
 * @param {boolean} data.urm - Whether to use regex matching (true) or exact matching (false).
 * @param {Function} [data.set] - Optional custom setter function (defaults to shallow assignment).
 * @param {Function|string} [data.out] - Optional output handler.
 * 
 * @returns {Object} Parameter object with applied transformations.
 *
 * @framework ggLowCodeGTMKit
 */
const copyFromDataLayer = require('copyFromDataLayer');

const buildCommandTable = function(agp, gpm, aep, epm, inp, urm, set) {
    const globalParameters = agp ? (gpm || []) : [];
    const eventParameters = aep ? (epm || []) : [];
    const inputVariable = inp;
    const useRegex = urm;

    const matchRule = function(pattern, value, isRegex) {
        if (isRegex) {
            return value && value.toString().match(pattern);
        }
        return pattern === value;
    };

    const applyTypToVal = function(arr) {
        return arr.map(item => {
            let val = item.val;
            if (item.typ === 'dlv') {
                val = copyFromDataLayer(val);
            } else if (item.typ === 'lzv' && typeof val === 'function') {
                val = val();
            }
            return {
                key: item.key,
                val: val
            };
        });
    };

    const setShallow = (obj, key, value) => {
        obj[key] = value;
    };
    const setter = typeof set === 'function' ? set : setShallow;

    const assignFromPairs = (targetObj, keyValuePairs, setterFn) => {
        keyValuePairs.forEach(pair => {
            setterFn(targetObj, pair.key, pair.val);
        });
        return targetObj;
    };

    const eventParametersToKeep = eventParameters.filter(x => matchRule(x.inp, inputVariable, useRegex));
    let finalTable = globalParameters.concat(eventParametersToKeep);
    finalTable = applyTypToVal(finalTable);

    return assignFromPairs({}, finalTable, setter);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

return out(buildCommandTable(data.agp, data.gpm, data.aep, data.epm, data.inp, data.urm, data.set));



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
  - name: '[example] Global parameters'
    code: |
      /* @display
      Add Global Parameter (not Lazy and shared): true
      Global Parameters: [{key: 'tracker_id', val: 'UA-12345', typ: 'val'}, {key: 'send_page_view', val: 'true', typ: 'val'}]
      Add Event Parameter (Lazy): false
      @output
      {tracker_id: 'UA-12345', send_page_view: 'true'}
      */
      const mockData = {
          agp: true,
          gpm: [
              {key: 'tracker_id', val: 'UA-12345', typ: 'val'},
              {key: 'send_page_view', val: 'true', typ: 'val'}
          ],
          aep: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({tracker_id: 'UA-12345', send_page_view: 'true'});
  - name: '[example] Event parameters match'
    code: |
      /* @display
      Add Global Parameter (not Lazy and shared): false
      Add Event Parameter (Lazy): true
      Input Variable: {{Event}}
      Use regex matching: false
      Event Parameters: [{inp: 'purchase', key: 'transaction_id', val: 'TX-123', typ: 'val'}, {inp: 'page_view', key: 'page_title', val: 'Home', typ: 'val'}]
      //When Event === purchase
      @output
{transaction_id: 'TX-123'}
      */
      const mockData = {
          agp: false,
          aep: true,
          epm: [
              {inp: 'purchase', key: 'transaction_id', val: 'TX-123', typ: 'val'},
              {inp: 'page_view', key: 'page_title', val: 'Home', typ: 'val'}
          ],
          inp: 'purchase',
          urm: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({transaction_id: 'TX-123'});
  - name: Event parameters with no match - should return empty object
    code: |-
      const mockData = {
          agp: false,
          aep: true,
          epm: [
              {inp: 'purchase', key: 'transaction_id', val: 'TX-123', typ: 'val'},
              {inp: 'page_view', key: 'page_title', val: 'Home', typ: 'val'}
          ],
          inp: 'add_to_cart',
          urm: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({});
  - name: Event parameters with regex match - should include parameters matching regex pattern
    code: |
      const mockData = {
          agp: false,
          aep: true,
          epm: [
              {inp: '^purchase.*', key: 'transaction_id', val: 'TX-123', typ: 'val'},
              {inp: 'page_view', key: 'page_title', val: 'Home', typ: 'val'}
          ],
          inp: 'purchase_complete',
          urm: true
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({transaction_id: 'TX-123'});
  - name: Combination of global and event parameters - should merge both
    code: |-
      const mockData = {
          agp: true,
          gpm: [
              {key: 'tracker_id', val: 'UA-12345', typ: 'val'},
              {key: 'user_id', val: '999', typ: 'val'}
          ],
          aep: true,
          epm: [
              {inp: 'purchase', key: 'transaction_id', val: 'TX-123', typ: 'val'},
              {inp: 'purchase', key: 'value', val: '100', typ: 'val'}
          ],
          inp: 'purchase',
          urm: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({
          tracker_id: 'UA-12345',
          user_id: '999',
          transaction_id: 'TX-123',
          value: '100'
      });
  - name: Lazy Variable processing - should evaluate function
    code: |
      const lazyFunc = function() { return 'computed_value'; };
      const mockData = {
          agp: true,
          gpm: [
              {key: 'dynamic_param', val: lazyFunc, typ: 'lzv'},
              {key: 'static_param', val: 'static', typ: 'val'}
          ],
          aep: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({dynamic_param: 'computed_value', static_param: 'static'});
  - name: Multiple event parameter matches with regex - should include all matching patterns
    code: |
      const mockData = {
          agp: false,
          aep: true,
          epm: [
              {inp: '^page_.*', key: 'page_type', val: 'standard', typ: 'val'},
              {inp: '.*_view$', key: 'view_type', val: 'full', typ: 'val'},
              {inp: 'checkout', key: 'checkout_step', val: '1', typ: 'val'}
          ],
          inp: 'page_view',
          urm: true
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({page_type: 'standard', view_type: 'full'});
  - name: No parameters enabled - should return empty object
    code: |-
      const mockData = {
          agp: false,
          aep: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({});
  - name: Custom setter and output function - should apply custom logic
    code: |-
      const customSetter = (obj, key, value) => {
          obj[key] = typeof value === 'string' ? value.toUpperCase() : value;
      };
      const mockData = {
          agp: true,
          gpm: [
              {key: 'event_name', val: 'purchase', typ: 'val'},
              {key: 'category', val: 'ecommerce', typ: 'val'}
          ],
          aep: false,
          set: customSetter,
          out: obj => obj.category
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('ECOMMERCE');
  - name: Data Layer Variable processing - should read from dataLayer
    code: |-
      const mockData = {
          agp: true,
          gpm: [
              {key: 'user_id', val: 'userId', typ: 'dlv'},
              {key: 'session_id', val: 'sessionId', typ: 'dlv'}
          ],
          aep: false
      };
      const variableResult = runCode(mockData);
      // copyFromDataLayer will be called with 'userId' and 'sessionId'
      // Assuming dataLayer has these values, the test should verify the function was called
      assertThat(typeof variableResult.user_id).isNotEqualTo('undefined');


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
