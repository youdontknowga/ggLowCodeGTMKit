___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "🧩 IF (else)",
  "description": "Returns one of two values based on a \u003cem\u003eboolean\u003c/em\u003e condition flag.",
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
    "help": "Returns one of two values based on a \u003cem\u003eboolean\u003c/em\u003e condition flag.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTrue condition returns value\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eCondition: true\u003cbr\u003eOutput: success\u003cbr\u003edef: failure\u003cbr\u003eael: true\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003esuccess\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFalse returns default\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eCondition: false\u003cbr\u003eOutput: success\u003cbr\u003edef: failure\u003cbr\u003eael: true\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efailure\u003c/strong\u003e"
  },
  {
    "type": "LABEL",
    "name": "h1_IF",
    "displayName": "____________________ \u003cbr\u003e \u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;🅸🅵\u0026nbsp;\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;  \u003cbr\u003e ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
  },
  {
    "type": "TEXT",
    "name": "con",
    "displayName": "Condition",
    "simpleValueType": true
  },
  {
    "type": "LABEL",
    "name": "h1_THEN",
    "displayName": "____________________\n\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;🆃🅷🅴🅽\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\n\u003cbr\u003e\n‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
  },
  {
    "type": "TEXT",
    "name": "res",
    "displayName": "Output",
    "simpleValueType": true
  },
  {
    "type": "CHECKBOX",
    "name": "ael",
    "checkboxText": "Add ELSE logic",
    "simpleValueType": true
  },
  {
    "type": "LABEL",
    "name": "h1_ELSE",
    "displayName": "____________________ \u003cbr\u003e \u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp\u0026nbsp🅴🅻🆂🅴\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp; \u003cbr\u003e ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾",
    "enablingConditions": [
      {
        "paramName": "ael",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  },
  {
    "displayName": "Default Output",
    "simpleValueType": true,
    "name": "def",
    "type": "TEXT",
    "help": "The value to return if none of the rules evaluate to true. Defaults to \u003cem\u003eundefined\u003c/em\u003e.",
    "enablingConditions": [
      {
        "paramName": "ael",
        "paramValue": true,
        "type": "EQUALS"
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
 * Evaluates a condition and returns one of two values (ternary operator).
 * Returns result value if condition is true, or default value if false.
 *
 * @param {*} con - Condition to evaluate for truthiness.
 * @param {*} res - Value to return when condition is true.
 * @param {boolean} ael - Whether to use def value when condition is false (add else).
 * @param {*} def - Value to return when condition is false (if ael is true).
 *
 * @returns {*} res value if condition is true, or def value (if ael is true) or undefined if false.
 *
 * @framework ggLowCodeGTMKit
 */
const ifElse = function(con, res, ael, def) {
	const condition = !!con;
	const output = ael ? def : undefined;
	return condition ? res : output;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// ifElse - Direct mode
// ===============================================================================
return out(ifElse(data.con, data.res, data.ael, data.def));


___TESTS___

scenarios:
  - name: '[example] True condition returns value'
    code: |-
      /* @display
      Condition: true
      Output: success
      Default Output: failure
      @output
      success
      */
      const con = true;
      const res = 'success';
      const def = 'failure';
      const ael = true;
      const mockData = {
          con: con,
          res: res,
          def: def,
          ael: ael,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('success');
  - name: '[example] False returns default'
    code: |-
      /* @display
      Condition: false
      Output: success
      Default Output: failure
      @output
      failure
      */
      const con = false;
      const res = 'success';
      const def = 'failure';
      const ael = true;
      const mockData = {
          con: con,
          res: res,
          def: def,
          ael: ael,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('failure');
  - name: Test condition false with ael false returns undefined
    code: |-
      const con = false;
      const res = 'success';
      const def = 'failure';
      const ael = false;
      const mockData = {
          con: con,
          res: res,
          def: def,
          ael: ael,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isUndefined();
  - name: Test truthy value as condition
    code: |-
      const con = 'hello';
      const res = 100;
      const def = 0;
      const ael = true;
      const mockData = {
          con: con,
          res: res,
          def: def,
          ael: ael,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(100);
  - name: Test falsy value as condition with default
    code: |-
      const con = 0;
      const res = 'result';
      const def = 'default';
      const ael = true;
      const mockData = {
          con: con,
          res: res,
          def: def,
          ael: ael,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('default');


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
