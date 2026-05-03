___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "🧩 OR",
  "description": "Checks a list of parameters and returns the first \u003cem\u003etruthy\u003c/em\u003e value. If no \u003cem\u003etruthy\u003c/em\u003e value is found, it returns \u003cem\u003efalse\u003c/em\u003e, mimicking the logical OR (\u003cem\u003e||\u003c/em\u003e) operator.",
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
    "help": "Checks a list of parameters and returns the first \u003cem\u003etruthy\u003c/em\u003e value. If no \u003cem\u003etruthy\u003c/em\u003e value is found, it returns \u003cem\u003efalse\u003c/em\u003e, mimicking the logical OR (\u003cem\u003e||\u003c/em\u003e) operator.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFirst truthy returned\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efirst truthy\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAll falsy returns false\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
  },
  {
    "type": "LABEL",
    "name": "h1_OR",
    "displayName": "____________________ \u003cbr\u003e \u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;🅾🆁\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;  \u003cbr\u003e ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "ls1",
    "displayName": "Values To Test (Return first truthy)",
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
 * Returns the first **truthy** `val` found in a list of parameter objects.
 *
 * @param {Array<Object>} ls1 - List of parameter objects to evaluate.
 * @param {*} ls1[].val - Value to evaluate for truthiness
 *
 * @returns {*} The first truthy value (`val`) found in the list, or `false` if none is found.
 *
 * @framework ggLowCodeGTMKit
 */
const or = function(ls1) {
	for (const parameter of ls1) {
		if (parameter && parameter.val) {
			return parameter.val;
		}
	}
	return false;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const out = safeFunction(data.out);
// ===============================================================================
// or - Direct mode
// ===============================================================================
const values = (data.ls1 || []).map(item => ({val: applyCast(data.pre, item ? item.val : undefined)}));
return out(or(values));


___TESTS___

scenarios:
  - name: '[example] First truthy returned'
    code: |-
      /* @display
      Values To Test: [
          {val: false},
          {val: 0},
          {val: 'first truthy'},
          {val: 'second truthy'}
      ]
      @output
      first truthy
      */
      const ls1 = [
          {val: false},
          {val: 0},
          {val: 'first truthy'},
          {val: 'second truthy'}
      ];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('first truthy');
  - name: '[example] All falsy returns false'
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
      false
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
      assertThat(variableResult).isFalse();
  - name: Test first value truthy returns immediately
    code: |-
      const ls1 = [
          {val: 'first'},
          {val: 'second'},
          {val: 'third'}
      ];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('first');
  - name: Test with pre function that transforms values
    code: |-
      const ls1 = [
          {val: 3},
          {val: 15},
          {val: 8}
      ];
      const mockData = {
          ls1: ls1,
          pre: function(val) { return val > 10 ? val : false; },
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(15);
  - name: Test with pre function where all values fail condition
    code: |-
      const ls1 = [
          {val: 3},
          {val: 5},
          {val: 8}
      ];
      const mockData = {
          ls1: ls1,
          pre: function(val) { return val > 10 ? val : false; },
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isFalse();


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
