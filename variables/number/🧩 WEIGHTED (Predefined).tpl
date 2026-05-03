___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "🧩 WEIGHTED (Predefined)",
  "description": "Each condition contributes a score when its rule evaluates to true. The final result is \u003cem\u003etrue\u003c/em\u003e if the total score meets or exceeds the threshold.",
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
    "help": "Evaluates conditions using \u003cstrong\u003epredefined comparison operators\u003c/strong\u003e with weighted point scoring. Each matching condition contributes points to a total score. Returns \u003ccode\u003etrue\u003c/code\u003e if the total meets/exceeds the threshold, or the raw score if no threshold is set.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e📊 How it works:\u003c/strong\u003e\u003cbr\u003e• Each condition has a \u003cem\u003epoint value\u003c/em\u003e\u003cbr\u003e• All conditions are evaluated (not short-circuit like IF-ELSE-IF)\u003cbr\u003e• Matching conditions add their points to the total score\u003cbr\u003e• With threshold: Returns \u003ccode\u003etrue/false\u003c/code\u003e based on score vs threshold\u003cbr\u003e• Without threshold: Returns the total score as a number\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e🔧 Use this version when:\u003c/strong\u003e\u003cbr\u003e• You need to accumulate points from multiple conditions\u003cbr\u003e• You want to use built-in operators (equals, contains, regex, numeric)\u003cbr\u003e• You need automatic type conversion (string/numeric)\u003cbr\u003e\u003cbr\u003e💡 \u003cem\u003eFor custom scoring functions, use \"Weighted Score (Custom Functions)\" instead.\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e🔄 Automatic Type Conversions:\u003c/strong\u003e\u003cbr\u003e• \u003cstrong\u003eString operators\u003c/strong\u003e: All values converted to strings\u003cbr\u003e\u0026nbsp;\u0026nbsp;→ \u003ccode\u003enull\u003c/code\u003e → \u003ccode\u003e\"null\"\u003c/code\u003e, \u003ccode\u003etrue\u003c/code\u003e → \u003ccode\u003e\"true\"\u003c/code\u003e, \u003ccode\u003e123\u003c/code\u003e → \u003ccode\u003e\"123\"\u003c/code\u003e\u003cbr\u003e• \u003cstrong\u003eNumeric operators\u003c/strong\u003e: Strings converted to numbers\u003cbr\u003e\u0026nbsp;\u0026nbsp;→ \u003ccode\u003e\"10\"\u003c/code\u003e → \u003ccode\u003e10\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSingle condition score\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBelow threshold returns 0\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
  },
  {
    "type": "LABEL",
    "name": "h1_SUM OUT",
    "displayName": "____________________\n\u003cbr\u003e\n\u0026nbsp;\u0026nbsp;\u0026nbsp;🆂🆄🅼 🅾🆄🆃\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp; \n\u003cbr\u003e\n‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
  },
  {
    "type": "PARAM_TABLE",
    "name": "ls1",
    "displayName": "",
    "paramTableColumns": [
      {
        "param": {
          "type": "TEXT",
          "name": "val",
          "displayName": "Input Value",
          "simpleValueType": true,
          "help": "💾 The value to evaluate against the condition.\u003cbr\u003e\u003cbr\u003eCan be any type: string, number, boolean, null, undefined, or a GTM variable.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003e{{Page Path}}\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e{{Event Category}}\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003etrue\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e100\u003c/code\u003e"
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "SELECT",
          "name": "con",
          "displayName": "Condition",
          "macrosInSelect": false,
          "selectItems": [
            {
              "value": "eq",
              "displayValue": "equals"
            },
            {
              "value": "eqi",
              "displayValue": "equals (case insensitive)"
            },
            {
              "value": "neq",
              "displayValue": "does not equal"
            },
            {
              "value": "neqi",
              "displayValue": "does not equal (case insensitive)"
            },
            {
              "value": "ct",
              "displayValue": "contains"
            },
            {
              "value": "cti",
              "displayValue": "contains (case insensitive)"
            },
            {
              "value": "nct",
              "displayValue": "does not contain"
            },
            {
              "value": "ncti",
              "displayValue": "does not contain (case insensitive)"
            },
            {
              "value": "sw",
              "displayValue": "starts with"
            },
            {
              "value": "swi",
              "displayValue": "starts with (case insensitive)"
            },
            {
              "value": "nsw",
              "displayValue": "does not start with"
            },
            {
              "value": "nswi",
              "displayValue": "does not start with (case insensitive)"
            },
            {
              "value": "ew",
              "displayValue": "ends with"
            },
            {
              "value": "ewi",
              "displayValue": "ends with (case insensitive)"
            },
            {
              "value": "new",
              "displayValue": "does not end with"
            },
            {
              "value": "newi",
              "displayValue": "does not end with (case insensitive)"
            },
            {
              "value": "re",
              "displayValue": "matches RegEx"
            },
            {
              "value": "rei",
              "displayValue": "matches RegEx (case insensitive)"
            },
            {
              "value": "nre",
              "displayValue": "does not match RegEx"
            },
            {
              "value": "nrei",
              "displayValue": "does not match RegEx (case insensitive)"
            },
            {
              "value": "xlt",
              "displayValue": "less than"
            },
            {
              "value": "nxlt",
              "displayValue": "greater than or equal to"
            },
            {
              "value": "xlte",
              "displayValue": "less than or equal to"
            },
            {
              "value": "nxlte",
              "displayValue": "greater than"
            }
          ],
          "simpleValueType": true,
          "help": "🔍 The comparison operation to perform.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e📝 String Operators:\u003c/strong\u003e (values converted to strings)\u003cbr\u003e• \u003ccode\u003eequals\u003c/code\u003e / \u003ccode\u003edoes not equal\u003c/code\u003e: Exact match\u003cbr\u003e• \u003ccode\u003econtains\u003c/code\u003e / \u003ccode\u003edoes not contain\u003c/code\u003e: Substring search\u003cbr\u003e• \u003ccode\u003estarts with\u003c/code\u003e / \u003ccode\u003edoes not start with\u003c/code\u003e: Prefix match\u003cbr\u003e• \u003ccode\u003eends with\u003c/code\u003e / \u003ccode\u003edoes not end with\u003c/code\u003e: Suffix match\u003cbr\u003e• Add \u003ccode\u003e(case insensitive)\u003c/code\u003e for case-insensitive matching\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e🔢 Numeric Operators:\u003c/strong\u003e (strings converted to numbers)\u003cbr\u003e• \u003ccode\u003eless than\u003c/code\u003e: \u003ccode\u003e\u0026lt;\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003eless than or equal to\u003c/code\u003e: \u003ccode\u003e\u0026lt;\u003d\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003egreater than or equal to\u003c/code\u003e: \u003ccode\u003e\u0026gt;\u003d\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003egreater than\u003c/code\u003e: \u003ccode\u003e\u0026gt;\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e🎯 RegEx Operators:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003ematches RegEx\u003c/code\u003e: Pattern matching\u003cbr\u003e• \u003ccode\u003ematches RegEx (case insensitive)\u003c/code\u003e: Case-insensitive patterns\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003e\\d+\u003c/code\u003e → matches digits\u003cbr\u003e• \u003ccode\u003e^/products/\u003c/code\u003e → starts with path\u003cbr\u003e• \u003ccode\u003eutm_(source|medium)\u003c/code\u003e → matches UTM params"
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "TEXT",
          "name": "ref",
          "displayName": "Reference Value",
          "simpleValueType": true,
          "help": "💾 The value to compare against.\u003cbr\u003e\u003cbr\u003eCan be a literal value, GTM variable, or regex pattern.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• String: \u003ccode\u003e/checkout\u003c/code\u003e\u003cbr\u003e• Number: \u003ccode\u003e100\u003c/code\u003e\u003cbr\u003e• RegEx: \u003ccode\u003e\\d{2,4}\u003c/code\u003e\u003cbr\u003e• Variable: \u003ccode\u003e{{Product Price}}\u003c/code\u003e"
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "TEXT",
          "name": "pts",
          "displayName": "Points",
          "simpleValueType": true,
          "help": "🎯 Points awarded if this condition evaluates to \u003ccode\u003etrue\u003c/code\u003e.\u003cbr\u003e\u003cbr\u003eCan be positive or negative numbers.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003e10\u003c/code\u003e → Add 10 points\u003cbr\u003e• \u003ccode\u003e-5\u003c/code\u003e → Subtract 5 points\u003cbr\u003e• \u003ccode\u003e{{Dynamic Points}}\u003c/code\u003e → Use variable"
        },
        "isUnique": false
      }
    ],
    "newRowTitle": "New Weighted Condition",
    "newRowButtonText": "+ WEIGHTED CONDITION",
    "editRowTitle": "Edit Condition",
    "help": "💡 \u003cstrong\u003eTips:\u003c/strong\u003e\u003cbr\u003e• All conditions are evaluated (unlike IF-ELSE-IF)\u003cbr\u003e• Use positive points for desired matches, negative for penalties\u003cbr\u003e• Combine different operator types for sophisticated scoring"
  },
  {
    "type": "GROUP",
    "name": "opt",
    "displayName": "Threshold Settings",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "eth",
        "checkboxText": "Define Threshold Score",
        "simpleValueType": true,
        "help": "Enable to return \u003ccode\u003etrue/false\u003c/code\u003e based on whether the total score meets the threshold. If disabled, returns the raw total score as a number."
      },
      {
        "type": "TEXT",
        "name": "thr",
        "displayName": "Threshold Score",
        "simpleValueType": true,
        "help": "Minimum total score required to return \u003ccode\u003etrue\u003c/code\u003e. If total score is below this value, returns \u003ccode\u003efalse\u003c/code\u003e.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExample:\u003c/strong\u003e\u003cbr\u003e• Threshold: \u003ccode\u003e50\u003c/code\u003e\u003cbr\u003e• Total Score: \u003ccode\u003e65\u003c/code\u003e → Returns \u003ccode\u003etrue\u003c/code\u003e\u003cbr\u003e• Total Score: \u003ccode\u003e30\u003c/code\u003e → Returns \u003ccode\u003efalse\u003c/code\u003e",
        "enablingConditions": [
          {
            "paramName": "eth",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
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
        "help": "⚙️ Optional function to transform the final result before returning it.\u003cbr\u003e\u003cbr\u003eApplied to the boolean (if threshold set) or numeric score (if no threshold).\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003escore \u003d\u003e score * 2\u003c/code\u003e → Double the score\u003cbr\u003e• \u003ccode\u003ebool \u003d\u003e bool ? \u0027Pass\u0027 : \u0027Fail\u0027\u003c/code\u003e → Convert to text\u003cbr\u003e• \u003ccode\u003eval \u003d\u003e Math.round(val)\u003c/code\u003e → Round score"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Evaluates conditions using weighted point scoring system with predefined operators.
 * Each condition has a point value, returns true if total score meets threshold.
 *
 * @param {Array<Object>} ls1 - List of condition objects with points.
 * @param {number} thr - Minimum score required to return true.
 * @param {boolean} eth - Whether threshold is enabled.
 *
 * @returns {boolean|number} True/false if threshold provided, or total score if no threshold.
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');

const weighted = function(ls1, thr, eth) {
    const toStr = function(val) {
        if (val === null) return 'null';
        if (val === undefined) return 'undefined';
        return typeof val === 'string' ? val : val.toString();
    };

    const toLower = function(str) { return str.toLowerCase(); };

    const convertToNumber = function(value) {
        if (typeof value === 'number') return value;
        if (typeof value !== 'string') return value;
        const num = makeNumber(value);
        return (typeof num === 'number' && num === num) ? num : value;
    };

    const ruleMethods = {
        eq: function(val, ref) { return val == ref; },
        ct: function(val, ref) { return val.indexOf(ref) > -1; },
        sw: function(val, ref) { return val.substring(0, ref.length) === ref; },
        ew: function(val, ref) { return val.substring(val.length - ref.length) === ref; },
        re: function(val, ref) { return val.search(ref) !== -1; },
        xlt: function(val, ref) { return val < ref; },
        xlte: function(val, ref) { return val <= ref; }
    };

    const evaluateCondition = function(cond) {
        if (!cond) return false;

        const condKey = cond.con || '';
        if (condKey.length === 0) return false;

        const firstChar = condKey[0];
        const lastChar = condKey[condKey.length - 1];

        const isNegated = firstChar === 'n' && condKey.length > 1;
        const isInsensitive = lastChar === 'i' && condKey.length > 1;

        const baseStart = isNegated ? 1 : 0;
        const baseEnd = isInsensitive ? condKey.length - 1 : condKey.length;
        const baseCondition = condKey.substring(baseStart, baseEnd);

        const ruleFn = ruleMethods[baseCondition];
        if (!ruleFn) return false;

        var val = cond.val;
        var ref = cond.ref;

        const isNumericRule = baseCondition[0] === 'x';

        if (isNumericRule) {
            val = convertToNumber(val);
            ref = convertToNumber(ref);
        } else {
            val = toStr(val);
            ref = toStr(ref);

            if (isInsensitive) {
                val = toLower(val);
                ref = toLower(ref);
            }
        }

        const result = ruleFn(val, ref);
        return isNegated ? !result : result;
    };

    // Weighted scoring evaluation
    const conditions = ls1 || [];
    const threshold = makeNumber(thr);
    var totalScore = 0;

    for (var i = 0; i < conditions.length; i++) {
        var item = conditions[i];
        if (!item) continue;

        // Support both nested {condition: {val, con, ref}, pts} and flat {val, con, ref, pts}
        var cond = item.condition || item;
        if (!cond.con) continue;

        const pointsValue = makeNumber(item.pts);
        const points = (typeof pointsValue === 'number' && pointsValue === pointsValue) ? pointsValue : 0;

        if (evaluateCondition(cond)) {
            totalScore += points;
        }
    }

    return (eth && typeof threshold === 'number' && threshold === threshold) ? totalScore >= threshold : totalScore;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// weighted - Direct mode
// ===============================================================================
return out(weighted(data.ls1, data.thr, data.eth));


___TESTS___

scenarios:
  - name: '[example] Single condition score'
    code: |-
      /* @display
      Conditions: [
          {
            "Input Value": "hello",
            "Condition": "eq",
            "Reference Value": "hello",
            "Points": "10"
          }
      ]

      Threshold Score: undefined
      @output
      10
      */
      const ls1 = [
          {condition: {val: 'hello', con: 'eq', ref: 'hello'}, pts: '10'}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(10);
  - name: With threshold - score meets threshold
    code: |-
      const ls1 = [
          {condition: {val: 'hello', con: 'eq', ref: 'hello'}, pts: 10},
          {condition: {val: 'world', con: 'eq', ref: 'world'}, pts: 5}
      ];
      const mockData = {
          ls1: ls1,
          thr: 12,
          eth: true,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isTrue();
  - name: '[example] Below threshold returns 0'
    code: |-
      /* @display
      Conditions: [
          {
            "Input Value": "hello",
            "Condition": "eq",
            "Reference Value": "goodbye",
            "Points": "10"
          },
          {
            "Input Value": "world",
            "Condition": "eq",
            "Reference Value": "world",
            "Points": "5"
          }
      ]
      Threshold Score: 10
      @output
      false
      */
      const ls1 = [
          {condition: {val: 'hello', con: 'eq', ref: 'goodbye'}, pts: 10},
          {condition: {val: 'world', con: 'eq', ref: 'world'}, pts: 5}
      ];
      const mockData = {
          ls1: ls1,
          thr: 10,
          eth: true,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isFalse();
  - name: Points as strings
    code: |-
      const ls1 = [
          {condition: {val: 'test', con: 'eq', ref: 'test'}, pts: '10'},
          {condition: {val: 'match', con: 'eq', ref: 'match'}, pts: '25'}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(35);
  - name: Negative points
    code: |-
      const ls1 = [
          {condition: {val: 'good', con: 'eq', ref: 'good'}, pts: 20},
          {condition: {val: 'bad', con: 'eq', ref: 'bad'}, pts: -10}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(10);
  - name: Contains operator
    code: |
      const ls1 = [
          {condition: {val: 'hello world', con: 'ct', ref: 'world'}, pts: 5},
          {condition: {val: 'test string', con: 'ct', ref: 'xyz'}, pts: 3}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(5);
  - name: Case insensitive equals
    code: |-
      const ls1 = [
          {condition: {val: 'Hello', con: 'eqi', ref: 'HELLO'}, pts: 10},
          {condition: {val: 'World', con: 'eqi', ref: 'earth'}, pts: 5}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(10);
  - name: Negation - not contains
    code: |-
      const ls1 = [
          {condition: {val: 'hello', con: 'nct', ref: 'world'}, pts: 8},
          {condition: {val: 'test', con: 'nct', ref: 'test'}, pts: 3}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(8);
  - name: Starts with case insensitive
    code: |-
      const ls1 = [
          {condition: {val: '/Products/shoes', con: 'swi', ref: '/products'}, pts: 15}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(15);
  - name: Ends with
    code: |-
      const ls1 = [
          {condition: {val: 'document.pdf', con: 'ew', ref: '.pdf'}, pts: 10},
          {condition: {val: 'image.jpg', con: 'ew', ref: '.pdf'}, pts: 5}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(10);
  - name: Regex match
    code: |-
      const ls1 = [
          {condition: {val: 'Price: $19.99', con: 're', ref: '\\d+'}, pts: 12}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(12);
  - name: Numeric less than
    code: |-
      const ls1 = [
          {condition: {val: '5', con: 'xlt', ref: '10'}, pts: 10},
          {condition: {val: '15', con: 'xlt', ref: '10'}, pts: 5}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(10);
  - name: Numeric not less than (greater or equal)
    code: |-
      const ls1 = [
          {condition: {val: '15', con: 'nxlt', ref: '10'}, pts: 20},
          {condition: {val: '10', con: 'nxlt', ref: '10'}, pts: 5}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(25);
  - name: Numeric less than or equal
    code: |-
      const ls1 = [
          {condition: {val: '10', con: 'xlte', ref: '10'}, pts: 8},
          {condition: {val: '9', con: 'xlte', ref: '10'}, pts: 4}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(12);
  - name: All conditions fail - zero score
    code: |-
      const ls1 = [
          {condition: {val: 'test', con: 'eq', ref: 'fail'}, pts: 10},
          {condition: {val: 'hello', con: 'eq', ref: 'goodbye'}, pts: 5}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(0);
  - name: null becomes string null for string comparison
    code: |-
      const ls1 = [
          {condition: {val: null, con: 'eq', ref: 'null'}, pts: 10}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(10);
  - name: undefined becomes string undefined
    code: |-
      const ls1 = [
          {condition: {val: undefined, con: 'ct', ref: 'def'}, pts: 7}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(7);
  - name: boolean true becomes string true
    code: |-
      const ls1 = [
          {condition: {val: true, con: 'eq', ref: 'true'}, pts: 12}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(12);
  - name: boolean false becomes string false
    code: |
      const ls1 = [
          {condition: {val: false, con: 'sw', ref: 'fal'}, pts: 8}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(8);
  - name: number becomes string
    code: |-
      const ls1 = [
          {condition: {val: 123, con: 'ct', ref: '23'}, pts: 6}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(6);
  - name: Invalid points (non-numeric string) defaults to 0
    code: |
      const ls1 = [
          {condition: {val: 'test', con: 'eq', ref: 'test'}, pts: 'abc'},
          {condition: {val: 'hello', con: 'eq', ref: 'hello'}, pts: '10'}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(10);
  - name: Invalid condition (empty operator) skipped
    code: |-
      const ls1 = [
          {condition: {val: 'test', con: '', ref: 'test'}, pts: 10},
          {condition: {val: 'valid', con: 'eq', ref: 'valid'}, pts: 5}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(5);
  - name: With output function (double the score)
    code: |
      const ls1 = [
          {condition: {val: 'test', con: 'eq', ref: 'test'}, pts: 10},
          {condition: {val: 'hello', con: 'eq', ref: 'hello'}, pts: 5}
      ];
      const out = function(val) { return val * 2; };
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: out
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(30);
  - name: With output function and threshold
    code: |-
      const ls1 = [
          {condition: {val: 'test', con: 'eq', ref: 'test'}, pts: 10},
          {condition: {val: 'hello', con: 'eq', ref: 'hello'}, pts: 5}
      ];
      const out = function(val) { return val ? 'Pass' : 'Fail'; };
      const mockData = {
          ls1: ls1,
          thr: 12,
          eth: true,
          out: out
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Pass');
  - name: Threshold exactly equals score
    code: |-
      const ls1 = [
          {condition: {val: 'test', con: 'eq', ref: 'test'}, pts: 10}
      ];
      const mockData = {
          ls1: ls1,
          thr: 10,
          eth: true,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isTrue();
  - name: Complex scenario - mix of operators and conversions
    code: |
      const ls1 = [
          {condition: {val: true, con: 'cti', ref: 'TRUE'}, pts: 5},
          {condition: {val: '100', con: 'xlt', ref: 200}, pts: 10},
          {condition: {val: null, con: 'ncti', ref: 'test'}, pts: 3},
          {condition: {val: 'path/file.pdf', con: 'ewi', ref: '.PDF'}, pts: 7}
      ];
      const mockData = {
          ls1: ls1,
          thr: 20,
          eth: true,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isTrue();
  - name: Negative total score with threshold
    code: |
      const ls1 = [
          {condition: {val: 'bad', con: 'eq', ref: 'bad'}, pts: -10},
          {condition: {val: 'worse', con: 'eq', ref: 'worse'}, pts: -5}
      ];
      const mockData = {
          ls1: ls1,
          thr: 0,
          eth: true,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isFalse();
  - name: Reference value stringification
    code: |-
      const ls1 = [
          {condition: {val: 'true', con: 'eq', ref: true}, pts: 10},
          {condition: {val: '123', con: 'eq', ref: 123}, pts: 5}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(15);


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
