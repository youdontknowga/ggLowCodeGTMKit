___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "not",
  "description": "Negates/inverts a boolean value or converts truthy/falsy values. Returns false for truthy values and true for falsy values. Commonly used as an output handler to invert the result of other functions.",
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
        "displayName": "Value to Negate",
        "simpleValueType": true,
        "help": "💾 The boolean or truthy/falsy value to negate.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eBoolean\u003c/strong\u003e: \u003cem\u003etrue\u003c/em\u003e, \u003cem\u003efalse\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny value\u003c/strong\u003e: truthy/falsy values will be coerced to boolean"
      }
    ],
    "help": "Negates a \u003cem\u003eboolean\u003c/em\u003e value. Returns \u003cem\u003efalse\u003c/em\u003e for truthy values and \u003cem\u003etrue\u003c/em\u003e for falsy values.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNegate true\u003c/em\u003e***\u003cbr\u003eValue to Negate: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNegate false\u003c/em\u003e***\u003cbr\u003eValue to Negate: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the value before negating (e.g., type conversion, normalization)."
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
        "help": "⚙️ Optional function to apply to the negated boolean before returning it (e.g., \u003ccode\u003eval =\u003e val ? 'yes' : 'no'\u003c/code\u003e, \u003ccode\u003eval =\u003e val.toString()\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Negates a boolean value.
 * 
 * @param {boolean} data.src - The boolean value to negate.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before negating.
 * 
 * @returns {boolean} The negated boolean value.
 *
 * @framework ggLowCodeGTMKit
 */
const not = function(value) {
    return !value;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// not - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(not(value));
// ===============================================================================
// not() – Apply Mode
// ===============================================================================
/*
return function(value) {
   return out(not(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Negate true'
    code: |-
      /* @display
      Value to Negate: true
      @output
      false
      */
      const src = true;
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
  - name: '[example] Negate false'
    code: |-
      /* @display
      Value to Negate: false
      @output
      true
      */
      const src = false;
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
  - name: Test negating truthy value returns false
    code: |-
      const src = 'hello';
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
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
  const mode = 'direct';
  // ===================================================================================================
  // Derived flags
  // ===================================================================================================
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 


___NOTES___

Created on 03/04/2026, 15:27:53


