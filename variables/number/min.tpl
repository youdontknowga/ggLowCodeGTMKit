___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "min",
  "description": "Returns the minimum value among the provided arguments.",
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
        "name": "src",
        "displayName": "Numbers to Compare",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Number",
            "name": "arg",
            "type": "TEXT"
          }
        ],
        "help": "💾 A list of numbers to find the minimum value from. Non-numeric values will be ignored.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e: \u003cem\u003e42\u003c/em\u003e, \u003cem\u003e3.14\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eVariable reference\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMinimum of positive numbers\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMinimum with mixed signs\u003c/em\u003e***"
      }
    ],
    "help": "Returns the minimum (smallest) value from an array of \u003cem\u003enumbers\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMinimum of positive numbers\u003c/em\u003e***\u003cbr\u003eNumbers to Compare: \u003cstrong\u003e[{arg: 10}, {arg: 25}, {arg: 15}, {arg: 5}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e5\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMinimum with mixed signs\u003c/em\u003e***\u003cbr\u003eNumbers to Compare: \u003cstrong\u003e[{arg: -10}, {arg: 0}, {arg: 15}, {arg: -3}, {arg: 8}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e-10\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the extracted numbers array before finding the minimum (e.g., filter values, transform array). Note: Values are extracted from the table's \u003ccode\u003earg\u003c/code\u003e property before this function is applied."
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
        "help": "⚙️ Optional function to apply to the minimum value before returning it (e.g., \u003ccode\u003eval =\u003e val * 2\u003c/code\u003e, \u003ccode\u003eval =\u003e Math.abs(val)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Returns the minimum value from an array of numbers.
 * 
 * @param {Array} data.src - Array of objects with 'arg' property (Direct mode) or array of numbers (Apply mode).
 * @param {Array} data.add - Additional numbers to include in the comparison (Apply mode only).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {number} The minimum value found, or NaN if the array is empty or contains no valid numbers.
 *
 * @framework ggLowCodeGTMKit
 */
const min = function(numberArray, additionalNumbers) {
    const additional = additionalNumbers || [];
    const combined = additional.length > 0 
        ? numberArray.concat(additional)
        : numberArray;
    const validNumbers = combined.filter(arg => typeof arg === 'number' && arg === arg);
    
    if (validNumbers.length === 0) return 0/0; // NaN
    
    let result = validNumbers[0];
    for (let i = 1; i < validNumbers.length; i++) {
        if (validNumbers[i] < result) {
            result = validNumbers[i];
        }
    }
    return result;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// min - Direct mode
// ===============================================================================
const extractArgumentValues = (items) => items.map(item => item ? item.arg : null);
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const extractedValues = extractArgumentValues(data.src);
const value = applyCast(data.pre, extractedValues);
return out(min(value));
// ===============================================================================
// min(...) – Apply Mode
// ===============================================================================
/*
return function(numberArray) {
   const extractAdditionalValues = (items) => items ? items.map(item => item ? item.arg : null) : [];
   const additionalNumbers = extractAdditionalValues(data.add);
   return out(min(numberArray, additionalNumbers));
};
*/


___TESTS___

scenarios:
  - name: '[example] Minimum of positive numbers'
    code: |
      /* @display
      Numbers to Compare: [{arg: 10}, {arg: 25}, {arg: 15}, {arg: 5}]
      @output
      5
      */
      const src = [{arg: 10}, {arg: 25}, {arg: 15}, {arg: 5}];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([10, 25, 15, 5]);
      }
      assertThat(variableResult).isEqualTo(5);
  - name: Test finding minimum from negative numbers
    code: |-
      const src = [{arg: -5}, {arg: -2}, {arg: -10}, {arg: -7}];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([-5, -2, -10, -7]);
      }
      assertThat(variableResult).isEqualTo(-10);
  - name: '[example] Minimum with mixed signs'
    code: |
      /* @display
      Numbers to Compare: [{arg: -10}, {arg: 0}, {arg: 15}, {arg: -3}, {arg: 8}]
      @output
      -10
      */
      const src = [{arg: -10}, {arg: 0}, {arg: 15}, {arg: -3}, {arg: 8}];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([-10, 0, 15, -3, 8]);
      }
      assertThat(variableResult).isEqualTo(-10);
  - name: Test with empty array returns NaN
    code: |-
      const src = [];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([]);
      }
      assertThat(variableResult).isNaN();
  - name: Test with single number
    code: |-
      const src = [{arg: 42}];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([42]);
      }
      assertThat(variableResult).isEqualTo(42);
  - name: Test finding minimum with additional numbers included
    code: |-
      const mockData = {
          src: [{arg: 50}, {arg: 75}, {arg: 60}, {arg: 5}, {arg: 100}],
          add: [{arg: 5}, {arg: 100}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([50, 75, 60]);
      }
      assertThat(variableResult).isEqualTo(5);
  - name: Test with floor value from additional numbers
    code: |-
      const mockData = {
          src: [{arg: 8}, {arg: 3}, {arg: 12}, {arg: 0}],
          add: [{arg: 0}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([8, 3, 12]);
      }
      assertThat(variableResult).isEqualTo(0);
  - name: Test with empty chained array but additional numbers provided
    code: |-
      const mockData = {
          src: [{arg: 10}, {arg: 20}],
          add: [{arg: 10}, {arg: 20}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([]);
      }
      assertThat(variableResult).isEqualTo(10);
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
