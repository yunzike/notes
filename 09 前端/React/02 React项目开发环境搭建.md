1、官网下载安装Node.js
命令行查看是否安装成功
node -v
查看npm是否安装成功
npm -v

2、通过 npm 使用 React

国内使用 npm 速度很慢，设置淘宝定制的 cnpm (gzip 压缩支持) 命令行工具代替默认的 npm。

```
$ npm install -g cnpm --registry=https://registry.npm.taobao.org
$ npm config set registry https://registry.npm.taobao.org
```

全局安装create-react-app模块
```
$ cnpm install -g create-react-app（使用npm则为npm install -g create-react-app）
```
创建项目
```
$ create-react-app my-app
```
运行项目
进入项目路径
```
$ cd my-app/
```
运行
```
$ npm start
```
自动在浏览器中运行http://localhost:3000/ ，显示默认React页面




1.下载最新的nodejs，可以选择nodejs官网的任何一个
  https://nodejs.org/en/
2.通过Win+R进入cmd黑色窗口，假设是第一次创建react工程
   在cmd中查看自己安装的nodejs版本，以及npm版本（安装nodejs的时候包含npm），在cmd中输入
 node -v    --->v8.11.1   注意：node 版本>6
 npm  -v    --->5.6.0       注意：npm版本>3
3.创建全局react，在cmd中输入下列命令行 
   在执行命令之前，先进入node.js的安装目录，然后才可以进行安装react工程.
   npm install -g create-react-app 按回车
  执行结果：

4.然后进入你想创建工程的比如D盘，创建工程名，创建react-basic基础包

进入d盘之后，创建文件夹

完文件夹之后，进入文件夹projects,创建工程名称。
然后输入create-react-app react-basic执行命令，下载脚手架，
出现下面结果，说明执行成功

5.进入react-basic，启动npm

执行完上名命令行，便会自动打开一个本地服务的react页面

打包项目
npm run build 