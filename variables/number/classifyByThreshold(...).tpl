___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "classifyByThreshold(...)",
  "description": "Classifies numeric values into categories based on threshold ranges. First matching range wins. Useful for grades, performance tiers, and scoring systems.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "paramSection",
    "displayName": "𝘋𝘦𝘴𝘤𝘳𝘪𝘱𝘵𝘪𝘰𝘯",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "tbl",
        "displayName": "Threshold Ranges",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Min Value (or Threshold)",
            "name": "min",
            "type": "TEXT"
          },
          {
            "defaultValue": "",
            "displayName": "Max Value (optional)",
            "name": "max",
            "type": "TEXT"
          },
          {
            "defaultValue": "",
            "displayName": "Category",
            "name": "cat",
            "type": "TEXT"
          }
        ],
        "help": "📋 Define threshold ranges with their corresponding categories. First matching range wins.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eRange logic:\u003c/strong\u003e value \u0026gt;= min AND value \u0026lt; max\u003cbr\u003e\u003cbr\u003e💡 \u003cstrong\u003eTips:\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Leave Max empty for open-ended ranges (e.g., \"100+\")\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Order matters - first match is returned\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Use 'min' for range start, or use 'thr' for simple thresholds\u003cbr\u003e\u003cbr\u003eExample:\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Min: \u003ccode\u003e0\u003c/code\u003e, Max: \u003ccode\u003e60\u003c/code\u003e, Category: \u003ccode\u003eF\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Min: \u003ccode\u003e60\u003c/code\u003e, Max: \u003ccode\u003e80\u003c/code\u003e, Category: \u003ccode\u003eC\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Min: \u003ccode\u003e90\u003c/code\u003e, Max: \u003cem\u003e(empty)\u003c/em\u003e, Category: \u003ccode\u003eA\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eClassify into middle range\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e75\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eC\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns default\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: 150\u003cbr\u003eNo Match Handler: Out of Range\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eOut of Range\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "def",
        "displayName": "No Match Handler (optional)",
        "simpleValueType": true,
        "help": "💾 Value to return or function to call when no threshold matches or input is invalid.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eDefault value\u003c/strong\u003e: \u003cem\u003e\"Unknown\"\u003c/em\u003e, \u003cem\u003e\"N/A\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eCallback function\u003c/strong\u003e: \u003cem\u003eval =\u003e \"Out of range: \" + val\u003c/em\u003e"
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template."
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Numeric Value"
      }
    ],
    "help": "Classifies a numeric value into categories based on threshold ranges.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eClassify into middle range\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e75\u003c/strong\u003e\u003cbr\u003eThreshold Ranges: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{min: \u003cstrong\u003e0, max: 60, cat: \"F\"},\u003c/strong\u003e\u003cbr\u003e{min: \u003cstrong\u003e60, max: 70, cat: \"D\"},\u003c/strong\u003e\u003cbr\u003e{min: \u003cstrong\u003e70, max: 80, cat: \"C\"},\u003c/strong\u003e\u003cbr\u003e{min: \u003cstrong\u003e80, max: 90, cat: \"B\"},\u003c/strong\u003e\u003cbr\u003e{min: \u003cstrong\u003e90, max: 100, cat: \"A\"}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eC\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns default\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e150\u003c/strong\u003e\u003cbr\u003eThreshold Ranges: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e{min: \u003cstrong\u003e0, max: 50, cat: \"Low\"},\u003c/strong\u003e\u003cbr\u003e{min: \u003cstrong\u003e50, max: 100, cat: \"High\"}\u003c/strong\u003e\u003cbr\u003e\u003cstrong\u003e]\u003c/strong\u003e\u003cbr\u003eNo Match Handler (optional): \u003cstrong\u003eOut of Range\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eOut of Range\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the category result before returning it (e.g., \u003ccode\u003ecat =\u003e cat.toUpperCase()\u003c/code\u003e, \u003ccode\u003ecat =\u003e \"Grade: \" + cat\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Classifies a numeric value into categories based on threshold ranges.
 * Returns the category for the first matching threshold.
 * 
 * @param {number} data.src - The numeric value to classify.
 * @param {Array} data.tbl - Array of objects with 'min' (or 'thr'), 'max' (optional), and 'cat' properties defining threshold ranges.
 * @param {*|Function} [data.def] - Optional default value or callback function when no threshold matches.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before classification.
 * 
 * @returns {string|any} The category name for the matching threshold, or the default value if no match.
 *
 * @framework ggLowCodeGTMKit
 */
