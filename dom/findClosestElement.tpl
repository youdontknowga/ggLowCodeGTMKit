___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "findClosestElement",
  "description": "Traverses up the DOM from a starting element to find the closest parent where an attribute matches a value. Returns the dataLayer path to the matching element, or \u003cem\u003eundefined\u003c/em\u003e if not found.",
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
        "type": "TEXT",
        "name": "src",
        "displayName": "Starting Element Path",
        "simpleValueType": true,
        "defaultValue": "gtm.element",
        "help": "💾 The dataLayer path to start searching from.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eClicked element\u003c/strong\u003e: \u003cem\u003e\"gtm.element\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eStart from parent\u003c/strong\u003e: \u003cem\u003e\"gtm.element.parentElement\"\u003c/em\u003e"
      },
      {
        "type": "SELECT",
        "name": "attr",
        "displayName": "Attribute to Match",
        "simpleValueType": true,
        "defaultValue": "tagName",
        "help": "💾 The attribute to check on each parent element.",
        "selectItems": [
          {
            "value": "tagName",
            "displayValue": "tagName"
          },
          {
            "value": "href",
            "displayValue": "href"
          },
          {
            "value": "class",
            "displayValue": "class"
          },
          {
            "value": "id",
            "displayValue": "id"
          },
          {
            "value": "src",
            "displayValue": "src"
          },
          {
            "value": "action",
            "displayValue": "action (form)"
          },
          {
            "value": "custom",
            "displayValue": "Custom attribute..."
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "customAttr",
        "displayName": "Custom Attribute Name",
        "simpleValueType": true,
        "help": "💾 Name of the custom attribute to match.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eData attribute\u003c/strong\u003e: \u003cem\u003e\"data-product-id\"\u003c/em\u003e, \u003cem\u003e\"data-gtm-click\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny attribute\u003c/strong\u003e: \u003cem\u003e\"aria-label\"\u003c/em\u003e, \u003cem\u003e\"title\"\u003c/em\u003e",
        "enablingConditions": [
          {
            "paramName": "attr",
            "paramValue": "custom",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "SELECT",
        "name": "mod",
        "displayName": "Comparison Mode",
        "simpleValueType": true,
        "defaultValue": "eql",
        "help": "💾 How to compare the attribute value against the reference value.\u003cbr\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eExact\u003c/strong\u003e: strict equality — \u003cem\u003e\"BUTTON\" === \"BUTTON\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eContains\u003c/strong\u003e: useful for class — \u003cem\u003e\"btn primary\"\u003c/em\u003e contains \u003cem\u003e\"btn\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eRegex\u003c/strong\u003e: pattern matching — \u003cem\u003e\"btn-primary\"\u003c/em\u003e matches \u003cem\u003e\"btn-.*\"\u003c/em\u003e",
        "selectItems": [
          {
            "value": "eql",
            "displayValue": "Exact match"
          },
          {
            "value": "cnt",
            "displayValue": "Contains"
          },
          {
            "value": "rgx",
            "displayValue": "Regex"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "val",
        "displayName": "Value to Match",
        "simpleValueType": true,
        "help": "💾 The value to compare against the attribute.\u003cbr\u003e\u003cbr\u003eExamples:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eTag name\u003c/strong\u003e: \u003cem\u003e\"A\"\u003c/em\u003e, \u003cem\u003e\"BUTTON\"\u003c/em\u003e, \u003cem\u003e\"DIV\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eClass fragment\u003c/strong\u003e: \u003cem\u003e\"btn\"\u003c/em\u003e, \u003cem\u003e\"top-header\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eData value\u003c/strong\u003e: \u003cem\u003e\"true\"\u003c/em\u003e, \u003cem\u003e\"product-card\"\u003c/em\u003e"
      },
      {
        "type": "TEXT",
        "name": "fn",
        "displayName": "Custom Comparison Function (optional)",
        "simpleValueType": true,
        "help": "⚙️ Optional custom function to compare attribute value with reference value. Overrides Comparison Mode. Receives \u003ccode\u003e(attrValue, refValue)\u003c/code\u003e and should return boolean.\u003cbr\u003e\u003cbr\u003eExamples:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eStarts with\u003c/strong\u003e: \u003ccode\u003e(a, b) =\u003e a \u0026\u0026 a.indexOf(b) === 0\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eExists\u003c/strong\u003e: \u003ccode\u003e(a) =\u003e a !== undefined\u003c/code\u003e"
      },

    ],
    "help": "Finds the closest parent element where an attribute matches a value. Traverses up the DOM from the starting element.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFind parent by tag name\u003c/em\u003e***\u003cbr\u003eStarting Element Path: \u003cstrong\u003egtm.element\u003c/strong\u003e\u003cbr\u003eAttribute to Match: \u003cstrong\u003etagName\u003c/strong\u003e\u003cbr\u003eValue to Match: \u003cstrong\u003eA\u003c/strong\u003e\u003cbr\u003eComparison Mode: \u003cstrong\u003eeql\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003egtm.element.parentElement.parentElement\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eNo match returns undefined\u003c/em\u003e***\u003cbr\u003eStarting Element Path: \u003cstrong\u003egtm.element\u003c/strong\u003e\u003cbr\u003eValue to Match: \u003cstrong\u003eA\u003c/strong\u003e\u003cbr\u003eAttribute to Match: \u003cstrong\u003etagName\u003c/strong\u003e\u003cbr\u003eComparison Mode: \u003cstrong\u003eeql\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eundefined\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the starting element path."
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
        "help": "⚙️ Optional function to apply to the result path before returning it. Useful for chaining with getElementAttribute to directly retrieve an attribute value from the matched element."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Finds the closest parent element where an attribute matches a value.
 * 
 * @param {string} data.src - The starting element path in dataLayer (default: "gtm.element").
 * @param {string} data.attr - The attribute to check (href, class, id, data-*, tagName, innerText, custom).
 * @param {string} [data.customAttr] - Custom attribute name when attr is "custom".
 * @param {*} data.val - Value to match against.
 * @param {string} [data.mod] - Comparison mode: "eql" (exact, default), "cnt" (contains), "rgx" (regex).
 * @param {Function} [data.fn] - Optional custom comparison function (receives attrValue, refValue).
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function.
 * 
 * @returns {string|undefined} The dataLayer path to the matching element, or undefined if not found.
 *
 * @framework ggLowCodeGTMKit
 */
const copyFromDataLayer = require('copyFromDataLayer');
const getAttributePath = function(attr) {
    if (attr.indexOf('data-') === 0) {
        const camelCase = attr.substring(5).split('-').map(function(text, index) {
            if (index === 0) return text;
            return text.charAt(0).toUpperCase() + text.substring(1);
        }).join('');
        return '.dataset.' + camelCase;
    }
    if (attr === 'tagName') return '.tagName';
    if (attr === 'innerText') return '.innerText';
    return '.attributes.' + attr + '.value';
};
const getCompareFunction = function(mode) {
    if (mode === 'cnt') {
        return function(attrValue, refValue) {
            return typeof attrValue === 'string' && attrValue.indexOf(refValue) > -1;
        };
    }
    if (mode === 'rgx') {
        return function(attrValue, refValue) {
            return typeof attrValue === 'string' && !!attrValue.match(refValue);
        };
    }
    return function(attrValue, refValue) {
        return attrValue === refValue;
    };
};
const findClosestElement = function(startPath, attribute, value, mode, compareFn) {
    if (!attribute) return undefined;
    
    const attrPath = getAttributePath(attribute);
    let currentPath = startPath || 'gtm.element';
    const MAX_DEPTH = 15;
    let depth = 0;

    const compare = typeof compareFn === 'function'
        ? compareFn
        : getCompareFunction(mode);
    
    while (depth < MAX_DEPTH && copyFromDataLayer(currentPath + '.tagName')) {
        const attrValue = copyFromDataLayer(currentPath + attrPath);
        
        if (compare(attrValue, value)) {
            return currentPath;
        }
        
        currentPath = currentPath + '.parentElement';
        depth++;
    }
    
    return undefined;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// findClosestElement - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const startPath = applyCast(data.pre, data.src);
const actualAttr = data.attr === 'custom' ? data.customAttr : data.attr;
return out(findClosestElement(startPath, actualAttr, data.val, data.mod, data.fn));
// ===============================================================================
// findClosestElement(...) – Apply Mode
// ===============================================================================
/*
return function(startPath, value) {
    value = data.rp1 ? data.val : value;
    const actualAttr = data.attr === 'custom' ? data.customAttr : data.attr;
    return out(findClosestElement(startPath, actualAttr, value, data.mod, data.fn));
};
*/


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
  - name: '[example] Find parent by tag name'
    code: |-
      /* @display
      Starting Element Path: gtm.element
      Attribute to Match: tagName
      Value to Match: A
      Comparison Mode: eql
      @output
      gtm.element.parentElement.parentElement
      */
      mock('copyFromDataLayer', function(path) {
          if (path === 'gtm.element.tagName') return 'SPAN';
          if (path === 'gtm.element.parentElement.tagName') return 'DIV';
          if (path === 'gtm.element.parentElement.parentElement.tagName') return 'A';
          return undefined;
      });
      const src = 'gtm.element';
      const attr = 'tagName';
      const val = 'A';
      const mockData = {
          src: src,
          attr: attr,
          val: val,
          mod: 'eql',
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo('gtm.element.parentElement.parentElement');
  - name: Test find parent by data attribute
    code: |-
      mock('copyFromDataLayer', function(path) {
          if (path === 'gtm.element.tagName') return 'SPAN';
          if (path === 'gtm.element.dataset.trackClick') return undefined;
          if (path === 'gtm.element.parentElement.tagName') return 'DIV';
          if (path === 'gtm.element.parentElement.dataset.trackClick') return 'true';
          return undefined;
      });
      const src = 'gtm.element';
      const val = 'true';
      const mockData = {
          src: src,
          attr: 'data-track-click',
          val: val,
          mod: 'eql',
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo('gtm.element.parentElement');
  - name: Test find parent with custom contains function
    code: |-
      mock('copyFromDataLayer', function(path) {
          if (path === 'gtm.element.tagName') return 'SPAN';
          if (path === 'gtm.element.attributes.class.value') return 'icon small';
          if (path === 'gtm.element.parentElement.tagName') return 'BUTTON';
          if (path === 'gtm.element.parentElement.attributes.class.value') return 'btn btn-primary';
          return undefined;
      });
      const src = 'gtm.element';
      const val = 'btn';
      const mockData = {
          src: src,
          attr: 'class',
          val: val,
          mod: 'cnt',
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isEqualTo('gtm.element.parentElement');
  - name: Test find parent with exists function (no value needed)
    code: |-
      mock('copyFromDataLayer', function(path) {
          if (path === 'gtm.element.tagName') return 'SPAN';
          if (path === 'gtm.element.attributes.href.value') return undefined;
          if (path === 'gtm.element.parentElement.tagName') return 'A';
          if (path === 'gtm.element.parentElement.attributes.href.value') return '/products';
          return undefined;
      });
      const src = 'gtm.element';
      const fn = function(attrValue) {
          return attrValue !== undefined && attrValue !== null;
      };
      const mockData = {
          src: src,
          attr: 'href',
          val: null,
          mod: 'eql',
          fn: fn,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, null);
      }
      assertThat(variableResult).isEqualTo('gtm.element.parentElement');
  - name: '[example] No match returns undefined'
    code: |-
      /* @display
      Starting Element Path: gtm.element
      Value to Match: A
      Attribute to Match: tagName
      Comparison Mode: eql
      @output
      undefined
      */
      mock('copyFromDataLayer', function(path) {
          if (path === 'gtm.element.tagName') return 'SPAN';
          if (path === 'gtm.element.parentElement.tagName') return 'DIV';
          if (path === 'gtm.element.parentElement.parentElement.tagName') return undefined;
          return undefined;
      });
      const src = 'gtm.element';
      const val = 'A';
      const mockData = {
          src: src,
          attr: 'tagName',
          val: val,
          mod: 'eql',
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, val);
      }
      assertThat(variableResult).isUndefined();
setup: |-
  // Change this to switch test mode ('direct', 'runtime', or 'configured')
  const mode = 'direct';
  // ===================================================================================================
  // Derived flags
  // ===================================================================================================
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply'; 


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
