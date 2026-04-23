___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "🧩 AND",
  "description": "Checks the provided list of parameters and returns the first \u003cem\u003efalsy\u003c/em\u003e value it encounters. If all values are \u003cem\u003etruthy\u003c/em\u003e, it returns the last \u003cem\u003etruthy\u003c/em\u003e value, mimicking the logical AND",
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
    "help": "Checks the provided list of parameters and returns the first \u003cem\u003efalsy\u003c/em\u003e value it encounters. If all values are \u003cem\u003etruthy\u003c/em\u003e, it returns the last \u003cem\u003etruthy\u003c/em\u003e value, mimicking the logical AND (\u003cem\u003e\u0026\u0026\u003c/em\u003e) operator.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAll truthy returns last\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003elast\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFirst falsy returned\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0\u003c/strong\u003e"
  },
  {
    "type": "LABEL",
    "name": "h1_AND",
    "displayName": "____________________\n\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;🅰🅽🅳\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp; \n\u003cbr\u003e\n‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "ls1",
    "displayName": "Values To Test (Return last)",
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
 * Returns the first **falsy** value found, or the **last value** if all are truthy 
 * (mimics && behavior exactly).
 *
 * @param {Array<Object>} ls1 - List of parameter objects to evaluate.
 * @param {*} ls1[].val - Value to evaluate in the logical AND chain
 *
 * @returns {*} First falsy value found, or last value if no falsy found.
 *
 * @framework ggLowCodeGTMKit
 */
const and = function(ls1) {
	let lastValue;
	for (const parameter of ls1) {
		if (!parameter) {
			return false;
		}
		if (!parameter.val) {
			return parameter.val;
		}
		lastValue = parameter.val;
	}
	return lastValue;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const out = safeFunction(data.out);
// ===============================================================================
// and - Direct mode
// ===============================================================================
const values = (data.ls1 || []).map(item => ({val: applyCast(data.pre, item ? item.val : undefined)}));
return out(and(values));


___TESTS___

scenarios:
  - name: '[example] All truthy returns last'
    code: |-
      /* @display
      Values To Test : [ {val: true}, {val: 'hello'}, {val: 42}, {val: 'last'}]
      @output
      last
      */
      const ls1 = [ {val: true}, {val: 'hello'}, {val: 42},{val: 'last'}];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('last');
  - name: '[example] First falsy returned'
    code: |
      /* @display
      Values To Test : [{val: true}, {val: 0}, {val: 'hello'}, {val: 'last'}]
      @output
      0
      */
      const ls1 = [
          {val: true},
          {val: 0},
          {val: 'hello'},
          {val: 'last'}
      ];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(0);
  - name: Test empty string is falsy and returned
    code: |
      const ls1 = [
          {val: 'first'},
          {val: ''},
          {val: 'last'}
      ];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('');
  - name: Test with pre function that transforms values
    code: |-
      const ls1 = [
          {val: 10},
          {val: 20},
          {val: 30}
      ];
      const mockData = {
          ls1: ls1,
          pre: function(val) { return val > 5; },
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isTrue();
  - name: Test with pre function that makes one value falsy
    code: |-
      const ls1 = [
          {val: 10},
          {val: 3},
          {val: 30}
      ];
      const mockData = {
          ls1: ls1,
          pre: function(val) { return val > 5; },
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
