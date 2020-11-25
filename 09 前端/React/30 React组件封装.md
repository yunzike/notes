---
title: React组件封装
date: 2019-03-19 16:33:00  
categories: React  
---
#### 1、新建组件目录文件并配置github和npm
````
//新建组件目录并初始化git
mkdir mycomponent
cd mycomponet
git init

//新建github仓库并将远程仓库关联至本地仓库
...

//登录npm账号并配置npm
npm login
...
npm init

//配置信息
name: (component-lib)
version: (1.0.0) 0.1.0
description: an example component library built with React!
entry point: (index.js) build/index.js
test command:
git repository:
keywords:
license: (ISC)
About to write to /Users/alanbsmith/personal-projects/trash/package.json:

{
  "name": "component-lib",
  "version": "0.1.0",
  "description": "an example component library built with React!",
  "main": "build/index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "Alan Smith <[alan.smith@example.com](mailto:a.bax.smith@gmail.com)> ([https://github.com/alanbsmith](https://github.com/alanbsmith))",
  "license": "ISC"
}

Is this ok? (yes)
````
#### 2、添加目录和文件




安装依赖包  
````
 "devDependencies": {
   "babel-cli": "^6.0.0",
   "babel-core": "^6.14.0",
   "babel-loader": "^6.2.5",
   "babel-plugin-istanbul": "^2.0.1",
   "babel-preset-es2015": "^6.14.0",
   "babel-preset-react": "^6.24.1",
   "react": "^15.6.1",
   "react-dom": "^15.6.1"
}
````
