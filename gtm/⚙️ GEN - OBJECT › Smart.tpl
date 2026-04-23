___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "⚙️ GEN - OBJECT › Smart",
  "description": "Transforms a source \u003cem\u003eobject\u003c/em\u003e by layering fixed, conditional, and rule-based properties. Existing properties can be preserved or overwritten. Supports custom setter for advanced assignment logic",
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
        "type": "TEXT",
        "name": "src",
        "displayName": "Source Object",
        "simpleValueType": true,
        "help": "💾 The source object to start from.\u003cbr\u003e\u003cbr\u003eUse the checkboxes below to add additional properties."
      },
      {
        "type": "SELECT",
        "name": "rul",
        "displayName": "Source Properties Handling",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": true,
            "displayValue": "Keep source properties"
          },
          {
            "value": false,
            "displayValue": "Remove source properties"
          }
        ],
        "simpleValueType": true,
        "defaultValue": true,
        "help": "🔧 Choose whether to keep properties from the source object.\u003cbr\u003e\u003cbr\u003e• \u003cstrong\u003eKeep\u003c/strong\u003e: Start with source object, add/overwrite with new properties\u003cbr\u003e• \u003cstrong\u003eRemove\u003c/strong\u003e: Start with empty object, only include new properties added below"
      },
      {
        "type": "CHECKBOX",
        "name": "afp",
        "checkboxText": "Add fixed property (or from variable)",
        "simpleValueType": true,
        "help": "✓ Include properties that are always added to the object, regardless of conditions."
      },
      {
        "type": "CHECKBOX",
        "name": "acp",
        "checkboxText": "Add conditional property (or from variable)",
        "simpleValueType": true,
        "help": "✓ Include properties that are only added when a global condition is true."
      },
      {
        "type": "CHECKBOX",
        "name": "arb",
        "checkboxText": "Add Rule-Based Properties",
        "simpleValueType": true,
        "help": "✓ Include properties where each property has its own individual condition."
      },
      {
        "type": "GROUP",
        "name": "newProp",
        "displayName": "",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "LABEL",
            "name": "h2_Add Fixed Property",
            "displayName": "-------------------------------------------------------\u003cstrong\u003e Add Fixed Property\u0026nbsp;⬇\u003c/strong\u003e\n--------------------------------------------------------"
          },
          {
            "type": "SIMPLE_TABLE",
            "name": "ffp",
            "displayName": "",
            "simpleTableColumns": [
              {
                "defaultValue": "",
                "displayName": "Property (Target Object)",
                "name": "key",
                "type": "TEXT"
              },
              {
                "defaultValue": "",
                "displayName": "Value",
                "name": "val",
                "type": "TEXT"
              }
            ],
            "newRowButtonText": "+ Add Property",
            "help": "💾 Define properties with static values that will always be added to the resulting object.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eProperty name\u003c/strong\u003e: Any valid object key\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eValue\u003c/strong\u003e: Static value or GTM variable"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "afp",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "conProp",
        "displayName": "",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "LABEL",
            "name": "h2_Add Conditional Property",
            "displayName": "---------------------------------------------------\u003cstrong\u003e\nAdd Conditional Property\u0026nbsp;⬇\u003c/strong\u003e---------------------------------------------------"
          },
          {
            "type": "TEXT",
            "name": "con",
            "displayName": "Condition",
            "simpleValueType": true,
            "help": "🔍 Enter a condition expression. If this evaluates to \u003cem\u003etrue\u003c/em\u003e, all properties below will be added to the object.\u003cbr\u003e\u003cbr\u003eExample: \u003ccode\u003e{{Page Type}} === \"checkout\"\u003c/code\u003e"
          },
          {
            "type": "SIMPLE_TABLE",
            "name": "fcp",
            "displayName": "",
            "simpleTableColumns": [
              {
                "defaultValue": "",
                "displayValue": "Property (Target Object)",
                "name": "key",
                "type": "TEXT"
              },
              {
                "defaultValue": "",
                "displayName": "Value",
                "name": "val",
                "type": "TEXT"
              }
            ],
            "newRowButtonText": "+ Add Property",
            "help": "💾 Properties that will be added only if the global condition above evaluates to \u003cem\u003etrue\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003eAll properties in this table share the same condition."
          }
        ],
        "enablingConditions": [
          {
            "paramName": "acp",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "rulProp",
        "displayName": "",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "LABEL",
            "name": "h2_Add Rule-Based Properties",
            "displayName": "--------------------------------------------------\u003cstrong\u003e Add Rule-Based Properties\u0026nbsp;⬇\u003c/strong\u003e-------------------------------------------------"
          },
          {
            "type": "SIMPLE_TABLE",
            "name": "rbp",
            "displayName": "",
            "simpleTableColumns": [
              {
                "defaultValue": "",
                "displayName": "Property (Target Object)",
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
                "defaultValue": "",
                "displayName": "Condition",
                "name": "con",
                "type": "TEXT"
              }
            ],
            "newRowButtonText": "+ Add Property",
            "help": "💾 Each property has its own condition. A property is added only if \u003cem\u003eits specific condition\u003c/em\u003e evaluates to \u003cem\u003etrue\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003eProperties are evaluated independently - multiple properties can be added if their conditions are met."
          }
        ],
        "enablingConditions": [
          {
            "paramName": "arb",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      }
    ],
    "help": "Generates an object with fixed and conditional properties based on conditions.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOverwrite fixed properties\u003c/em\u003e***\u003cbr\u003eSource Object: \u003cstrong\u003e{name: 'John', age: 30}\u003c/strong\u003e\u003cbr\u003eSource Properties Handling: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eAdd fixed property (or from variable): \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003effp: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003eAdd conditional property (or from variable): \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eAdd Rule-Based Properties: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{name: 'John', age: 25, type: 'user'}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eConditional properties added\u003c/em\u003e***\u003cbr\u003eSource Object: \u003cstrong\u003e{name: 'Product'}\u003c/strong\u003e\u003cbr\u003eSource Properties Handling: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eAdd fixed property (or from variable): \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eAdd conditional property (or from variable): \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003econ: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003efcp: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003eAdd Rule-Based Properties: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{name: 'Product', category: 'checkout', tracked: true}\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to customize how values are assigned: \u003ccode\u003e(obj, key, value) =\u003e {...}\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eDefault behavior: \u003ccode\u003eobj[key] = value\u003c/code\u003e (shallow assignment).\u003cbr\u003e\u003cbr\u003eUse this for:\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Deep path assignment (e.g., \u003ccode\u003eobj.user.name = value\u003c/code\u003e)\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Validation before setting\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Custom assignment logic"
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
 * Transforms an object by adding fixed values, conditional properties, and rule-based properties.
 * 
 * @param {Object} data.src - Source object to transform.
 * @param {boolean} data.rul - Whether to preserve existing properties (true = don't overwrite, false = allow overwrite).
 * @param {boolean} data.afp - Whether to include fixed properties.
 * @param {Array<{key: string, val: any}>} data.ffp - Fixed properties to add.
 * @param {boolean} data.acp - Whether to include conditional properties.
 * @param {boolean} data.con - Global condition result.
 * @param {Array<{key: string, val: any}>} data.fcp - Conditional properties (added if condition is true).
 * @param {boolean} data.arb - Whether to include rule-based properties.
 * @param {Array<{key: string, val: any, con: boolean}>} data.rbp - Rule-based properties (each added if its condition is true).
 * @param {Function} [data.set] - Optional custom setter (defaults to shallow assignment).
 * @param {Function|string} [data.out] - Optional output handler.
 * 
 * @returns {Object} Transformed object.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const buildSmartObject = function(src, rul, afp, ffp, acp, con, fcp, arb, rbp, set) {
    const sourceObj = getType(src) === 'object' && src || {};
    const overwrite = !rul; 

    const setShallow = (obj, key, value, allowOverwrite) => {
        if (allowOverwrite || !obj.hasOwnProperty(key)) {
            obj[key] = value;
        }
    };
    const setter = typeof set === 'function' ? set : setShallow;

    const assignFromPairs = (targetObj, keyValuePairs, setterFn, allowOverwrite) => {
        keyValuePairs.forEach(pair => {
            setterFn(targetObj, pair.key, pair.val, allowOverwrite);
        });
        return targetObj;
    };

    const fromFixed = afp ? (ffp || []) : [];
    const fromCondition = acp && con ? (fcp || []) : [];
    const fromRules = arb ? (rbp || []).filter(item => item.con) : [];
    const finalPairs = fromFixed.concat(fromCondition, fromRules);

    return assignFromPairs(sourceObj, finalPairs, setter, overwrite);
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

return out(buildSmartObject(data.src, data.rul, data.afp, data.ffp, data.acp, data.con, data.fcp, data.arb, data.rbp, data.set));


___TESTS___

scenarios:
  - name: '[example] Overwrite fixed properties'
    code: |-
      /* @display
      Source Object: {name: 'John', age: 30}
      Source Properties Handling: false
      Add fixed property (or from variable): true
      ffp: [
      Add conditional property (or from variable): false
      Add Rule-Based Properties: false
      @output
      {name: 'John', age: 25, type: 'user'}
      */
      const src = {name: 'John', age: 30};
      const mockData = {
          src: src,
          rul: false,
          afp: true,
          ffp: [
              {key: 'age', val: 25},
              {key: 'type', val: 'user'}
          ],
          acp: false,
          arb: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({name: 'John', age: 25, type: 'user'});
  - name: Fixed properties with keep source - should not overwrite existing properties
    code: |-
      const src = {name: 'John', age: 30};
      const mockData = {
          src: src,
          rul: true,
          afp: true,
          ffp: [
              {key: 'age', val: 25},
              {key: 'type', val: 'user'}
          ],
          acp: false,
          arb: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({name: 'John', age: 30, type: 'user'});
  - name: '[example] Conditional properties added'
    code: |
      /* @display
      Source Object: {name: 'Product'}
      Source Properties Handling: false
      Add fixed property (or from variable): false
      Add conditional property (or from variable): true
      con: true
      fcp: [
      Add Rule-Based Properties: false
      @output
      {name: 'Product', category: 'checkout', tracked: true}
      */
      const src = {name: 'Product'};
      const mockData = {
          src: src,
          rul: false,
          afp: false,
          acp: true,
          con: true,
          fcp: [
              {key: 'category', val: 'checkout'},
              {key: 'tracked', val: true}
          ],
          arb: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({name: 'Product', category: 'checkout', tracked: true});
  - name: Conditional properties with false condition - should not add conditional properties
    code: |-
      const src = {name: 'Product'};
      const mockData = {
          src: src,
          rul: false,
          afp: false,
          acp: true,
          con: false,
          fcp: [
              {key: 'category', val: 'checkout'},
              {key: 'tracked', val: true}
          ],
          arb: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({name: 'Product'});
  - name: Rule-based properties with mixed conditions - should only add where condition is true
    code: |
      const src = {type: 'event'};
      const mockData = {
          src: src,
          rul: false,
          afp: false,
          acp: false,
          arb: true,
          rbp: [
              {key: 'premium', val: 'true', con: true},
              {key: 'discount', val: '10', con: false},
              {key: 'vip', val: 'yes', con: true}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({type: 'event', premium: 'true', vip: 'yes'});
  - name: Combination of all property types with overwrite - should merge all applicable properties
    code: |
      const src = {id: 123, status: 'draft'};
      const mockData = {
          src: src,
          rul: false,
          afp: true,
          ffp: [{key: 'type', val: 'page'}],
          acp: true,
          con: true,
          fcp: [{key: 'status', val: 'published'}],
          arb: true,
          rbp: [
              {key: 'featured', val: true, con: true},
              {key: 'archived', val: false, con: false}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({id: 123, status: 'published', type: 'page', featured: true});
  - name: Empty source object - should only contain added properties
    code: |
      const src = {};
      const mockData = {
          src: src,
          rul: false,
          afp: true,
          ffp: [
              {key: 'name', val: 'Test'},
              {key: 'value', val: 42}
          ],
          acp: false,
          arb: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({name: 'Test', value: 42});
  - name: No properties added - should return source object unchanged
    code: |-
      const src = {original: 'value', count: 5};
      const mockData = {
          src: src,
          rul: false,
          afp: false,
          acp: false,
          arb: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({original: 'value', count: 5});
  - name: Custom setter function - should use custom logic for assignment
    code: |-
      const customSetter = (obj, key, value, allowOverwrite) => {
          if (allowOverwrite || !obj.hasOwnProperty(key)) {
              obj[key] = value.toUpperCase();
          }
      };
      const src = {id: 1};
      const mockData = {
          src: src,
          rul: false,
          afp: true,
          ffp: [
              {key: 'status', val: 'active'},
              {key: 'type', val: 'user'}
          ],
          acp: false,
          arb: false,
          set: customSetter
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({id: 1, status: 'ACTIVE', type: 'USER'});


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
