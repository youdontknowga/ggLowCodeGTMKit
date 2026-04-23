___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "includesAny(...)",
  "description": "Checks whether the source content contains \u003cstrong\u003eany\u003c/strong\u003e of the provided search terms.",
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
        "name": "tms",
        "displayName": "Search Terms",
        "simpleValueType": true,
        "help": "🔍   Term, array or comma-separated string of terms to search for.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString (comma-separated)\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },      
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template."
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Data To Search",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template."
      },
      {
        "type": "GROUP",
        "name": "Advanced Settings",
        "displayName": "Advanced Settings",
        "groupStyle": "ZIPPY_OPEN_ON_PARAM",
        "subParams": [
          {
            "type": "CHECKBOX",
            "name": "rp1",
            "checkboxText": "⚡Use runtime parameter for: Search Terms",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Checks if any of the specified terms are found in the source \u003cem\u003earray\u003c/em\u003e or \u003cem\u003estring\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTerm found returns true\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eThe quick brown fox jumps over the lazy dog\u003c/strong\u003e\u003cbr\u003eSearch Terms: \u003cstrong\u003e[\"quick\", \"fox\"]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eComma-separated match\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eThe quick brown fox jumps over the lazy dog\u003c/strong\u003e\u003cbr\u003eSearch Terms: \u003cstrong\u003equick,fox,dog\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., bool =\u003e bool ? 'found' : 'not found', val =\u003e !val for negation). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Checks if the source contains **any** of the provided search terms.
 *
 * @param {*} data.src - The data to search within (string, number, object, etc.).
 * @param {Array<string>|string} data.tms - Term, array or comma-separated string of terms to search for.
 * @param {string|Function} [data.out] - Output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional function to transform `src` before searching.
 *
 * @returns {boolean} True if any of the terms are found, false otherwise.
 *
 * @framework ggLowCodeGTMKit
 */
const includesAny = function(searchData, searchTerms) {
	if (searchData == null || searchTerms == null) {
		return false;
	}
	const searchString = searchData.toString();
	const safeSplit = value => typeof value === 'string' ? value.split(',') : value;
	searchTerms = safeSplit(searchTerms);
	return searchTerms.some(term => term != null && searchString.indexOf(term) > -1);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// includesAny - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const searchData = applyCast(data.pre, data.src);
return out(includesAny(searchData, data.tms));
*/
// ===============================================================================
// includesAny(...) – Apply Mode
// ===============================================================================
return function(searchData, searchTerms) {
  searchTerms = data.rp1 ? data.tms : searchTerms;
  return out(includesAny(searchData, searchTerms));
};


___TESTS___

scenarios:
  - name: '[example] Term found returns true'
    code: |-
      /* @display
      Value to Process: The quick brown fox jumps over the lazy dog
      Search Terms: ["quick", "fox"]
      @output
      true
      */
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = ["quick", "fox"];
      const mockData = {
          src: src,
          tms: tms,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] Comma-separated match'
    code: |-
      /* @display
      Value to Process: The quick brown fox jumps over the lazy dog
      Search Terms: quick,fox,dog
      @output
      true
      */
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = "quick,fox,dog";
      const mockData = {
          src: src,
          tms: tms,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isTrue();
  - name: String with some matching terms - should return true
    code: |-
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = ["quick", "fox", "cat"];
      const mockData = {
          src: src,
          tms: tms,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isTrue();
  - name: With output function - should return transformed result
    code: |-
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = ["quick", "fox", "dog"];
      const mockData = {
          src: src,
          tms: tms,
          rp1: false,
          out: (result) => result ? "Found all terms" : "Not found"
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isEqualTo("Found all terms");
  - name: With pre-processor function - should extract and search text
    code: |-
      // With pre-processor function in Direct mode - should extract and search text
      const src = { text: "The quick brown fox jumps over the lazy dog" };
      const tms = ["quick", "fox", "dog"];
      const mockData = {
          src: src,
          tms: tms,
          rp1: false,
          pre: (obj) => obj.text
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src.text, tms); // Pass the extracted text in Apply mode
      }
      assertThat(variableResult).isTrue();
  - name: Null source - should return false
    code: |-
      const src = null;
      const tms = ["quick", "fox", "dog"];
      const mockData = {
          src: src,
          tms: tms,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isFalse();
  - name: Null terms - should return false
    code: |-
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = null;
      const mockData = {
          src: src,
          tms: tms,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isFalse();
  - name: Number source with matching terms - should convert and return true
    code: |-
      const src = 12345;
      const tms = ["123", "45"];
      const mockData = {
          src: src,
          tms: tms,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isTrue();
  - name: JSON string with matching terms - should return true
    code: |-
      const src = '{"id":123,"name":"Product XYZ","categories":["electronics","gadgets"],"inStock":true}';
      const tms = ["Product XYZ", "electronics", "true"];
      const mockData = {
          src: src,
          tms: tms,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isTrue();
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
