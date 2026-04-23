___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "extractSegmentByIndex(...)",
  "description": "Returns the segment at a specific index (Index 0 is root, 1 is first segment) from the pathname.",
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
        "name": "idx",
        "displayName": "Segment Index",
        "simpleValueType": true,
        "help": "💾 The zero-based index of the segment to extract. Index 0 is the root (\"\"), index 1 is the first segment after root.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e: \u003cem\u003e0\u003c/em\u003e, \u003cem\u003e1\u003c/em\u003e, \u003cem\u003e2\u003c/em\u003e, etc.",
        "enablingConditions": [
          {
            "paramName": "rp1",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "def",
        "displayName": "Default Value (optional)",
        "simpleValueType": true,
        "help": "💾 The value to return if the index is out of range or the input is invalid.\u003cbr\u003e\u003cbr\u003eSupported formats:\u003cbr\u003e\u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eAny type\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "rp4",
            "paramValue": true,
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "rts",
        "simpleValueType": true,
        "checkboxText": "Remove Trailing Slash",
        "help": "☑️ If enabled, removes trailing slash from pathname before splitting (e.g., \"/products/\" becomes \"/products\").",
        "enablingConditions": []
      },
      {
        "type": "CHECKBOX",
        "name": "rem",
        "simpleValueType": true,
        "checkboxText": "Remove Empty Segments",
        "help": "☑️ If enabled, removes empty segments from the path (except the leading empty string representing root).",
        "enablingConditions": []
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract first segment\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: /products/shoes/nike\u003cbr\u003eSegment Index: 0\u003cbr\u003erts: false\u003cbr\u003erem: false\u003cbr\u003eDefault Value: undefined\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract middle segment\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003esrc: /products/shoes/nike\u003cbr\u003eSegment Index: 2\u003cbr\u003erts: false\u003cbr\u003erem: false\u003cbr\u003eDefault Value: undefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eshoes\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Pathname"
      },
      {
        "type": "GROUP",
        "name": "Advanced Settings",
        "displayName": "Advanced Settings",
        "groupStyle": "ZIPPY_OPEN_ON_PARAM",
        "subParams": [
          {
            "type": "CHECKBOX",
            "name": "rp1",
            "checkboxText": "⚡Use runtime parameter for: Segment Index",
            "simpleValueType": true
          },
          {
            "type": "CHECKBOX",
            "name": "rp2",
            "checkboxText": "⚡Use runtime parameter for: Default Value",
            "simpleValueType": true
          }
        ]
      }
    ],
    "help": "Extracts a URL path segment by its index position.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract first segment\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e/products/shoes/nike\u003c/strong\u003e\u003cbr\u003eSegment Index: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003eRemove Trailing Slash: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eRemove Empty Segments: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eDefault Value (optional): \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eExtract middle segment\u003c/em\u003e***\u003cbr\u003eValue to Process: \u003cstrong\u003e/products/shoes/nike\u003c/strong\u003e\u003cbr\u003eSegment Index: \u003cstrong\u003e2\u003c/strong\u003e\u003cbr\u003eRemove Trailing Slash: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eRemove Empty Segments: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003eDefault Value (optional): \u003cstrong\u003eundefined\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003eshoes\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the extracted segment before returning it (e.g., \u003ccode\u003estr =\u003e str.toUpperCase()\u003c/code\u003e, \u003ccode\u003estr =\u003e decodeURIComponent(str)\u003c/code\u003e). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Returns a specific segment from a pathname string using its index.
 *
 * @param {string} data.src - The pathname string to extract from (e.g., "/products/shoes").
 * @param {number} data.idx - The index of the segment to return (0-based).
 * @param {boolean} [data.rts=false] - Whether to remove a trailing slash before splitting.
 * @param {boolean} [data.rem=false] - Whether to remove empty segments (except the leading one).
 * @param {*} [data.def] - The default value to return if index is out of range or input is invalid.
 * @param {Function|string} [data.out] - Optional output handler: function to transform result or string with format.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src before processing.
 * 
 * @returns {string|*} The path segment at the specified index, or the default value if not found.
 *
 * @framework ggLowCodeGTMKit
 */
const extractSegmentByIndex = function(pathname, index, removeTrailingSlash, removeEmpty, defaultValue) {
    if (typeof pathname !== "string" || typeof index !== "number") {
        return defaultValue;
    }
    
    let normalizedPath = pathname[0] === "/" ? pathname : "/" + pathname;
    
    if (removeTrailingSlash && normalizedPath[normalizedPath.length - 1] === "/") {
        normalizedPath = normalizedPath.slice(0, -1);
    }
    
    let segments = normalizedPath.split("/");
    
    if (removeEmpty) {
        segments = segments.filter(function(segment) { return segment.length > 0; });
        segments.unshift('');
    }
    
    return index >= 0 && index < segments.length ? segments[index] : defaultValue;
};
const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);
// ===============================================================================
// extractSegmentByIndex - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(extractSegmentByIndex(value, data.idx, data.rts, data.rem, data.def));
*/
// ===============================================================================
// extractSegmentByIndex(...) – Apply Mode
// ===============================================================================
return function(pathname, index, removeTrailingSlash, removeEmpty, defaultValue) {
   index = data.rp1 ? data.idx : index;
   defaultValue = data.rp2 ? data.def : defaultValue;
   return out(extractSegmentByIndex(pathname, index, data.rts, data.rem, defaultValue));
};


