___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "extractFirstSegment",
  "description": "Returns the first part of a \u003cem\u003estring\u003c/em\u003e split by a given separator. If the input is not a valid  \u003cem\u003estring\u003c/em\u003e or splitting fails, the original  \u003cem\u003estring\u003c/em\u003e is returned.",
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
        "displayName": "String To Split",
        "simpleValueType": true,
        "help": "Returns the first part of a \u003cem\u003estring\u003c/em\u003e split by a given separator. If the input is not a valid \u003cem\u003estring\u003c/em\u003e, the original value is returned.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit by comma\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eString To Split: hello-world-test\u003cbr\u003eSeparator: -\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmail username extraction\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eString To Split: user@example.com\u003cbr\u003eSeparator: @\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003euser\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns original\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eString To Split: 12345\u003cbr\u003eSeparator: -\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12345\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "sep",
        "displayName": "Separator",
        "simpleValueType": true,
        "help": "💾   The separator to use for splitting the string.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Returns the first part of a \u003cem\u003estring\u003c/em\u003e split by a given separator. If the input is not a valid \u003cem\u003estring\u003c/em\u003e, the original value is returned.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSplit by comma\u003c/em\u003e***\u003cbr\u003eString To Split: \u003cstrong\u003ehello-world-test\u003c/strong\u003e\u003cbr\u003eSeparator: \u003cstrong\u003e-\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmail username extraction\u003c/em\u003e***\u003cbr\u003eString To Split: \u003cstrong\u003euser@example.com\u003c/strong\u003e\u003cbr\u003eSeparator: \u003cstrong\u003e@\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003euser\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string input returns original\u003c/em\u003e***\u003cbr\u003eString To Split: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003eSeparator: \u003cstrong\u003e-\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e12345\u003c/strong\u003e"
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
 * Returns the first part of a string split by a given separator.
 * If the input is not a valid string, the original value is returned.
 *
 * @param {string} data.src - The string to split.
 * @param {string} data.sep - The separator to use for splitting the string.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before splitting.
 * 
 * @returns {string} The first segment of the split string, or the original value if input is not a string.
 *
 * @framework ggLowCodeGTMKit
 */
const extractFirstSegment = function(inputString, separator) {
    if (typeof inputString !== 'string') {
        return inputString;
    }
    const parts = inputString.split(separator);
    return parts[0];
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// extractFirstSegment - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(extractFirstSegment(value, data.sep));
// ===============================================================================
// extractFirstSegment(...) – Apply Mode
// ===============================================================================
/*
return function(value, separator) {
   separator = data.rp1 ? data.sep : separator;
   return out(extractFirstSegment(value, separator));
};
*/


___TESTS___

scenarios:
  - name: '[example] Split by comma'
    code: |-
      /* @display
      String To Split: hello-world-test
      Separator: -
      @output
      hello
      */
      const src = 'hello-world-test';
      const sep = '-';
      const mockData = {
          src: src,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sep);
      }
      assertThat(variableResult).isEqualTo('hello');
  - name: String without separator - should return original string
    code: |
      const src = 'helloworld';
      const sep = '-';
      const mockData = {
          src: src,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sep);
      }
      assertThat(variableResult).isEqualTo('helloworld');
  - name: '[example] Email username extraction'
    code: |-
      /* @display
      String To Split: user@example.com
      Separator: @
      @output
      user
      */
      const src = 'user@example.com';
      const sep = '@';
      const mockData = {
          src: src,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sep);
      }
      assertThat(variableResult).isEqualTo('user');
  - name: String starting with separator - should return empty string
    code: |
      const src = '/path/to/file';
      const sep = '/';
      const mockData = {
          src: src,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sep);
      }
      assertThat(variableResult).isEqualTo('');
  - name: '[example] Non-string input returns original'
    code: |-
      /* @display
      String To Split: 12345
      Separator: -
      @output
      12345
      */
      const src = 12345;
      const sep = '-';
      const mockData = {
          src: src,
          sep: sep,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, sep);
      }
      assertThat(variableResult).isEqualTo(12345);
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
