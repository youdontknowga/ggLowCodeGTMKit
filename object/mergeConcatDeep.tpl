___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "mergeConcatDeep",
  "description": "Deep merges two objects recursively with \u003cem\u003earray\u003c/em\u003e concatenation. Nested \u003cem\u003eobjects\u003c/em\u003e are merged, \u003cem\u003earrays\u003c/em\u003e are concatenated, \u003cem\u003eprimitives\u003c/em\u003e are overridden.",
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
        "name": "src",
        "displayName": "Base Object",
        "simpleValueType": true,
        "help": "💾 The base object to merge from. Its properties will be overridden by the additional object.",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "add",
        "displayName": "Additional Object",
        "simpleValueType": true,
        "help": "💾 The object to merge in. Its properties take priority over the base object.",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      }
    ],
    "help": "Deep-merges two \u003cem\u003eobjects\u003c/em\u003e, concatenating arrays at all levels.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDeep arrays concatenated\u003c/em\u003e***\u003cbr\u003eBase Object: \u003cstrong\u003e{name: 'John', tags: ['user', 'active']}\u003c/strong\u003e\u003cbr\u003eAdditional Object: \u003cstrong\u003e{age: 30, tags: ['premium']}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDeep non-array override\u003c/em\u003e***\u003cbr\u003eBase Object: \u003cstrong\u003e{status: 'pending', priority: 1, count: 5}\u003c/strong\u003e\u003cbr\u003eAdditional Object: \u003cstrong\u003e{status: 'completed', count: 10}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ecompleted\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the base object before merging."
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
        "help": "⚙️ Optional function to apply to the merged object before returning it."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Deep merges two objects recursively, concatenating arrays instead of replacing them.
 *
 * @param {Object} data.src - The base object to merge from.
 * @param {Object} data.add - The additional object to merge in.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function.
 * 
 * @returns {Object} A new object with deep merged properties. Arrays are concatenated, nested objects are recursively merged.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const mergeConcatDeep = function(baseObject, additionalObject) {
    const mergedObject = {};
    
    if (!baseObject || typeof baseObject !== 'object') {
        return additionalObject || {};
    }
    
    if (!additionalObject || typeof additionalObject !== 'object') {
        return baseObject;
    }
    
    for (let key in baseObject) {
        if (baseObject.hasOwnProperty(key)) {
            const baseVal = baseObject[key];
            const addVal = additionalObject[key];
            
            if (getType(baseVal) === 'array' && getType(addVal) === 'array') {
                mergedObject[key] = baseVal.concat(addVal);
            } else if (getType(baseVal) === 'object' && getType(addVal) === 'object') {
                mergedObject[key] = mergeConcatDeep(baseVal, addVal);
            } else if (addVal !== undefined) {
                mergedObject[key] = addVal;
            } else {
                mergedObject[key] = baseVal;
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
// mergeConcatDeep - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(mergeConcatDeep(value, data.add));
// ===============================================================================
// mergeConcatDeep(...) – Apply Mode
// ===============================================================================
/*
return function(baseObject, additionalObject) {
   additionalObject = data.rp1 ? data.add : additionalObject;
   return out(mergeConcatDeep(baseObject, additionalObject));
};
*/


___TESTS___

scenarios:
  - name: '[example] Deep arrays concatenated'
    code: |
      /* @display
      Base Object: {name: 'John', tags: ['user', 'active']}
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
  - name: '[example] Deep non-array override'
    code: |-
      /* @display
      Base Object: {status: 'pending', priority: 1, count: 5}
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
  - name: Test nested objects are recursively merged (deep)
    code: |-
      const src = {config: {debug: true, level: 1}};
      const add = {config: {verbose: true}};
      const mockData = {
          src: src,
          add: add
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult.config.verbose).isEqualTo(true);
      assertThat(variableResult.config.debug).isEqualTo(true);
      assertThat(variableResult.config.level).isEqualTo(1);
  - name: Test deeply nested objects merged
    code: |-
      const src = {a: {b: {c: 1, d: 2}}};
      const add = {a: {b: {e: 3}}};
      const mockData = {
          src: src,
          add: add
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult.a.b.c).isEqualTo(1);
      assertThat(variableResult.a.b.d).isEqualTo(2);
      assertThat(variableResult.a.b.e).isEqualTo(3);
  - name: Test nested arrays concatenated
    code: |
      const src = {data: {items: ['a', 'b'], count: 2}};
      const add = {data: {items: ['c'], count: 3}};
      const mockData = {
          src: src,
          add: add
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult.data.items[0]).isEqualTo('a');
      assertThat(variableResult.data.items[2]).isEqualTo('c');
      assertThat(variableResult.data.count).isEqualTo(3);
  - name: Test additional properties added at all levels
    code: |-
      const src = {a: 1, nested: {b: 2}};
      const add = {c: 3, nested: {d: 4}};
      const mockData = {
          src: src,
          add: add
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult.a).isEqualTo(1);
      assertThat(variableResult.c).isEqualTo(3);
      assertThat(variableResult.nested.b).isEqualTo(2);
      assertThat(variableResult.nested.d).isEqualTo(4);
  - name: Test null base returns additional
    code: |-
      const src = null;
      const add = {a: 1};
      const mockData = {
          src: src,
          add: add
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, add);
      }
      assertThat(variableResult.a).isEqualTo(1);
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
