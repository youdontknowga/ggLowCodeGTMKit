___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "max(...)",
  "description": "Returns the largest value among the provided arguments.",
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
        "name": "add",
        "displayName": "Additional Numbers (optional)",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Number",
            "name": "arg",
            "type": "TEXT"
          }
        ],
        "help": "💾 Optional additional numbers to include in the comparison alongside the chained input array.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e: \u003cem\u003e42\u003c/em\u003e, \u003cem\u003e3.14\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eVariable reference\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMaximum of positive numbers\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMaximum with negatives\u003c/em\u003e***"
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template."
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Numbers Array"
      }
    ],
    "help": "Returns the maximum (largest) value from an array of \u003cem\u003enumbers\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMaximum of positive numbers\u003c/em\u003e***\u003cbr\u003eAdditional Numbers (optional): \u003cstrong\u003e[]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e25\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMaximum with negatives\u003c/em\u003e***\u003cbr\u003eAdditional Numbers (optional): \u003cstrong\u003e[{arg: -1}]\u003c/strong\u003e\u003cbr\u003eValue to Process: \u003cstrong\u003e[{arg: -5}, {arg: -2}, {arg: -10}, {arg: -1}]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e-1\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the maximum value before returning it (e.g., \u003ccode\u003eval =\u003e val * 2\u003c/code\u003e, \u003ccode\u003eval =\u003e Math.round(val)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Returns the maximum value from an array of numbers.
 * 
 * @param {Array} data.src - Array of objects with 'arg' property (Direct mode) or array of numbers (Apply mode).
 * @param {Array} data.add - Additional numbers to include in the comparison (Apply mode only).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {number} The maximum value found, or NaN if the array is empty or contains no valid numbers.
 *
 * @framework ggLowCodeGTMKit
 */
const max = function(numberArray, additionalNumbers) {
    const additional = additionalNumbers || [];
    const combined = additional.length > 0 
        ? numberArray.concat(additional)
        : numberArray;
    const validNumbers = combined.filter(arg => typeof arg === 'number' && arg === arg);
    
    if (validNumbers.length === 0) return 0/0; // NaN
    
    let result = validNumbers[0];
    for (let i = 1; i < validNumbers.length; i++) {
        if (validNumbers[i] > result) {
            result = validNumbers[i];
        }
    }
    return result;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// max - Direct mode
// ===============================================================================
/*
const extractArgumentValues = (items) => items.map(item => item ? item.arg : null);
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const extractedValues = extractArgumentValues(data.src);
const value = applyCast(data.pre, extractedValues);
return out(max(value));
*/
// ===============================================================================
// max(...) – Apply Mode
// ===============================================================================
return function(numberArray) {
   const extractAdditionalValues = (items) => items ? items.map(item => item ? item.arg : null) : [];
   const additionalNumbers = extractAdditionalValues(data.add);
   return out(max(numberArray, additionalNumbers));
};


___TESTS___

scenarios:
  - name: '[example] Maximum of positive numbers'
    code: |
      /* @display
      Additional Numbers (optional): []
      @output
      25
      */
      const mockData = {
          src: [{arg: 10}, {arg: 25}, {arg: 15}, {arg: 5}],
          add: []
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([10, 25, 15, 5]);
      }
      assertThat(variableResult).isEqualTo(25);
  - name: Test finding maximum with additional numbers (Apply Mode only feature)
    code: |-
      const mockData = {
          src: [{arg: 10}, {arg: 20}, {arg: 15}, {arg: 50}, {arg: 5}],
          add: [{arg: 50}, {arg: 5}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([10, 20, 15]);
      }
      assertThat(variableResult).isEqualTo(50);
  - name: Test with ceiling value
    code: |-
      const mockData = {
          src: [{arg: 8}, {arg: 3}, {arg: 12}, {arg: 20}],
          add: [{arg: 20}]
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([8, 3, 12]);
      }
      assertThat(variableResult).isEqualTo(20);
  - name: '[example] Maximum with negatives'
    code: |-
      /* @display
      Additional Numbers (optional): [{arg: -1}]
      Value to Process: [{arg: -5}, {arg: -2}, {arg: -10}, {arg: -1}]
      @output
      -1
      */
      const add = [{arg: -1}];
      const src = [{arg: -5}, {arg: -2}, {arg: -10}, {arg: -1}];
      const mockData = {
          src: src,
          add: add};
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([-5, -2, -10]);
      }
      assertThat(variableResult).isEqualTo(-1);
  - name: Test with single number
    code: |-
      const mockData = {
          src: [{arg: 42}],
          add: []
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func([42]);
      }
      assertThat(variableResult).isEqualTo(42);
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
