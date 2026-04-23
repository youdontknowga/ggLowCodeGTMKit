___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "itemSplitProperty",
  "description": "Splits a breadcrumb \u003cem\u003ecategory\u003c/em\u003e string (e.g. \"Clothing>Men>T-Shirts\") into GA4's flat \u003cem\u003eitem_category\u003c/em\u003e, \u003cem\u003eitem_category2\u003c/em\u003e, ..., \u003cem\u003eitem_category5\u003c/em\u003e structure on each item.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "paramSection",
    "displayName": "\ud835\ude0b\ud835\ude26\ud835\ude34\ud835\ude24\ud835\ude33\ud835\ude2a\ud835\ude31\ud835\ude35\ud835\ude2a\ud835\ude30\ud835\ude2f",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "src",
        "displayName": "Items (Array of Objects)",
        "simpleValueType": true,
        "help": "\ud83d\udcbe   Array of e-commerce items to process.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;\u2713 \u003cstrong\u003eArray\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "prp",
        "displayName": "Category Property",
        "simpleValueType": true,
        "defaultValue": "item_category",
        "help": "\ud83d\udcbe   The property containing the breadcrumb string to expand (default: item_category).\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;\u2713 \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "sep",
        "displayName": "Separator",
        "simpleValueType": true,
        "defaultValue": ">",
        "help": "\ud83d\udcbe   The delimiter used in the breadcrumb string (default: >).\u003cbr\u003e\u003cbr\u003e  Common separators:\u003cbr\u003e \u0026nbsp;\u0026nbsp;\u2713 \u003cstrong\u003e>\u003c/strong\u003e (Shopify, WooCommerce)\u003cbr\u003e \u0026nbsp;\u0026nbsp;\u2713 \u003cstrong\u003e/\u003c/strong\u003e (Magento)\u003cbr\u003e \u0026nbsp;\u0026nbsp;\u2713 \u003cstrong\u003e|\u003c/strong\u003e (custom)"
      }
    ],
    "help": "Splits a breadcrumb category string into GA4's flat item_category structure.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExpand breadcrumb categories\u003c/em\u003e***\u003cbr\u003eItems: \u003cstrong\u003e[{item_name: \"Blue T-Shirt\", item_category: \"Clothing>Men>T-Shirts\"}]\u003c/strong\u003e\u003cbr\u003eCategory Property: \u003cstrong\u003eitem_category\u003c/strong\u003e\u003cbr\u003eSeparator: \u003cstrong\u003e>\u003c/strong\u003e\u003cbr\u003e\u2197\ufe0f Output: \u003cstrong\u003e[{item_name: \"Blue T-Shirt\", item_category: \"Clothing\", item_category2: \"Men\", item_category3: \"T-Shirts\"}]\u003c/strong\u003e"
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
        "help": "\u2699\ufe0f Optional pre-processing function applied to the input before internal logic (e.g., convert object to string, normalize case). Internal transformations such as case handling will still apply afterward."
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
        "help": "\u2699\ufe0f Optional function to apply to the result before returning it (e.g., str =\u003e str + ' \u20ac', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Splits a breadcrumb category string into GA4's flat item_category structure.
 * GA4 supports item_category through item_category5 (5 levels max).
 *
 * @param {Array} data.src - Array of e-commerce items.
 * @param {string} data.prp - The property containing the breadcrumb string (default: "item_category").
 * @param {string} data.sep - The delimiter used in the breadcrumb (default: ">").
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {Array} Items with the specified property split into numbered properties.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const itemSplitProperty = function(items, property, separator) {
    if (getType(items) !== 'array') return [];
    property = property || 'item_category';
    separator = separator || '>';

    return items.map(function(item) {
        if (item == null || typeof item !== 'object') return item;
        const catValue = item[property];
        if (typeof catValue !== 'string' || catValue.indexOf(separator) === -1) return item;

        const parts = catValue.split(separator);
        const result = {};
        for (var k in item) {
            if (item.hasOwnProperty(k)) result[k] = item[k];
        }

        for (var i = 0; i < parts.length; i++) {
            var trimmed = typeof parts[i] === 'string' ? parts[i].trim() : '';
            if (trimmed) result[i === 0 ? property : property + (i + 1)] = trimmed;
        }

        return result;
    });
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// itemSplitProperty - Direct mode
// ===============================================================================
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(itemSplitProperty(value, data.prp, data.sep));

// ===============================================================================
// itemSplitProperty(...) - Apply Mode
// ===============================================================================
/*
return function(value, property) {
   property = data.rp1 ? property : data.prp;
   return out(itemSplitProperty(value, property, data.sep));
};
*/


___TESTS___

scenarios:
  - name: '[example] Expand breadcrumb categories'
    code: |
      /* @display
      Items (Array of Objects): [{item_name: "Blue T-Shirt", item_category: "Clothing>Men>T-Shirts"}]
      Category Property: item_category
      Separator: >
      @output
      [{item_name: "Blue T-Shirt", item_category: "Clothing", item_category2: "Men", item_category3: "T-Shirts"}]
      */
      const src = [{item_name: "Blue T-Shirt", item_category: "Clothing>Men>T-Shirts"}];
      const mockData = { src: src, prp: "item_category", sep: ">", rp1: false };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, "item_category");
      }
      assertThat(variableResult).isEqualTo([{item_name: "Blue T-Shirt", item_category: "Clothing", item_category2: "Men", item_category3: "T-Shirts"}]);
  - name: '[example] Multiple items with different depths'
    code: |
      /* @display
      Items (Array of Objects): [{item_name: "Shirt", item_category: "Clothing>Men"}, {item_name: "Laptop", item_category: "Electronics>Computers>Laptops>Gaming>Premium"}]
      Category Property: item_category
      Separator: >
      @output
      [{item_name: "Shirt", item_category: "Clothing", item_category2: "Men"}, {item_name: "Laptop", item_category: "Electronics", item_category2: "Computers", item_category3: "Laptops", item_category4: "Gaming", item_category5: "Premium"}]
      */
      const src = [
          {item_name: "Shirt", item_category: "Clothing>Men"},
          {item_name: "Laptop", item_category: "Electronics>Computers>Laptops>Gaming>Premium"}
      ];
      const mockData = { src: src, prp: "item_category", sep: ">", rp1: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, "item_category");
      assertThat(variableResult).isEqualTo([
          {item_name: "Shirt", item_category: "Clothing", item_category2: "Men"},
          {item_name: "Laptop", item_category: "Electronics", item_category2: "Computers", item_category3: "Laptops", item_category4: "Gaming", item_category5: "Premium"}
      ]);
  - name: No separator in value - returns item unchanged
    code: |-
      const src = [{item_name: "Shirt", item_category: "Clothing"}];
      const mockData = { src: src, prp: "item_category", sep: ">", rp1: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, "item_category");
      assertThat(variableResult).isEqualTo([{item_name: "Shirt", item_category: "Clothing"}]);
  - name: Slash separator (Magento style)
    code: |-
      const src = [{item_name: "Shirt", item_category: "Clothing/Men/T-Shirts"}];
      const mockData = { src: src, prp: "item_category", sep: "/", rp1: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, "item_category");
      assertThat(variableResult).isEqualTo([{item_name: "Shirt", item_category: "Clothing", item_category2: "Men", item_category3: "T-Shirts"}]);
  - name: Trims whitespace from parts
    code: |-
      const src = [{item_name: "Shirt", item_category: "Clothing > Men > T-Shirts"}];
      const mockData = { src: src, prp: "item_category", sep: ">", rp1: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, "item_category");
      assertThat(variableResult).isEqualTo([{item_name: "Shirt", item_category: "Clothing", item_category2: "Men", item_category3: "T-Shirts"}]);
  - name: Handles any depth dynamically
    code: |-
      const src = [{item_category: "A>B>C>D>E>F>G"}];
      const mockData = { src: src, prp: "item_category", sep: ">", rp1: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, "item_category");
      assertThat(variableResult).isEqualTo([{item_category: "A", item_category2: "B", item_category3: "C", item_category4: "D", item_category5: "E", item_category6: "F", item_category7: "G"}]);
  - name: Empty array returns empty
    code: |-
      const mockData = { src: [], prp: "item_category", sep: ">", rp1: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)([], "item_category");
      assertThat(variableResult).isEqualTo([]);
  - name: Missing category property - returns items unchanged
    code: |-
      const src = [{item_name: "Shirt", price: 10}];
      const mockData = { src: src, prp: "item_category", sep: ">", rp1: false };
      let variableResult = isDirectMode ? runCode(mockData) : runCode(mockData)(src, "item_category");
      assertThat(variableResult).isEqualTo([{item_name: "Shirt", price: 10}]);
setup: |-
  const mode = 'direct';
  const isDirectMode = mode === 'direct';
  const isApplyMode = mode === 'apply';


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
