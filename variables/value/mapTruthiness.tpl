___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "mapTruthiness",
  "description": "Maps truthy values to one output and falsy values to another output. Returns the truthy value if predicate evaluates to \u003cem\u003etrue\u003c/em\u003e, otherwise returns the falsy value.",
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
        "displayName": "Predicate Value",
        "simpleValueType": true,
        "help": "💾   The predicate value to evaluate for truthiness.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "tru",
        "displayName": "Truthy Value",
        "simpleValueType": true,
        "help": "💾   The value to return when predicate is truthy.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "fal",
        "displayName": "Falsy Value",
        "simpleValueType": true,
        "help": "💾   The value to return when predicate is falsy.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny\u003c/strong\u003e"
      }
    ],
    "help": "Maps truthy values to one output and falsy values to another output.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTruthy maps to truthy value\u003c/em\u003e***\u003cbr\u003ePredicate Value: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003eTruthy Value: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003eFalsy Value: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFalsy maps to falsy value\u003c/em\u003e***\u003cbr\u003ePredicate Value: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003eTruthy Value: \u003cstrong\u003esuccess\u003c/strong\u003e\u003cbr\u003eFalsy Value: \u003cstrong\u003efailure\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efailure\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the predicate before internal logic (e.g., convert object to string, normalize case). Internal transformations such as case handling will still apply afterward."
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
* Maps truthy values to one output and falsy values to another output.
* 
* @param {any} data.src - The input value to evaluate for truthiness.
* @param {any} data.tru - The value to return when the input is truthy.
* @param {any} data.fal - The value to return when the input is falsy.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before evaluation.
* 
* @returns {any} The truthy value if input is truthy, otherwise the falsy value.
*
* @framework ggLowCodeGTMKit
*/
const mapTruthiness = function(predicate, truthyValue, falsyValue) {
   return predicate ? truthyValue : falsyValue;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// mapTruthiness - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const predicate = applyCast(data.pre, data.src);
return out(mapTruthiness(predicate, data.tru, data.fal));
// ===============================================================================
// mapTruthiness(...) – Apply Mode
// ===============================================================================
/*
return function(value, truthyValue, falsyValue) {
   truthyValue = data.rp1 ? data.tru : truthyValue;
   falsyValue = data.rp2 ? data.fal : falsyValue;
   return out(mapTruthiness(value, truthyValue, falsyValue));
};
*/


___TESTS___

scenarios:
  - name: Truthy value (true) - should return truthy value
    code: |-
      const src = true;
      const tru = 'yes';
      const fal = 'no';
      const mockData = {
          src: src,
          tru: tru,
          fal: fal,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tru, fal);
      }
      assertThat(variableResult).isEqualTo('yes');
  - name: Falsy value (false) - should return falsy value
    code: |-
      const src = false;
      const tru = 'yes';
      const fal = 'no';
      const mockData = {
          src: src,
          tru: tru,
          fal: fal,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tru, fal);
      }
      assertThat(variableResult).isEqualTo('no');
  - name: '[example] Truthy maps to truthy value'
    code: |-
      /* @display
      Predicate Value: hello
      Truthy Value: 1
      Falsy Value: 0
      @output
      1
      */
      const src = 'hello';
      const tru = 1;
      const fal = 0;
      const mockData = {
          src: src,
          tru: tru,
          fal: fal,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tru, fal);
      }
      assertThat(variableResult).isEqualTo(1);
  - name: '[example] Falsy maps to falsy value'
    code: |
      /* @display
      Predicate Value: 
      Truthy Value: success
      Falsy Value: failure
      @output
      failure
      */
      const src = '';
      const tru = 'success';
      const fal = 'failure';
      const mockData = {
          src: src,
          tru: tru,
          fal: fal,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tru, fal);
      }
      assertThat(variableResult).isEqualTo('failure');
  - name: Falsy value (0) - should return falsy value
    code: |-
      const src = 0;
      const tru = 'positive';
      const fal = 'zero or negative';
      const mockData = {
          src: src,
          tru: tru,
          fal: fal,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tru, fal);
      }
      assertThat(variableResult).isEqualTo('zero or negative');
  - name: Truthy value (positive number) - should return truthy value
    code: |-
      const src = 42;
      const tru = 'has value';
      const fal = 'no value';
      const mockData = {
          src: src,
          tru: tru,
          fal: fal,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tru, fal);
      }
      assertThat(variableResult).isEqualTo('has value');
  - name: Truthy value (empty object) - should return truthy value
    code: |-
      const src = {};
      const tru = 'truthy';
      const fal = 'falsy';
      const mockData = {
          src: src,
          tru: tru,
          fal: fal,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tru, fal);
      }
      assertThat(variableResult).isEqualTo('truthy');
  - name: Truthy value (empty array) - should return truthy value
    code: |-
      const src = [];
      const tru = 'truthy';
      const fal = 'falsy';
      const mockData = {
          src: src,
          tru: tru,
          fal: fal,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tru, fal);
      }
      assertThat(variableResult).isEqualTo('truthy');
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
