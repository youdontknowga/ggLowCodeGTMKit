___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "toObjectPairs",
  "description": "Creates an \u003cem\u003eObject\u003c/em\u003e where each key is paired with its corresponding value, derived from the provided key-value pairs.",
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
        "type": "SIMPLE_TABLE",
        "name": "tbl",
        "displayName": "Map-like structure to create",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Property Key",
            "name": "key",
            "type": "TEXT"
          },
          {
            "defaultValue": "",
            "displayName": "Property Value",
            "name": "val",
            "type": "TEXT"
          }
        ],
        "help": "💾   The array of objects representing the simple table.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray of Objects\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTable to object map\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDuplicate keys last wins\u003c/em\u003e***"
      }
    ],
    "help": "Converts a GTM table of key-value pairs into an \u003cem\u003eobject\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTable to object map\u003c/em\u003e***\u003cbr\u003eMap-like structure to create: \u003cstrong\u003e[{key: 'name', val: 'John'}, {key: 'age', val: 30}, {key: 'city', val: 'Paris'}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{name: 'John', age: 30, city: 'Paris'}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDuplicate keys last wins\u003c/em\u003e***\u003cbr\u003eMap-like structure to create: \u003cstrong\u003e[{key: 'color', val: 'red'}, {key: 'size', val: 'large'}, {key: 'color', val: 'blue'}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{color: 'blue', size: 'large'}\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the table before internal logic (e.g., filter rows, normalize data). Internal transformations will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., obj =\u003e JSON.stringify(obj), obj =\u003e Object.keys(obj).length for count). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Converts a simple table object into a Map based on the specified key and value fields.
 *
 * @param {Array<Object>} data.tbl - The array of objects representing the simple table, where each object has a 'key' and 'value' field.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform tbl before conversion.
 * 
 * @returns {Object|null} Returns an object (Map) where the specified key and value fields become the keys and values in the Map. If no valid key-value pairs are found, it returns null.
 *
 * @framework ggLowCodeGTMKit
 */
const makeTableMap = require('makeTableMap');

const toObjectPairs = function(simpleTable) {
    return makeTableMap(simpleTable, "key", "val");
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// toObjectPairs - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedTable = applyCast(data.pre, data.tbl);
return out(toObjectPairs(processedTable));
// ===============================================================================
// toObjectPairs() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(toObjectPairs(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Table to object map'
    code: |-
      /* @display
      Map-like structure to create: [{key: 'name', val: 'John'}, {key: 'age', val: 30}, {key: 'city', val: 'Paris'}]
      @output
      {name: 'John', age: 30, city: 'Paris'}
      */
      const tbl = [{key: 'name', val: 'John'}, {key: 'age', val: 30}, {key: 'city', val: 'Paris'}];
      const mockData = {
          tbl: tbl
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(tbl);
      }
      assertThat(variableResult).isEqualTo({name: 'John', age: 30, city: 'Paris'});
  - name: Test with single key-value pair
    code: |-
      const tbl = [{key: 'status', val: 'active'}];
      const mockData = {
          tbl: tbl
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(tbl);
      }
      assertThat(variableResult).isEqualTo({status: 'active'});
  - name: '[example] Duplicate keys last wins'
    code: |-
      /* @display
      Map-like structure to create: [{key: 'color', val: 'red'}, {key: 'size', val: 'large'}, {key: 'color', val: 'blue'}]
      @output
      {color: 'blue', size: 'large'}
      */
      const tbl = [{key: 'color', val: 'red'}, {key: 'size', val: 'large'}, {key: 'color', val: 'blue'}];
      const mockData = {
          tbl: tbl
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(tbl);
      }
      assertThat(variableResult).isEqualTo({color: 'blue', size: 'large'});
  - name: Test with empty array returns null
    code: |-
      const tbl = [];
      const mockData = {
          tbl: tbl
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(tbl);
      }
      assertThat(variableResult).isNull();
  - name: Test with mixed value types
    code: |-
      const tbl = [{key: 'count', val: 42}, {key: 'enabled', val: true}, {key: 'data', val: null}];
      const mockData = {
          tbl: tbl
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(tbl);
      }
      assertThat(variableResult).isEqualTo({count: 42, enabled: true, data: null});
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
