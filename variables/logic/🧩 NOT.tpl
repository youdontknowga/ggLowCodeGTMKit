___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "🧩 NOT",
  "description": "Checks the provided list of parameters and returns \u003cem\u003etrue\u003c/em\u003e if all values are \u003cem\u003efalsy\u003c/em\u003e, \u003cem\u003efalse\u003c/em\u003e otherwise.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "description",
    "displayName": "𝘋𝘦𝘴𝘤𝘳𝘪𝘱𝘵𝘪𝘰𝘯",
    "groupStyle": "NO_ZIPPY",
    "subParams": [],
    "help": "Checks the provided list of parameters and returns \u003cem\u003etrue\u003c/em\u003e if all values are \u003cem\u003efalsy\u003c/em\u003e, \u003cem\u003efalse\u003c/em\u003e otherwise.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAll falsy returns true\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOne truthy returns false\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
  },
  {
    "type": "LABEL",
    "name": "h1_NOT",
    "displayName": "____________________\n\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;🅽🅾🆃\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp; \n\u003cbr\u003e\n‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "ls1",
    "displayName": "Values To Test",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "Value",
        "name": "val",
        "type": "TEXT"
      }
    ]
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
        "help": "Optional pre-processing function applied to each value before internal logic (e.g., convert object to string, normalize case). Internal transformations such as case handling will still apply afterward."
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
        "help": "Optional function to apply to the result before returning it (e.g., `str \u003d\u003e str + \u0027 €\u0027`). Useful for chaining transformations on the output."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Returns `false` as soon as a truthy value is found in the list.
 * Returns *`true`* only if **all values** are falsy.
 *
 * @param {Array<Object>} ls1 - List of parameter objects to evaluate.
 * @param {*} ls1[].val - Value to evaluate for truthiness
 *
 * @returns {boolean} `false` if any value is truthy, `true` if all are falsy.
 *
 * @framework ggLowCodeGTMKit
 */
const not = function(ls1) {
	for (const parameter of ls1) {
		if (!parameter) {
			continue;
		}
		if (!!parameter.val) {
			return false;
		}
	}
	return true;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const out = safeFunction(data.out);
// ===============================================================================
// not - Direct mode
// ===============================================================================
const values = (data.ls1 || []).map(item => item ? {val: applyCast(data.pre, item.val)} : item);
return out(not(values));


___TESTS___

scenarios:
  - name: '[example] All falsy returns true'
    code: |-
      /* @display
      Values To Test: [
          {val: false},
          {val: 0},
          {val: ''},
          {val: null},
          {val: undefined}
      ]
      @output
      true
      */
      const ls1 = [
          {val: false},
          {val: 0},
          {val: ''},
          {val: null},
          {val: undefined}
      ];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isTrue();
  - name: '[example] One truthy returns false'
    code: |-
      /* @display
      Values To Test: [
          {val: false},
          {val: 0},
          {val: 'hello'},
          {val: null}
      ]
      @output
      false
      */
      const ls1 = [
          {val: false},
          {val: 0},
          {val: 'hello'},
          {val: null}
      ];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isFalse();
  - name: Test first value truthy returns false immediately
    code: |-
      const ls1 = [
          {val: true},
          {val: false},
          {val: false}
      ];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isFalse();
  - name: Test empty list returns true
    code: |-
      const ls1 = [];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isTrue();
  - name: Test with null/undefined items skipped
    code: |-
      const ls1 = [
          null,
          undefined,
          {val: false},
          {val: 0}
      ];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isTrue();
  - name: Test with pre function that transforms values
    code: |-
      const ls1 = [
          {val: 5},
          {val: 3},
          {val: 2}
      ];
      const mockData = {
          ls1: ls1,
          pre: function(val) { return val > 10; },
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isTrue();


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
