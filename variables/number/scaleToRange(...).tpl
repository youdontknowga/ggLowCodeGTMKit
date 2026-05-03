___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "scaleToRange(...)",
  "description": "Scales a value from an original range to a new target range.",
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
        "name": "omin",
        "displayName": "Original Minimum",
        "simpleValueType": true,
        "help": "📉   The lower bound of the original range.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "omax",
        "displayName": "Original Maximum",
        "simpleValueType": true,
        "help": "📈   The upper bound of the original range.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "nmin",
        "displayName": "Target Minimum",
        "simpleValueType": true,
        "help": "📉   The lower bound of the new target range.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "TEXT",
        "name": "nmax",
        "displayName": "Target Maximum",
        "simpleValueType": true,
        "help": "📈   The upper bound of the new target range.\u003cbr\u003e\u003cbr\u003e  Supported formats:\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eNumber\u003c/strong\u003e\u003cbr\u003e \u0026nbsp;\u0026nbsp;✓ \u003cstrong\u003eString\u003c/strong\u003e"
      },
      {
        "type": "CHECKBOX",
        "name": "clmp",
        "checkboxText": "Clamp to Target Range",
        "simpleValueType": true,
        "help": "☑️ Check this to prevent the result from exceeding the bounds of the target range if the input is outside the original range."
      },
      {
        "type": "GROUP",
        "name": "Applied Function Parameters",
        "displayName": "𝘈𝘱𝘱𝘭𝘪𝘦𝘥 𝘍𝘶𝘯𝘤𝘵𝘪𝘰𝘯 𝘗𝘢𝘳𝘢𝘮𝘦𝘵𝘦𝘳𝘴",
        "groupStyle": "NO_ZIPPY",
        "subParams": [],
        "help": "Runtime parameters supplied by the function chain. These fields show what will be passed as arguments, not what is configured in this template.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eScale 0-100 to 0-1\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e50\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0.5\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOverflow with Clamp\u003c/em\u003e***\u003cbr\u003eInput: \u003cstrong\u003e150\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e10\u003c/strong\u003e"
      },
      {
        "type": "LABEL",
        "name": "Chained Parameters",
        "displayName": "🔗 Chained callback parameter: Value To Scale"
      }
    ],
    "help": "Scales a value from an original range to a new target range.\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eScale 0-100 to 0-1\u003c/em\u003e***\u003cbr\u003eValue To Scale: \u003cstrong\u003e50\u003c/strong\u003e\u003cbr\u003eOriginal Minimum: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003eOriginal Maximum: \u003cstrong\u003e100\u003c/strong\u003e\u003cbr\u003eTarget Minimum: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003eTarget Maximum: \u003cstrong\u003e1\u003c/strong\u003e\u003cbr\u003eClamp to Target Range: \u003cstrong\u003efalse\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e0.5\u003c/strong\u003e\u003cbr\u003e\u003cbr\u003e*** \u003cem\u003eOverflow with Clamp\u003c/em\u003e***\u003cbr\u003eValue To Scale: \u003cstrong\u003e150\u003c/strong\u003e\u003cbr\u003eOriginal Minimum: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003eOriginal Maximum: \u003cstrong\u003e100\u003c/strong\u003e\u003cbr\u003eTarget Minimum: \u003cstrong\u003e0\u003c/strong\u003e\u003cbr\u003eTarget Maximum: \u003cstrong\u003e10\u003c/strong\u003e\u003cbr\u003eClamp to Target Range: \u003cstrong\u003etrue\u003c/strong\u003e\u003cbr\u003e↪️ Output: \u003cstrong\u003e10\u003c/strong\u003e"
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
        "help": "⚙️ Optional function to apply to the result before returning it (e.g., str =\u003e str + ' €', val =\u003e val !== undefined for boolean conversion). Useful for chaining transformations on the output."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Scales a value from an original range to a new target range.
 * 
 * @param {number|string} data.src - The value to be scaled.
 * @param {number|string} data.omin - The lower bound of the original range.
 * @param {number|string} data.omax - The upper bound of the original range.
 * @param {number|string} data.nmin - The lower bound of the new target range.
 * @param {number|string} data.nmax - The upper bound of the new target range.
 * @param {boolean} data.clmp - Whether to clamp the result to the target range.
 * @param {Function|string} [data.out] - Optional output handler.
 *
 * Direct-mode specific parameters:
 * @param {Function} [data.pre] - Optional pre-processor function to transform src.
 * 
 * @returns {number|undefined} The scaled number.
 *
 * @framework ggLowCodeGTMKit
 */
