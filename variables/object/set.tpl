___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "set",
  "description": "Sets a value in an object using a dot-separated path. If the path doesn’t exist, it creates nested objects as needed.",
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
        "displayName": "Target Object",
        "simpleValueType": true,
        "help": "💾 The object to modify. \u003cstrong\u003eWarning:\u003c/strong\u003e This function mutates (modifies) the original object.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject variable\u003c/strong\u003e: \u003cem\u003e{{myObject}}\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eObject literal\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "pth",
        "displayName": "Property Path",
        "simpleValueType": true,
        "help": "💾 The path where to set the value. Creates nested objects automatically if they don't exist.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString (dot notation)\u003c/strong\u003e: \u003cem\u003e\"user.profile.name\"\u003c/em\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eArray\u003c/strong\u003e: \u003cem\u003e[\"user\", \"profile\", \"name\"]\u003c/em\u003e"
      },
      {
        "type": "TEXT",
        "name": "val",
        "displayName": "Value to Set",
        "simpleValueType": true,
        "help": "💾 The value to set at the specified path.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny type\u003c/strong\u003e: string, number, boolean, object, array"
      }
    ],
    "help": "Sets a property on an \u003cem\u003eobject\u003c/em\u003e at a given path, creating nested structures as needed.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSet simple property\u003c/em\u003e***\u003cbr\u003eTarget Object: \u003cstrong\u003e{name: 'John'}\u003c/strong\u003e\u003cbr\u003eProperty Path: \u003cstrong\u003eage\u003c/strong\u003e\u003cbr\u003eValue to Set: \u003cstrong\u003e30\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJohn\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eSet nested with auto-create\u003c/em\u003e***\u003cbr\u003eTarget Object: \u003cstrong\u003e{user: {}}\u003c/strong\u003e\u003cbr\u003eProperty Path: \u003cstrong\u003euser.profile.name\u003c/strong\u003e\u003cbr\u003eValue to Set: \u003cstrong\u003eJane\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eJane\u003c/strong\u003e"
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
        "help": "⚙️ Optional pre-processing function applied to the target object before setting the value (e.g., clone object to avoid mutation, normalize structure)."
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
        "help": "⚙️ Optional function to apply to the modified object before returning it (e.g., \u003ccode\u003eobj =\u003e JSON.stringify(obj)\u003c/code\u003e, \u003ccode\u003eobj =\u003e Object.freeze(obj)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Sets a value at a given path in an object, creating nested objects as needed.
 *
 * @param {Object} data.src - The target object to modify.
 * @param {string|Array} data.pth - The path where to set the value (e.g., "a.b.c" or ["a", "b", "c"]).
 * @param {*} data.val - The value to set at the path.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {Object} The modified object (mutates the original object).
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const set = function(object, path, value) {
    if (getType(object) !== 'object' || object === null) {
        return object;
    }
    
    const pathParts = getType(path) === 'array' 
        ? path.map(part => part.toString()) 
        : path.split('.');
    
    let current = object;
    for (let i = 0; i < pathParts.length; i++) {
        const key = pathParts[i];
        if (i === pathParts.length - 1) {
            current[key] = value;
        } else {
            if (getType(current[key]) !== 'object' || current[key] === null) {
                current[key] = {};
            }
            current = current[key];
        }
    }
    
    return object;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// set - Direct mode
// ===============================================================================

const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(set(value, data.pth, data.val));
// ===============================================================================
// set(...) – Apply Mode
// ===============================================================================
/*
return function(object, path, value) {
   path = data.rp1 ? data.pth : path;
   value = data.rp2 ? data.val : value;
   return out(set(object, path, value));
};
*/


___TESTS___

scenarios:
  - name: '[example] Set simple property'
    code: |-
      /* @display
      Target Object: {name: 'John'}
      Property Path: age
      Value to Set: 30
      @output
      John
      */
      const src = {name: 'John'};
      const pth = 'age';
      const val = 30;
      const mockData = {
          src: src,
          pth: pth,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth, val);
      }
      assertThat(variableResult.name).isEqualTo('John');
      assertThat(variableResult.age).isEqualTo(30);
  - name: '[example] Set nested with auto-create'
    code: |-
      /* @display
      Target Object: {user: {}}
      Property Path: user.profile.name
      Value to Set: Jane
      @output
      Jane
      */
      const src = {user: {}};
      const pth = 'user.profile.name';
      const val = 'Jane';
      const mockData = {
          src: src,
          pth: pth,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth, val);
      }
      assertThat(variableResult.user.profile.name).isEqualTo('Jane');
  - name: Test with array path format
    code: |-
      const src = {data: {}};
      const pth = ['data', 'settings', 'theme'];
      const val = 'dark';
      const mockData = {
          src: src,
          pth: pth,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth, val);
      }
      assertThat(variableResult.data.settings.theme).isEqualTo('dark');
  - name: Test overriding existing nested property
    code: |-
      const src = {user: {profile: {name: 'John', age: 30}}};
      const pth = 'user.profile.name';
      const val = 'Jane';
      const mockData = {
          src: src,
          pth: pth,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth, val);
      }
      assertThat(variableResult.user.profile.name).isEqualTo('Jane');
      assertThat(variableResult.user.profile.age).isEqualTo(30);
  - name: Test setting deeply nested property in empty object
    code: |-
      const src = {};
      const pth = 'a.b.c.d.e';
      const val = 'deep';
      const mockData = {
          src: src,
          pth: pth,
          val: val,
          rp1: false,
          rp2: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, pth, val);
      }
      assertThat(variableResult.a.b.c.d.e).isEqualTo('deep');
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
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

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
