## 1、插件

### 基本插件

| 插件名称                       | 作用               |
| ------------------------------ | ------------------ |
| Chinese（Simplified）          | 中文简体           |
| Project Manager                | 项目管理器         |
| vscode-icons                   | 文件图标优化       |
| GitLens                        | git记录管理        |
| Bracket Pair Colorizer 2       | 彩色括号           |
| Auto Close Tag                 | 自动闭合标签       |
| Auto Rename Tag                | 自动改标签名       |
| git-commit-lint-vscode         | git commit 规范    |
| ESLint                         | 检查ES代码语法规范 |
| JavaScript (ES6) code snippets | ES6 语法提示       |
| Easy LESS                      | 自动转化less为css  |

### ue 开发相关插件



### React-Native 开发相关插件



### 其他



## 2、用户代码片段

- React 基础组件

  ```json
  "React 组件": {
  	  "prefix": "rrr",
  	  "body": [
  		"import React from 'react'\n",
  		"class ${1:${TM_FILENAME/(.*).(?:jsx|js)/$1/i}} extends React.Component {",
  		"  render () {",
  		"    return (",
  		"      ${2|null|}",
  		"    )",
  		"  }",
  		"}\n",
  		"export default ${1:${TM_FILENAME/(.*).(?:jsx|js)/$1/i}}\n"
  	  ],
  	  "description": "引入React基本组件"
  	}
  ```

- React-Native 基础组件

  ```json
  "React-Native 组件": {
  		"prefix": "rrn",
  		"body": [
  		  "import React, {Component} from 'react';",
  		  "import {View, Text} from 'react-native';\n",
  		  "class ${1:${TM_FILENAME/(.*).(?:jsx|js)/$1/i}} extends Component {",
  		  "  render() {",
  		  "    return (",
  		  "      <View><Text></Text></View>",
  		  "    );",
  		  "  }",
  		  "}\n",
  		  "export default ${1:${TM_FILENAME/(.*).(?:jsx|js)/$1/i}};\n"
  		],
  		"description": "引入 React-Native 基本组件"
  	  }
  ```

- Vue 基础组件

  ```json
  ```

  



