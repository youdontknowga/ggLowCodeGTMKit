___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "normalizeEmail",
  "description": "Normalizes an email address for Enhanced Conversions hashing: trims whitespace, lowercases, and for Gmail/Googlemail domains removes dots and +suffix from the local part \u003cem\u003estring\u003c/em\u003e.",
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
        "displayName": "Email Address",
        "simpleValueType": true,
        "help": "💾   The email address to normalize before hashing.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Normalizes an email address following the Google Ads / Campaign Manager 360 / Meta CAPI Enhanced Conversions specification.\u003cbr\u003e\u003cbr\u003eFour-step normalization:\u003cbr\u003e1. Trim leading/trailing whitespace\u003cbr\u003e2. Lowercase the entire string\u003cbr\u003e3. Gmail/Googlemail only: remove dots from local part\u003cbr\u003e4. Gmail/Googlemail only: remove +suffix from local part\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGmail dot and plus removal\u003c/em\u003e***\u003cbr\u003eEmail Address: \u003cstrong\u003eJane.Doe+Shopping@googlemail.com\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ejanedoe@googlemail.com\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-Gmail unchanged\u003c/em\u003e***\u003cbr\u003eEmail Address: \u003cstrong\u003e  User.Name+tag@outlook.com  \u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003euser.name+tag@outlook.com\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string returns undefined\u003c/em\u003e***\u003cbr\u003eEmail Address: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., extract email from an object). Internal transformations such as trimming and lowercasing will still apply afterward."
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
* Normalizes an email address for Enhanced Conversions hashing.
*
* Applies the four-step normalization sequence required by Google Ads,
* Campaign Manager 360, and Meta CAPI before SHA-256 hashing:
*   1. Trim leading and trailing whitespace
*   2. Lowercase the entire string
*   3. For gmail.com / googlemail.com: remove all dots from the local part
*   4. For gmail.com / googlemail.com: remove the + and everything after it in the local part
*
* @param {string} data.src - The email address to normalize.
* @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function to transform src before normalizing.
*
* @returns {string|undefined} The normalized email address, or undefined if input is not a valid email string.
*
* @framework ggLowCodeGTMKit
*/
const normalizeEmail = function(email) {
  if (typeof email !== 'string') { return undefined; }

  let i = 0;
  while (
    i < email.length &&
    (email.charAt(i) === ' ' ||
     email.charAt(i) === '\t' ||
     email.charAt(i) === '\n' ||
     email.charAt(i) === '\r')
  ) { i++; }

  let j = email.length - 1;
  while (
    j >= 0 &&
    (email.charAt(j) === ' ' ||
     email.charAt(j) === '\t' ||
     email.charAt(j) === '\n' ||
     email.charAt(j) === '\r')
  ) { j--; }

  email = email.slice(i, j + 1);
  
  email = email.toLowerCase();

  const atIdx = email.indexOf('@');
  if (atIdx === -1 || atIdx === 0 || atIdx === email.length - 1) {
    return undefined;
  }
  if (email.indexOf('@', atIdx + 1) !== -1) {
    return undefined;
  }

  var local = email.slice(0, atIdx);
  var domain = email.slice(atIdx + 1);

  // Gmail / Googlemail normalization
  if (domain === 'gmail.com' || domain === 'googlemail.com') {
    var plusIdx = local.indexOf('+');
    if (plusIdx !== -1) {
      local = local.slice(0, plusIdx);
    }

    local = local.split('.').join('');
  }

  return local + '@' + domain;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// normalizeEmail - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(normalizeEmail(value));
// ===============================================================================
// normalizeEmail() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(normalizeEmail(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Gmail dot and plus removal'
    code: |-
      /* @display
      Email Address: Jane.Doe+Shopping@googlemail.com
      @output
      janedoe@googlemail.com
      */
      const src = "Jane.Doe+Shopping@googlemail.com";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("janedoe@googlemail.com");
  - name: '[example] Non-Gmail unchanged'
    code: |-
      /* @display
      Email Address:   User.Name+tag@outlook.com  
      @output
      user.name+tag@outlook.com
      */
      const src = "  User.Name+tag@outlook.com  ";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("user.name+tag@outlook.com");
  - name: Gmail dot com with dots only - removes dots
    code: |-
      const src = "john.william.doe@gmail.com";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("johnwilliamdoe@gmail.com");
  - name: Gmail dot com with plus only - removes plus suffix
    code: |-
      const src = "user+newsletter@gmail.com";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("user@gmail.com");
  - name: Gmail dot com with dots and plus combined - full normalization
    code: |-
      const src = "  J.a.n.e+Shopping@Gmail.Com  ";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("jane@gmail.com");
  - name: Non-Gmail with dots and plus - preserves dots and plus
    code: |-
      const src = "first.last+alias@company.com";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("first.last+alias@company.com");
  - name: Mixed case domain and local - lowercases both
    code: |-
      const src = "Admin@MyCompany.COM";
      const mockData = {
          src: src,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("admin@mycompany.com");
  - name: '[example] Non-string returns undefined'
    code: |-
      /* @display
      Email Address: 12345
      @output
      undefined
      */
      const src = 12345;
      const mockData = {
          src: src,
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
  - name: No @ sign - returns undefined
    code: |-
      const src = "notanemail";
      const mockData = {
          src: src,
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
  - name: Multiple @ signs - returns undefined
    code: |-
      const src = "user@@gmail.com";
      const mockData = {
          src: src,
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
