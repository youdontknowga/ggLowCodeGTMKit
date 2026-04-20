___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "applyFromObject(...)",
  "description": "Extracts properties from an object and passes them as arguments to an apply-mode function. Useful for computing new values from existing object properties when chaining with itemSetProperty.",
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
        "name": "fn",
        "displayName": "Apply-Mode Function",
        "simpleValueType": true,
        "help": "💾 The apply-mode function to call with the extracted property values.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eMath\u003c/strong\u003e: \u003cem\u003e{{multiply(...)}}\u003c/em\u003e, \u003cem\u003e{{divide(...)}}\u003c/em\u003e, \u003cem\u003e{{subtract(...)}}\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny apply-mode variable\u003c/strong\u003e: \u003cem\u003e{{myVariable(...)}}\u003c/em\u003e",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "pr1",
        "displayName": "First Property",
        "simpleValueType": true,
        "help": "💾 The first property name to extract from the object and pass as the first argument.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eProperty name\u003c/strong\u003e: \u003cem\u003e\"price\"\u003c/em\u003e, \u003cem\u003e\"quantity\"\u003c/em\u003e",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "pr2",
        "displayName": "Second Property (optional)",
        "simpleValueType": true,
        "help": "💾 The second property name to extract from the object and pass as the second argument.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eProperty name\u003c/strong\u003e: \u003cem\u003e\"cost\"\u003c/em\u003e, \u003cem\u003e\"discount\"\u003c/em\u003e"
      },
      {
        "type": "TEXT",
        "name": "pr3",
        "displayName": "Third Property (optional)",
        "simpleValueType": true,
        "help": "💾 The third property name to extract from the object and pass as the third argument.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eProperty name\u003c/strong\u003e: \u003cem\u003e\"minScore\"\u003c/em\u003e, \u003cem\u003e\"maxScore\"\u003c/em\u003e"
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMultiply two properties\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003emultiplyApplyMode: function(a, b) { return a * b\u003cbr\u003emultiplyFn: function() { return multiplyApplyMode\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e30\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNull returns undefined\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Object"
      }
    ],
    "help": "Applies a function using values extracted from an \u003cem\u003eobject\u003c/em\u003e as parameters.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMultiply two properties\u003c/em\u003e***\u003cbr\u003emultiplyApplyMode: \u003cstrong\u003efunction(a, b) { return a * b; }\u003c/strong\u003e\u003cbr\u003emultiplyFn: \u003cstrong\u003efunction() { return multiplyApplyMode; }; // simulates apply mode\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003econst mockData = {\u003c/strong\u003e\u003cbr\u003efn: \u003cstrong\u003emultiplyFn(),  // fn is the returned apply-mode function\u003c/strong\u003e\u003cbr\u003epr1: \u003cstrong\u003e'price',\u003c/strong\u003e\u003cbr\u003epr2: \u003cstrong\u003e'quantity'\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e}\u003c/strong\u003e\u003cbr\u003eApply-Mode Function: \u003cstrong\u003emultiplyFn(),  // fn is the returned apply-mode function\u003c/strong\u003e\u003cbr\u003eFirst Property: \u003cstrong\u003eprice\u003c/strong\u003e\u003cbr\u003eSecond Property (optional): \u003cstrong\u003equantity\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e30\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNull returns undefined\u003c/em\u003e***\u003cbr\u003eApply-Mode Function: \u003cstrong\u003efunction(a, b) { return a * b; }\u003c/strong\u003e\u003cbr\u003eFirst Property: \u003cstrong\u003eprice\u003c/strong\u003e\u003cbr\u003eSecond Property (optional): \u003cstrong\u003equantity\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., \u003ccode\u003ex =\u003e Math.round(x * 100)\u003c/code\u003e to convert margin to percentage)."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Extracts specified properties from an object and passes them as arguments to an apply-mode function.
 * Useful for chaining with itemSetProperty to compute new properties from existing item properties.
 *
 * @param {string} data.pr1 - First property name to extract and pass as first argument.
 * @param {string} [data.pr2] - Second property name to extract and pass as second argument.
 * @param {string} [data.pr3] - Third property name to extract and pass as third argument.
 * @param {Function} data.fn - The apply-mode function to call with extracted property values.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * @returns {Function} A function that receives an object and returns the result of fn(obj[pr1], obj[pr2], obj[pr3]).
 *
 * @framework ggLowCodeGTMKit
 */
const applyFromObject = function(obj, fn, pr1, pr2, pr3) {
    if (obj == null || typeof obj !== 'object') return undefined;
    if (typeof fn !== 'function') return undefined;
    
    const arg1 = pr1 ? obj[pr1] : undefined;
    const arg2 = pr2 ? obj[pr2] : undefined;
    const arg3 = pr3 ? obj[pr3] : undefined;
    
    if (pr3) return fn(arg1, arg2, arg3);
    if (pr2) return fn(arg1, arg2);
    return fn(arg1);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// applyFromObject - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(applyFromObject(value, data.fn, data.pr1, data.pr2, data.pr3));
*/
// ===============================================================================
// applyFromObject(...) – Apply Mode
// ===============================================================================
return function(obj) {
    return out(applyFromObject(obj, data.fn, data.pr1, data.pr2, data.pr3));
};


___TESTS___

scenarios:
  - name: '[example] Multiply two properties'
    code: |-
      /* @display
      multiplyApplyMode: function(a, b) { return a * b; }
      multiplyFn: function() { return multiplyApplyMode; }; // simulates apply mode
      const mockData = {
          fn: multiplyFn(),  // fn is the returned apply-mode function
          pr1: 'price',
          pr2: 'quantity'
      }
      Apply-Mode Function: multiplyFn(),  // fn is the returned apply-mode function
      First Property: price
      Second Property (optional): quantity
      @output
      30
      */
      const multiplyApplyMode = function(a, b) { return a * b; };
      const multiplyFn = function() { return multiplyApplyMode; }; // simulates apply mode
      const mockData = {
          fn: multiplyFn(),  // fn is the returned apply-mode function
          pr1: 'price',
          pr2: 'quantity'
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode({src: {price: 10, quantity: 3}, fn: multiplyFn(), pr1: 'price', pr2: 'quantity'});
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func({price: 10, quantity: 3});
      }
      assertThat(variableResult).isEqualTo(30);
  - name: Two properties subtraction
    code: |-
      const mockData = {
          src: {price: 100, cost: 60},
          fn: function(a, b) { return a - b; },
          pr1: 'price',
          pr2: 'cost'
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func({price: 100, cost: 60});
      }
      assertThat(variableResult).isEqualTo(40);
  - name: '[example] Null returns undefined'
    code: |-
      /* @display
      Apply-Mode Function: function(a, b) { return a * b; }
      First Property: price
      Second Property (optional): quantity
      @output
      undefined
      */
      const fn = function(a, b) { return a * b; };
      const mockData = {
          src: null,
          fn: fn,
          pr1: 'price',
          pr2: 'quantity'
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(null);
      }
      assertThat(variableResult).isUndefined();
  - name: Invalid fn returns undefined
    code: |-
      const mockData = {
          src: {price: 10, quantity: 3},
          fn: 'notAFunction',
          pr1: 'price',
          pr2: 'quantity'
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func({price: 10, quantity: 3});
      }
      assertThat(variableResult).isUndefined();
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
