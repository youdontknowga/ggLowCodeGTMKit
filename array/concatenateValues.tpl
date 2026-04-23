___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "concatenateValues",
  "description": "Concatenate list values, and optionally add a separator (e.g., comma).",
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
        "type": "SIMPLE_TABLE",
        "name": "src",
        "displayName": "Values to Concatenate",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "val",
            "type": "TEXT"
          }
        ],
        "help": "💾 List of values to concatenate. Each row represents one value.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eBoolean\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eVariable reference\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eConcatenate with separator\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMixed types concatenation\u003c/em\u003e***"
      },
      {
        "type": "TEXT",
        "name": "sep",
        "displayName": "Separator (use %esc% for space, blank for no separator)",
        "simpleValueType": true,
        "help": "💾 The separator string to place between concatenated values.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eSpecial encoding:\u003c/strong\u003e Use \u003ccode\u003e%esc%\u003c/code\u003e to represent a space character (spaces are trimmed in GTM fields).\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e (use %esc% for space)\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eEmpty string\u003c/strong\u003e (no separator)"
      }
    ],
    "help": "Concatenates multiple values or arrays into a single \u003cem\u003earray\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eConcatenate with separator\u003c/em\u003e***\u003cbr\u003eValues to Concatenate: \u003cstrong\u003e[{val: 'apple'}, {val: 'banana'}, {val: 'orange'}]\u003c/strong\u003e\u003cbr\u003eSeparator (use %esc% for space, blank for no separator): \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eapple,banana,orange\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMixed types concatenation\u003c/em\u003e***\u003cbr\u003eValues to Concatenate: \u003cstrong\u003e[{val: 1}, {val: 2.5}, {val: 'three'}, {val: true}, {val: 0}]\u003c/strong\u003e\u003cbr\u003eSeparator (use %esc% for space, blank for no separator): \u003cstrong\u003e|\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1|2.5|three|true|0\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the extracted values array before concatenation (e.g., filter empty values, transform array). Note: Values are extracted from the table's \u003ccode\u003eval\u003c/code\u003e property before this function is applied."
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
        "help": "⚙️ Optional function to apply to the concatenated result before returning it (e.g., \u003ccode\u003estr =\u003e str.toUpperCase()\u003c/code\u003e, \u003ccode\u003estr =\u003e str.trim()\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Concatenates the values in an array, with an optional separator.
 * 
 * @param {Array} data.src - An array of objects (Direct mode) or values (Apply mode) to concatenate.
 * @param {string} data.sep - The separator string to use (use %esc% for spaces).
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {string} The concatenated string of values, separated by the provided separator.
 *
 * @framework ggLowCodeGTMKit
 */
const decodeEsc = (value) => value == null ? '' : value.toString().split('%esc%').join(' ');
const toString = (value) => (value == null ? '' : value.toString());

const concatenateValues = function(valueArray, separator) {
    const values = valueArray || [];
    const sep = decodeEsc(separator);
    return values.map(val => toString(val)).join(sep);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// concatenateValues - Direct mode
// ===============================================================================
const extractItemValues = (items) => items.map(item => item ? item.val : null);
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const extractedValues = extractItemValues(data.src);
const value = applyCast(data.pre, extractedValues);
return out(concatenateValues(value, data.sep));
// ===============================================================================
// concatenateValues(...) – Apply Mode
// ===============================================================================
/*
return function(value, separator) {
   return out(concatenateValues(value, data.sep));
};
*/


___TESTS___

scenarios:
  - name: '[example] Concatenate with separator'
    code: |-
      /* @display
      Values to Concatenate: [{val: 'apple'}, {val: 'banana'}, {val: 'orange'}]
      Separator (use %esc% for space, blank for no separator): ,
      @output
      apple,banana,orange
      */
      const src = [{val: 'apple'}, {val: 'banana'}, {val: 'orange'}];
      const sep = ',';
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
          variableResult = func(['apple', 'banana', 'orange'], sep);
      }
      assertThat(variableResult).isEqualTo('apple,banana,orange');
  - name: Test concatenation with space separator using %esc% encoding
    code: |-
      const src = [{val: 'hello'}, {val: 'world'}, {val: 'test'}];
      const sep = '%esc%';
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
          variableResult = func(['hello', 'world', 'test'], sep);
      }
      assertThat(variableResult).isEqualTo('hello world test');
  - name: Test with empty array
    code: |-
      const src = [];
      const sep = ',';
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
  - name: Test with null and undefined values in array
    code: |-
      const src = [{val: 'start'}, {val: null}, {val: undefined}, {val: 'end'}];
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
          variableResult = func(['start', null, undefined, 'end'], sep);
      }
      assertThat(variableResult).isEqualTo('start---end');
  - name: '[example] Mixed types concatenation'
    code: |-
      /* @display
      Values to Concatenate: [{val: 1}, {val: 2.5}, {val: 'three'}, {val: true}, {val: 0}]
      Separator (use %esc% for space, blank for no separator): |
      @output
      1|2.5|three|true|0
      */
      const src = [{val: 1}, {val: 2.5}, {val: 'three'}, {val: true}, {val: 0}];
      const sep = '|';
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
          variableResult = func([1, 2.5, 'three', true, 0], sep);
      }
      assertThat(variableResult).isEqualTo('1|2.5|three|true|0');
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
  const mode = 'direct';
  // ===================================================================================================
  // Derived flags
  // ===================================================================================================
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 


___NOTES___

Created on 17/12/2023 11:49:27


