___INFO___

{
  "data": {
    "categories": [
      "Core Infrastructure"
    ],
    "description": "Handles the primary logic wrapper (apply/direct) for passing inputs between GTM Variables.",
    "id": "core_execution_router",
    "type": "MACRO",
    "name": "Core - Execution Router"
  },
  "rules": []
}

___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "mode",
    "displayName": "Execution Mode",
    "defaultValue": "apply",
    "selectItems": [
      {
        "value": "direct",
        "displayValue": "Direct Execution (Standalone)"
      },
      {
        "value": "apply",
        "displayValue": "Apply (Chain to next Input)"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "src",
    "displayName": "Source Input Value (src)",
    "help": "Enter the name of the previous variable or static string to process."
  },
  {
    "type": "TEXT",
    "name": "out",
    "displayName": "Output Target (out)",
    "help": "If in apply mode, define the target transformation execution."
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Strict Sandboxed JS Execution Context
// GTM prohibits throw(), standard try/catch logic is bypassed where possible

const mode = data.mode || "apply";
const src = data.src;
const out = data.out;

// Safe generic fallback for missing src
if (typeof src === "undefined" || src === null || src === "") {
  return undefined;
}

if (mode === "direct") {
  // Immediate string return logic
  return src;
}

if (mode === "apply") {
  // Simulated chaining syntax for downstream evaluation mapping
  if (!out) {
    return src; 
  }
  return {
    __gtm_chain_apply: true,
    data: src,
    target: out
  };
}

return undefined;


___WEB_PERMISSIONS___

[
  {
    "name": "execute_sandboxed_js",
    "type": "boolean",
    "value": true
  }
]