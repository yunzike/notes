### 1、安装 node.js

官网下载安装：https://nodejs.org/zh-cn/

```bash
# 版本查看
$ node -v
$ npm -v
```

### 2、使用淘宝镜像源

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

### 3、npm 包管理

```bash
# 查看所有全局安装的包
$ npm list -g --depth 0
# 更新
$ npm update -g xxx
# 删除（注意不要带模块的版本号）
$ npm uninstall -g xxx
```