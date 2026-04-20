___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "reduceRight(...)",
  "description": "Reduces an \u003cem\u003earray\u003c/em\u003e from right to left using a callback \u003cem\u003efunction\u003c/em\u003e  and an optional initial value.",
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
        "name": "fnc",
        "displayName": "Reducer Function",
        "simpleValueType": true,
        "help": "💾   A reducer function of the form (accumulator, currentValue) =\u003e nextAccumulator.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eFunction\u003c/strong\u003e",
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
        "name": "ini",
        "displayName": "Initial Value",
        "simpleValueType": true,
        "help": "💾   An optional initial value for the accumulator.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp2",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "SELECT",
        "name": "use",
        "displayName": "Use Initial Value",
        "selectItems": [
          {
            "value": true,
            "displayValue": "Yes"
          },
          {
            "value": false,
            "displayValue": "No"
          }
        ],
        "simpleValueType": true,
        "defaultValue": false,
        "help": "💾   Whether to use the initial value.\u003cbr\u003e\u003cbr\u003e  Options:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eYes/No\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp3",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template."
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Array To Reduce",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template."
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
            "checkboxText": "⚡Use runtime parameter for: Reducer Function",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Reduces an \u003cem\u003earray\u003c/em\u003e from right to left using a callback function and an optional initial value.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eReverse concatenation\u003c/em\u003e***\u003cbr\u003earr: \u003cstrong\u003e['a', 'b', 'c', 'd']\u003c/strong\u003e\u003cbr\u003efnc: \u003cstrong\u003efunction(acc, val) { return acc + val; }\u003c/strong\u003e\u003cbr\u003eini: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003euse: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003edcba\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSum from right\u003c/em\u003e***\u003cbr\u003earr: \u003cstrong\u003e[1, 2, 3, 4, 5]\u003c/strong\u003e\u003cbr\u003efnc: \u003cstrong\u003efunction(acc, val) { return acc + val; }\u003c/strong\u003e\u003cbr\u003eini: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003euse: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e15\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., val =\u003e Math.round(val), val =\u003e val.toString() for string conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Reduces an array from right to left using a callback function and an optional initial value.
 *
 * @param {Array} data.arr - The array to reduce.
 * @param {Function} data.fnc - A reducer function of the form (accumulator, currentValue) => nextAccumulator.
 * @param {*} data.ini - An optional initial value for the accumulator.
 * @param {boolean} data.use - Whether to use the initial value.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform arr before reducing.
 * 
 * @returns {*|undefined} The final accumulated result from the right-to-left reduce operation. Returns undefined if the input is not a valid array or the callback is not a function.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');
