___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "hasKeyEqualTo(...)",
  "description": "Checks if an \u003cem\u003eobject\u003c/em\u003e has a top-level own property with the given key and that its value strictly equals the expected value.",
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
        "displayName": "Property Key",
        "simpleValueType": true,
        "help": "💾   The property name to verify.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "val",
        "displayName": "Expected Value",
        "simpleValueType": true,
        "help": "💾   The value to compare against.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp2",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eKey value matches\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eProperty Key: name\u003cbr\u003eExpected Value: John\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eKey value mismatch\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eProperty Key: age\u003cbr\u003eExpected Value: 25\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Object To Check: chained callback parameter"
      }
    ],
    "help": "Checks if an \u003cem\u003eobject\u003c/em\u003e has a key with a specific value (strict equality).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eKey value matches\u003c/em\u003e***\u003cbr\u003eobj: \u003cstrong\u003e{name: \"John\", age: 30, city: \"Paris\"}\u003c/strong\u003e\u003cbr\u003eProperty Key: \u003cstrong\u003ename\u003c/strong\u003e\u003cbr\u003eExpected Value: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eKey value mismatch\u003c/em\u003e***\u003cbr\u003eobj: \u003cstrong\u003e{name: \"John\", age: 30}\u003c/strong\u003e\u003cbr\u003eProperty Key: \u003cstrong\u003eage\u003c/strong\u003e\u003cbr\u003eExpected Value: \u003cstrong\u003e25\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., val =\u003e val ? 'Found' : 'Not found', val =\u003e !val for negation). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Checks if an object has a top-level own property with the given key and that its value strictly equals the expected value.
 *
 * @param {Object} data.obj - The object to check.
 * @param {string} data.key - The property name to verify.
 * @param {*} data.val - The value to compare against.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform obj before checking.
 * 
 * @returns {boolean} True if the key exists and its value matches the expected value, false otherwise.
 *
 * @framework ggLowCodeGTMKit
 */
const hasKeyEqualTo = function(obj, key, expectedValue) {
    return obj != null &&
           typeof obj === 'object' &&
           typeof key === 'string' &&
           obj.hasOwnProperty(key) &&
           obj[key] === expectedValue;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// hasKeyEqualTo - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedObj = applyCast(data.pre, data.obj);
return out(hasKeyEqualTo(processedObj, data.key, data.val));
*/
// ===============================================================================
// hasKeyEqualTo(...) – Apply Mode
// ===============================================================================
return function(value, key, expectedValue) {
   return out(hasKeyEqualTo(value, data.key, data.val));
};


___TESTS___

scenarios:
  - name: '[example] Key value matches'
    code: |-
      /* @display
      obj: {name: "John", age: 30, city: "Paris"}
      Property Key: name
      Expected Value: John
      @output
      true
      */
      const obj = {name: "John", age: 30, city: "Paris"};
      const key = "name";
      const val = "John";
      const mockData = {
          obj: obj,
          key: key,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key, val);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] Key value mismatch'
    code: |-
      /* @display
      obj: {name: "John", age: 30}
      Property Key: age
      Expected Value: 25
      @output
      false
      */
      const obj = {name: "John", age: 30};
      const key = "age";
      const val = 25;
      const mockData = {
          obj: obj,
          key: key,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key, val);
      }
      assertThat(variableResult).isFalse();
  - name: Object doesn't have the key - returns false
    code: |-
      const obj = {name: "John", age: 30};
      const key = "email";
      const val = "john@example.com";
      const mockData = {
          obj: obj,
          key: key,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key, val);
      }
      assertThat(variableResult).isFalse();
  - name: Strict equality check - number vs string returns false
    code: |-
      const obj = {id: 123};
      const key = "id";
      const val = "123";
      const mockData = {
          obj: obj,
          key: key,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key, val);
      }
      assertThat(variableResult).isFalse();
  - name: Non-object input - returns false
    code: |-
      const obj = "not an object";
      const key = "name";
      const val = "test";
      const mockData = {
          obj: obj,
          key: key,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(obj, key, val);
      }
      assertThat(variableResult).isFalse();
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
