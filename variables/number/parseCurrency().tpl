___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "parseCurrency()",
  "description": "Extracts and parses a valid number from a formatted currency string, handling thousand separators and decimal points.",
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
        "type": "SELECT",
        "name": "dec",
        "displayName": "Decimal Separator",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": ".",
            "displayValue": ". (Dot)"
          },
          {
            "value": ",",
            "displayValue": ", (Comma)"
          }
        ],
        "simpleValueType": true,
        "help": "⚙️ The decimal separator used in the source string. All other non-digit characters (currency symbols, spaces, thousand separators) will be stripped automatically."
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eUS Format (Dot)\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e$ 1,234.56 USD\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1234.56\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGerman Format (Comma)\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e1.234,56 €\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1234.56\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: String To Process"
      }
    ],
    "help": "Extracts and parses a valid number from a formatted currency string by stripping out currency symbols, thousand separators, and whitespace.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eUS Format (Dot)\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e$ 1,234.56 USD\u003c/strong\u003e\u003cbr\u003eDecimal Separator: \u003cstrong\u003e.\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1234.56\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEU Format (Comma)\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e1 234,56 €\u003c/strong\u003e\u003cbr\u003eDecimal Separator: \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1234.56\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGerman Format (Comma)\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e1.234,56 €\u003c/strong\u003e\u003cbr\u003eDecimal Separator: \u003cstrong\u003e,\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e1234.56\u003c/strong\u003e"
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
* Extracts and parses a valid number from a formatted currency string.
* 
* @param {string} data.src - The currency string to parse.
* @param {string} data.dec - The decimal separator used ('.' or ',').
* @param {Function|string} [data.out] - Optional output handler.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src.
* 
* @returns {number|undefined} The parsed number, or undefined if invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeNumber = require('makeNumber');

const parseCurrency = function(input, decimalSeparator) {
    if (typeof input !== 'string') return undefined;
    
    const sep = decimalSeparator === ',' ? ',' : '.';
    
    let cleanString = "";
    for (let i = 0; i < input.length; i++) {
        const char = input.charAt(i);
        if (
            (char >= '0' && char <= '9') || 
            char === '-' || 
            char === sep
        ) {
            cleanString += char;
        }
    }
    
    if (cleanString === "") return undefined;
    
    if (sep === ',') {
        let dotString = "";
        for (let i = 0; i < cleanString.length; i++) {
            dotString += cleanString.charAt(i) === ',' ? '.' : cleanString.charAt(i);
        }
        cleanString = dotString;
    }
    
    const parsed = makeNumber(cleanString);
    if (parsed !== parsed) return undefined; // NaN check
    
    return parsed;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// parseCurrency - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(parseCurrency(value, data.dec));
*/
// ===============================================================================
// parseCurrency(...) – Apply Mode
// ===============================================================================

return function(value) {
   return out(parseCurrency(value, data.dec));
};


___TESTS___

scenarios:
  - name: '[example] US Format (Dot)'
    code: |-
      /* @display
      Input: $ 1,234.56 USD
      @output
      1234.56
      */
      const src = '$ 1,234.56 USD';
      const dec = '.';
      const mockData = {
          src: src,
          dec: dec,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(1234.56);
  - name: '[example] EU Format (Comma)'
    code: |-
      /* @display
      Input: 1 234,56 €
      @output
      1234.56
      */
      const src = '1 234,56 €';
      const dec = ',';
      const mockData = {
          src: src,
          dec: dec,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(1234.56);
  - name: '[example] German Format (Comma)'
    code: |-
      /* @display
      Input: 1.234,56 €
      @output
      1234.56
      */
      const src = '1.234,56 €';
      const dec = ',';
      const mockData = {
          src: src,
          dec: dec,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(1234.56);
  - name: Negative values
    code: |-
      const src = '-$45.99';
      const dec = '.';
      const mockData = {
          src: src,
          dec: dec,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(-45.99);
  - name: No numbers returns undefined
    code: |-
      const src = 'Free';
      const dec = '.';
      const mockData = {
          src: src,
          dec: dec,
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
  - name: Non-string returns undefined
    code: |-
      const src = 1234.56;
      const dec = '.';
      const mockData = {
          src: src,
          dec: dec,
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
