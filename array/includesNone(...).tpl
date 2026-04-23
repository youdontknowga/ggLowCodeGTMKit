___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "includesNone(...)",
  "description": "Checks whether the source content contains \u003cstrong\u003enone\u003c/strong\u003e of the provided search terms.",
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
        "help": "🔍   Search terms (one or more) to find within the data.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e: \u003cem\u003e\"hello world\"\u003c/em\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e: \u003cem\u003e[\"a\", \"b\", \"c\"]\u003c/em\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eComma-separated string\u003c/strong\u003e: \u003cem\u003e\"a,b,c\"\u003c/em\u003e\u003cbr\u003e",
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
        "displayName": "🔗 Chained callback parameter: Source Content",
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
            "checkboxText": "⚡Use runtime parameter for: earch Terms:",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Checks if none of the specified terms are found in the source \u003cem\u003earray\u003c/em\u003e or \u003cem\u003estring\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo terms found\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eThe quick brown fox jumps over the lazy dog\u003c/strong\u003e\u003cbr\u003eSearch Terms: \u003cstrong\u003e[\"cat\", \"mouse\", \"bird\"]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTerm found returns false\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003eThe quick brown fox jumps over the lazy dog\u003c/strong\u003e\u003cbr\u003eSearch Terms: \u003cstrong\u003e[\"cat\", \"fox\", \"bird\"]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., bool =\u003e bool ? 'clean' : 'contains terms', val =\u003e !val for negation). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Checks if the source contains **none** of the provided search terms.
 *
 * @param {*} data.src - The data to search within (string, number, object, etc.).
 * @param {Array<string>|string} data.tms - Term, array or comma-separated string of terms to search for.
 * @param {string|Function} [data.out] - Output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional function to transform `src` before searching.
 *
 * @returns {boolean} True if none of the terms are found, false otherwise.
 *
 * @framework ggLowCodeGTMKit
 */
const includesNone = function(searchData, searchTerms) {
	if (searchData == null || searchTerms == null) {
		return false;
	}
	const searchString = searchData.toString();
	const safeSplit = value => typeof value === 'string' ? value.split(',') : value;
	searchTerms = safeSplit(searchTerms);
	return searchTerms.every(term => term != null && searchString.indexOf(term) === -1);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// includesNone - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const searchData = applyCast(data.pre, data.src);
return out(includesNone(searchData, data.tms));
*/
// ===============================================================================
// includesNone(...) – Apply Mode
// ===============================================================================
  return function(searchData, searchTerms) {
  searchTerms = data.rp1 ? data.tms : searchTerms;
  return out(includesNone(searchData, searchTerms));
};


___TESTS___

scenarios:
  - name: '[example] No terms found'
    code: |-
      /* @display
      Value to Process: The quick brown fox jumps over the lazy dog
      Search Terms: ["cat", "mouse", "bird"]
      @output
      true
      */
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = ["cat", "mouse", "bird"];
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
  - name: '[example] Term found returns false'
    code: |-
      /* @display
      Value to Process: The quick brown fox jumps over the lazy dog
      Search Terms: ["cat", "fox", "bird"]
      @output
      false
      */
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = ["cat", "fox", "bird"];
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
  - name: String with all matching terms - should return false
    code: |-
      const src = "The quick brown fox jumps over the lazy dog";
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
  - name: Comma-separated terms with no matches - should return true
    code: |-
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = "cat,mouse,bird";
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
  - name: Null source - should return false
    code: |-
      const src = null;
      const tms = ["cat", "mouse"];
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
      const src = "The quick brown fox";
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
  - name: Number source with no matching terms - should return true
    code: |
      const src = 12345;
      const tms = ["67", "89", "abc"];
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
  - name: Number source with matching terms - should return false
    code: |-
      const src = 12345;
      const tms = ["123", "67"];
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
  - name: Empty string with search terms - should return true
    code: |-
      const src = "";
      const tms = ["cat", "dog"];
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
  - name: JSON string with no matching terms - should return true
    code: |-
      const src = '{"id":123,"name":"Product XYZ"}';
      const tms = ["ABC", "999", "unavailable"];
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
