___INFO___

{
  "data": {
    "categories": [
      "Ecommerce"
    ],
    "description": "Extracts an ecommerce purchase payload from the input string.",
    "id": "ecommerce_purchase_parser",
    "type": "MACRO",
    "name": "Ecommerce - Parse Purchase Event"
  },
  "rules": []
}

___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "src",
    "displayName": "Source Data (e.g. {{DataLayer - ecommerce}})"
  },
  {
    "type": "TEXT",
    "name": "out",
    "displayName": "Output Target (e.g. push to next stage)"
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const src = data.src;
if (!src || !src.purchase) return undefined;

if (data.out) {
  return {
    __gtm_chain_apply: true,
    data: src.purchase,
    target: data.out
  };
}

return src.purchase;


___WEB_PERMISSIONS___

[
  {
    "name": "execute_sandboxed_js",
    "type": "boolean",
    "value": true
  }
]