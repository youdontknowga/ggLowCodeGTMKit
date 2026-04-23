___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "gtmIsPreviewMode",
  "description": "Returns\u003cem\u003e true\u003c/em\u003e if the container is running in preview mode.",
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
        "name": "No Parameters",
        "displayName": "🌐 This function takes no parameters."
      }
    ],
    "help": "Returns\u003cem\u003e true\u003c/em\u003e if the container is running in preview mode."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

/**
 * Checks if the container is in preview mode.
 * 
 * @returns {boolean} True if the container is running in preview mode, false otherwise.
 *
 * @framework ggLowCodeGTMKit
 */
const getContainerVersion = require('getContainerVersion');

return getContainerVersion().previewMode;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_container_data",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Untitled test 1
  code: |-
    const mockData = {
      // Mocked field values
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);


___NOTES___

ggLowCodeGTMKit - The Composable Variable Framework
Version: 0.0.1
License: MIT

📚 Documentation: https://youdontknowga.com/
🐙 GitHub: https://github.com/youdontknowga/ggLowCodeGTMKit
Created by Gwennaël Grandmougin
