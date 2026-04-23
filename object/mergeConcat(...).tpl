___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "mergeConcat(...)",
  "description": "Merges the properties of two objects by concatenating \u003cem\u003earrays\u003c/em\u003e and overwriting \u003cem\u003enon-array\u003c/em\u003e properties.",
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
        "name": "add",
        "displayName": "Additional Object",
        "simpleValueType": true,
        "help": "💾 The additional object to merge in. Properties override base object, except arrays which are concatenated.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject variable\u003c/strong\u003e: \u003cem\u003e{{anotherObject}}\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject literal\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eArrays concatenated on merge\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-array properties override\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ecompleted\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Base Object"
      },
      {
        "type": "GROUP",
        "name": "Advanced Settings",
        "displayName": "Advanced Settings",
        "groupStyle": "ZIPPY_OPEN_ON_PARAM",
        "subParams": [
          {
            "type": "CHECKBOX",
            "name": "rp1",
            "checkboxText": "⚡Use runtime parameter for: Additional Object",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Merges two \u003cem\u003eobjects\u003c/em\u003e, concatenating arrays instead of replacing them.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eArrays concatenated on merge\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{name: 'John', tags: ['user', 'active']}\u003c/strong\u003e\u003cbr\u003eAdditional Object: \u003cstrong\u003e{age: 30, tags: ['premium']}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-array properties override\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e{status: 'pending', priority: 1, count: 5}\u003c/strong\u003e\u003cbr\u003eAdditional Object: \u003cstrong\u003e{status: 'completed', count: 10}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ecompleted\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the merged object before returning it (e.g., \u003ccode\u003eobj =\u003e JSON.stringify(obj)\u003c/code\u003e, \u003ccode\u003eobj =\u003e Object.freeze(obj)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Shallow merges two objects, concatenating arrays instead of replacing them.
 *
 * @param {Object} data.src - The base object to merge from.
 * @param {Object} data.add - The additional object to merge in.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function.
 * 
 * @returns {Object} A new object with merged properties. Arrays are concatenated, nested objects are replaced.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const mergeConcat = function(baseObject, additionalObject) {
    const mergedObject = {};
    
    if (!baseObject || typeof baseObject !== 'object') {
        return additionalObject || {};
    }
    
    if (!additionalObject || typeof additionalObject !== 'object') {
        return baseObject;
    }
    
    for (let key in baseObject) {
        if (baseObject.hasOwnProperty(key)) {
            if (getType(baseObject[key]) === 'array' && getType(additionalObject[key]) === 'array') {
                mergedObject[key] = baseObject[key].concat(additionalObject[key]);
            } else if (additionalObject[key] !== undefined) {
                mergedObject[key] = additionalObject[key];
            } else {
                mergedObject[key] = baseObject[key];
            }
        }
    }
    
    for (let key in additionalObject) {
        if (additionalObject.hasOwnProperty(key) && baseObject[key] === undefined) {
            mergedObject[key] = additionalObject[key];
        }
    }
    
    return mergedObject;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// mergeConcat- Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(mergeConcat(value, data.add));
*/
// ===============================================================================
// mergeConcat(...) – Apply Mode
// ===============================================================================
return function(baseObject, additionalObject) {
   additionalObject = data.rp1 ? data.add : additionalObject;
   return out(mergeConcat(baseObject, additionalObject));
};


___TESTS___

scenarios:
  - name: '[example] Arrays concatenated on merge'
    code: |
      /* @display
      Value to Process: {name: 'John', tags: ['user', 'active']}
      Additional Object: {age: 30, tags: ['premium']}
      @output
      John
      */
      const src = {name: 'John', tags: ['user', 'active']};
      const add = {age: 30, tags: ['premium']};
      const mockData = {
          src: src,
          add: add,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo(30);
      assertThat(variableResult.tags).isEqualTo(['user', 'active', 'premium']);
  - name: '[example] Non-array properties override'
    code: |-
      /* @display
      Value to Process: {status: 'pending', priority: 1, count: 5}
      Additional Object: {status: 'completed', count: 10}
      @output
      completed
      */
      const src = {status: 'pending', priority: 1, count: 5};
      const add = {status: 'completed', count: 10};
      const mockData = {
          src: src,
          add: add,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult.status).isEqualTo('completed');
      assertThat(variableResult.priority).isEqualTo(1);
      assertThat(variableResult.count).isEqualTo(10);
  - name: Test adding new properties
    code: |-
      const src = {id: 1, name: 'Product'};
      const add = {price: 99, category: 'electronics'};
      const mockData = {
          src: src,
          add: add,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult.id).isEqualTo(1);
      assertThat(variableResult.name).isEqualTo('Product');
      assertThat(variableResult.price).isEqualTo(99);
      assertThat(variableResult.category).isEqualTo('electronics');
  - name: Test empty additional object
    code: |
      const src = {name: 'John', age: 30, tags: ['user']};
      const add = {};
      const mockData = {
          src: src,
          add: add,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo(30);
      assertThat(variableResult.tags).isEqualTo(['user']);
  - name: Test array with one empty array
    code: |-
      const src = {items: ['a', 'b']};
      const add = {items: []};
      const mockData = {
          src: src,
          add: add,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult.items).isEqualTo(['a', 'b']);
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
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
