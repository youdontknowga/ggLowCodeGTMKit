___INFO___

{
  "displayName": "🧩 IF ELSE IF (Advanced)",
  "description": "Evaluates a set of conditions and returns a value based on the first matching rule.",
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
    "help": "Evaluates conditions using \u003cstrong\u003ecustom JavaScript functions\u003c/strong\u003e and returns the value of the first matching rule.\u003cbr\u003e\u003cbr\u003e🔧 \u003cstrong\u003eCustom Functions Version\u003c/strong\u003e - Use your own comparison logic for complex scenarios.\u003cbr\u003e\u003cbr\u003e💡 \u003cem\u003eFor simple comparisons (equals, contains, regex, etc.), use \"IF ELSE IF (Predefined Operators)\" instead.\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e📋 How it works:\u003c/strong\u003e\u003cbr\u003e• Each condition has a \u003cem\u003ecustom function\u003c/em\u003e that receives (val, ref) and returns true/false\u003cbr\u003e• Conditions are evaluated \u003cem\u003ein order from top to bottom\u003c/em\u003e\u003cbr\u003e• The \u003cem\u003efirst\u003c/em\u003e condition that returns \u003ccode\u003etrue\u003c/code\u003e returns its output value\u003cbr\u003e• Remaining conditions are \u003cem\u003eskipped\u003c/em\u003e (short-circuit evaluation)\u003cbr\u003e• If \u003cem\u003eno conditions match\u003c/em\u003e, the default output is returned\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e🔄 Optional Cast Function:\u003c/strong\u003e\u003cbr\u003e• Apply a \u003cem\u003ecast function\u003c/em\u003e to both val and ref before passing to custom functions\u003cbr\u003e• Useful for normalization (lowercase, trim, type conversion, etc.)\u003cbr\u003e• Applied consistently to all conditions\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFirst match wins\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eNo match\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eMatch 1\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns default\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eDefault value\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eDefault value\u003c/strong\u003e"
  },
  {
    "type": "LABEL",
    "name": "h1_IF ELSE",
    "displayName": "____________________ \u003cbr\u003e \u0026nbsp;\u0026nbsp;\u0026nbsp\u0026nbsp🅸🅵\u0026nbsp;🅴🅻🆂🅴\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;  \u003cbr\u003e ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
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
          "help": "💾 The value to evaluate.\u003cbr\u003e\u003cbr\u003eThis will be passed as the first argument to your custom function (after cast, if provided).\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003e{{Page Path}}\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e{{Product Object}}\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e{{Custom Variable}}\u003c/code\u003e"
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "TEXT",
          "name": "fn",
          "displayName": "Custom Function",
          "simpleValueType": true,
          "help": "⚙️ JavaScript function that receives \u003ccode\u003e(val, ref)\u003c/code\u003e and returns \u003ccode\u003etrue\u003c/code\u003e or \u003ccode\u003efalse\u003c/code\u003e.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eFunction signature:\u003c/strong\u003e \u003ccode\u003e(val, ref) \u003d\u003e boolean\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003e(v, r) \u003d\u003e v \u003d\u003d\u003d r\u003c/code\u003e → Strict equality\u003cbr\u003e• \u003ccode\u003e(v, r) \u003d\u003e v.length \u003e r\u003c/code\u003e → String length comparison\u003cbr\u003e• \u003ccode\u003e(v, r) \u003d\u003e v.price \u003e r.price\u003c/code\u003e → Object property comparison\u003cbr\u003e• \u003ccode\u003e(v, r) \u003d\u003e v.includes(r) \u0026\u0026 v.startsWith(\u0027/\u0027)\u003c/code\u003e → Complex logic\u003cbr\u003e• \u003ccode\u003e(v, r) \u003d\u003e new Date(v) \u003e new Date(r)\u003c/code\u003e → Date comparison\u003cbr\u003e\u003cbr\u003e💡 Both \u003ccode\u003eval\u003c/code\u003e and \u003ccode\u003eref\u003c/code\u003e are processed by the cast function (if provided) before being passed to your function."
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "TEXT",
          "name": "ref",
          "displayName": "Reference Value",
          "simpleValueType": true,
          "help": "💾 The reference value for comparison.\u003cbr\u003e\u003cbr\u003eThis will be passed as the second argument to your custom function (after cast, if provided).\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• String: \u003ccode\u003e/checkout\u003c/code\u003e\u003cbr\u003e• Number: \u003ccode\u003e100\u003c/code\u003e\u003cbr\u003e• Object: \u003ccode\u003e{{Reference Object}}\u003c/code\u003e\u003cbr\u003e• Variable: \u003ccode\u003e{{Threshold Variable}}\u003c/code\u003e"
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "TEXT",
          "name": "res",
          "displayName": "Output Value",
          "simpleValueType": true,
          "help": "📤 The value to return if this condition\u0027s function returns \u003ccode\u003etrue\u003c/code\u003e.\u003cbr\u003e\u003cbr\u003eThis value is returned \u003cem\u003eas-is\u003c/em\u003e without modification.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• String: \u003ccode\u003ePremium User\u003c/code\u003e\u003cbr\u003e• Number: \u003ccode\u003e1\u003c/code\u003e\u003cbr\u003e• Boolean: \u003ccode\u003etrue\u003c/code\u003e\u003cbr\u003e• Variable: \u003ccode\u003e{{Dynamic Output}}\u003c/code\u003e"
        },
        "isUnique": false
      }
    ],
    "newRowTitle": "New Condition",
    "newRowButtonText": "+ IF / ELSE IF",
    "editRowTitle": "Edit Condition",
    "help": "💡 \u003cstrong\u003eTips:\u003c/strong\u003e\u003cbr\u003e• Order matters! Conditions are checked from top to bottom\u003cbr\u003e• First match wins - remaining conditions are skipped\u003cbr\u003e• Use specific conditions first, general conditions last\u003cbr\u003e• Your custom functions can contain any JavaScript logic\u003cbr\u003e• Access GTM APIs like \u003ccode\u003erequire(\u0027makeNumber\u0027)\u003c/code\u003e inside functions"
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
    "help": "📤 The value to return if \u003cstrong\u003enone of the conditions match\u003c/strong\u003e (all custom functions return \u003ccode\u003efalse\u003c/code\u003e).\u003cbr\u003e\u003cbr\u003eThis is the \"ELSE\" in the IF-ELSE-IF-ELSE logic.\u003cbr\u003e\u003cbr\u003eIf left empty, returns \u003ccode\u003eundefined\u003c/code\u003e.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003eUnknown\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e0\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e{{Fallback Variable}}\u003c/code\u003e"
  },
  {
    "type": "GROUP",
    "name": "Input Setup",
    "displayName": "Input Setup",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "TEXT",
        "name": "cast",
        "displayName": "Cast Function (optional)",
        "simpleValueType": true,
        "help": "⚙️ Optional function to transform \u003cstrong\u003eboth\u003c/strong\u003e val and ref before passing them to your custom functions.\u003cbr\u003e\u003cbr\u003eApplied consistently to all conditions for normalization.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eFunction signature:\u003c/strong\u003e \u003ccode\u003e(value) \u003d\u003e transformedValue\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003ev \u003d\u003e String(v).toLowerCase()\u003c/code\u003e → Convert to lowercase\u003cbr\u003e• \u003ccode\u003ev \u003d\u003e String(v).trim()\u003c/code\u003e → Remove whitespace\u003cbr\u003e• \u003ccode\u003ev \u003d\u003e { const makeNumber \u003d require(\u0027makeNumber\u0027); return makeNumber(v) || v; }\u003c/code\u003e → Convert to number\u003cbr\u003e• \u003ccode\u003ev \u003d\u003e v \u0026\u0026 v.price ? v.price : 0\u003c/code\u003e → Extract object property\u003cbr\u003e• \u003ccode\u003ev \u003d\u003e JSON.parse(v)\u003c/code\u003e → Parse JSON string\u003cbr\u003e\u003cbr\u003e💡 If not provided, values are passed to custom functions unchanged."
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
        "help": "⚙️ Optional function to transform the final output before returning it.\u003cbr\u003e\u003cbr\u003eApplied to \u003cem\u003eboth\u003c/em\u003e matched condition outputs and the default output.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003estr \u003d\u003e str.toUpperCase()\u003c/code\u003e → Convert to uppercase\u003cbr\u003e• \u003ccode\u003eval \u003d\u003e val + \u0027 €\u0027\u003c/code\u003e → Append currency\u003cbr\u003e• \u003ccode\u003eval \u003d\u003e parseInt(val)\u003c/code\u003e → Convert to integer\u003cbr\u003e• \u003ccode\u003eval \u003d\u003e val || \u0027N/A\u0027\u003c/code\u003e → Fallback for empty values\u003cbr\u003e\u003cbr\u003eUseful for ensuring consistent output format."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Evaluates conditions sequentially using custom functions (IF ELSE IF logic).
 * Returns the value of the first matching condition, or default if none match.
 *
 * Direct-mode only
 * @param {Array<Object>} data.ls1 - Array of condition objects with values to return
 * @param {Object} data.ls1[].condition - Condition object for this rule
 * @param {*} data.ls1[].condition.val - Value to evaluate
 * @param {Function} data.ls1[].condition.fn - Custom function that receives (val, ref) and returns boolean
 * @param {*} data.ls1[].condition.ref - Reference value to compare against
 * @param {*} data.ls1[].res - Value to return if this condition matches
 * @param {*} data.def - Default value to return if no conditions match
 * @param {Function} [data.cast] - Optional cast function applied to both val and ref before passing to custom function
 * @param {Function} [data.out] - Optional function to transform the final result
 *
 * @returns {*} The value of the first matching condition, or default value.
 *
 * @note Custom Functions Version - Use for complex logic not covered by predefined operators
 *
 * @framework ggLowCodeGTMKit
 */
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const castFn = safeFunction(data.cast);
const out = safeFunction(data.out);

const rules = data.ls1 || [];
const defaultValue = data.def;

const evaluateCondition = (cond) => {
    if (!cond) return false;
    
    const fn = cond.fn;
    if (typeof fn !== 'function') return false;
    
    const val = castFn(cond.val);
    const ref = castFn(cond.ref);
    
    return fn(val, ref);
};

for (let i = 0; i < rules.length; i++) {
    const rule = rules[i];
    if (!rule || !rule.condition) {
        continue;
    }
    
    if (evaluateCondition(rule.condition)) {
        return out(rule.res);
    }
}

return out(defaultValue);


___TESTS___

scenarios:
  - name: '[example] First match wins'
    code: |-
      /* @display
      Conditions: [{ 

        condition: { 
            Input Value: 'hello', 
            Custom Function: (v, r) => v === r, 
            Reference: 'hello'
            }, 
            Result: 'Match 1'
          },
          
          { condition: { 
            Input Value: 'world', 
            Custom Function: (v, r) => v === r, 
            Reference: 'world'
            }, 
            Result: 'Match 2'
          }
      ]
      Default Output: No match
      @output
      Match 1
      */
      const ls1 = [
          {condition: {val: 'hello', fn: (v, r) => v === r, ref: 'hello'}, res: 'Match 1'},
          {condition: {val: 'world', fn: (v, r) => v === r, ref: 'world'}, res: 'Match 2'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Match 1');
  - name: Second condition matches (first fails)
    code: |-
      const ls1 = [
          {condition: {val: 'hello', fn: (v, r) => v.length > r, ref: 10}, res: 'Match 1'},
          {condition: {val: 'world', fn: (v, r) => v === r, ref: 'world'}, res: 'Match 2'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Match 2');
  - name: '[example] No match returns default'
    code: |-
      /* @display
      Conditions: [

          { condition: { 
            Input Value: 'hello', 
            Custom Function: (v, r) => v === r, 
            Reference: 'goodbye'
            }, 
            Result: 'Match 1'
          },

          { condition: { 
            Input Value: 'world', 
            Custom Function: (v, r) => v === r, 
            Reference: 'xyz'
            }, 
            Result: 'Match 2'
          }
      ]
      Default Output: Default value
      @output
      Default value
      */
      const ls1 = [
          {condition: {val: 'hello', fn: (v, r) => v === r, ref: 'goodbye'}, res: 'Match 1'},
          {condition: {val: 'world', fn: (v, r) => v === r, ref: 'xyz'}, res: 'Match 2'}
      ];
      const def = 'Default value';
      const mockData = {
          ls1: ls1,
          def: def,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Default value');
  - name: Custom function with complex logic
    code: |-
      const ls1 = [
          {condition: {val: '/products/shoes', fn: (v, r) => (v.substring(0, r.length) === r) && (v.indexOf('shoes') > -1), ref: '/products'}, res: 'Product page'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Product page');
  - name: With cast function - lowercase normalization
    code: |-
      const ls1 = [
          {condition: {val: 'HELLO', fn: (v, r) => v === r, ref: 'hello'}, res: 'Case match'}
      ];
      const def = 'No match';
      const cast = function(v) { return v.toLowerCase(); };
      const mockData = {
          ls1: ls1,
          def: def,
          cast: cast,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Case match');
  - name: With cast function - numeric conversion
    code: |-
      const ls1 = [
          {condition: {val: '100', fn: (v, r) => v > r, ref: '50'}, res: 'Greater'}
      ];
      const def = 'No match';
      const cast = function(v) {
          const makeNumber = require('makeNumber');
          const num = makeNumber(v);
          return typeof num === 'number' ? num : v;
      };
      const mockData = {
          ls1: ls1,
          def: def,
          cast: cast,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Greater');
  - name: Custom function with object property comparison
    code: |-
      const ls1 = [
          {condition: {val: {name: 'Product', price: 99}, fn: (v, r) => v.price > r, ref: 50}, res: 'Expensive'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Expensive');
  - name: With output function
    code: |
      const ls1 = [
          {condition: {val: 'test', fn: (v, r) => v === r, ref: 'test'}, res: 'matched'}
      ];
      const def = 'No match';
      const out = function(val) { return val.toUpperCase(); };
      const mockData = {
          ls1: ls1,
          def: def,
          cast: undefined,
          out: out
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('MATCHED');
  - name: Invalid function (not a function) - skips to next
    code: |-
      const ls1 = [
          {condition: {val: 'test', fn: 'not a function', ref: 'test'}, res: 'Bad condition'},
          {condition: {val: 'valid', fn: (v, r) => v === r, ref: 'valid'}, res: 'Good condition'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Good condition');
  - name: Missing condition object - skips to next
    code: |-
      const ls1 = [
          {res: 'No condition'},
          {condition: {val: 'test', fn: (v, r) => v === r, ref: 'test'}, res: 'Has condition'}
      ];
      const def = 'No match';
      const mockData = {
          ls1: ls1,
          def: def,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Has condition');


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