const makeNumber = require('makeNumber');

const classifyByThreshold = function(value, thresholds, defaultOrCallback) {
    const numValue = makeNumber(value);
    
    if (numValue !== numValue) {
        if (typeof defaultOrCallback === 'function') {
            return defaultOrCallback(value);
        }
        return defaultOrCallback;
    }
    
    for (let i = 0; i < thresholds.length; i++) {
        const range = thresholds[i];
        
        const minValue = range.min !== undefined ? makeNumber(range.min) : makeNumber(range.thr);
        let maxValue = range.max !== undefined ? makeNumber(range.max) : undefined;
        
        if (maxValue === undefined && i < thresholds.length - 1) {
            const nextRange = thresholds[i + 1];
            maxValue = nextRange.min !== undefined ? makeNumber(nextRange.min) : makeNumber(nextRange.thr);
        }
        
        const meetsMin = minValue !== minValue || numValue >= minValue;
        const meetsMax = maxValue === undefined || maxValue !== maxValue || numValue < maxValue;
        
        if (meetsMin && meetsMax) {
            return range.cat;
        }
    }
    
    if (typeof defaultOrCallback === 'function') {
        return defaultOrCallback(numValue);
    }
    return defaultOrCallback;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// classifyByThreshold - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(classifyByThreshold(value, data.tbl, data.def));
*/
// ===============================================================================
// classifyByThreshold(...) – Apply Mode
// ===============================================================================
return function(value) {
   return out(classifyByThreshold(value, data.tbl, data.def));
};


___TESTS___

scenarios:
  - name: '[example] Classify into middle range'
    code: |-
      /* @display
      Value to Process: 75
      Threshold Ranges: [
          {min: 0, max: 60, cat: "F"},
          {min: 60, max: 70, cat: "D"},
          {min: 70, max: 80, cat: "C"},
          {min: 80, max: 90, cat: "B"},
          {min: 90, max: 100, cat: "A"}
      ]
      @output
      C
      */
      const src = 75;
      const tbl = [
          {min: 0, max: 60, cat: "F"},
          {min: 60, max: 70, cat: "D"},
          {min: 70, max: 80, cat: "C"},
          {min: 80, max: 90, cat: "B"},
          {min: 90, max: 100, cat: "A"}
      ];
      const mockData = {
          src: src,
          tbl: tbl
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("C");
  - name: Classify value in first range
    code: |-
      const src = 25;
      const tbl = [
          {min: 0, max: 50, cat: "Low"},
          {min: 50, max: 100, cat: "Medium"},
          {min: 100, cat: "High"}
      ];
      const mockData = {
          src: src,
          tbl: tbl
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("Low");
  - name: Classify value in open-ended last range using thr format
    code: |
      const src = 5000;
      const tbl = [
          {thr: 0, cat: "Slow"},
          {thr: 1000, cat: "Medium"},
          {thr: 3000, cat: "Fast"}
      ];
      const mockData = {
          src: src,
          tbl: tbl
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("Fast");
  - name: '[example] No match returns default'
    code: |-
      /* @display
      Value to Process: 150
      Threshold Ranges: [
          {min: 0, max: 50, cat: "Low"},
          {min: 50, max: 100, cat: "High"}
      ]
      No Match Handler (optional): Out of Range
      @output
      Out of Range
      */
      const src = 150;
      const tbl = [
          {min: 0, max: 50, cat: "Low"},
          {min: 50, max: 100, cat: "High"}
      ];
      const def = "Out of Range";
      const mockData = {
          src: src,
          tbl: tbl,
          def: def
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("Out of Range");
  - name: Invalid numeric input returns default
    code: |-
      const src = "not a number";
      const tbl = [
          {min: 0, max: 100, cat: "Valid"}
      ];
      const def = "Invalid Input";
      const mockData = {
          src: src,
          tbl: tbl,
          def: def
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo("Invalid Input");
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
  const mode = 'apply';
  // ===================================================================================================
  // Derived flags
  // ===================================================================================================
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
