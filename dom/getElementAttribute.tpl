___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "getElementAttribute",
  "description": "Gets an attribute value from a clicked element or its parents via dataLayer. Supports href, class, data-*, tagName, innerText, and custom attributes.",
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
        "displayName": "Element Path",
        "simpleValueType": true,
        "defaultValue": "gtm.element",
        "help": "💾 The dataLayer path to the element. Use \"gtm.element\" for clicked element, or add \".parentElement\" to traverse up.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eClicked element\u003c/strong\u003e: \u003cem\u003e\"gtm.element\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eParent\u003c/strong\u003e: \u003cem\u003e\"gtm.element.parentElement\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eGrandparent\u003c/strong\u003e: \u003cem\u003e\"gtm.element.parentElement.parentElement\"\u003c/em\u003e"
      },
      {
        "type": "SELECT",
        "name": "attr",
        "displayName": "Attribute",
        "selectItems": [
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
            "value": "tagName",
            "displayValue": "tagName"
          },
          {
            "value": "innerText",
            "displayValue": "innerText"
          },
          {
            "value": "custom",
            "displayValue": "Custom attribute..."
          }
        ],
        "simpleValueType": true,
        "help": "💾 The attribute to retrieve from the element."
      },
      {
        "type": "TEXT",
        "name": "customAttr",
        "displayName": "Custom Attribute Name",
        "simpleValueType": true,
        "help": "💾 Name of the custom attribute to retrieve.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eData attribute\u003c/strong\u003e: \u003cem\u003e\"data-product-id\"\u003c/em\u003e, \u003cem\u003e\"data-gtm-click\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny attribute\u003c/strong\u003e: \u003cem\u003e\"aria-label\"\u003c/em\u003e, \u003cem\u003e\"title\"\u003c/em\u003e",
        "enablingConditions": [
          {
            "paramName": "attr",
            "paramValue": "custom",
            "type": "EQUALS"
          }
        ]
      }
    ],
    "help": "Gets an attribute value from a DOM element via the dataLayer.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet href attribute\u003c/em\u003e***\u003cbr\u003eElement Path: \u003cstrong\u003egtm.element\u003c/strong\u003e\u003cbr\u003eAttribute: \u003cstrong\u003ehref\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e/products/shoes\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eGet tag name\u003c/em\u003e***\u003cbr\u003eElement Path: \u003cstrong\u003egtm.element\u003c/strong\u003e\u003cbr\u003eAttribute: \u003cstrong\u003etagName\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eA\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the element path before retrieval."
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
        "help": "⚙️ Optional function to apply to the attribute value before returning it (e.g., \u003ccode\u003eval =\u003e val.toLowerCase()\u003c/code\u003e, \u003ccode\u003eval =\u003e val.split(' ')[0]\u003c/code\u003e for first class). Useful for chaining transformations."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Gets an attribute value from a dataLayer element path.
 * 
 * @param {string} data.src - The element path in dataLayer (e.g., "gtm.element" or "gtm.element.parentElement").
 * @param {string} data.attr - The attribute to retrieve (href, class, id, data-*, tagName, innerText, custom).
 * @param {string} [data.customAttr] - Custom attribute name when attr is "custom".
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function.
 * 
 * @returns {string|undefined} The attribute value, or undefined if not found.
 *
 * @framework ggLowCodeGTMKit
 */
const copyFromDataLayer = require('copyFromDataLayer');

const attributePathCache = {};
const getAttributePath = function(attr) {
    if (attributePathCache[attr]) return attributePathCache[attr];
    let path;
    if (attr.indexOf('data-') === 0) {
        const camelCase = attr.substring(5).split('-').map(function(text, index) {
            if (index === 0) return text;
            return text.charAt(0).toUpperCase() + text.substring(1);
        }).join('');
        path = '.dataset.' + camelCase;
    } else if (attr === 'tagName') {
        path = '.tagName';
    } else if (attr === 'innerText') {
        path = '.innerText';
    } else {
        path = '.attributes.' + attr + '.value';
    }
    attributePathCache[attr] = path;
    return path;
};

const getElementAttribute = function(elementPath, attribute, customAttribute) {
    if (!elementPath || !attribute) {
        return undefined;
    }
    
    const actualAttr = attribute === 'custom' ? customAttribute : attribute;
    
    if (!actualAttr) {
        return undefined;
    }
    
    const fullPath = elementPath + getAttributePath(actualAttr);
    let value = copyFromDataLayer(fullPath);
    
    if (actualAttr === 'innerText' && typeof value === 'string') {
        value = value.trim().split('\n').join(' ').split('\t').join(' ');
    }
    
    return value;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// getElementAttribute - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const elementPath = applyCast(data.pre, data.src);
return out(getElementAttribute(elementPath, data.attr, data.customAttr));
// ===============================================================================
// getElementAttribute(...) – Apply Mode
// ===============================================================================
/*
return function(elementPath, attribute) {
   attribute = data.rp1 ? data.attr : attribute;
   const customAttribute = data.rp1 ? data.customAttr : undefined;
   return out(getElementAttribute(elementPath, attribute, customAttribute));
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
  - name: '[example] Get href attribute'
    code: |-
      /* @display
      Element Path: gtm.element
      Attribute: href
      @output
      /products/shoes
      */
      mock('copyFromDataLayer', function(path) {
          if (path === 'gtm.element.attributes.href.value') return '/products/shoes';
          return undefined;
      });

      const src = 'gtm.element';
      const attr = 'href';
      const mockData = {
          src: src,
          attr: attr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, attr);
      }
      assertThat(variableResult).isEqualTo('/products/shoes');
  - name: '[example] Get tag name'
    code: |-
      /* @display
      Element Path: gtm.element
      Attribute: tagName
      @output
      A
      */
      mock('copyFromDataLayer', function(path) {
          if (path === 'gtm.element.tagName') return 'A';
          return undefined;
      });

      const src = 'gtm.element';
      const attr = 'tagName';
      const mockData = {
          src: src,
          attr: attr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, attr);
      }
      assertThat(variableResult).isEqualTo('A');
  - name: Test get data-* attribute converts to camelCase
    code: |-
      mock('copyFromDataLayer', function(path) {
          if (path === 'gtm.element.dataset.productId') return '12345';
          return undefined;
      });

      const src = 'gtm.element';
      const attr = 'data-product-id';
      const mockData = {
          src: src,
          attr: attr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, attr);
      }
      assertThat(variableResult).isEqualTo('12345');
  - name: Test get innerText attribute cleans whitespace
    code: |-
      mock('copyFromDataLayer', function(path) {
          if (path === 'gtm.element.innerText') return '  Hello\n\tWorld  ';
          return undefined;
      });

      const src = 'gtm.element';
      const attr = 'innerText';
      const mockData = {
          src: src,
          attr: attr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, attr);
      }
      assertThat(variableResult).isEqualTo('Hello  World');
  - name: Test get attribute from parent element
    code: |-
      mock('copyFromDataLayer', function(path) {
          if (path === 'gtm.element.parentElement.attributes.class.value') return 'container main';
          return undefined;
      });

      const src = 'gtm.element.parentElement';
      const attr = 'class';
      const mockData = {
          src: src,
          attr: attr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, attr);
      }
      assertThat(variableResult).isEqualTo('container main');
  - name: Test undefined element path returns undefined
    code: |-
      const src = '';
      const attr = 'href';
      const mockData = {
          src: src,
          attr: attr,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, attr);
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
