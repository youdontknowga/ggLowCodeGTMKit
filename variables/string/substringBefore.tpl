___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "substringBefore",
  "description": "Returns the substring before the first occurrence of a delimiter.",
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
        "displayName": "String To Process",
        "simpleValueType": true,
        "help": "💾   The string to process.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "del",
        "displayName": "Delimiter",
        "simpleValueType": true,
        "help": "✂️   The delimiter to search for.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Returns the substring before the first occurrence of a delimiter. If the delimiter is not found, it returns the original string.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet email username\u003c/em\u003e***\u003cbr\u003eString To Process: \u003cstrong\u003ejane.doe@example.com\u003c/strong\u003e\u003cbr\u003eDelimiter: \u003cstrong\u003e@\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ejane.doe\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDelimiter not found\u003c/em\u003e***\u003cbr\u003eString To Process: \u003cstrong\u003eno-delimiter-here\u003c/strong\u003e\u003cbr\u003eDelimiter: \u003cstrong\u003e@\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eno-delimiter-here\u003c/strong\u003e"
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
 * Returns the substring before the first occurrence of a delimiter.
 * 
 * @param {string} data.src - The string to process.
 * @param {string} data.del - The delimiter to search for.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src.
 * 
 * @returns {string|undefined} Returns the substring before the delimiter, the original string if not found, or undefined if input is invalid.
 *
 * @framework ggLowCodeGTMKit
 */
const substringBefore = function(input, delimiter) {
    if (typeof input !== 'string') return undefined;
    if (typeof delimiter !== 'string') return input;
    
    const index = input.indexOf(delimiter);
    if (index === -1) {
        return input;
    }
    return input.substring(0, index);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// substringBefore - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(substringBefore(value, data.del));
// ===============================================================================
// substringBefore(...) – Apply Mode
// ===============================================================================
/*
return function(value, delimiter) {
   delimiter = data.rp1 ? delimiter : data.del;
   return out(substringBefore(value, delimiter));
};
*/


___TESTS___

scenarios:
  - name: '[example] Get email username'
    code: |-
      /* @display
      String To Process: jane.doe@example.com
      Delimiter: @
      @output
      jane.doe
      */
      const src = 'jane.doe@example.com';
      const del = '@';
      const mockData = {
          src: src,
          del: del,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, del);
      }
      assertThat(variableResult).isEqualTo('jane.doe');
  - name: '[example] Delimiter not found'
    code: |-
      /* @display
      String To Process: no-delimiter-here
      Delimiter: @
      @output
      no-delimiter-here
      */
      const src = 'no-delimiter-here';
      const del = '@';
      const mockData = {
          src: src,
          del: del,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, del);
      }
      assertThat(variableResult).isEqualTo('no-delimiter-here');
  - name: Empty string returns empty string
    code: |-
      const src = '';
      const del = '@';
      const mockData = {
          src: src,
          del: del,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, del);
      }
      assertThat(variableResult).isEqualTo('');
  - name: Non-string returns undefined
    code: |-
      const src = 12345;
      const del = '@';
      const mockData = {
          src: src,
          del: del,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, del);
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
