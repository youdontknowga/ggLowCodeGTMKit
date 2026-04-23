___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "pluckProperty",
  "description": "Extracts values from an array of \u003cem\u003eobjects\u003c/em\u003e (items) by property name, filtering out \u003cem\u003enull/undefined\u003c/em\u003e values and returning a clean list.",
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
        "displayName": "Items (Array of Objects with shared schema)",
        "simpleValueType": true,
        "help": "💾   Array of objects to extract values from.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "prp",
        "displayName": "Property Name",
        "simpleValueType": true,
        "help": "💾   Property name to extract from each object.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Extracts values from an array of objects by property name, filtering out null/undefined values.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003ePluck property values\u003c/em\u003e***\u003cbr\u003eItems (Array of Objects with shared schema): \u003cstrong\u003e[{name: \"John\", age: 30}, {name: \"Jane\", age: 25}, {name: \"Bob\", age: 35}]\u003c/strong\u003e\u003cbr\u003eProperty Name: \u003cstrong\u003ename\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[\"John\", \"Jane\", \"Bob\"]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty array returns empty\u003c/em\u003e***\u003cbr\u003eItems (Array of Objects with shared schema): \u003cstrong\u003e[]\u003c/strong\u003e\u003cbr\u003eProperty Name: \u003cstrong\u003ename\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert object to string, normalize case). Internal transformations such as case handling will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str + ' €', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Extracts values from an array of objects by property name, filtering out null/undefined values.
 *
 * @param {Array} data.src - Array of objects to extract values from.
 * @param {string} data.prp - Property name to extract from each object.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {Array} Array of extracted values with null/undefined filtered out.
 *
 * @framework ggLowCodeGTMKit
 */
const pluckProperty = function(items, property) {
    const values = items.map(function(item) {
        return item && item[property] !== undefined ? item[property] : null;
    }).filter(value => value != null); // null == undefined returns true
    return values;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// pluckProperty - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(pluckProperty(value, data.prp));
// ===============================================================================
// pluckProperty(...) – Apply Mode
// ===============================================================================
/*
return function(value, property) {
   property = data.rp1 ? data.prp : property;
   return out(pluckProperty(value, property));
};
*/


___TESTS___

scenarios:
  - name: '[example] Pluck property values'
    code: |
      /* @display
      Items (Array of Objects with shared schema): [{name: "John", age: 30}, {name: "Jane", age: 25}, {name: "Bob", age: 35}]
      Property Name: name
      @output
      ["John", "Jane", "Bob"]
      */
      const src = [{name: "John", age: 30}, {name: "Jane", age: 25}, {name: "Bob", age: 35}];
      const prp = "name";
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(["John", "Jane", "Bob"]);
  - name: Array with some objects missing the property - filters out undefined values
    code: |-
      const src = [{id: 1, value: "A"}, {id: 2}, {id: 3, value: "C"}];
      const prp = "value";
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(["A", "C"]);
  - name: Array with null values in property - filters out null values
    code: |-
      const src = [{name: "Alice"}, {name: null}, {name: "Charlie"}];
      const prp = "name";
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo(["Alice", "Charlie"]);
  - name: '[example] Empty array returns empty'
    code: |-
      /* @display
      Items (Array of Objects with shared schema): []
      Property Name: name
      @output
      []
      */
      const src = [];
      const prp = "name";
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo([]);
  - name: Array with nested property access - extracts nested values
    code: |-
      const src = [{user: {id: 1}}, {user: {id: 2}}, {user: {id: 3}}];
      const prp = "user";
      const mockData = {
          src: src,
          prp: prp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prp);
      }
      assertThat(variableResult).isEqualTo([{id: 1}, {id: 2}, {id: 3}]);
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
