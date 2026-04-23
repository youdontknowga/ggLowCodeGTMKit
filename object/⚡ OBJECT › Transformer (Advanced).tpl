___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "⚡ OBJECT › Transformer (Advanced)",
  "description": "Transforms an \u003cem\u003eobject\u003c/em\u003e by renaming keys and applying \u003cem\u003efunctions\u003c/em\u003e to their values. Supports nested paths with dot notation, automatic structure creation, custom getter/setter functions.",
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
        "name": "h1_OBJECT",
        "displayName": "____________________ \u003cbr\u003e \u0026nbsp;\u0026nbsp;\u0026nbsp\u0026nbsp🅾🅱🅹🅴🅲🆃\u0026nbsp;⬇\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp;\u0026nbsp; \u003cbr\u003e ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
      },
      {
        "type": "TEXT",
        "name": "src",
        "displayName": "Source Object",
        "simpleValueType": true,
        "help": "💾 The source object to transform.\u003cbr\u003e\u003cbr\u003eProperties from this object will be read, optionally renamed, and/or transformed based on the mappings below."
      },
      {
        "type": "CHECKBOX",
        "name": "kup",
        "checkboxText": "Keep unmapped properties",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "✓ When enabled, properties NOT in the mapping table are preserved in the result.\u003cbr\u003e\u003cbr\u003eWhen disabled, only mapped properties appear in the result."
      },
      {
        "type": "CHECKBOX",
        "name": "kor",
        "checkboxText": "Keep original keys when renaming",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "✓ When enabled, the original key is kept alongside the renamed key (both appear in result).\u003cbr\u003e\u003cbr\u003eWhen disabled, the original key is replaced by the new key."
      },
      {
        "type": "LABEL",
        "name": "h2_Key Mappings",
        "displayName": "-------------------------------------------------------\u003cstrong\u003e Key Mappings\u0026nbsp;⬇\u003c/strong\u003e--------------------------------------------------------"
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "tkm",
        "displayName": "",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Source Key",
            "name": "key",
            "type": "TEXT"
          },
          {
            "defaultValue": "",
            "displayName": "Target Key (optional)",
            "name": "tgt",
            "type": "TEXT"
          },
          {
            "defaultValue": "",
            "displayName": "Transform Function (optional)",
            "name": "fnc",
            "type": "TEXT"
          }
        ],
        "newRowButtonText": "+ Add Mapping",
        "help": "💾 Define how to transform object properties.\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eSource Key:\u003c/strong\u003e Path to read from source object\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Simple: \u003ccode\u003e\"firstName\"\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Nested: \u003ccode\u003e\"user.firstName\"\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Complex: \u003ccode\u003e\"['user']['firstName']\"\u003c/code\u003e (requires path parser)\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eTarget Key:\u003c/strong\u003e Path to write to result object\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Leave empty to keep same key name\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Simple: \u003ccode\u003e\"first_name\"\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Nested: \u003ccode\u003e\"profile.name\"\u003c/code\u003e (auto-creates nested structure)\u003cbr\u003e\u003cbr\u003e\u003cstrong\u003eTransform Function:\u003c/strong\u003e Optional function to modify the value\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Leave empty to copy value as-is\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Examples: \u003ccode\u003eval =\u003e val.toUpperCase()\u003c/code\u003e, \u003ccode\u003eparseInt\u003c/code\u003e, \u003ccode\u003eval =\u003e val.trim()\u003c/code\u003e"
      }
    ],
    "help": "Transforms object structure using key renaming, value transformation, and nesting rules.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eRename object keys\u003c/em\u003e***\u003cbr\u003eKeep unmapped properties: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003eKeep original keys when renaming: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003etkm: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{first_name: 'John', lastName: 'Doe', age: 30}\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eFlatten nested values\u003c/em\u003e***\u003cbr\u003eKeep unmapped properties: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003eKeep original keys when renaming: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003etkm: \u003cstrong\u003e[\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e{name: 'John', user: {firstName: 'John', age: 30}, status: 'active'}\u003c/strong\u003e"
  },
  {
    "type": "GROUP",
    "name": "Path Processing",
    "displayName": "Path Processing",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "TEXT",
        "name": "prs",
        "displayName": "Path Parser (optional)",
        "simpleValueType": true,
        "help": "⚙️ Optional function to normalize complex path syntax before processing: \u003ccode\u003epath =\u003e normalizedPath\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eUse this to support custom path formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Bracket notation: \u003ccode\u003e\"['user']['name']\"\u003c/code\u003e → \u003ccode\u003e[\"user\", \"name\"]\u003c/code\u003e\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Array notation: \u003ccode\u003e\"items[0].name\"\u003c/code\u003e → \u003ccode\u003e[\"items\", \"0\", \"name\"]\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eExample parser:\u003cbr\u003e\u003ccode\u003epath =\u003e path.replace(/\\[['\"]/g, '.').replace(/['\"]\\]/g, '').split('.').filter(x =\u003e x)\u003c/code\u003e"
      },
      {
        "type": "TEXT",
        "name": "get",
        "displayName": "Custom Getter (optional)",
        "simpleValueType": true,
        "help": "⚙️ Optional function to customize property retrieval: \u003ccode\u003e(obj, path) =\u003e value\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eDefault behavior: Handles dot notation and array paths.\u003cbr\u003e\u003cbr\u003eUse this for:\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Case-insensitive lookups\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Special property access logic\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Custom path resolution"
      },
      {
        "type": "TEXT",
        "name": "set",
        "displayName": "Custom Setter (optional)",
        "simpleValueType": true,
        "help": "⚙️ Optional function to customize property assignment: \u003ccode\u003e(obj, path, value) =\u003e obj\u003c/code\u003e\u003cbr\u003e\u003cbr\u003eDefault behavior: Handles dot notation, auto-creates nested objects.\u003cbr\u003e\u003cbr\u003eUse this for:\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Validation before setting\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Custom nested structure creation\u003cbr\u003e\u0026nbsp;\u0026nbsp;• Special assignment logic"
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
        "help": "⚙️ Optional function to transform the final object before returning it (e.g., \u003ccode\u003eobj =\u003e JSON.stringify(obj)\u003c/code\u003e, \u003ccode\u003eobj =\u003e Object.freeze(obj)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Transforms an object by renaming keys and/or applying functions to their values. Supports nested paths.
 * 
 * @param {Object} data.src - Source object to transform.
 * @param {boolean} data.kup - Whether to keep unmapped properties (properties not in mapping table).
 * @param {boolean} data.kor - Whether to keep original keys when renaming.
 * @param {Array<{key: string, tgt?: string, fnc?: Function}>} data.tkm - Key transformation mappings.
 * @param {Function} [data.prs] - Optional path parser to normalize complex paths (e.g., ["JJ"]["kko"] → ["JJ", "kko"]).
 * @param {Function} [data.get] - Optional custom getter (defaults to path-aware getter).
 * @param {Function} [data.set] - Optional custom setter (defaults to path-aware setter).
 * @param {Function|string} [data.out] - Optional output handler.
 * 
 * @returns {Object} Transformed object with renamed keys and transformed values.
 *
 * @framework ggLowCodeGTMKit
 */
const getType = require('getType');

const transformerGenerator = function(src, kup, kor, tkm, prs, get, set) {
    const sourceObj = getType(src) === 'object' && src || {};
    const keepUnmapped = kup;
    const keepOriginal = kor;
    const keyMappings = tkm || [];

    const parsePath = function(path) {
        return getType(path) === 'array' 
            ? path.map(part => part.toString()) 
            : path.split('.');
    };

    const getPath = function(object, path) {
        if (getType(object) !== 'object' || object === null) {
            return undefined;
        }
        
        const pathParts = parsePath(path);
        
        let current = object;
        for (let i = 0; i < pathParts.length; i++) {
            const key = pathParts[i];
            if (current === null || current === undefined) {
                return undefined;
            }
            current = current[key];
        }
        return current;
    };

    const pathExists = function(object, path) {
        if (getType(object) !== 'object' || object === null) {
            return false;
        }
        
        const pathParts = parsePath(path);
        
        let current = object;
        for (let i = 0; i < pathParts.length; i++) {
            const key = pathParts[i];
            if (current === null || current === undefined || !current.hasOwnProperty(key)) {
                return false;
            }
            current = current[key];
        }
        return true;
    };

    const setPath = function(object, path, value) {
        if (getType(object) !== 'object' || object === null) {
            return object;
        }
        
        const pathParts = parsePath(path);
        
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

    const internalSafeFn = fn => typeof fn === 'function' ? fn : x => x;

    const pathParser = internalSafeFn(prs);
    const getter = typeof get === 'function' ? get : getPath;
    const setter = typeof set === 'function' ? set : setPath;

    const result = {};

    // Step 1: Identify shallow keys that should be excluded when copying
    // (only needed if we're keeping unmapped but not keeping originals when renaming)
    const excludedShallowKeys = {};
    if (keepUnmapped && !keepOriginal) {
        keyMappings.forEach(mapping => {
            if (!mapping.key) return;
            const sourceKey = pathParser(mapping.key);
            const targetKey = mapping.tgt ? pathParser(mapping.tgt) : sourceKey;
            const sourceKeyStr = getType(sourceKey) === 'array' ? sourceKey.join('.') : sourceKey;
            const targetKeyStr = getType(targetKey) === 'array' ? targetKey.join('.') : targetKey;
            
            // Only track shallow keys (no dots) that are being renamed and exist in source
            if (sourceKeyStr !== targetKeyStr && sourceKeyStr.indexOf('.') === -1 && pathExists(sourceObj, sourceKey)) {
                excludedShallowKeys[sourceKeyStr] = true;
            }
        });
    }

    // Step 2: Copy unmapped properties (excluding renamed shallow keys if applicable)
    if (keepUnmapped) {
        for (const key in sourceObj) {
            if (sourceObj.hasOwnProperty(key) && !excludedShallowKeys[key]) {
                result[key] = sourceObj[key];
            }
        }
    }

    // Step 3: Apply all mappings
    keyMappings.forEach(mapping => {
        if (!mapping.key) return;
        
        const sourceKey = pathParser(mapping.key);
        const targetKey = mapping.tgt ? pathParser(mapping.tgt) : sourceKey;
        
        // Skip if source key doesn't exist
        if (!pathExists(sourceObj, sourceKey)) {
            return;
        }
        
        const transform = internalSafeFn(mapping.fnc);
        
        const sourceValue = getter(sourceObj, sourceKey);
        const transformedValue = transform(sourceValue);
        
        // Set target key with transformed value
        setter(result, targetKey, transformedValue);
        
        // Handle keeping original key when renaming
        const sourceKeyStr = getType(sourceKey) === 'array' ? sourceKey.join('.') : sourceKey;
        const targetKeyStr = getType(targetKey) === 'array' ? targetKey.join('.') : targetKey;
        
        if (sourceKeyStr !== targetKeyStr && keepOriginal) {
            setter(result, sourceKey, transformedValue);
        }
    });

    return result;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

return out(transformerGenerator(data.src, data.kup, data.kor, data.tkm, data.prs, data.get, data.set));


___TESTS___

scenarios:
  - name: '[example] Rename object keys'
    code: |
      /* @display
      Source Object: {firstName: 'John', lastName: 'Doe', age: 30}
      Keep unmapped properties: true
      Keep original keys when renaming: false
      Key Mappings: [{key: 'firstName', tgt: 'first_name'}]
      @output
      {first_name: 'John', lastName: 'Doe', age: 30}
      */
      const mockData = {
          src: {firstName: 'John', lastName: 'Doe', age: 30},
          kup: true,
          kor: false,
          tkm: [
              {key: 'firstName', tgt: 'first_name'}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({first_name: 'John', lastName: 'Doe', age: 30});
  - name: Key rename with transform - should rename and transform value
    code: |-
      const mockData = {
          src: {firstName: 'john', age: 30},
          kup: true,
          kor: false,
          tkm: [
              {key: 'firstName', tgt: 'first_name', fnc: val => val.toUpperCase()}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({first_name: 'JOHN', age: 30});
  - name: '[example] Flatten nested values'
    code: |
      /* @display
      Source Object: {user: {firstName: 'John', age: 30}, status: 'active'}
      Keep unmapped properties: true
      Keep original keys when renaming: false
      Key Mappings: [{key: 'user.firstName', tgt: 'name'}]
      @output
      {name: 'John', user: {firstName: 'John', age: 30}, status: 'active'}
      */
      const mockData = {
          src: {user: {firstName: 'John', age: 30}, status: 'active'},
          kup: true,
          kor: false,
          tkm: [
              {key: 'user.firstName', tgt: 'name'}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({name: 'John', user: {firstName: 'John', age: 30}, status: 'active'});
  - name: Flat source to nested target - should create nested structure
    code: |-
      const mockData = {
          src: {firstName: 'John', lastName: 'Doe'},
          kup: false,
          kor: false,
          tkm: [
              {key: 'firstName', tgt: 'user.first'},
              {key: 'lastName', tgt: 'user.last'}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({user: {first: 'John', last: 'Doe'}});
  - name: Don't keep unmapped properties - should only include mapped properties
    code: |-
      const mockData = {
          src: {firstName: 'John', lastName: 'Doe', age: 30, city: 'Paris'},
          kup: false,
          kor: false,
          tkm: [
              {key: 'firstName', tgt: 'first_name'},
              {key: 'age', tgt: 'age'}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({first_name: 'John', age: 30});
  - name: Keep original keys when renaming - should have both old and new keys
    code: |
      const mockData = {
          src: {firstName: 'John', age: 30},
          kup: true,
          kor: true,
          tkm: [
              {key: 'firstName', tgt: 'first_name'}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({firstName: 'John', first_name: 'John', age: 30});
  - name: Empty target key - should use source key as target
    code: |
      const mockData = {
          src: {name: 'john', age: 30},
          kup: true,
          kor: false,
          tkm: [
              {key: 'name', tgt: '', fnc: val => val.toUpperCase()}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({name: 'JOHN', age: 30});
  - name: Keep both flags enabled - should keep unmapped and original renamed keys
    code: |-
      const mockData = {
          src: {firstName: 'John', lastName: 'Doe', age: 30},
          kup: true,
          kor: true,
          tkm: [
              {key: 'firstName', tgt: 'first_name', fnc: val => val.toUpperCase()}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({
          firstName: 'JOHN',
          first_name: 'JOHN',
          lastName: 'Doe',
          age: 30
      });
  - name: Empty source object - should return empty object
    code: |-
      const mockData = {
          src: {},
          kup: true,
          kor: false,
          tkm: [
              {key: 'firstName', tgt: 'first_name'}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({});
  - name: Nested to nested rename - should transform nested structure
    code: |-
      const mockData = {
          src: {old: {path: {value: 'data'}}},
          kup: false,
          kor: false,
          tkm: [
              {key: 'old.path.value', tgt: 'new.location.data'}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({new: {location: {data: 'data'}}});
  - name: Multiple nested transformations - should handle complex mappings
    code: |-
      const mockData = {
          src: {
              user: {firstName: 'john', lastName: 'doe'},
              meta: {created: '2024', updated: '2025'}
          },
          kup: false,
          kor: false,
          tkm: [
              {key: 'user.firstName', tgt: 'profile.first', fnc: val => val.toUpperCase()},
              {key: 'user.lastName', tgt: 'profile.last', fnc: val => val.toUpperCase()},
              {key: 'meta.created', tgt: 'dates.created', fnc: val => val.toUpperCase()}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({
          profile: {first: 'JOHN', last: 'DOE'},
          dates: {created: "2024"}
      });
  - name: Transform without rename - should transform value but keep same key
    code: |-
      const mockData = {
          src: {price: 'four', quantity: 'five'},
          kup: true,
          kor: false,
          tkm: [
              {key: 'price', fnc: val => val.toUpperCase()},
              {key: 'quantity', fnc: val => val.toUpperCase()}
          ]
      };
      const variableResult = runCode(mockData);
      assertThat(variableResult).isEqualTo({price: "FOUR", quantity: "FIVE"});


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://library.youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
