___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "extendedDateToBasic",
  "description": "Convert an extended ISO 8601 date from extended format (yyyy-mm-dd) to basic format (yyyymmdd) \u003cem\u003estring\u003c/em\u003e.",
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
        "displayName": "Extended Date",
        "simpleValueType": true,
        "help": "💾   The extended date string in \"yyyy-mm-dd\" format.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Converts an extended ISO date (YYYY-MM-DD) to basic format (YYYYMMDD).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtended to basic ISO date\u003c/em\u003e***\u003cbr\u003eExtended Date: \u003cstrong\u003e2024-12-25\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e20241225\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid returns undefined\u003c/em\u003e***\u003cbr\u003eExtended Date: \u003cstrong\u003e2024-12-2\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
* Convert an extended ISO 8601 date string (yyyy-mm-dd) to basic ISO format (yyyymmdd).
* 
* @param {string} data.src - The extended date string in "yyyy-mm-dd" format.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before conversion.
* 
* @returns {string|undefined} The date in "yyyymmdd" format, or undefined if the input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const extendedDateToBasic = function(date) {
   if (typeof date !== 'string' || date.length !== 10) { return undefined; }
   return date.split('-').join('');
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// extendedDateToBasic - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(extendedDateToBasic(value));

// ===============================================================================
// extendedDateToBasic() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(extendedDateToBasic(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Extended to basic ISO date'
    code: |-
      /* @display
      Extended Date: 2024-12-25
      @output
      20241225
      */
      const src = "2024-12-25";
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
      assertThat(variableResult).isEqualTo("20241225");
  - name: Valid date with January first - converts correctly
    code: |
      const src = "2025-01-01";
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
      assertThat(variableResult).isEqualTo("20250101");
  - name: Valid date end of year - converts correctly
    code: |-
      const src = "1999-12-31";
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
      assertThat(variableResult).isEqualTo("19991231");
  - name: '[example] Invalid returns undefined'
    code: |-
      /* @display
      Extended Date: 2024-12-2
      @output
      undefined
      */
      const src = "2024-12-2";
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

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
