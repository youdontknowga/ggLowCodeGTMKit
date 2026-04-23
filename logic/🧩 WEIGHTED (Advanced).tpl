___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "🧩 WEIGHTED (Advanced)",
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
    "help": "Evaluates conditions using \u003cstrong\u003ecustom JavaScript functions\u003c/strong\u003e with weighted point scoring. Each matching condition contributes points to a total score. Returns \u003ccode\u003etrue\u003c/code\u003e if the total meets/exceeds the threshold, or the raw score if no threshold is set.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e📊 How it works:\u003c/strong\u003e\u003cbr\u003e• Each condition has a \u003cem\u003ecustom function\u003c/em\u003e that receives (val, ref) and a \u003cem\u003epoint value\u003c/em\u003e\u003cbr\u003e• All conditions are evaluated (not short-circuit)\u003cbr\u003e• Matching conditions add their points to the total score\u003cbr\u003e• With threshold: Returns \u003ccode\u003etrue/false\u003c/code\u003e based on score vs threshold\u003cbr\u003e• Without threshold: Returns the total score as a number\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e🔧 Use this version when:\u003c/strong\u003e\u003cbr\u003e• You need custom comparison logic for scoring\u003cbr\u003e• You want complex JavaScript functions for conditions\u003cbr\u003e• Simple operators (equals, contains) aren\u0027t sufficient\u003cbr\u003e\u003cbr\u003e💡 \u003cem\u003eFor predefined operators, use \"Weighted Score (Predefined Operators)\" instead.\u003c/em\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003e🔄 Optional Cast Function:\u003c/strong\u003e\u003cbr\u003e• Apply a \u003cem\u003ecast function\u003c/em\u003e to both val and ref before passing to custom functions\u003cbr\u003e• Useful for normalization (lowercase, trim, type conversion, etc.)\u003cbr\u003e• Applied consistently to all conditions\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eScore without threshold\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e15\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBelow threshold returns 0\u003c/em\u003e***\u003cbr\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003efalse\u003c/strong\u003e"
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
          "help": "💾 The value to evaluate.\u003cbr\u003e\u003cbr\u003eThis will be passed as the first argument to your custom function (after cast, if provided).\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003e{{Page Path}}\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e{{User Object}}\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e{{Custom Variable}}\u003c/code\u003e"
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "TEXT",
          "name": "fn",
          "displayName": "Custom Function",
          "simpleValueType": true,
          "help": "⚙️ JavaScript function that receives \u003ccode\u003e(val, ref)\u003c/code\u003e and returns \u003ccode\u003etrue\u003c/code\u003e or \u003ccode\u003efalse\u003c/code\u003e.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eFunction signature:\u003c/strong\u003e \u003ccode\u003e(val, ref) \u003d\u003e boolean\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003e(v, r) \u003d\u003e v \u003d\u003d\u003d r\u003c/code\u003e → Strict equality\u003cbr\u003e• \u003ccode\u003e(v, r) \u003d\u003e v.length \u003e r\u003c/code\u003e → String length comparison\u003cbr\u003e• \u003ccode\u003e(v, r) \u003d\u003e v.price \u003e r.price\u003c/code\u003e → Object property comparison\u003cbr\u003e• \u003ccode\u003e(v, r) \u003d\u003e v \u003e r \u0026\u0026 v \u003c r * 2\u003c/code\u003e → Range check\u003cbr\u003e• \u003ccode\u003e(v, r) \u003d\u003e new Date(v) \u003e new Date(r)\u003c/code\u003e → Date comparison\u003cbr\u003e\u003cbr\u003e💡 Both \u003ccode\u003eval\u003c/code\u003e and \u003ccode\u003eref\u003c/code\u003e are processed by the cast function (if provided) before being passed to your function."
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "TEXT",
          "name": "ref",
          "displayName": "Reference Value",
          "simpleValueType": true,
          "help": "💾 The reference value for comparison.\u003cbr\u003e\u003cbr\u003eThis will be passed as the second argument to your custom function (after cast, if provided).\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• Threshold: \u003ccode\u003e100\u003c/code\u003e\u003cbr\u003e• Object: \u003ccode\u003e{{Reference Object}}\u003c/code\u003e\u003cbr\u003e• Variable: \u003ccode\u003e{{Baseline Value}}\u003c/code\u003e"
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "TEXT",
          "name": "pts",
          "displayName": "Points",
          "simpleValueType": true,
          "help": "🎯 Points awarded if this condition\u0027s function returns \u003ccode\u003etrue\u003c/code\u003e.\u003cbr\u003e\u003cbr\u003eCan be positive or negative numbers. Automatically converted from string to number.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003e10\u003c/code\u003e → Add 10 points\u003cbr\u003e• \u003ccode\u003e-5\u003c/code\u003e → Subtract 5 points\u003cbr\u003e• \u003ccode\u003e{{Dynamic Points}}\u003c/code\u003e → Use variable"
        },
        "isUnique": false
      }
    ],
    "newRowTitle": "New Weighted Condition",
    "newRowButtonText": "+ WEIGHTED CONDITION",
    "editRowTitle": "Edit Condition",
    "help": "💡 \u003cstrong\u003eTips:\u003c/strong\u003e\u003cbr\u003e• All conditions are evaluated (unlike IF-ELSE-IF)\u003cbr\u003e• Your custom functions can contain any JavaScript logic\u003cbr\u003e• Use positive points for desired matches, negative for penalties\u003cbr\u003e• Access GTM APIs like \u003ccode\u003erequire(\u0027makeNumber\u0027)\u003c/code\u003e inside functions"
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
        "help": "⚙️ Optional function to transform the final result before returning it.\u003cbr\u003e\u003cbr\u003eApplied to the boolean (if threshold set) or numeric score (if no threshold).\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003escore \u003d\u003e score * 2\u003c/code\u003e → Double the score\u003cbr\u003e• \u003ccode\u003ebool \u003d\u003e bool ? \u0027Pass\u0027 : \u0027Fail\u0027\u003c/code\u003e → Convert to text\u003cbr\u003e• \u003ccode\u003eval \u003d\u003e Math.round(val)\u003c/code\u003e → Round score\u003cbr\u003e• \u003ccode\u003escore \u003d\u003e score + \u0027 points\u0027\u003c/code\u003e → Add label"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Evaluates conditions using weighted point scoring with custom functions.
 * Each condition has a point value, returns true if total score meets threshold.
 *
 * Direct-mode only
 * @param {Array<Object>} data.ls1 - List of condition objects with points
 * @param {Object} data.ls1[].condition - Condition object for this item
 * @param {*} data.ls1[].condition.val - Value to evaluate
 * @param {Function} data.ls1[].condition.fn - Custom function that receives (val, ref) and returns boolean
 * @param {*} data.ls1[].condition.ref - Reference value to compare against
 * @param {number} data.ls1[].pts - Points awarded if this condition passes
 * @param {number} data.thr - Minimum score required to return true
 * @param {Function} [data.cast] - Optional cast function applied to both val and ref before passing to custom function
 * @param {Function} [data.out] - Optional function to transform the final result
 *
 * @returns {boolean|number} True/false if threshold provided, or total score if no threshold.
 *
 * @note Custom Functions Version - Use for complex scoring logic not covered by predefined operators
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const castFn = safeFunction(data.cast);
const out = safeFunction(data.out);