___TESTS___

scenarios:
  - name: '[example] Extract first segment'
    code: |-
      /* @display
      Value to Process: /products/shoes/nike
      Segment Index: 0
      Remove Trailing Slash: false
      Remove Empty Segments: false
      Default Value (optional): undefined
      */
      const src = '/products/shoes/nike';
      const idx = 0;
      const rts = false;
      const rem = false;
      const def = undefined;
      const mockData = {
          src: src,
          idx: idx,
          rts: rts,
          rem: rem,
          def: def,
          rp1: false,
          rp2: false,
          rp3: false,
          rp4: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx, rts, rem, def);
      }
      assertThat(variableResult).isEqualTo('');
  - name: '[example] Extract middle segment'
    code: |-
      /* @display
      Value to Process: /products/shoes/nike
      Segment Index: 2
      Remove Trailing Slash: false
      Remove Empty Segments: false
      Default Value (optional): undefined
      @output
      shoes
      */
      const src = '/products/shoes/nike';
      const idx = 2;
      const rts = false;
      const rem = false;
      const def = undefined;
      const mockData = {
          src: src,
          idx: idx,
          rts: rts,
          rem: rem,
          def: def,
          rp1: false,
          rp2: false,
          rp3: false,
          rp4: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx, rts, rem, def);
      }
      assertThat(variableResult).isEqualTo('shoes');
  - name: Test with trailing slash removal
    code: |-
      const src = '/products/shoes/';
      const idx = 2;
      const rts = true;
      const rem = false;
      const def = undefined;
      const mockData = {
          src: src,
          idx: idx,
          rts: rts,
          rem: rem,
          def: def,
          rp1: false,
          rp2: false,
          rp3: false,
          rp4: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx, rts, rem, def);
      }
      assertThat(variableResult).isEqualTo('shoes');
  - name: Test with index out of range returns default
    code: |-
      const src = '/products/shoes';
      const idx = 5;
      const rts = false;
      const rem = false;
      const def = 'not-found';
      const mockData = {
          src: src,
          idx: idx,
          rts: rts,
          rem: rem,
          def: def,
          rp1: false,
          rp2: false,
          rp3: false,
          rp4: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx, rts, rem, def);
      }
      assertThat(variableResult).isEqualTo('not-found');
  - name: Test with empty segment removal
    code: |
      const src = '/products//shoes///nike';
      const idx = 1;
      const rts = false;
      const rem = true;
      const def = undefined;
      const mockData = {
          src: src,
          idx: idx,
          rts: rts,
          rem: rem,
          def: def,
          rp1: false,
          rp2: false,
          rp3: false,
          rp4: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx, rts, rem, def);
      }
      assertThat(variableResult).isEqualTo('products');
  - name: Test without leading slash (auto-added)
    code: |
      const src = 'products/shoes/nike';
      const idx = 1;
      const rts = false;
      const rem = false;
      const def = undefined;
      const mockData = {
          src: src,
          idx: idx,
          rts: rts,
          rem: rem,
          def: def,
          rp1: false,
          rp2: false,
          rp3: false,
          rp4: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx, rts, rem, def);
      }
      assertThat(variableResult).isEqualTo('products');
  - name: Test with non-string input returns default
    code: |-
      const src = 12345;
      const idx = 0;
      const rts = false;
      const rem = false;
      const def = 'invalid';
      const mockData = {
          src: src,
          idx: idx,
          rts: rts,
          rem: rem,
          def: def,
          rp1: false,
          rp2: false,
          rp3: false,
          rp4: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx, rts, rem, def);
      }
      assertThat(variableResult).isEqualTo('invalid');
  - name: Test with single segment path
    code: |-
      const src = '/home';
      const idx = 1;
      const rts = false;
      const rem = false;
      const def = undefined;
      const mockData = {
          src: src,
          idx: idx,
          rts: rts,
          rem: rem,
          def: def,
          rp1: false,
          rp2: false,
          rp3: false,
          rp4: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx, rts, rem, def);
      }
      assertThat(variableResult).isEqualTo('home');
  - name: Test with root path only
    code: |-
      const src = '/';
      const idx = 0;
      const rts = false;
      const rem = false;
      const def = undefined;
      const mockData = {
          src: src,
          idx: idx,
          rts: rts,
          rem: rem,
          def: def,
          rp1: false,
          rp2: false,
          rp3: false,
          rp4: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx, rts, rem, def);
      }
      assertThat(variableResult).isEqualTo('');
  - name: Test last segment extraction
    code: |-
      const src = '/api/v1/users/profile';
      const idx = 4;
      const rts = false;
      const rem = false;
      const def = undefined;
      const mockData = {
          src: src,
          idx: idx,
          rts: rts,
          rem: rem,
          def: def,
          rp1: false,
          rp2: false,
          rp3: false,
          rp4: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src, idx, rts, rem, def);
      }
      assertThat(variableResult).isEqualTo('profile');
setup: |-
  // Change this to switch test mode ('direct', or 'apply')
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

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
