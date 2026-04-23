___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "𝐎𝐁𝐉𝐄𝐂𝐓 From Arrays Generator - Object",
  "description": "Maps two \u003cem\u003earrays\u003c/em\u003e or comma-separated \u003cem\u003estrings\u003c/em\u003e into an \u003cem\u003eobject\u003c/em\u003e. Uses the keys array length as reference — missing values become \u003cem\u003eundefined\u003c/em\u003e and extra values are ignored.",
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
    "help": "Maps two \u003cem\u003earrays\u003c/em\u003e or comma-separated \u003cem\u003estrings\u003c/em\u003e into an \u003cem\u003eobject\u003c/em\u003e. Uses the keys array length as reference — missing values become \u003cem\u003eundefined\u003c/em\u003e, extra values are ignored.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eBasic mapping\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eKeys: \"name,age,city\", Values: \"John,30,Paris\"\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{name: \"John\", age: \"30\", city: \"Paris\"}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eMissing values\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eKeys: [\"firstName\", \"lastName\", \"email\"], Values: [\"Alice\", \"Smith\"]\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{firstName: \"Alice\", lastName: \"Smith\", email: undefined}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eCustom separator\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eKeys: \"name|age|city\", Values: \"Bob|25|London\", Separator: \"|\"\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{name: \"Bob\", age: \"25\", city: \"London\"}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eWith GTM variables\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003eKeys: {{DL - Form Fields}}, Values: {{DL - Form Values}}\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{field1: \"value1\", field2: \"value2\", ...}\u003c/strong\u003e"
  },
  {
    "type": "TEXT",
    "name": "keys",
    "displayName": "Keys (Property Names)",
    "simpleValueType": true,
    "help": "🔑 Array of property names or comma-separated string.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eAccepted formats:\u003c/strong\u003e\u003cbr\u003e• Array: \u003ccode\u003e[\u0027name\u0027, \u0027age\u0027, \u0027city\u0027]\u003c/code\u003e\u003cbr\u003e• String: \u003ccode\u003ename,age,city\u003c/code\u003e\u003cbr\u003e• Variable: \u003ccode\u003e{{Key Array Variable}}\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eNotes:\u003c/strong\u003e\u003cbr\u003e• Empty keys are skipped\u003cbr\u003e• Duplicate keys: last value wins\u003cbr\u003e• Special characters allowed: \u003ccode\u003euser.name\u003c/code\u003e, \u003ccode\u003euser-id\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003ename,email,phone\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e[\u0027firstName\u0027, \u0027lastName\u0027, \u0027age\u0027]\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e{{Form Field Names}}\u003c/code\u003e"
  },
  {
    "type": "TEXT",
    "name": "vals",
    "displayName": "Values",
    "simpleValueType": true,
    "help": "💾 Array of values or comma-separated string.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eAccepted formats:\u003c/strong\u003e\u003cbr\u003e• Array: \u003ccode\u003e[\u0027John\u0027, 30, \u0027Paris\u0027]\u003c/code\u003e\u003cbr\u003e• String: \u003ccode\u003eJohn,30,Paris\u003c/code\u003e\u003cbr\u003e• Variable: \u003ccode\u003e{{Value Array Variable}}\u003c/code\u003e\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eNotes:\u003c/strong\u003e\u003cbr\u003e• Values matched to keys by position\u003cbr\u003e• Missing values → \u003ccode\u003eundefined\u003c/code\u003e\u003cbr\u003e• Extra values → ignored\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003eJohn Doe,john@example.com,555-1234\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e[\u0027Alice\u0027, \u0027alice@test.com\u0027, \u0027555-5678\u0027]\u003c/code\u003e\u003cbr\u003e• \u003ccode\u003e{{Form Field Values}}\u003c/code\u003e"
  },
  {
    "type": "TEXT",
    "name": "sep",
    "displayName": "Separator (optional)",
    "simpleValueType": true,
    "defaultValue": ",",
    "help": "✂️ Character(s) used to split strings into arrays.\u003cbr\u003e\u003cbr\u003eOnly applies when keys or vals are strings (not arrays).\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eDefault:\u003c/strong\u003e \u003ccode\u003e,\u003c/code\u003e (comma)\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003e,\u003c/code\u003e → Comma (default)\u003cbr\u003e• \u003ccode\u003e|\u003c/code\u003e → Pipe\u003cbr\u003e• \u003ccode\u003e;\u003c/code\u003e → Semicolon\u003cbr\u003e• \u003ccode\u003e; \u003c/code\u003e → Semicolon with space\u003cbr\u003e• \u003ccode\u003e\\t\u003c/code\u003e → Tab character\u003cbr\u003e\u003cbr\u003e💡 For arrays, this parameter is ignored."
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
        "help": "⚙️ Optional function to transform the final object before returning it.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eExamples:\u003c/strong\u003e\u003cbr\u003e• \u003ccode\u003eobj \u003d\u003e JSON.stringify(obj)\u003c/code\u003e → Convert to JSON string\u003cbr\u003e• \u003ccode\u003eobj \u003d\u003e Object.keys(obj).length\u003c/code\u003e → Count properties\u003cbr\u003e• \u003ccode\u003eobj \u003d\u003e ({...obj, timestamp: Date.now()})\u003c/code\u003e → Add timestamp\u003cbr\u003e• \u003ccode\u003eobj \u003d\u003e Object.entries(obj)\u003c/code\u003e → Convert to array of pairs\u003cbr\u003e\u003cbr\u003eUseful for post-processing or format conversion."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Maps two arrays into an object, using keys array length as reference.
 * If a value is missing, assigns undefined. Extra values are ignored.
 *
 * Direct-mode only
 * @param {Array|string} data.keys - Array of property names, or comma-separated string
 * @param {Array|string} data.vals - Array of values, or comma-separated string
 * @param {string} [data.sep] - Separator for string splitting (default: ',')
 * @param {Function} [data.out] - Optional function to transform the final object
 *
 * @returns {Object} Object with keys and corresponding values (undefined if missing)
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const buildObjectFromArrays = function(keysInput, valsInput, sep) {
    const separator = sep || ',';

    const arrKeys = getType(keysInput) === 'array'
        ? keysInput 
        : (typeof keysInput === 'string' ? keysInput.split(separator) : []);

    const arrValues =  getType(valsInput) === 'array'
        ? valsInput 
        : (typeof valsInput === 'string' ? valsInput.split(separator) : []);

    const result = {};
    for (let i = 0; i < arrKeys.length; i++) {
        const key = arrKeys[i];
        if (key !== '' && key != null) {
            result[key] = i < arrValues.length ? arrValues[i] : undefined;
        }
    }
    return result;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

return out(buildObjectFromArrays(data.keys, data.vals, data.sep));


___TESTS___

scenarios:
  - name: '[example] Pair keys and values'
    code: |-
      /* @display
      Keys (Property Names): name,age,city
      Values: John,30,Paris
      Separator (optional): ,
      @output
      {"name":"John","age":30,"city":"Paris"}
      */
      const keys = ['name', 'age', 'city'];
      const vals = ['John', 30, 'Paris'];
      const mockData = {
          keys: keys,
          vals: vals,
          sep: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo(30);
      assertThat(variableResult.city).isEqualTo('Paris');
  - name: String input with default separator
    code: |
      const keys = 'name,age,city';
      const vals = 'John,30,Paris';
      const mockData = {
          keys: keys,
          vals: vals,
          sep: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo('30');
      assertThat(variableResult.city).isEqualTo('Paris');
  - name: '[example] Custom separator'
    code: |-
      /* @display
      Keys (Property Names): name|age|city
      Values: John|30|Paris
      Separator (optional): |
      @output
      {"name":"John","age":"30","city":"Paris"}
      */
      const keys = 'name|age|city';
      const vals = 'John|30|Paris';
      const mockData = {
          keys: keys,
          vals: vals,
          sep: '|',
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo('30');
      assertThat(variableResult.city).isEqualTo('Paris');
  - name: Missing values - assigns undefined
    code: |
      const keys = ['name', 'age', 'city'];
      const vals = ['John', 30];
      const mockData = {
          keys: keys,
          vals: vals,
          sep: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo(30);
      assertThat(variableResult.city).isUndefined();
  - name: Extra values - ignored
    code: |-
      const keys = ['name', 'age'];
      const vals = ['John', 30, 'Paris', 'France'];
      const mockData = {
          keys: keys,
          vals: vals,
          sep: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo(30);
      assertThat(variableResult.city).isUndefined();
  - name: Empty key is skipped
    code: |-
      const keys = ['name', '', 'age'];
      const vals = ['John', 'ignored', 30];
      const mockData = {
          keys: keys,
          vals: vals,
          sep: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult['']).isUndefined();
      assertThat(variableResult.age).isEqualTo(30);
  - name: Null key is skipped
    code: |-
      const keys = ['name', null, 'age'];
      const vals = ['John', 'ignored', 30];
      const mockData = {
          keys: keys,
          vals: vals,
          sep: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo(30);
  - name: Mix of array and string
    code: |-
      const keys = ['name', 'age', 'city'];
      const vals = 'John,30,Paris';
      const mockData = {
          keys: keys,
          vals: vals,
          sep: ',',
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo('30');
      assertThat(variableResult.city).isEqualTo('Paris');
  - name: Special characters in keys
    code: |-
      const keys = ['user.name', 'user-age', 'user_city'];
      const vals = ['John', 30, 'Paris'];
      const mockData = {
          keys: keys,
          vals: vals,
          sep: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult['user.name']).isEqualTo('John');
      assertThat(variableResult['user-age']).isEqualTo(30);
      assertThat(variableResult['user_city']).isEqualTo('Paris');
  - name: Empty values array
    code: |-
      const keys = ['name', 'age'];
      const vals = [];
      const mockData = {
          keys: keys,
          vals: vals,
          sep: undefined,
          out: undefined
      };
      let variableResult = runCode(mockData);
      assertThat(variableResult.name).isUndefined();
      assertThat(variableResult.age).isUndefined();


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