const conditions = data.ls1 || [];
const threshold = makeNumber(data.thr);

const evaluateCondition = (cond) => {
    if (!cond) return false;
    
    const fn = cond.fn;
    if (typeof fn !== 'function') return false;
    
    const val = castFn(cond.val);
    const ref = castFn(cond.ref);
    
    return fn(val, ref);
};

let totalScore = 0;

for (let i = 0; i < conditions.length; i++) {
    const item = conditions[i];
    if (!item || !item.condition) {
        continue;
    }
    
    const pointsValue = makeNumber(item.pts);
    const points = (typeof pointsValue === 'number' && pointsValue === pointsValue) ? pointsValue : 0;
    
    if (evaluateCondition(item.condition)) {
        totalScore += points;
    }
}

const result = (typeof threshold === 'number' && threshold === threshold) ? totalScore >= threshold : totalScore;

return out(result);


___TESTS___

scenarios:
  - name: '[example] Score without threshold'
    code: |
      /* @display
      Conditions: [

          {condition: {
            Input Value: 'hello', 
            Custom Function: (v, r) => v === r, 
            Reference: 'hello'
          }, 
          
          Points: 10
          },

          {condition: {
            Input Value: 'world', 
            Custom Function: (v, r) => v === r, 
            Reference: 'world'
          }, 
          
          Points: 5
          },

          {condition: {
            Input Value: 'test', 
            Custom Function: (v, r) => v === r, 
            Reference: 'fail'
          }, 
          
          Points: 3
          }
      ]
      
      Threshold Score: undefined
      @output
      15
      */
      const ls1 = [
          {condition: {val: 'hello', fn: (v, r) => v === r, ref: 'hello'}, pts: 10},
          {condition: {val: 'world', fn: (v, r) => v === r, ref: 'world'}, pts: 5},
          {condition: {val: 'test', fn: (v, r) => v === r, ref: 'fail'}, pts: 3}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(15);
  - name: With threshold - score meets threshold
    code: |-
      const ls1 = [
          {condition: {val: 'test',fn: (v, r) => v.length > r, ref: 2 }, pts: 10},
          {condition: {val: 'hello', fn: (v, r) => v.length > r, ref: 2}, pts: 5}
      ];
      const mockData = {
          ls1: ls1,
          thr: 12,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isTrue();
  - name: '[example] Below threshold returns 0'
    code: |-
      /* @display
      Conditions: [

          {condition: {
            Input Value: 'test', 
            Custom Function: (v, r) => v === r, 
            Reference: 'fail'
            }, 
            
            Points: 10
            },

          {condition: {
            Input Value: 'hello', 
            Custom Function: (v, r) => v === r, 
            Reference: 'hello'
            }, 
            
            Points: 5
            }
      ]

      Threshold Score: 10
      @output
      false
      */
      const ls1 = [
          {condition: {val: 'test', fn: (v, r) => v === r, ref: 'fail'}, pts: 10},
          {condition: {val: 'hello', fn: (v, r) => v === r, ref: 'hello'}, pts: 5}
      ];
      const mockData = {
          ls1: ls1,
          thr: 10,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isFalse();
  - name: Points as strings
    code: |-
      const ls1 = [
          {condition: {val: 'test', fn: (v, r) => v === r, ref: 'test'}, pts: '10'},
          {condition: {val: 'match', fn: (v, r) => v === r, ref: 'match'}, pts: '25'}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(35);
  - name: Negative points
    code: |
      const ls1 = [
          {condition: {val: 'good', fn: (v, r) => v === r, ref: 'good'}, pts: 20},
          {condition: {val: 'bad', fn: (v, r) => v === r, ref: 'bad'}, pts: "-10"}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(10);
  - name: With cast function - lowercase normalization
    code: |-
      const ls1 = [
          {condition: {val: 'HELLO', fn: (v, r) => v === r, ref: 'hello'}, pts: 10},
          {condition: {val: 'world', fn: (v, r) => v === r, ref: 'WORLD'}, pts: 5}
      ];
      const cast = function(v) { return v.toLowerCase(); };
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: cast,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(15);
  - name: With cast function - numeric conversion
    code: |-
      const ls1 = [
          {condition: {val: '100', fn: (v, r) => v > r, ref: '50'}, pts: 15},
          {condition: {val: '30', fn: (v, r) => v < r, ref: '50'}, pts: 10}
      ];
      const cast = function(v) {
          const makeNumber = require('makeNumber');
          const num = makeNumber(v);
          return typeof num === 'number' ? num : v;
      };
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: cast,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(25);
  - name: Custom function with object property comparison
    code: |
      const ls1 = [
          {condition: {val: {price: 99}, fn: (v, r) => v.price > r, ref: 50}, pts: 20},
          {condition: {val: {price: 30}, fn: (v, r) => v.price < r, ref: 50}, pts: 10}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(30);
  - name: Complex custom logic
    code: |
      const ls1 = [
          {condition: {val: '/products/shoes', fn: (v, r) => (v.substring(0, r.length) === r) && (v.indexOf('shoes') > -1), ref: '/products'}, pts: 12}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(12);
  - name: With output function (double the score)
    code: |-
      const ls1 = [
          {condition: {val: 'test', fn: (v, r) => v === r, ref: 'test'}, pts: 10},
          {condition: {val: 'hello', fn: (v, r) => v === r, ref: 'hello'}, pts: 5}
      ];
      const out = function(val) { return val * 2; };
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: undefined,
          out: out
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(30);
  - name: With output function and threshold
    code: |-
      const ls1 = [
          {condition: {val: 'test', fn: (v, r) => v === r, ref: 'test'}, pts: 10},
          {condition: {val: 'hello', fn: (v, r) => v === r, ref: 'hello'}, pts: 5}
      ];
      const out = function(val) { return val ? 'Pass' : 'Fail'; };
      const mockData = {
          ls1: ls1,
          thr: 12,
          cast: undefined,
          out: out
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('Pass');
  - name: All conditions fail - zero score
    code: |-
      const ls1 = [
          {condition: {val: 'test', fn: (v, r) => v === r, ref: 'fail'}, pts: 10},
          {condition: {val: 'hello', fn: (v, r) => v === r, ref: 'xyz'}, pts: 5}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(0);
  - name: Invalid function (not a function) - skipped
    code: |
      const ls1 = [
          {condition: {val: 'test', fn: 'not a function', ref: 'test'}, pts: 10},
          {condition: {val: 'valid', fn: (v, r) => v === r, ref: 'valid'}, pts: 7}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(7);
  - name: Missing condition object - skipped
    code: |
      const ls1 = [
          {pts: 10},
          {condition: {val: 'test', fn: (v, r) => v === r, ref: 'test'}, pts: 8}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(8);
  - name: Invalid points (non-numeric string) defaults to 0
    code: |
      const ls1 = [
          {condition: {val: 'test', fn: (v, r) => v === r, ref: 'test'}, pts: 'abc'},
          {condition: {val: 'hello', fn: (v, r) => v === r, ref: 'hello'}, pts: '10'}
      ];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(10);
  - name: Empty conditions array
    code: |-
      const ls1 = [];
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(0);
  - name: Threshold exactly equals score
    code: |-
      const ls1 = [
          {condition: {val: 'test', fn: (v, r) => v === r, ref: 'test'}, pts: 10}
      ];
      const mockData = {
          ls1: ls1,
          thr: 10,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isTrue();
  - name: Negative total score with threshold
    code: |
      const ls1 = [
          {condition: {val: 'bad', fn: (v, r) => v === r, ref: 'bad'}, pts: -10},
          {condition: {val: 'worse', fn: (v, r) => v === r, ref: 'worse'}, pts: -5}
      ];
      const mockData = {
          ls1: ls1,
          thr: 0,
          cast: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isFalse();
  - name: Cast with property extraction
    code: |-
      const ls1 = [
          {condition: {val: {name: 'Product', price: 99}, fn: (v, r) => v > r, ref: {price: 50}}, pts: 15}
      ];
      const cast = function(v) { return v && v.price ? v.price : 0; };
      const mockData = {
          ls1: ls1,
          thr: undefined,
          cast: cast,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(15);
  - name: omplex scenario - mix of conditions and cast
    code: |-
      const ls1 = [
          {condition: {val: 'HELLO', fn: (v, r) => v === r, ref: 'hello'}, pts: 5},
          {condition: {val: '100', fn: (v, r) => v > r, ref: '50'}, pts: 10},
          {condition: {val: 'test', fn: (v, r) => v.substring(0, r.length) === r, ref: 'est'}, pts: 3}
      ];
      const cast = function(v) {
          const makeNumber = require('makeNumber');
          const num = makeNumber(v);
        if ( num !== num) return 'NaN';  
        if (typeof num === 'number') return num;
          return v.toLowerCase();
      };
      const mockData = {
          ls1: ls1,
          thr: 15,
          cast: cast,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult).isTrue();


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
