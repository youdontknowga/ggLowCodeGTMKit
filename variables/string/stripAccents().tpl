___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "stripAccents()",
  "description": "Replaces accented characters in a \u003cem\u003estring\u003c/em\u003e with their closest ASCII equivalents (e.g. é→e, ü→u, ß→ss). GTM sandbox alternative to .normalize('NFD').",
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
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFrench accents\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eCafé résumé naïve\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eCafe resume naive\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGerman umlauts and eszett\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eÜber große Straße\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eUeber grosse Strasse\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string returns undefined\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Text To Strip"
      }
    ],
    "help": "Replaces accented characters with their closest ASCII equivalents. Preserves the original case of the string.\u003cbr\u003e\u003cbr\u003eThis is the GTM sandbox equivalent of \u003ccode\u003e.normalize('NFD').replace(/[\\u0300-\\u036f]/g, '')\u003c/code\u003e, which is not available in the sandboxed JavaScript environment.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFrench accents\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eCafé résumé naïve\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eCafe resume naive\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGerman umlauts and eszett\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eÜber große Straße\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eUeber grosse Strasse\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNon-string returns undefined\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e12345\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., toLowerCase(), slugify). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
* Replaces accented characters with their closest ASCII equivalents.
*
* GTM sandbox alternative to .normalize('NFD').replace(/[\u0300-\u036f]/g, ''),
* which is not available in the sandboxed JavaScript environment.
*
* Handles both uppercase and lowercase accented characters, preserving
* the original case of the surrounding text. Multi-character replacements
* (ß→ss, æ→ae, œ→oe, þ→th, Æ→AE, Œ→OE, Þ→Th) follow standard
* transliteration conventions.
*
* @param {string} data.src - The string to strip accents from.
* @param {Function|string} [data.out] - Optional output handler.
*
* Direct-mode specific parameters:
* @param {Function} [data.pre] - Optional pre-processor function.
*
* @returns {string|undefined} The string with accents replaced, or undefined if input is not a string.
*
* @framework ggLowCodeGTMKit
*/
const stripAccents = function(input) {
   if (typeof input !== 'string') { return undefined; }

   var map = {
  'à':'a','á':'a','â':'a','ã':'a','ä':'ae','å':'a','æ':'ae',
  'ç':'c',
  'è':'e','é':'e','ê':'e','ë':'e',
  'ì':'i','í':'i','î':'i','ï':'i',
  'ð':'d','ñ':'n',
  'ò':'o','ó':'o','ô':'o','õ':'o','ö':'oe','ø':'o','œ':'oe',
  'ù':'u','ú':'u','û':'u','ü':'ue',
  'ý':'y','ÿ':'y','þ':'th','ß':'ss',

  'ł':'l','đ':'d',
  'ž':'z','š':'s','č':'c','ř':'r','ě':'e','ů':'u',
  'ń':'n','ň':'n','ś':'s','ź':'z','ż':'z',
  'ą':'a','ę':'e','ć':'c',
  'ő':'o','ű':'u',
  'ğ':'g','ı':'i','ş':'s',
  'ť':'t','ď':'d','ľ':'l','ĺ':'l','ŕ':'r',

  'À':'A','Á':'A','Â':'A','Ã':'A','Ä':'Ae','Å':'A','Æ':'AE',
  'Ç':'C',
  'È':'E','É':'E','Ê':'E','Ë':'E',
  'Ì':'I','Í':'I','Î':'I','Ï':'I',
  'Ð':'D','Ñ':'N',
  'Ò':'O','Ó':'O','Ô':'O','Õ':'O','Ö':'Oe','Ø':'O','Œ':'OE',
  'Ù':'U','Ú':'U','Û':'U','Ü':'Ue',
  'Ý':'Y','Ÿ':'Y','Þ':'Th',

  'Ł':'L','Đ':'D',
  'Ž':'Z','Š':'S','Č':'C','Ř':'R','Ě':'E','Ů':'U',
  'Ń':'N','Ň':'N','Ś':'S','Ź':'Z','Ż':'Z',
  'Ą':'A','Ę':'E','Ć':'C',
  'Ő':'O','Ű':'U',
  'Ğ':'G','İ':'I','Ş':'S',
  'Ť':'T','Ď':'D','Ľ':'L','Ĺ':'L','Ŕ':'R'
};

var result = [];
  for (var i = 0; i < input.length; i++) {
    var c = input.charAt(i);
    var r = map[c];
    result.push(r !== undefined ? r : c);
  }
  return result.join('');
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// stripAccents - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(stripAccents(value));
*/
// ===============================================================================
// stripAccents() – Apply Mode
// ===============================================================================
return function(value) {
  return out(stripAccents(value));
};


___TESTS___

scenarios:
  - name: '[example] French accents'
    code: |-
      /* @display
      Value to Process: Café résumé naïve
      @output
      Cafe resume naive
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
      assertThat(variableResult).isEqualTo("Cafe resume naive");
  - name: '[example] German umlauts and eszett'
    code: |-
      /* @display
      Value to Process: Über große Straße
      @output
      Ueber grosse Strasse
      */
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
      assertThat(variableResult).isEqualTo("Ueber grosse Strasse");
  - name: Spanish with ñ
    code: |-
      const src = "El niño español";
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
      assertThat(variableResult).isEqualTo("El nino espanol");
  - name: Scandinavian characters
    code: |-
      const src = "Ångström Ødegaard Ålborg";
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
      assertThat(variableResult).isEqualTo("Angstroem Odegaard Alborg");
  - name: Czech and Polish characters
    code: |-
      const src = "Příliš žluťoučký kůň";
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
      assertThat(variableResult).isEqualTo("Prilis zlutoucky kun");
  - name: No accents - unchanged
    code: |-
      const src = "Hello World 123";
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
      assertThat(variableResult).isEqualTo("Hello World 123");
  - name: Ligatures - æ and œ
    code: |-
      const src = "Encyclopædia cœur";
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
      assertThat(variableResult).isEqualTo("Encyclopaedia coeur");
  - name: Turkish characters
    code: |-
      const src = "İstanbul güneşli";
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
      assertThat(variableResult).isEqualTo("Istanbul guenesli");
  - name: Mixed case preserves case
    code: |-
      const src = "ÉLAN élégant";
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
      assertThat(variableResult).isEqualTo("ELAN elegant");
  - name: '[example] Non-string returns undefined'
    code: |-
      /* @display
      Value to Process: 12345
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
  - name: Empty string returns empty
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
