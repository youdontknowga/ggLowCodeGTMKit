___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "includesAll",
  "description": "Checks whether the source content contains \u003cstrong\u003eall\u003c/strong\u003e of the provided search terms.",
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
        "displayName": "Source Content",
        "simpleValueType": true,
        "help": "💾   The value to search within.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e: \u003cem\u003e\"hello world\"\u003c/em\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e: \u003cem\u003e[\"a\", \"b\", \"c\"]\u003c/em\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eComma-separated string\u003c/strong\u003e: \u003cem\u003e\"a,b,c\"\u003c/em\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eJSON-stringified array or object\u003c/strong\u003e: \u003cem\u003e'[\"a\",\"b\"]'\u003c/em\u003e\u003cbr\u003e"
      },
      {
        "type": "TEXT",
        "name": "tms",
        "displayName": "Search Terms",
        "simpleValueType": true,
        "help": "🔍  Search terms (one or more) to find within the data.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e: \u003cem\u003e\"hello world\"\u003c/em\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e: \u003cem\u003e[\"a\", \"b\", \"c\"]\u003c/em\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eComma-separated string\u003c/strong\u003e: \u003cem\u003e\"a,b,c\"\u003c/em\u003e\u003cbr\u003e"
      }
    ],
    "help": "Checks if all specified terms are found in the source.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAll terms found\u003c/em\u003e***\u003cbr\u003eSource Content: \u003cstrong\u003eThe quick brown fox jumps over the lazy dog\u003c/strong\u003e\u003cbr\u003eSearch Terms: \u003cstrong\u003e[\"quick\", \"fox\", \"dog\"]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMissing term returns false\u003c/em\u003e***\u003cbr\u003eSource Content: \u003cstrong\u003eThe quick brown fox jumps over the lazy dog\u003c/strong\u003e\u003cbr\u003eSearch Terms: \u003cstrong\u003e[\"quick\", \"fox\", \"cat\"]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the input before internal logic (e.g., convert object to string, normalize case). Internal transformations such as case handling will still apply afterward."
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str + ' €', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Checks if the source contains **all** of the provided search terms.
 *
 * @param {*} data.src - The data to search within (string, number, object, etc.).
 * @param {Array<string>|string} data.tms - Term, array or comma-separated string of terms to search for.
 * @param {string|Function} [data.out] - Output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional function to transform `src` before searching.
 *
 * @returns {boolean} True if all of the terms are found, false otherwise.
 *
 * @framework ggLowCodeGTMKit
 */
const includesAll = function(searchData, searchTerms) {
	if (searchData == null || searchTerms == null) {
		return false;
	}
	const searchString = searchData.toString();
	const safeSplit = value => typeof value === 'string' ? value.split(',') : value;
	searchTerms = safeSplit(searchTerms);
	return searchTerms.every(term => term != null && searchString.indexOf(term) > -1);
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// includesAll - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const searchData = applyCast(data.pre, data.src);
return out(includesAll(searchData, data.tms));

// ===============================================================================
// includesAll(...) – Apply Mode
// ===============================================================================
/*
return function(searchData, searchTerms) {
  searchTerms = data.rp1 ? data.tms : searchTerms;
   return out(includesAll(searchData, searchTerms));
};
*/


___TESTS___

scenarios:
  - name: '[example] All terms found'
    code: |-
      /* @display
      Source Content: The quick brown fox jumps over the lazy dog
      Search Terms: ["quick", "fox", "dog"]
      @output
      true
      */
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = ["quick", "fox", "dog"];

      const mockData = {
          src: src,
          tms: tms,
          rp1: true
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isTrue();
  - name: Using comma-separated string for terms
    code: |-
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = "quick,fox,dog";
      const mockData = {
          src: src,
          tms: tms,
          rp1: true
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isTrue();
  - name: '[example] Missing term returns false'
    code: |-
      /* @display
      Source Content: The quick brown fox jumps over the lazy dog
      Search Terms: ["quick", "fox", "cat"]
      @output
      false
      */
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = ["quick", "fox", "cat"];
      const mockData = {
          src: src,
          tms: tms,
          rp1: true
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isFalse();
  - name: Custom output transformation
    code: |-
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = ["quick", "fox", "dog"];
      const out = (result) => result ? "Found all terms" : "Not found";
      const mockData = {
          src: src,
          tms: tms,
          rp1: true,
          out: out
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isEqualTo("Found all terms");
  - name: Using pre-processing function on complex source
    code: |-
      const src = { text: "The quick brown fox jumps over the lazy dog" };
      const tms = ["quick", "fox", "dog"];
      const pre = (obj) => obj.text;

      const mockData = {
          src: src,
          tms: tms,
          rp1: true,
          pre: pre
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
        assertThat(variableResult).isTrue();
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
        assertThat(variableResult).isFalse();
      }
  - name: Null source data should return false
    code: |-
      const src = null;
      const tms = ["quick", "fox", "dog"];

      const mockData = {
          src: src,
          tms: tms,
          rp1: true
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isFalse();
  - name: Null search terms should return false
    code: |-
      const src = "The quick brown fox jumps over the lazy dog";
      const tms = null;
      const mockData = {
          src: src,
          tms: tms,
          rp1: true 
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }
      assertThat(variableResult).isFalse();
  - name: Numeric data gets converted to string for search
    code: |-
      const src = 12345;
      const tms = ["123", "45"];
      const mockData = {
          src: src,
          tms: tms,
          rp1: true
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }

      assertThat(variableResult).isTrue();
  - name: JSON stringified object search
    code: |-
      const src = '{"id":123,"name":"Product XYZ","categories":["electronics","gadgets"],"inStock":true}';
      const tms = ["Product XYZ", "electronics", "true"];
      const mockData = {
          src: src,
          tms: tms,
          rp1: true
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, tms);
      }

      assertThat(variableResult).isTrue();

      assertThat(variableResult).isTrue();
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
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
