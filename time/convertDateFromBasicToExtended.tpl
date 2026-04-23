___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "convertDateFromBasicToExtended",
  "description": "Convert a basic ISO 8601 date from compact format (yyyymmdd) to extended format (yyyy-mm-dd) \u003cem\u003estring\u003c/em\u003e.",
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
        "displayName": "Compact Date",
        "simpleValueType": true,
        "help": "💾   The compact date string in \"yyyymmdd\" format.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Converts a basic ISO date (YYYYMMDD) to extended format (YYYY-MM-DD).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBasic to extended ISO date\u003c/em\u003e***\u003cbr\u003eCompact Date: \u003cstrong\u003e20241225\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e2024-12-25\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid returns undefined\u003c/em\u003e***\u003cbr\u003eCompact Date: \u003cstrong\u003e2024122\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
* Convert a basic ISO 8601 date (yyyymmdd) to extended format (yyyy-mm-dd).
* 
* @param {string} data.src - The compact date string in "yyyymmdd" format.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {string|undefined} The extended date string in "yyyy-mm-dd" format, or undefined if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const convertDateFromBasicToExtended = function(date) {
   if (typeof date !== 'string' || date.length !== 8) { return undefined; }
   const year = date.slice(0, 4);
   const month = date.slice(4, 6);
   const day = date.slice(6, 8);
   return year + "-" + month + "-" + day;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// convertDateFromBasicToExtended - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(convertDateFromBasicToExtended(value));
// ===============================================================================
// convertDateFromBasicToExtended() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(convertDateFromBasicToExtended(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Basic to extended ISO date'
    code: |-
      /* @display
      Compact Date: 20241225
      @output
      2024-12-25
      */
      const src = "20241225";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("2024-12-25");
  - name: Valid date with January first - converts correctly
    code: |-
      const src = "20250101";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("2025-01-01");
  - name: Valid date end of year - converts correctly
    code: |-
      const src = "19991231";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("1999-12-31");
  - name: '[example] Invalid returns undefined'
    code: |
      /* @display
      Compact Date: 2024122
      @output
      undefined
      */
      const src = "2024122";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isUndefined();
  - name: Non-string input - returns undefined
    code: |-
      const src = 20241225;
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isUndefined();
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'direct';
  // ===================================================================================================
  // Derived flags
  // ===================================================================================================
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 


___NOTES___

Created on 11/05/2025 10:47:02


