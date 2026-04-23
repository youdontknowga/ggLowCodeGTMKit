___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "isUnixTimestamp()",
  "description": "Check if the input is a valid Unix timestamp.",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSeconds timestamp\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e1609459200\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMilliseconds timestamp\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e1609459200000\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Value To Check"
      }
    ],
    "help": "Check if the input is a valid Unix timestamp.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSeconds timestamp\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e1609459200\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMilliseconds timestamp\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e1609459200000\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
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
 * Checks if the provided input is a valid Unix timestamp.
 * 
 * @param {any} data.src - The input value to check (could be a string or number).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform `src` before checking.
 * 
 * @returns {boolean} True if the input is a valid Unix timestamp (seconds or milliseconds), false otherwise.
 *
 * @framework ggLowCodeGTMKit
 */
const makeInteger = require('makeInteger');
const makeNumber = require('makeNumber');
const isUnixTimestamp = function(value) {
  	if (value === null || value === "") { return false;}
	const valueNum = makeNumber(value);
	const valueInt = makeInteger(value);
	if (typeof valueInt === 'number' && valueNum === valueInt) {
		const isMilliseconds = valueInt >= 1000000000000 && valueInt <= 8640000000000;  // Valid range for milliseconds
		const isSeconds = valueInt >= -2147483648 && valueInt <= 2147483647;  // Valid range for seconds
		return isMilliseconds || isSeconds;
	}
	return false;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// isUnixTimestamp - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(isUnixTimestamp(value));
*/
// ===============================================================================
// isUnixTimestamp() – Apply Mode
// ===============================================================================
return function(value) {
   return out(isUnixTimestamp(value));
};


___TESTS___

scenarios:
  - name: '[example] Seconds timestamp'
    code: |
      /* @display
      Value to Process: 1609459200
      @output
      true
      */
      const src = 1609459200;
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
  - name: '[example] Milliseconds timestamp'
    code: |
      /* @display
      Value to Process: 1609459200000
      @output
      true
      */
      const src = 1609459200000;
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
  - name: String timestamp - should return true
    code: |
      const src = "1609459200";
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
  - name: Decimal timestamp - should return false
    code: |+
      const src = 1609459200.5;
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

  - name: Too large timestamp - should return false
    code: |-
      const src = 9999999999999;
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
  - name: Zero Timestamp - should return true
    code: |
      const src = 0;
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
  - name: Empty String - should return false
    code: |-
      const src = "";
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
