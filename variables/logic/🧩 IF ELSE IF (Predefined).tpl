___INFO___

{
  "displayName": "🧩 IF ELSE IF (Predefined)",
  "description": "IF-ELSE-IF logic with predefined comparison operators (equals, contains, starts with, regex, numeric). Returns first match or default value.",
  "id": "cvt_T9HKB",
  "type": "MACRO",
  "version": 1,
  "containerContexts": [
    "WEB"
  ],
  "securityGroups": []
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "description",
    "displayName": "𝘋𝘦𝘴𝘤𝘳𝘪𝘱𝘵𝘪𝘰𝘯",
    "groupStyle": "NO_ZIPPY",
    "subParams": [],
    "help": "Evaluates conditions sequentially (IF → ELSE IF → ELSE IF → ... → ELSE) and returns the output value of the \u003cstrong\u003efirst matching condition\u003c/strong\u003e. If no conditions match, returns the default output.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e📋 How it works:\u003c/strong\u003e\u003cbr\u003e• Conditions are evaluated \u003cem\u003ein order from top to bottom\u003c/em\u003e\u003cbr\u003e• The \u003cem\u003efirst\u003c/em\u003e condition that evaluates to \u003ccode\u003etrue\u003c/code\u003e returns its output value\u003cbr\u003e• Remaining conditions are \u003cem\u003eskipped\u003c/em\u003e (short-circuit evaluation)\u003cbr\u003e• If \u003cem\u003eno conditions match\u003c/em\u003e, the default output is returned\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e🔄 Automatic Type Conversions:\u003c/strong\u003e\u003cbr\u003e• \u003cstrong\u003eString operators\u003c/strong\u003e (equals, contains, starts with, etc.): All values are converted to strings\u003cbr\u003e\u0026nbsp;\u0026nbsp;→ \u003ccode\u003enull\u003c/code\u003e becomes \u003ccode\u003e\"null\"\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;→ \u003ccode\u003eundefined\u003c/code\u003e becomes \u003ccode\u003e\"undefined\"\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;→ \u003ccode\u003etrue\u003c/code\u003e becomes \u003ccode\u003e\"true\"\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;→ \u003ccode\u003efalse\u003c/code\u003e becomes \u003ccode\u003e\"false\"\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;→ \u003ccode\u003e123\u003c/code\u003e becomes \u003ccode\u003e\"123\"\u003c/code\u003e\u003cbr\u003e• \u003cstrong\u003eNumeric operators\u003c/strong\u003e (less than, greater than, etc.): String numbers are converted to actual numbers\u003cbr\u003e\u0026nbsp;\u0026nbsp;→ \u003ccode\u003e\"10\"\u003c/code\u003e becomes \u003ccode\u003e10\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;→ Non-numeric strings remain unchanged\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEquals match\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eNo match\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eMatch 1\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns default\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eDefault value\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eDefault value\u003c/strong\u003e"
  },
  {
    "type": "LABEL",
    "name": "h1_IF ELSE",
    "displayName": "____________________ \u003cbr\u003e \u0026nbsp;\u0026nbsp;\u0026nbsp\u0026nbsp🅸🅵\u0026nbsp;🅴🅻🆂🅴\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;  \u003cbr\u003e ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
  },
  {
    "type": "PARAM_TABLE",
    "name": "cg1",
    "displayName": "Params Table",
    "paramTableColumns": [
      {
        "param": {
          "type": "TEXT",
          "name": "val",
          "displayName": "Input Value",
          "simpleValueType": true,
          "help": "💾 The value to evaluate against the condition.\u003cbr\u003e\u003cbr\u003eCan be any type: string, number, boolean, null, undefined, or a GTM variable.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003e{{Page Path}}\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e{{Click Text}}\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003etrue\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e123\u003c/code\u003e"
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "SELECT",
          "name": "con",
          "displayName": "Condition",
          "macrosInSelect": true,
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
          "help": "🔍 The comparison operation to perform.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e📝 String Operators:\u003c/strong\u003e (values converted to strings)\u003cbr\u003e• \u003ccode\u003eequals\u003c/code\u003e / \u003ccode\u003edoes not equal\u003c/code\u003e: Exact match\u003cbr\u003e• \u003ccode\u003econtains\u003c/code\u003e / \u003ccode\u003edoes not contain\u003c/code\u003e: Substring search\u003cbr\u003e• \u003ccode\u003estarts with\u003c/code\u003e / \u003ccode\u003edoes not start with\u003c/code\u003e: Prefix match\u003cbr\u003e• \u003ccode\u003eends with\u003c/code\u003e / \u003ccode\u003edoes not end with\u003c/code\u003e: Suffix match\u003cbr\u003e• Add \u003ccode\u003e(case insensitive)\u003c/code\u003e for case-insensitive matching\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e🔢 Numeric Operators:\u003c/strong\u003e (strings converted to numbers)\u003cbr\u003e• \u003ccode\u003eless than\u003c/code\u003e: \u003ccode\u003e\u0026lt;\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003eless than or equal to\u003c/code\u003e: \u003ccode\u003e\u0026lt;\u003d\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003egreater than or equal to\u003c/code\u003e: \u003ccode\u003e\u0026gt;\u003d\u003c/code\u003e (same as \"not less than\")\u003cbr\u003e• \u003ccode\u003egreater than\u003c/code\u003e: \u003ccode\u003e\u0026gt;\u003c/code\u003e (same as \"not less than or equal to\")\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e🎯 RegEx Operators:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003ematches RegEx\u003c/code\u003e: Pattern matching with regular expressions\u003cbr\u003e• \u003ccode\u003ematches RegEx (case insensitive)\u003c/code\u003e: Case-insensitive pattern matching\u003cbr\u003e• \u003ccode\u003edoes not match RegEx\u003c/code\u003e: Negation of regex match\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eRegEx Examples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003e\\d+\u003c/code\u003e → matches one or more digits\u003cbr\u003e• \u003ccode\u003e^/products/\u003c/code\u003e → starts with /products/\u003cbr\u003e• \u003ccode\u003e\\.pdf$\u003c/code\u003e → ends with .pdf\u003cbr\u003e• \u003ccode\u003eutm_(source|medium|campaign)\u003c/code\u003e → matches any of these UTM parameters\u003cbr\u003e\u003cbr\u003e⚠️ \u003cstrong\u003eEscaping in GTM:\u003c/strong\u003e Use single backslash in this field (e.g., \u003ccode\u003e\\d+\u003c/code\u003e). GTM handles the escaping automatically."
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "TEXT",
          "name": "ref",
          "displayName": "Reference Value",
          "simpleValueType": true,
          "help": "💾 The value to compare against.\u003cbr\u003e\u003cbr\u003eCan be a literal value, GTM variable, or regex pattern (for regex operators).\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• String: \u003ccode\u003e/checkout\u003c/code\u003e\u003cbr\u003e• Number: \u003ccode\u003e100\u003c/code\u003e\u003cbr\u003e• RegEx: \u003ccode\u003e\\d{2,4}\u003c/code\u003e\u003cbr\u003e• Variable: \u003ccode\u003e{{Some Variable}}\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eType Conversions:\u003c/strong\u003e\u003cbr\u003e• For \u003cem\u003estring operators\u003c/em\u003e: Converted to string automatically\u003cbr\u003e• For \u003cem\u003enumeric operators\u003c/em\u003e: Converted to number if possible\u003cbr\u003e• For \u003cem\u003eregex operators\u003c/em\u003e: Used as regex pattern"
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "TEXT",
          "name": "res",
          "displayName": "Output Value",
          "simpleValueType": true,
          "help": "📤 The value to return if this condition matches.\u003cbr\u003e\u003cbr\u003eThis value is returned \u003cem\u003eas-is\u003c/em\u003e without type conversion.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• String: \u003ccode\u003eHome Page\u003c/code\u003e\u003cbr\u003e• Number: \u003ccode\u003e1\u003c/code\u003e\u003cbr\u003e• Boolean: \u003ccode\u003etrue\u003c/code\u003e\u003cbr\u003e• Variable: \u003ccode\u003e{{Custom Value}}\u003c/code\u003e\u003cbr\u003e• Function call: \u003ccode\u003emyFunction()\u003c/code\u003e"
        },
        "isUnique": false
      }
    ],
    "newRowTitle": "New Condition",
    "newRowButtonText": "+ IF / ELSE IF",
    "editRowTitle": "Edit Condition",
    "help": "💡 \u003cstrong\u003eTips:\u003c/strong\u003e\u003cbr\u003e• Order matters! Conditions are checked from top to bottom\u003cbr\u003e• First match wins - remaining conditions are skipped\u003cbr\u003e• Use specific conditions first, general conditions last\u003cbr\u003e• Combine operators: \u003ccode\u003estarts with (case insensitive)\u003c/code\u003e for flexible matching"
  },
  {
    "type": "LABEL",
    "name": "h1_ELSE",
    "displayName": "____________________ \u003cbr\u003e \u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp\u0026nbsp🅴🅻🆂🅴\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp; \u003cbr\u003e ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
  },
  {
    "displayName": "Default Output",
    "simpleValueType": true,
    "name": "def",
    "type": "TEXT",
    "help": "📤 The value to return if \u003cstrong\u003enone of the conditions match\u003c/strong\u003e.\u003cbr\u003e\u003cbr\u003eThis is the \"ELSE\" in the IF-ELSE-IF-ELSE logic.\u003cbr\u003e\u003cbr\u003eIf left empty, returns \u003ccode\u003eundefined\u003c/code\u003e.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003eUnknown\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e0\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e{{Fallback Variable}}\u003c/code\u003e"
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
        "help": "⚙️ Optional function to transform the final output before returning it.\u003cbr\u003e\u003cbr\u003eApplied to \u003cem\u003eboth\u003c/em\u003e matched condition outputs and the default output.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003estr \u003d\u003e str.toUpperCase()\u003c/code\u003e → Convert to uppercase\u003cbr\u003e• \u003ccode\u003eval \u003d\u003e val + \u0027 €\u0027\u003c/code\u003e → Append currency\u003cbr\u003e• \u003ccode\u003eval \u003d\u003e parseInt(val)\u003c/code\u003e → Convert to integer\u003cbr\u003e• \u003ccode\u003eval \u003d\u003e val || \u0027N/A\u0027\u003c/code\u003e → Fallback for empty values\u003cbr\u003e\u003cbr\u003eUseful for chaining transformations or ensuring consistent output format."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Evaluates conditions sequentially using IF ELSE IF logic.
 * Returns the value of the first matching condition, or default if none match.
 *
 * @param {Array<Object>} ls1 - Array of condition objects with values to return.
 * @param {*} def - Default value to return if no conditions match.
 *
 * @returns {*} The value of the first matching condition, or default value.
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');

const ifElseIf = function(ls1, def) {
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

    // Sequential IF-ELSE-IF evaluation
    const rules = ls1 || [];
    for (var i = 0; i < rules.length; i++) {
        var rule = rules[i];
        if (!rule) continue;

        // Support both nested {condition: {val, con, ref}, res} and flat {val, con, ref, res}
        var cond = rule.condition || rule;
        if (!cond.con) continue;

        if (evaluateCondition(cond)) {
            return rule.res;
        }
    }

    // No condition matched, return default
    return def;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// ifElseIf - Direct mode
// ===============================================================================
return out(ifElseIf(data.ls1, data.def));


___TESTS___

scenarios:
  - name: '[example] Equals match'
    code: |-
      /* @display
      Params Table: [
          {
            "Input Value": "hello",
            "Condition": "eq",
            "Reference Value": "hello",
            "Output Value": "Match 1"
          },
          {
            "Input Value": "world",
            "Condition": "eq",
            "Reference Value": "world",
            "Output Value": "Match 2"
          }
      ]

      Default Output: No match
      @output
      Match 1
      */
      const ls1 = [
          {condition: {val: 'hello', con: 'eq', ref: 'hello'}, res: 'Match 1'},
          {condition: {val: 'world', con: 'eq', ref: 'world'}, res: 'Match 2'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Match 1');
  - name: Second condition matches (first fails)
    code: |-
      const ls1 = [
          {condition: {val: 'hello', con: 'eq', ref: 'goodbye'}, res: 'Match 1'},
          {condition: {val: 'world', con: 'eq', ref: 'world'}, res: 'Match 2'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Match 2');
  - name: '[example] No match returns default'
    code: |-
      /* @display
      Params Table: [
          {
            "Input Value": "hello",
            "Condition": "eq",
            "Reference Value": "goodbye",
            "Output Value": "Match 1"
          },
          {
            "Input Value": "world",
            "Condition": "eq",
            "Reference Value": "earth",
            "Output Value": "Match 2"
          }
      ]

      Default Output: Default value
      @output
      Default value
      */
      const ls1 = [
          {condition: {val: 'hello', con: 'eq', ref: 'goodbye'}, res: 'Match 1'},
          {condition: {val: 'world', con: 'eq', ref: 'earth'}, res: 'Match 2'}
      ];
      const def = 'Default value';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Default value');
  - name: Case insensitive equals (eqi)
    code: |-
      const ls1 = [
          {condition: {val: 'Hello', con: 'eqi', ref: 'HELLO'}, res: 'Case match'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Case match');
  - name: Contains (ct)
    code: |-
      const ls1 = [
          {condition: {val: 'hello world', con: 'ct', ref: 'world'}, res: 'Contains'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Contains');
  - name: Not contains (nct)
    code: |-
      const ls1 = [
          {condition: {val: 'hello world', con: 'nct', ref: 'goodbye'}, res: 'Does not contain'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Does not contain');
  - name: Starts with (sw)
    code: |
      const ls1 = [
          {condition: {val: '/products/shoes', con: 'sw', ref: '/products'}, res: 'Products page'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Products page');
  - name: Ends with case insensitive (ewi)
    code: |-
      const ls1 = [
          {condition: {val: 'test.PDF', con: 'ewi', ref: '.pdf'}, res: 'PDF file'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('PDF file');
  - name: Regex match (re)
    code: |-
      const ls1 = [
          {condition: {val: 'Price: $19.99', con: 're', ref: '\\d+'}, res: 'Has numbers'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Has numbers');
  - name: Numeric less than (xlt)
    code: |-
      const ls1 = [
          {condition: {val: '5', con: 'xlt', ref: '10'}, res: 'Less than 10'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Less than 10');
  - name: Numeric not less than (nxlt = greater than or equal)
    code: |-
      const ls1 = [
          {condition: {val: '15', con: 'nxlt', ref: '10'}, res: 'Greater or equal'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Greater or equal');
  - name: Multiple conditions with priority (first match wins)
    code: |-
      const ls1 = [
          {condition: {val: '100', con: 'xlt', ref: '50'}, res: 'Less than 50'},
          {condition: {val: '100', con: 'xlte', ref: '100'}, res: 'Less or equal 100'},
          {condition: {val: '100', con: 'nxlt', ref: '50'}, res: 'Greater or equal 50'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Less or equal 100');
  - name: With output function
    code: |-
      const ls1 = [
          {condition: {val: 'test', con: 'eq', ref: 'test'}, res: 'matched'}
      ];
      const def = 'No match';
      const out = function(val) { return val.toUpperCase(); };
      const mockData = {
          ls1: ls1,
          def: def,
          out: out
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('MATCHED');
  - name: Empty rules array returns default
    code: |-
      const ls1 = [];
      const def = 'Default';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Default');
  - name: Invalid condition (missing operator) skips to next
    code: |-
      const ls1 = [
          {condition: {val: 'test', con: '', ref: 'test'}, res: 'Bad condition'},
          {condition: {val: 'valid', con: 'eq', ref: 'valid'}, res: 'Good condition'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Good condition');
  - name: null is stringified for string comparison
    code: |-
      const ls1 = [
          {condition: {val: null, con: 'eq', ref: 'null'}, res: 'Null matched'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Null matched');
  - name: undefinedis stringified for string comparison
    code: |-
      const ls1 = [
          {condition: {val: undefined, con: 'eq', ref: 'undefined'}, res: 'Undefined matched'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Undefined matched');
  - name: boolean true is stringified for string comparison
    code: |-
      const ls1 = [
          {condition: {val: true, con: 'eq', ref: 'true'}, res: 'True matched'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('True matched');
  - name: boolean false is stringified for string comparison
    code: |-
      const ls1 = [
          {condition: {val: false, con: 'eq', ref: 'false'}, res: 'False matched'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('False matched');
  - name: number becomes string for string comparison
    code: |-
      const ls1 = [
          {condition: {val: 123, con: 'eq', ref: '123'}, res: 'Number matched'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Number matched');
  - name: null in contains operation
    code: |-
      const ls1 = [
          {condition: {val: null, con: 'ct', ref: 'ull'}, res: 'Contains ull'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Contains ull');
  - name: String 10 vs number 10 in numeric comparison (both converted)
    code: |-
      const ls1 = [
          {condition: {val: '10', con: 'xlt', ref: 20}, res: 'String compared as number'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('String compared as number');
  - name: Number in string operation (toString called)
    code: |-
      const ls1 = [
          {condition: {val: 456, con: 'sw', ref: '45'}, res: 'Number starts with 45'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Number starts with 45');
  - name: Boolean in contains (true → string true)
    code: |-
      const ls1 = [
          {condition: {val: true, con: 'ct', ref: 'rue'}, res: 'True contains rue'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('True contains rue');
  - name: Numeric comparison with non-numeric string (stays as is)
    code: |-
      const ls1 = [
          {condition: {val: 'abc', con: 'xlt', ref: '10'}, res: 'Non-numeric stays string'}
      ];
      const def = 'No numeric match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('No numeric match');
  - name: Reference value stringification (ref with boolean)
    code: |-
      const ls1 = [
          {condition: {val: 'true', con: 'eq', ref: true}, res: 'Ref boolean to string'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Ref boolean to string');
  - name: Both val and ref are null
    code: |-
      const ls1 = [
          {condition: {val: null, con: 'eq', ref: null}, res: 'Both null'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Both null');


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
