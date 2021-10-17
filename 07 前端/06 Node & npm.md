## 1、基本使用

### 1.1 安装 node.js

官网下载安装：https://nodejs.org/zh-cn/

```bash
# 版本查看
$ node -v
$ npm -v
```

### 1.2 使用淘宝镜像源

- 方式一：替换 npm 工具下载镜像源为淘宝镜像源地址

  ```bash
  # 设置为淘宝镜像源地址
  $ npm config set registry https://registry.npm.taobao.org
  
  # 验证
  $ npm config get registry
  
  # 恢复官方镜像源
  $ npm config set registry https://registry.npmjs.org
  ```

- 方式二：使用 npm 全局安装 cnpm 同时配置其镜像源为淘宝地址

  使用淘宝镜像源时需要使用 cnpm ,使用 npm 为官方源

  ```bash
  $ npm install -g cnpm --registry=https://registry.npm.taobao.org
  ```

- 方式三：临时使用淘宝镜像源安装依赖

  ```bash
  # 临时使用淘宝镜像源安装 express 依赖
  $ npm --registry https://registry.npm.taobao.org install express
  ```

### 1.3 npm 包管理

#### 查看所有全局安装的包

```bash
$ npm list -g --depth 0
```

#### 更新包

```bash
$ npm update -g xxx
```

#### 删除包

```bash
# 注意不要带模块的版本号
$ npm uninstall -g xxx
```

### 1.4 node 卸载 & 重装

#### win10



#### Mac

[Mac电脑如何彻底删除node - 不会电脑的码农 - 博客园 (cnblogs.com)](https://www.cnblogs.com/ChenGuangW/p/11398367.html)

[Mac下彻底卸载node和npm_Room-CSDN博客_mac卸载node和npm](https://blog.csdn.net/shiquanqq/article/details/78032943)





## 2、组件封装

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







