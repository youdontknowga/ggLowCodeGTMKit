___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "substringAfter(...)",
  "description": "Returns the substring after the first occurrence of a delimiter.",
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
        "name": "del",
        "displayName": "Delimiter",
        "simpleValueType": true,
        "help": "✂️   The delimiter to search for.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
                "enablingConditions": [
          {
            "paramName": "rp1",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet email domain\u003c/em\u003e***\u003cbr\u003eInput 1: \u003cstrong\u003ejane.doe@example.com\u003c/strong\u003e\u003cbr\u003eInput 2: \u003cstrong\u003e@\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eexample.com\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDelimiter not found\u003c/em\u003e***\u003cbr\u003eInput 1: \u003cstrong\u003eno-delimiter-here\u003c/strong\u003e\u003cbr\u003eInput 2: \u003cstrong\u003e@\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\u003c/strong\u003e (empty string)"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameters: (String To Process, Delimiter)"
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
            "checkboxText": "⚡Use runtime parameter for: Delimiter",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Returns the substring after the first occurrence of a delimiter. If the delimiter is not found, it returns an empty string.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet email domain\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ejane.doe@example.com\u003c/strong\u003e\u003cbr\u003eDelimiter: \u003cstrong\u003e@\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eexample.com\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eDelimiter not found\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eno-delimiter-here\u003c/strong\u003e\u003cbr\u003eDelimiter: \u003cstrong\u003e@\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\u003c/strong\u003e (empty string)"
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
 * Returns the substring after the first occurrence of a delimiter.
 * 
 * @param {string} data.src - The string to process.
 * @param {string} data.del - The delimiter to search for.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src.
 * 
 * @returns {string|undefined} Returns the substring after the delimiter, an empty string if not found, or undefined if input is invalid.
 *
 * @framework ggLowCodeGTMKit
 */
const substringAfter = function(input, delimiter) {
    if (typeof input !== 'string') return undefined;
    if (typeof delimiter !== 'string') return '';
    
    const index = input.indexOf(delimiter);
    if (index === -1) {
        return '';
    }
    return input.substring(index + delimiter.length);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// substringAfter - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(substringAfter(value, data.del));
*/
// ===============================================================================
// substringAfter(...) – Apply Mode
// ===============================================================================
return function(value, delimiter) {
   delimiter = data.rp1 ? delimiter : data.del;
   return out(substringAfter(value, delimiter));
};


___TESTS___

scenarios:
  - name: '[example] Get email domain'
    code: |-
      /* @display
      Value to Process: jane.doe@example.com
      Delimiter: @
      @output
      example.com
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
      assertThat(variableResult).isEqualTo('example.com');
  - name: '[example] Delimiter not found'
    code: |-
      /* @display
      Value to Process: no-delimiter-here
      Delimiter: @
      @output
      
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
      assertThat(variableResult).isEqualTo('');
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
