___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "reverse()",
  "description": "Returns a new \u003cem\u003earray\u003c/em\u003e with the elements in reverse order without modifying the original \u003cem\u003earray\u003c/em\u003e .",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReverse array\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[5, 4, 3, 2, 1]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-array returns empty\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: not an array\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Array To Reverse"
      }
    ],
    "help": "Returns a new \u003cem\u003earray\u003c/em\u003e with the elements in reverse order without modifying the original.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReverse array\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[5, 4, 3, 2, 1]\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-array returns empty\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003enot an array\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., arr =\u003e arr.join(','), arr =\u003e arr.length for counting). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Returns a new array with the elements in reverse order.
* 
* @param {Array} data.src - The array to reverse.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before reversing.
* 
* @returns {Array} A new array with reversed elements, or an empty array if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const getType = require('getType');

const reverse = function(arr) {
   if (getType(arr) !== 'array') {
       return [];
   }
   return arr.slice().reverse();
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// reverse - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(reverse(value));
*/
// ===============================================================================
// reverse() – Apply Mode
// ===============================================================================
return function(value) {
  return out(reverse(value));
};


___TESTS___

scenarios:
  - name: '[example] Reverse array'
    code: |-
      /* @display
      Value to Process: [1, 2, 3, 4, 5]
      @output
      [5, 4, 3, 2, 1]
      */
      const src = [1, 2, 3, 4, 5];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([5, 4, 3, 2, 1]);
  - name: Array with strings - should reverse order
    code: |+
      const src = ['apple', 'banana', 'cherry'];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(['cherry', 'banana', 'apple']);

  - name: Array with single element - should return same element
    code: |
      const src = [42];
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([42]);
  - name: Empty array - should return empty array
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
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([]);
  - name: '[example] Non-array returns empty'
    code: |-
      /* @display
      Value to Process: not an array
      @output
      []
      */
      const src = 'not an array';
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo([]);
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
