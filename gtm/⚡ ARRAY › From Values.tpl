___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "⚡ ARRAY › From Values",
  "description": "Creates an \u003cem\u003earray\u003c/em\u003e from a simple table by extracting values from each row. Supports an optional transform \u003cem\u003efunction\u003c/em\u003e applied to each value before adding to the \u003cem\u003earray\u003c/em\u003e.",
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
        "name": "tbl",
        "displayName": "Array Values",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "val",
            "type": "TEXT"
          }
        ],
        "newRowButtonText": "+ Add Value",
        "help": "💾 Define the values to include in the array.\u003cbr\u003e\u003cbr\u003eEach row will become an element in the resulting array. Empty values and variables are preserved."
      }
    ],
    "help": "Generates an array from a simple GTM table of values.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eArray from table values\u003c/em\u003e***\u003cbr\u003eArray Values: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e['apple', 'banana', 'cherry']\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eEmpty table returns empty\u003c/em\u003e***\u003cbr\u003eArray Values: \u003cstrong\u003e[]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e[]\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to transform \u003cstrong\u003eeach individual value\u003c/strong\u003e before adding it to the array: \u003ccode\u003eval =\u003e transformedVal\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eUse this for:\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Split strings: \u003ccode\u003eval =\u003e val.split(',')\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Trim whitespace: \u003ccode\u003eval =\u003e val.trim()\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Parse numbers: \u003ccode\u003eval =\u003e parseFloat(val)\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Transform case: \u003ccode\u003eval =\u003e val.toUpperCase()\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eNote: This applies to each value individually, before creating the final array."
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
        "help": "⚙️ Optional function to transform the \u003cstrong\u003eentire array\u003c/strong\u003e before returning it: \u003ccode\u003earr =\u003e transformedArr\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eUse this for:\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Filter array: \u003ccode\u003earr =\u003e arr.filter(x =\u003e x)\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Flatten nested arrays: \u003ccode\u003earr =\u003e arr.flat()\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Convert to string: \u003ccode\u003earr =\u003e arr.join(',')\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Sort array: \u003ccode\u003earr =\u003e arr.sort()\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eNote: This applies to the complete array after all values have been processed."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Creates an array from a simple table by extracting and optionally transforming values from the 'val' column.
 * 
 * @param {Array<Object>} data.tbl - The array of objects representing the simple table.
 * @param {Function} [data.map] - Optional function to transform each value before adding to array.
 * @param {Function|string} [data.out] - Optional output handler.
 * 
 * @returns {Array} An array of values extracted from the 'val' column.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const buildArrayFromValues = function(tbl, map) {
    const simpleTable = getType(tbl) === 'array' && tbl || [];
    const mapper = typeof map === 'function' ? map : x => x;

    const result = [];

    for (let i = 0; i < simpleTable.length; i++) {
        const item = simpleTable[i];
        if (item) {
            result.push(mapper(item.val));
        }
    }
    return result;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

return out(buildArrayFromValues(data.tbl, data.map));


___TESTS___

scenarios:
  - name: '[example] Array from table values'
    code: |
      /* @display
      Array Values: [{val: 'apple'}, {val: 'banana'}, {val: 'cherry'}]
      @output
      ['apple', 'banana', 'cherry']
      */
      const mockData = {
          tbl: [
              {val: 'apple'},
              {val: 'banana'},
              {val: 'cherry'}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['apple', 'banana', 'cherry']);
  - name: '[example] Empty table returns empty'
    code: |-
      /* @display
      Array Values: []
      @output
      []
      */
      const mockData = {
          tbl: []
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo([]);
  - name: Table with undefined and empty values - should preserve them
    code: |-
      const mockData = {
          tbl: [
              {val: 'first'},
              {val: undefined},
              {val: ''},
              {val: 'last'}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['first', undefined, '', 'last']);
  - name: Table with null items - should skip null items
    code: |-
      const mockData = {
          tbl: [
              {val: 'one'},
              null,
              {val: 'three'}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['one', 'three']);
  - name: Mapper function to transform each value - should apply to all values
    code: |-
      const mockData = {
          tbl: [
              {val: 'hello'},
              {val: 'world'}
          ],
          map: val => val.toUpperCase()
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['HELLO', 'WORLD']);
  - name: Mapper with split function - should split each string into array
    code: |-
      const mockData = {
          tbl: [
              {val: 'a,b,c'},
              {val: 'd,e,f'}
          ],
          map: val => val.split(',')
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo([['a','b','c'], ['d','e','f']]);
  - name: Output function to filter array - should remove empty values
    code: |-
      const mockData = {
          tbl: [
              {val: 'first'},
              {val: ''},
              {val: 'second'},
              {val: undefined}
          ],
          out: arr => arr.filter(x => x)
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['first', 'second']);
  - name: Output function to join array - should convert to CSV string
    code: |-
      const mockData = {
          tbl: [
              {val: 'apple'},
              {val: 'banana'},
              {val: 'cherry'}
          ],
          out: arr => arr.join(',')
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo('apple,banana,cherry');
  - name: Combination of mapper and output - should apply mapper first then output
    code: |-
      const mockData = {
          tbl: [
              {val: 'a,b,c'},
              {val: 'd,e,f'}
          ],
          map: val => val.split(','),
          out: arr => {
              const result = [];
              for (let i = 0; i < arr.length; i++) {
                  for (let j = 0; j < arr[i].length; j++) {
                      result.push(arr[i][j]);
                  }
              }
              return result;
          }
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['a', 'b', 'c', 'd', 'e', 'f']);
  - name: Different value types - should preserve types
    code: |-
      const mockData = {
          tbl: [
              {val: 'string'},
              {val: 123},
              {val: true},
              {val: false},
              {val: 0}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo(['string', 123, true, false, 0]);


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
