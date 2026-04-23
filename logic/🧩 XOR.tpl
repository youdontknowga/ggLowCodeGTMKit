___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "🧩 XOR",
  "description": "Checks the provided list of parameters and returns the single \u003cem\u003etruthy\u003c/em\u003e value if exactly one is found, \u003cem\u003efalse\u003c/em\u003e otherwise, mimicking the logical XOR operator.",
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
    "help": "Checks the provided list of parameters and returns the single \u003cem\u003etruthy\u003c/em\u003e value if exactly one is found, \u003cem\u003efalse\u003c/em\u003e otherwise, mimicking the logical XOR operator.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOne truthy returns value\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eonly truthy\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTwo truthy returns false\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
  },
  {
    "type": "LABEL",
    "name": "h1_XOR",
    "displayName": "____________________\n\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;🆇🅾🆁\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp; \n\u003cbr\u003e\n‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "ls1",
    "displayName": "Values To Test (Return unique truthy or false)",
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
 * Returns the single truthy value if exactly one is found, false otherwise
 * (XOR logic - exactly one must be true)
 *
 * @param {Array<Object>} ls1 - List of parameter objects to evaluate.
 * @param {*} ls1[].val - Value to evaluate in the XOR logic
 *
 * @returns {*} Single truthy value if exactly one is found, false otherwise
 *
 * @framework ggLowCodeGTMKit
 */
const xor = function(ls1) {
	let foundValue = null;
	let foundCount = 0;
	for (const parameter of ls1) {
		if (!parameter) continue;
		if (parameter.val) {
			foundCount++;
			if (foundCount === 1) {
				foundValue = parameter.val;
			} else {
				return false;
			}
		}
	}
	return foundCount === 1 ? foundValue : false;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const out = safeFunction(data.out);
// ===============================================================================
// xor - Direct mode
// ===============================================================================
const values = (data.ls1 || []).map(item => item ? {val: applyCast(data.pre, item.val)} : item);
return out(xor(values));


___TESTS___

scenarios:
  - name: '[example] One truthy returns value'
    code: |-
      /* @display
      Values to test: [
          {val: false},
          {val: 0},
          {val: 'only truthy'},
          {val: ''},
          {val: null}
      ]
      @output
      only truthy
      */
      const ls1 = [
          {val: false},
          {val: 0},
          {val: 'only truthy'},
          {val: ''},
          {val: null}
      ];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('only truthy');
  - name: '[example] Two truthy returns false'
    code: |
      /* @display
      Values to test: [
          {val: 'first'},
          {val: false},
          {val: 'second'}
      ]
      @output
      false
      */
      const ls1 = [
          {val: 'first'},
          {val: false},
          {val: 'second'}
      ];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isFalse();
  - name: Test all falsy values returns false
    code: |-
      const ls1 = [
          {val: false},
          {val: 0},
          {val: ''},
          {val: null}
      ];
      const mockData = {
          ls1: ls1,
          pre: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isFalse();
  - name: Test with pre function where exactly one passes
    code: |-
      const ls1 = [
          {val: 5},
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
  - name: Test with pre function where multiple pass returns false
    code: |-
      const ls1 = [
          {val: 12},
          {val: 15},
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