const reduceRight = function(array, callback, initialValue, useInitial) {
    if (getType(array) !== 'array' || typeof callback !== 'function') {
        return undefined;
    }
    return useInitial ? array.reduceRight(callback, initialValue) : array.reduceRight(callback);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// reduceRight - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const processedArray = applyCast(data.pre, data.arr);
return out(reduceRight(processedArray, data.fnc, data.ini, data.use));
*/
// ===============================================================================
// reduceRight(...) – Apply Mode
// ===============================================================================
return function(array, callback, initialValue, useInitial) {
   callback = data.rp1 ? data.fnc : callback;
   return out(reduceRight(array, callback, data.ini, data.use));
};


___TESTS___

scenarios:
  - name: '[example] Reverse concatenation'
    code: |-
      /* @display
      arr: ['a', 'b', 'c', 'd']
      fnc: function(acc, val) { return acc + val; }
      ini: 
      use: true
      @output
      dcba
      */
      const arr = ['a', 'b', 'c', 'd'];
      const fnc = function(acc, val) { return acc + val; };
      const ini = '';
      const use = true;
      const mockData = {
          arr: arr,
          fnc: fnc,
          ini: ini,
          use: use,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, fnc, ini, use);
      }
      assertThat(variableResult).isEqualTo('dcba');
  - name: Subtract numbers from right to left with initial value
    code: |-
      const arr = [1, 2, 3, 4];
      const fnc = function(acc, val) { return acc - val; };
      const ini = 0;
      const use = true;
      const mockData = {
          arr: arr,
          fnc: fnc,
          ini: ini,
          use: use,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, fnc, ini, use);
      }
      assertThat(variableResult).isEqualTo(-10);
  - name: Build array from right to left with initial value
    code: |-
      const arr = [1, 2, 3, 4];
      const fnc = function(acc, val) { acc.push(val); return acc; };
      const ini = [];
      const use = true;
      const mockData = {
          arr: arr,
          fnc: fnc,
          ini: ini,
          use: use,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, fnc, ini, use);
      }
      assertThat(variableResult).isEqualTo([4, 3, 2, 1]);
  - name: Flatten nested arrays from right to left with initial value
    code: |-
      const arr = [[1, 2], [3, 4], [5]];
      const fnc = function(acc, val) { return acc.concat(val); };
      const ini = [];
      const use = true;
      const mockData = {
          arr: arr,
          fnc: fnc,
          ini: ini,
          use: use,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, fnc, ini, use);
      }
      assertThat(variableResult).isEqualTo([5, 3, 4, 1, 2]);
  - name: '[example] Sum from right'
    code: |-
      /* @display
      arr: [1, 2, 3, 4, 5]
      fnc: function(acc, val) { return acc + val; }
      ini: undefined
      use: false
      @output
      15
      */
      const arr = [1, 2, 3, 4, 5];
      const fnc = function(acc, val) { return acc + val; };
      const ini = undefined;
      const use = false;
      const mockData = {
          arr: arr,
          fnc: fnc,
          ini: ini,
          use: use,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, fnc, ini, use);
      }
      assertThat(variableResult).isEqualTo(15);
  - name: Single element array with initial value - should return combined result
    code: |-
      const arr = [10];
      const fnc = function(acc, val) { return acc + val; };
      const ini = 5;
      const use = true;
      const mockData = {
          arr: arr,
          fnc: fnc,
          ini: ini,
          use: use,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, fnc, ini, use);
      }
      assertThat(variableResult).isEqualTo(15);
  - name: Single element array without initial value - should return the element
    code: |-
      const arr = [42];
      const fnc = function(acc, val) { return acc + val; };
      const ini = undefined;
      const use = false;
      const mockData = {
          arr: arr,
          fnc: fnc,
          ini: ini,
          use: use,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, fnc, ini, use);
      }
      assertThat(variableResult).isEqualTo(42);
  - name: Empty array with initial value - should return initial value
    code: |-
      const arr = [];
      const fnc = function(acc, val) { return acc + val; };
      const ini = 10;
      const use = true;
      const mockData = {
          arr: arr,
          fnc: fnc,
          ini: ini,
          use: use,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, fnc, ini, use);
      }
      assertThat(variableResult).isEqualTo(10);
  - name: Non-function callback - should return undefined
    code: |-
      const arr = [1, 2, 3];
      const fnc = 'not a function';
      const ini = 0;
      const use = true;
      const mockData = {
          arr: arr,
          fnc: fnc,
          ini: ini,
          use: use,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, fnc, ini, use);
      }
      assertThat(variableResult).isUndefined();
  - name: Compose functions from right to left
    code: |-
      const arr = [
          function(x) { return x + 1; },
          function(x) { return x * 2; },
          function(x) { return x - 3; }
      ];
      const fnc = function(acc, fn) { return function(x) { return acc(fn(x)); }; };
      const ini = function(x) { return x; };
      const use = true;
      const mockData = {
          arr: arr,
          fnc: fnc,
          ini: ini,
          use: use,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, fnc, ini, use);
      }
      const composedFunction = variableResult;
      assertThat(composedFunction(5)).isEqualTo(9);
  - name: Build nested structure from right to left with initial value
    code: |
      const arr = ['a', 'b', 'c'];
      const fnc = function(acc, val) { return {value: val, next: acc}; };
      const ini = null;
      const use = true;
      const mockData = {
          arr: arr,
          fnc: fnc,
          ini: ini,
          use: use,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(arr, fnc, ini, use);
      }
      assertThat(variableResult).isEqualTo({value: 'a', next: {value: 'b', next: {value: 'c', next: null}}});
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
