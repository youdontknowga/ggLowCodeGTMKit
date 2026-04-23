___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "hasParameterWithValue",
  "description": "Checks if a specific parameter exists and has a non-empty value in a query or fragment \u003cem\u003estring\u003c/em\u003e.",
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
        "displayName": "Query/Fragment String",
        "simpleValueType": true,
        "help": "💾   A string starting with \"?\" or \"#\" containing parameters.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "prm",
        "displayName": "Parameter Name",
        "simpleValueType": true,
        "help": "🔍   The parameter name to check for existence and non-empty value.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Checks if a URL contains a specific parameter with a non-empty value.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eParameter with value\u003c/em\u003e***\u003cbr\u003eQuery/Fragment String: \u003cstrong\u003e?utm_source=google\u0026utm_medium=cpc\u003c/strong\u003e\u003cbr\u003eParameter Name: \u003cstrong\u003eutm_source\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMissing parameter returns false\u003c/em\u003e***\u003cbr\u003eQuery/Fragment String: \u003cstrong\u003e?param1=value\u0026param2=test\u003c/strong\u003e\u003cbr\u003eParameter Name: \u003cstrong\u003eparam3\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
* Checks if a specific parameter exists and has a non-empty value in a query or fragment string.
* 
* @param {string} data.src - A string starting with "?" or "#" (e.g. "?a=1&b=2").
* @param {string} data.prm - The parameter name to check.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before checking.
* 
* @returns {boolean} True if the parameter exists and has a non-empty value.
*
* @framework ggLowCodeGTMKit
*/
const hasParameterWithValue = function(input, paramName) {
   if (typeof input !== 'string' || typeof paramName !== 'string' || !input || !paramName) {
       return false;
   }
   const raw = input.charAt(0) === '?' || input.charAt(0) === '#' ? input.slice(1) : input;
   if (!raw) return false;
   
   const pattern = '(^|&)' + paramName + '=([^&]+)';
   const match = raw.match(pattern);
   
   return match !== null;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// hasParameterWithValue - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(hasParameterWithValue(value, data.prm));
// ===============================================================================
// hasParameterWithValue(...) – Apply Mode
// ===============================================================================
/*
return function(value, paramName) {
   paramName = data.rp1 ? data.prm : paramName;
   return out(hasParameterWithValue(value, paramName));
};
*/


___TESTS___

scenarios:
  - name: '[example] Parameter with value'
    code: |
      /* @display
      Query/Fragment String: ?utm_source=google&utm_medium=cpc
      Parameter Name: utm_source
      @output
      true
      */
      const src = "?utm_source=google&utm_medium=cpc";
      const prm = "utm_source";
      const mockData = {
          src: src,
          prm: prm,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prm);
      }
      assertThat(variableResult).isTrue();
  - name: Parameter exists but with empty value - returns false
    code: |-
      const src = "?param1=value&param2=";
      const prm = "param2";
      const mockData = {
          src: src,
          prm: prm,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prm);
      }
      assertThat(variableResult).isFalse();
  - name: '[example] Missing parameter returns false'
    code: |
      /* @display
      Query/Fragment String: ?param1=value&param2=test
      Parameter Name: param3
      @output
      false
      */
      const src = "?param1=value&param2=test";
      const prm = "param3";
      const mockData = {
          src: src,
          prm: prm,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prm);
      }
      assertThat(variableResult).isFalse();
  - name: Fragment string with parameter - returns true
    code: |-
      const src = "#param=value&other=test";
      const prm = "param";
      const mockData = {
          src: src,
          prm: prm,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prm);
      }
      assertThat(variableResult).isTrue();
  - name: Empty or invalid input - returns false
    code: |-
      const src = "";
      const prm = "param";
      const mockData = {
          src: src,
          prm: prm,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, prm);
      }
      assertThat(variableResult).isFalse();
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
