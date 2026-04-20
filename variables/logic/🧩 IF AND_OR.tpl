___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "🧩 IF AND/OR",
  "description": "Applies AND if condition is \u003cem\u003etrue\u003c/em\u003e, OR if \u003cem\u003efalse\u003c/em\u003e.",
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
    "help": "Applies AND if condition is \u003cem\u003etrue\u003c/em\u003e, OR if \u003cem\u003efalse\u003c/em\u003e.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eAND all truthy\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003etest\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOR first truthy\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efirst truthy\u003c/strong\u003e"
  },
  {
    "type": "LABEL",
    "name": "h1_IF",
    "displayName": "____________________ \u003cbr\u003e \u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;🅸🅵\u0026nbsp;\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp; \u003cbr\u003e ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
  },
  {
    "type": "TEXT",
    "name": "con",
    "displayName": "Condition to decide which logic to apply",
    "simpleValueType": true,
    "help": "🔀 Applies \u003cstrong\u003eAND\u003c/strong\u003e if the condition is \u003cem\u003etrue\u003c/em\u003e, otherwise applies \u003cstrong\u003eOR\u003c/strong\u003e. \n\u003cbr\u003e\u003cbr\u003e\n↳ AND: Returns the first \u003cem\u003efalsy\u003c/em\u003e value found, or the last value if all are \u003cem\u003etruthy\u003c/em\u003e \u003cbr\u003e\u003cbr\u003e\n↳ OR: Returns the first \u003cem\u003etruthy\u003c/em\u003e value found or the last value if all are \u003cem\u003efalsy\u003c/em\u003e."
  },
  {
    "type": "LABEL",
    "name": "h1_AND/OR",
    "displayName": "____________________\n\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;🅰🅽🅳 / 🅾🆁\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp; \n\u003cbr\u003e\n‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
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
 * Evaluates conditions using dynamic logic selection based on a flag.
 * Switches between AND logic (true) and OR logic (false).
 *
 * @param {boolean} useAnd - Flag to determine logic type (true = AND, false = OR)
 * @param {Array<Object>} ls1 - Array of value objects to evaluate
 * @param {*} ls1[].val - Value to evaluate in the logic operation
 *
 * @returns {*} Result based on AND or OR logic.
 *
 * @framework ggLowCodeGTMKit
 */
const ifAndOr = function(useAnd, ls1) {
    if (useAnd) {
        // AND Logic: all must be truthy
        let lastValue;
        for (let i = 0; i < ls1.length; i++) {
            const item = ls1[i];
            if (!item) {
                return false;
            }
            const value = item.val;
            if (!value) {
                return value;
            }
            lastValue = value;
        }
        return lastValue;
    } else {
        // OR Logic: first truthy wins
        for (let i = 0; i < ls1.length; i++) {
            const item = ls1[i];
            if (!item) {
                continue;
            }
            const value = item.val;
            if (value) {
                return value;
            }
        }
        return false;
    }
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// ifAndOr - Direct mode
// ===============================================================================
return out(ifAndOr(!!data.con, data.ls1 || []));


___TESTS___

scenarios:
  - name: '[example] AND all truthy'
    code: |-
      /* @display
      Condition to decide which logic to apply: true
      Values To Test: [{val: 'hello'}, {val: 'world'},{val: 'test'}]
      @output
      test
      */
      const con = true;
      const ls1 = [
          {val: 'hello'},
          {val: 'world'},
          {val: 'test'}
      ];
      const mockData = {
          con: con,
          ls1: ls1,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('test');
  - name: AND logic - one falsy value, returns first falsy
    code: |
      const con = true;
      const ls1 = [
          {val: 'hello'},
          {val: 0},
          {val: 'world'}
      ];
      const mockData = {
          con: con,
          ls1: ls1,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(0);
  - name: '[example] OR first truthy'
    code: |-
      /* @display
      Condition to decide which logic to apply: false
      Values To Test: [{val: false}, {val: 'first truthy'}, {val: 'second truthy'}]
      @output
      first truthy
      */
      const con = false;
      const ls1 = [
          {val: false},
          {val: 'first truthy'},
          {val: 'second truthy'}
      ];
      const mockData = {
          con: con,
          ls1: ls1,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('first truthy');
  - name: OR logic - all values are falsy, returns false
    code: |-
      const con = false;
      const ls1 = [
          {val: false},
          {val: 0},
          {val: null},
          {val: ''}
      ];
      const mockData = {
          con: con,
          ls1: ls1,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isFalse();
  - name: AND logic with output function
    code: |-
      const con = true;
      const ls1 = [
          {val: 'hello'},
          {val: 'world'}
      ];
      const out = function(val) { return val.toUpperCase(); };
      const mockData = {
          con: con,
          ls1: ls1,
          out: out
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('WORLD');


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
