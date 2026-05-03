___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "normalizePhone",
  "description": "Normalizes a phone number to E.164 format for Enhanced Conversions hashing: strips non-digit characters, prepends a configurable default country code, and optionally toggles the leading + for Meta CAPI compatibility with \u003cem\u003estring\u003c/em\u003e input.",
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
        "displayName": "Phone Number",
        "simpleValueType": true,
        "help": "💾   The phone number to normalize to E.164 format.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "cc",
        "displayName": "Default Country Code",
        "simpleValueType": true,
        "defaultValue": "1",
        "help": "🌍   The default country code to prepend when the input does not already include one. Digits only, no + sign.\u003cbr\u003e\u003cbr\u003eExamples: \u003cstrong\u003e1\u003c/strong\u003e (US/Canada), \u003cstrong\u003e44\u003c/strong\u003e (UK), \u003cstrong\u003e33\u003c/strong\u003e (France), \u003cstrong\u003e49\u003c/strong\u003e (Germany).\u003cbr\u003e\u003cbr\u003eThe country code is prepended only if the cleaned digits do not already start with it."
      },
      {
        "type": "CHECKBOX",
        "name": "noPlus",
        "checkboxText": "Remove leading + (Meta CAPI mode)",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "☑️   When enabled, the output omits the leading + sign.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eGoogle Ads / CM360\u003c/strong\u003e: requires the + → leave unchecked (default).\u003cbr\u003e\u003cstrong\u003eMeta CAPI\u003c/strong\u003e: expects digits only → check this box."
      }
    ],
    "help": "Normalizes a phone number to E.164 format following Google Ads, Campaign Manager 360, and Meta CAPI specifications for Enhanced Conversions.\u003cbr\u003e\u003cbr\u003eNormalization steps:\u003cbr\u003e1. Strip all non-digit characters (except a leading +)\u003cbr\u003e2. If no country code is detected, prepend the configured default\u003cbr\u003e3. Optionally remove the leading + for Meta CAPI compatibility\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eUS phone with formatting\u003c/em\u003e***\u003cbr\u003ePhone Number: \u003cstrong\u003e(800) 555-0200\u003c/strong\u003e\u003cbr\u003eDefault Country Code: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e+18005550200\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMeta CAPI mode (no plus)\u003c/em\u003e***\u003cbr\u003ePhone Number: \u003cstrong\u003e+1 650-555-1234\u003c/strong\u003e\u003cbr\u003eDefault Country Code: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e16505551234\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string returns undefined\u003c/em\u003e***\u003cbr\u003ePhone Number: \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., extract phone from an object)."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., pipe into a SHA-256 hash function). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Normalizes a phone number to E.164 format for Enhanced Conversions.
*
* Follows the normalization rules required by Google Ads, Campaign Manager 360,
* and Meta CAPI before SHA-256 hashing:
*   1. Strip all non-digit characters (preserving knowledge of a leading +)
*   2. If no country code detected, prepend the configured default
*   3. Optionally omit the leading + for Meta CAPI compatibility
*
* @param {string|number} data.src - The phone number to normalize.
* @param {string} [data.cc] - Default country code (digits only, default "1").
* @param {boolean} [data.noPlus] - If true, omit the leading + (Meta CAPI mode).
* @param {Function|string} [data.out] - Optional output handler.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function.
*
* @returns {string|undefined} The E.164-formatted phone number, or undefined if input is invalid.
*
* @framework ggLowCodeGTMKit
*/
const makeString = require('makeString');

const normalizePhone = function(phone, countryCode, omitPlus) {
   var str = makeString(phone);
   if (!str || str === 'undefined' || str === 'null') { return undefined; }

   var hadPlus = str.charAt(0) === '+';
   var digits = '';
   for (var i = 0; i < str.length; i++) {
       var ch = str.charAt(i);
       if (ch >= '0' && ch <= '9') {
           digits += ch;
       }
   }

   if (digits.length === 0) { return undefined; }

   var cc = countryCode || '1';

   var cleanCC = '';
   for (var j = 0; j < cc.length; j++) {
       var d = cc.charAt(j);
       if (d >= '0' && d <= '9') {
           cleanCC += d;
       }
   }
   if (cleanCC.length === 0) { cleanCC = '1'; }

   var fullDigits = digits;
   if (!hadPlus) {
       var startsWithCC = true;
       if (digits.length <= cleanCC.length) {
           startsWithCC = false;
       } else {
           for (var k = 0; k < cleanCC.length; k++) {
               if (digits.charAt(k) !== cleanCC.charAt(k)) {
                   startsWithCC = false;
                   break;
               }
           }
       }
       if (!startsWithCC) {
           fullDigits = cleanCC + digits;
       }
   }

   if (omitPlus) {
       return fullDigits;
   }
   return '+' + fullDigits;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// normalizePhone - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(normalizePhone(value, data.cc, data.noPlus));
// ===============================================================================
// normalizePhone() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(normalizePhone(value, data.cc, data.noPlus));
};
*/


___TESTS___

scenarios:
  - name: '[example] US phone with formatting'
    code: |-
      /* @display
      Phone Number: (800) 555-0200
      Default Country Code: 1
      @output
      +18005550200
      */
      const src = "(800) 555-0200";
      const mockData = {
          src: src,
          cc: "1",
          noPlus: false,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("+18005550200");
  - name: '[example] Meta CAPI mode (no plus)'
    code: |-
      /* @display
      Phone Number: +1 650-555-1234
      Default Country Code: 1
      @output
      16505551234
      */
      const src = "+1 650-555-1234";
      const mockData = {
          src: src,
          cc: "1",
          noPlus: true,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("16505551234");
  - name: Already has leading + and country code - preserves digits
    code: |-
      const src = "+44 20 7946 0958";
      const mockData = {
          src: src,
          cc: "44",
          noPlus: false,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("+442079460958");
  - name: French number without country code - prepends 33
    code: |-
      const src = "06 12 34 56 78";
      const mockData = {
          src: src,
          cc: "33",
          noPlus: false,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("+330612345678");
  - name: Number already starting with country code digits - no double prepend
    code: |-
      const src = "16505551234";
      const mockData = {
          src: src,
          cc: "1",
          noPlus: false,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("+16505551234");
  - name: German number with dashes and dots
    code: |-
      const src = "030-1234-5678";
      const mockData = {
          src: src,
          cc: "49",
          noPlus: false,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("+4903012345678");
  - name: Numeric input coerced to string
    code: |-
      const src = 8005550200;
      const mockData = {
          src: src,
          cc: "1",
          noPlus: false,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("+18005550200");
  - name: '[example] Non-string returns undefined'
    code: |-
      /* @display
      Phone Number: undefined
      @output
      undefined
      */
      const src = undefined;
      const mockData = {
          src: src,
          cc: "1",
          noPlus: false,
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
  - name: Empty string - returns undefined
    code: |-
      const src = "";
      const mockData = {
          src: src,
          cc: "1",
          noPlus: false,
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
  - name: No digits in input - returns undefined
    code: |-
      const src = "not-a-phone";
      const mockData = {
          src: src,
          cc: "1",
          noPlus: false,
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
