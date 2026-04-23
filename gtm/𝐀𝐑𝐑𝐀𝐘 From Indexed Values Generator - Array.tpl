___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "𝐀𝐑𝐑𝐀𝐘 From Indexed Values Generator - Array",
  "description": "Creates an ordered \u003cem\u003earray\u003c/em\u003e from indexed values. Items are placed at their specified index — gaps become \u003cem\u003eundefined\u003c/em\u003e. Unindexed items can optionally be appended at the end.",
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
        "type": "LABEL",
        "name": "h1_ARRAY",
        "displayName": "____________________ \u003cbr\u003e \u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;🅰🆁🆁🅰🆈\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp; \u003cbr\u003e ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "ivl",
        "displayName": "Indexed Values",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Index",
            "name": "ind",
            "type": "TEXT"
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "val",
            "type": "TEXT"
          }
        ],
        "newRowButtonText": "+ Add Value",
        "help": "💾 Define values with optional indices.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eIndex column:\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Valid indices: Non-negative numbers (0, 1, 2, ...)\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Invalid/empty indices: Values are appended at the end (if enabled)\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Gaps in indices: Filled with \u003ccode\u003eundefined\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eValue column:\u003c/strong\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Any value (string, number, variable, etc.)"
      },
      {
        "type": "CHECKBOX",
        "name": "aui",
        "checkboxText": "Append unindexed values at the end",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "✓ When enabled, values without valid indices are appended after the indexed values. When disabled, unindexed values are excluded from the result."
      }
    ],
    "help": "Generates an array from indexed table values, ordered by index.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eTransform with mapper\u003c/em\u003e***\u003cbr\u003eIndexed Values: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003eAppend unindexed values at the end: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003eMapper Function (optional): \u003cstrong\u003eval =\u003e val.toUpperCase()\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['HELLO', 'WORLD', 'EXTRA']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eArray ordered by index\u003c/em\u003e***\u003cbr\u003eIndexed Values: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003eAppend unindexed values at the end: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['first', 'second', 'third']\u003c/strong\u003e"
  },
  {
    "type": "GROUP",
    "name": "Value Processing",
    "displayName": "Value Processing",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "TEXT",
        "name": "map",
        "displayName": "Mapper Function (optional)",
        "simpleValueType": true,
        "help": "⚙️ Optional function to transform \u003cstrong\u003eeach individual value\u003c/strong\u003e before adding it to the array: \u003ccode\u003eval =\u003e transformedVal\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eUse this for:\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Trim whitespace: \u003ccode\u003eval =\u003e val.trim()\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Parse numbers: \u003ccode\u003eval =\u003e parseFloat(val)\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Transform case: \u003ccode\u003eval =\u003e val.toUpperCase()\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Add prefix: \u003ccode\u003eval =\u003e 'item_' + val\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eNote: This applies to each value individually, including both indexed and unindexed values."
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
        "help": "⚙️ Optional function to transform the \u003cstrong\u003eentire array\u003c/strong\u003e before returning it: \u003ccode\u003earr =\u003e transformedArr\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eUse this for:\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Remove gaps: \u003ccode\u003earr =\u003e arr.filter(x =\u003e x !== undefined)\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Convert to string: \u003ccode\u003earr =\u003e arr.join(',')\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Reverse array: \u003ccode\u003earr =\u003e arr.reverse()\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eNote: This applies to the complete array after all values have been processed and positioned."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Converts indexed objects into a properly ordered array with optional unindexed values appended.
 * 
 * @param {Array<{ind?: number, val: any}>} data.ivl - Array of objects with optional index (ind) and value (val).
 * @param {boolean} [data.aui=true] - Whether to append unindexed values at the end.
 * @param {Function} [data.map] - Optional function to transform each value before adding to array.
 * @param {Function|string} [data.out] - Optional output handler.
 * 
 * @returns {Array} Ordered array with indexed values and optionally appended unindexed values.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');
const makeNumber = require('makeNumber');

const buildArrayFromIndexedValues = function(ivl, aui, mapper) {
    const indexedObjects = getType(ivl) === 'array' && ivl || [];
    const appendUnindexed = typeof aui !== 'undefined' ? aui : true;
    if (typeof mapper !== 'function') mapper = function(x) { return x; };

    const indexed = [];
    const unindexed = [];

    indexedObjects.forEach(obj => {
        if (obj && obj.hasOwnProperty('ind') && obj.ind !== null && obj.ind !== undefined && obj.ind !== '') {
            const idx = makeNumber(obj.ind);
            if (typeof idx === 'number' && idx >= 0 && idx === idx) { 
                indexed.push(obj);
            } else if (obj.hasOwnProperty('val')) {
                unindexed.push(obj);
            }
        } else if (obj && obj.hasOwnProperty('val')) {
            unindexed.push(obj);
        }
    });

    indexed.sort((a, b) => makeNumber(a.ind) - makeNumber(b.ind));

    let maxIndex = -1;
    indexed.forEach(obj => {
        const idx = makeNumber(obj.ind);
        if (idx > maxIndex) {
            maxIndex = idx;
        }
    });

    const result = [];
    result.length = maxIndex + 1;

    indexed.forEach(obj => {
        result[makeNumber(obj.ind)] = mapper(obj.val);
    });

    if (appendUnindexed) {
        unindexed.forEach(obj => result.push(mapper(obj.val)));
    }

    return result;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

return out(buildArrayFromIndexedValues(data.ivl, data.aui, safeFunction(data.map)));


___TESTS___

scenarios:
  - name: '[example] Transform with mapper'
    code: |-
      /* @display
      Indexed Values: [{ind: 0, val: 'hello'}, {ind: 1, val: 'world'}, {val: 'extra'}]
      Append unindexed values at the end: true
      Mapper Function (optional): val => val.toUpperCase()
      @output
      ['HELLO', 'WORLD', 'EXTRA']
      */
      const mockData = {
          ivl: [
              {ind: 0, val: 'hello'},
              {ind: 1, val: 'world'},
              {val: 'extra'}
          ],
          aui: true,
          map: val => val.toUpperCase()
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['HELLO', 'WORLD', 'EXTRA']);
  - name: '[example] Array ordered by index'
    code: |
      /* @display
      Indexed Values: [{ind: 0, val: 'first'}, {ind: 2, val: 'third'}, {ind: 1, val: 'second'}]
      Append unindexed values at the end: true
      @output
      ['first', 'second', 'third']
      */
      const mockData = {
          ivl: [
              {ind: 0, val: 'first'},
              {ind: 2, val: 'third'},
              {ind: 1, val: 'second'}
          ],
          aui: true
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['first', 'second', 'third']);
  - name: Array with gaps - should fill with undefined
    code: |-
      const mockData = {
          ivl: [
              {ind: 0, val: 'start'},
              {ind: 3, val: 'end'}
          ],
          aui: true
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['start', undefined, undefined, 'end']);
  - name: Unindexed values appended - should add at the end
    code: |-
      const mockData = {
          ivl: [
              {ind: 0, val: 'indexed'},
              {val: 'unindexed1'},
              {val: 'unindexed2'}
          ],
          aui: true
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['indexed', 'unindexed1', 'unindexed2']);
  - name: Unindexed values not appended - should exclude them
    code: |-
      const mockData = {
          ivl: [
              {ind: 0, val: 'indexed'},
              {val: 'unindexed1'},
              {val: 'unindexed2'}
          ],
          aui: false
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['indexed']);
  - name: Mixed indexed and unindexed with gaps
    code: |
      const mockData = {
          ivl: [
              {ind: 0, val: 'first'},
              {val: 'extra1'},
              {ind: 2, val: 'third'},
              {val: 'extra2'}
          ],
          aui: true
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['first', undefined, 'third', 'extra1', 'extra2']);
  - name: Invalid indices - should treat as unindexed
    code: |-
      const mockData = {
          ivl: [
              {ind: 0, val: 'valid'},
              {ind: -1, val: 'negative'},
              {ind: 'abc', val: 'string'},
              {ind: null, val: 'null'}
          ],
          aui: true
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['valid', 'negative', 'string', 'null']);
  - name: Empty array - should return empty array
    code: |
      const mockData = {
          ivl: [],
          aui: true
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo([]);
  - name: Duplicate indices - last one should win
    code: |-
      const mockData = {
          ivl: [
              {ind: 0, val: 'first'},
              {ind: 0, val: 'overwrite'},
              {ind: 1, val: 'second'}
          ],
          aui: true
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['overwrite', 'second']);
  - name: Output function to remove undefined - should filter gaps
    code: |-
      const mockData = {
          ivl: [
              {ind: 0, val: 'start'},
              {ind: 3, val: 'end'}
          ],
          aui: true,
          out: arr => arr.filter(x => x !== undefined)
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['start', 'end']);
  - name: Unsorted indices - should sort properly
    code: |-
      const mockData = {
          ivl: [
              {ind: 5, val: 'five'},
              {ind: 1, val: 'one'},
              {ind: 3, val: 'three'},
              {ind: 0, val: 'zero'}
          ],
          aui: true
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['zero', 'one', undefined, 'three', undefined, 'five']);


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