const Math = require('Math');
const makeNumber = require('makeNumber');

const scaleToRange = function(value, oldMin, oldMax, newMin, newMax, shouldClamp) {
    const val = makeNumber(value);
    const oMin = makeNumber(oldMin);
    const oMax = makeNumber(oldMax);
    const nMin = makeNumber(newMin);
    const nMax = makeNumber(newMax);
    
    if (val !== val || oMin !== oMin || oMax !== oMax || nMin !== nMin || nMax !== nMax) {
        return undefined;
    }
    
    if (oMin === oMax) {
        return undefined;
    }
    
    let result = ((val - oMin) / (oMax - oMin)) * (nMax - nMin) + nMin;
    
    if (shouldClamp) {
        const minClamp = Math.min(nMin, nMax);
        const maxClamp = Math.max(nMin, nMax);
        if (result < minClamp) return minClamp;
        if (result > maxClamp) return maxClamp;
    }
    
    return result;
};

const safeFunction = fn => typeof fn === 'function' ? fn : x => x;
const out = safeFunction(data.out);

// ===============================================================================
// scaleToRange - Direct mode
// ===============================================================================
/*
const applyCast = (castFn, value) => safeFunction(castFn)(value);
const value = applyCast(data.pre, data.src);
return out(scaleToRange(value, data.omin, data.omax, data.nmin, data.nmax, data.clmp));
*/
// ===============================================================================
// scaleToRange(...) – Apply Mode
// ===============================================================================

return function(value) {
   return out(scaleToRange(value, data.omin, data.omax, data.nmin, data.nmax, data.clmp));
};


___TESTS___

scenarios:
  - name: '[example] Scale 0-100 to 0-1'
    code: |-
      /* @display
      Input: 50
      @output
      0.5
      */
      const src = 50;
      const omin = 0;
      const omax = 100;
      const nmin = 0;
      const nmax = 1;
      const clmp = false;
      const mockData = {
          src: src,
          omin: omin,
          omax: omax,
          nmin: nmin,
          nmax: nmax,
          clmp: clmp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(0.5);
  - name: '[example] Overflow with Clamp'
    code: |-
      /* @display
      Input: 150
      @output
      10
      */
      const src = 150;
      const omin = 0;
      const omax = 100;
      const nmin = 0;
      const nmax = 10;
      const clmp = true;
      const mockData = {
          src: src,
          omin: omin,
          omax: omax,
          nmin: nmin,
          nmax: nmax,
          clmp: clmp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(10);
  - name: Overflow without Clamp
    code: |-
      const src = 150;
      const omin = 0;
      const omax = 100;
      const nmin = 0;
      const nmax = 10;
      const clmp = false;
      const mockData = {
          src: src,
          omin: omin,
          omax: omax,
          nmin: nmin,
          nmax: nmax,
          clmp: clmp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(15);
  - name: Underflow with Clamp
    code: |-
      const src = -50;
      const omin = 0;
      const omax = 100;
      const nmin = 0;
      const nmax = 10;
      const clmp = true;
      const mockData = {
          src: src,
          omin: omin,
          omax: omax,
          nmin: nmin,
          nmax: nmax,
          clmp: clmp,
          rp1: false
      };
      let variableResult;
      if (isDirectMode) {
          variableResult = runCode(mockData);
      } else if (isApplyMode) {
          const func = runCode(mockData);
          variableResult = func(src);
      }
      assertThat(variableResult).isEqualTo(0);
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
