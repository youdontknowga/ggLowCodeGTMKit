___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "truncate(...)",
  "description": "Truncates a \u003cem\u003estring\u003c/em\u003e if it is longer than the specified maximum length. The last characters of the truncated \u003cem\u003estring\u003c/em\u003e are replaced with the omission \u003cem\u003estring\u003c/em\u003e (default is \u0027...\u0027).",
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
        "name": "max",
        "displayName": "Max Length",
        "simpleValueType": true,
        "help": "💾   The maximum length the string can be before truncation.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "add",
        "checkboxText": "Use Custom Omission",
        "simpleValueType": true,
        "help": "💾   Flag to determine if custom omission should be used instead of default '...'.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eBoolean\u003c/strong\u003e",
        "enablingConditions": []
      },
      {
        "type": "TEXT",
        "name": "chr",
        "displayName": "Custom Omission",
        "simpleValueType": true,
        "help": "💾   The custom omission string to append to the truncated string.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "add",
            "paramValue": true,
            "type": "EQUALS"
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
        "displayName": "🔗 Chained callback parameter: String To Truncate",
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
            "checkboxText": "⚡Use runtime parameter for: Max Length",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Truncates a \u003cem\u003estring\u003c/em\u003e if it is longer than the specified maximum length. The last characters are replaced with the omission string (default \u003cem\u003e...\u003c/em\u003e).\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTruncate with ellipsis\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello world\u003c/strong\u003e\u003cbr\u003eMax Length: \u003cstrong\u003e8\u003c/strong\u003e\u003cbr\u003eUse Custom Omission: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eCustom Omission: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello...\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eShort string unchanged\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003eMax Length: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003eUse Custom Omission: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eCustom Omission: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str.toUpperCase(), str =\u003e str.trim()). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Truncates a string if it is longer than the specified maximum length.
 * The last characters of the truncated string are replaced with the omission string (default is "...").
 *
 * @param {string} data.src - The string to truncate.
 * @param {number} data.max - The maximum length the string can be before truncation.
 * @param {boolean} data.add - Flag to determine if custom omission should be used.
 * @param {string} data.chr - The custom omission string to append to the truncated string.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before truncating.
 * 
 * @returns {string} The truncated string with the omission string appended, or the original string if it is shorter than the maximum length.
 *
 * @framework ggLowCodeGTMKit
 */
const truncate = function(string, maxLength, addCustomOmission, customChars) {
    const omission = addCustomOmission ? customChars : "...";
    if (typeof string !== 'string' || string.length <= maxLength) {
        return string; 
    }
    return string.slice(0, maxLength - omission.length) + omission;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// truncate - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(truncate(value, data.max, data.add, data.chr));
*/
// ===============================================================================
// truncate(...) – Apply Mode
// ===============================================================================
return function(value, maxLength, addCustomOmission, customChars) {
   maxLength = data.rp1 ? data.max : maxLength;
   return out(truncate(value, maxLength, data.add, data.chr));
};


___TESTS___

scenarios:
  - name: '[example] Truncate with ellipsis'
    code: |-
      /* @display
      Value to Process: hello world
      Max Length: 8
      Use Custom Omission: false
      Custom Omission: 
      @output
      hello...
      */
      const src = 'hello world';
      const max = 8;
      const add = false;
      const chr = '';
      const mockData = {
          src: src,
          max: max,
          add: add,
          chr: chr,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, max, add, chr);
      }
      assertThat(variableResult).isEqualTo('hello...');
  - name: String longer than max length with custom omission - should truncate with custom chars
    code: |-
      const src = 'hello world';
      const max = 10;
      const add = true;
      const chr = '>>>';
      const mockData = {
          src: src,
          max: max,
          add: add,
          chr: chr,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, max, add, chr);
      }
      assertThat(variableResult).isEqualTo('hello w>>>');
  - name: '[example] Short string unchanged'
    code: |-
      /* @display
      Value to Process: hello
      Max Length: 10
      Use Custom Omission: false
      Custom Omission: 
      @output
      hello
      */
      const src = 'hello';
      const max = 10;
      const add = false;
      const chr = '';
      const mockData = {
          src: src,
          max: max,
          add: add,
          chr: chr,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, max, add, chr);
      }
      assertThat(variableResult).isEqualTo('hello');
  - name: String equal to max length - should return unchanged
    code: |-
      const src = 'hello';
      const max = 5;
      const add = false;
      const chr = '';
      const mockData = {
          src: src,
          max: max,
          add: add,
          chr: chr,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, max, add, chr);
      }
      assertThat(variableResult).isEqualTo('hello');
  - name: Non-string input - should return unchanged
    code: |-
      const src = 12345;
      const max = 3;
      const add = false;
      const chr = '';
      const mockData = {
          src: src,
          max: max,
          add: add,
          chr: chr,
          rp1: false,
          rp2: false,
          rp3: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, max, add, chr);
      }
      assertThat(variableResult).isEqualTo(12345);
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
