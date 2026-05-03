___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "slugify",
  "description": "Converts a \u003cem\u003estring\u003c/em\u003e into a URL-friendly slug: lowercases, strips accents, replaces special characters and whitespace with hyphens, and removes leading/trailing hyphens.",
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
        "displayName": "Text To Slugify",
        "simpleValueType": true,
        "help": "💾   The string to convert into a URL-friendly slug.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      }
    ],
    "help": "Converts a \u003cem\u003estring\u003c/em\u003e into a URL-friendly slug.\u003cbr\u003e\u003cbr\u003eSlugification steps:\u003cbr\u003e1. Lowercase and trim\u003cbr\u003e2. Replace accented characters with ASCII equivalents\u003cbr\u003e3. Replace special characters with spaces\u003cbr\u003e4. Collapse multiple spaces or hyphens into a single hyphen\u003cbr\u003e5. Remove leading and trailing hyphens\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBasic slugification\u003c/em\u003e***\u003cbr\u003eText To Slugify: \u003cstrong\u003eHello World! This is a Test\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ehello-world-this-is-a-test\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAccented characters\u003c/em\u003e***\u003cbr\u003eText To Slugify: \u003cstrong\u003eCafé résumé naïve\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003ecafe-resume-naive\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string returns undefined\u003c/em\u003e***\u003cbr\u003eText To Slugify: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before slugification."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., prepend a path prefix). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Converts a string into a URL-friendly slug.
*
* Steps:
*   1. Lowercase and trim
*   2. Replace accented characters with ASCII equivalents
*   3. Replace non-alphanumeric characters with spaces
*   4. Collapse multiple spaces/hyphens into a single hyphen
*   5. Strip leading and trailing hyphens
*
* Uses the established replaceAllWithRegex pattern for GTM sandbox compatibility
* (no regex literals, no .normalize(), no .replaceAll()).
*
* @param {string} data.src - The string to slugify.
* @param {Function|string} [data.out] - Optional output handler.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function.
*
* @returns {string|undefined} The slugified string, or undefined if input is not a string.
*
* @framework ggLowCodeGTMKit
*/
const slugify = function(input) {
   if (typeof input !== 'string') { return undefined; }

   // --- Helper: replaceAllWithRegex (GTM sandbox pattern from toKebabCase/toSnakeCase) ---
   const replaceAllWithRegex = function(str, pattern, replacement) {
       if (typeof str !== 'string' || typeof pattern !== 'string') { return str; }
       var result = str;
       var lastIndex = 0;
       while (lastIndex < result.length) {
           var remaining = result.substring(lastIndex);
           var matchObj = remaining.match(pattern);
           if (matchObj === null) { break; }
           var actualMatchIndex = lastIndex + (matchObj.index || 0);
           result = result.substring(0, actualMatchIndex) +
                    replacement +
                    result.substring(actualMatchIndex + matchObj[0].length);
           lastIndex = actualMatchIndex + replacement.length;
       }
       return result;
   };

   var slug = input.toLowerCase().trim();

   var accentMap = {
       'à': 'a', 'á': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'å': 'a', 'æ': 'ae',
       'ç': 'c', 'è': 'e', 'é': 'e', 'ê': 'e', 'ë': 'e',
       'ì': 'i', 'í': 'i', 'î': 'i', 'ï': 'i',
       'ð': 'd', 'ñ': 'n',
       'ò': 'o', 'ó': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o', 'ø': 'o',
       'ù': 'u', 'ú': 'u', 'û': 'u', 'ü': 'u',
       'ý': 'y', 'ÿ': 'y', 'þ': 'th',
       'ß': 'ss', 'œ': 'oe',
       'ł': 'l', 'đ': 'd', 'ž': 'z', 'š': 's', 'č': 'c', 'ř': 'r',
       'ě': 'e', 'ů': 'u', 'ń': 'n', 'ś': 's', 'ź': 'z', 'ą': 'a', 'ę': 'e',
       'ć': 'c', 'ő': 'o', 'ű': 'u'
   };
   var deaccented = '';
   for (var i = 0; i < slug.length; i++) {
       var ch = slug.charAt(i);
       deaccented += accentMap[ch] || ch;
   }
   slug = deaccented;

   slug = replaceAllWithRegex(slug, "[^a-z0-9\\s-]", ' ');

   slug = slug.trim();

   slug = replaceAllWithRegex(slug, "[\\s-]+", '-');

   while (slug.length > 0 && slug.charAt(0) === '-') {
       slug = slug.substring(1);
   }
   while (slug.length > 0 && slug.charAt(slug.length - 1) === '-') {
       slug = slug.substring(0, slug.length - 1);
   }

   return slug;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// slugify - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(slugify(value));
// ===============================================================================
// slugify() – Apply Mode
// ===============================================================================
/*
return function(value) {
  return out(slugify(value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Basic slugification'
    code: |-
      /* @display
      Text To Slugify: Hello World! This is a Test
      @output
      hello-world-this-is-a-test
      */
      const src = "Hello World! This is a Test";
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
      assertThat(variableResult).isEqualTo("hello-world-this-is-a-test");
  - name: '[example] Accented characters'
    code: |-
      /* @display
      Text To Slugify: Café résumé naïve
      @output
      cafe-resume-naive
      */
      const src = "Café résumé naïve";
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
      assertThat(variableResult).isEqualTo("cafe-resume-naive");
  - name: German umlauts and eszett
    code: |-
      const src = "Über große Straße";
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
      assertThat(variableResult).isEqualTo("uber-grosse-strasse");
  - name: Multiple spaces and special characters
    code: |-
      const src = "  Hello   ---   World!!!  ";
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
      assertThat(variableResult).isEqualTo("hello-world");
  - name: Already a valid slug - unchanged
    code: |-
      const src = "hello-world-test";
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
      assertThat(variableResult).isEqualTo("hello-world-test");
  - name: Numbers preserved
    code: |-
      const src = "Top 10 Products 2024";
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
      assertThat(variableResult).isEqualTo("top-10-products-2024");
  - name: Mixed underscores and hyphens
    code: |-
      const src = "hello_world - test_case";
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
      assertThat(variableResult).isEqualTo("hello-world-test-case");
  - name: French text with multiple accents
    code: |-
      const src = "Étude complète des données";
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
      assertThat(variableResult).isEqualTo("etude-complete-des-donnees");
  - name: '[example] Non-string returns undefined'
    code: |-
      /* @display
      Text To Slugify: 12345
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
  - name: Empty string returns empty string
    code: |-
      const src = "";
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
      assertThat(variableResult).isEqualTo("");
  - name: Ampersands and special chars
    code: |-
      const src = "Ben & Jerry's Ice Cream";
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
      assertThat(variableResult).isEqualTo("ben-jerry-s-ice-cream");
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
