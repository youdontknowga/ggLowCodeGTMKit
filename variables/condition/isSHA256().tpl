___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "isSHA256()",
  "description": "Checks if the provided value is \u003cem\u003eSHA-256 hashed\u003c/em\u003e.",
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
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValid SHA-256 hash\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ee3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid hash returns false\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003ee3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b85\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Value To Check"
      }
    ],
    "help": "Checks if the provided value is \u003cem\u003eSHA-256 hashed\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eValid SHA-256 hash\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ee3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eInvalid hash returns false\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003ee3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b85\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
 * Checks if the value matches the SHA256 pattern.
 * 
 * @param {any} data.src - The value to check.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform `src` before checking.
 * 
 * @returns {boolean} True if the value matches the SHA256 pattern, false otherwise.
 *
 * @framework ggLowCodeGTMKit
 */
const isSHA256 = function(value) {
  const pattern = "^[a-f0-9]{64}$";
  return !!(
    typeof value === 'string' &&
    value.toLowerCase().match(pattern) &&
    value.toLowerCase().match(pattern)[0] === value.toLowerCase()
  );
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// isSHA256 - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(isSHA256(value));
*/
// ===============================================================================
// isSHA256() – Apply Mode
// ===============================================================================
return function(value) {
   return out(isSHA256(value));
};


___TESTS___

scenarios:
  - name: '[example] Valid SHA-256 hash'
    code: |-
      /* @display
      Value to Process: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
      @output
      true
      */
      const src = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isTrue();
  - name: Valid SHA256 hash with uppercase - should return true
    code: |-
      const src = "E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855";
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] Invalid hash returns false'
    code: |-
      /* @display
      Value to Process: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b85
      @output
      false
      */
      const src ="e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b85";
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isFalse();
  - name: Invalid too long - should return false
    code: |-
      const src ="e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b8551";
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isFalse();
  - name: Invalid contains invalid characters - should return false
    code: |-
      const src ="g3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isFalse();
  - name: Not a string - should return false
    code: |-
      const src ={};
      const mockData = {
          src: src
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isFalse();
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'apply';
  // ==========================================================a=========================================
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
