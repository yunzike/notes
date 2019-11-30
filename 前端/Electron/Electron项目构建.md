1.安装node、cnpm以及git环境

2.安装Electron
````
cnpm install -g electron
````
3.安装Electron-forge
````
cnpm install -g electron-forge
````

4.初始化项目
````
electron-forge init notepad
````

5.启动项目
````
cd notepad
electron-forge start
或
npm start
````

6.修改入口文件index.js为main.js

7.开发

8.打包
````
//修改package.json，在electronPackagerConfig部分添加"asar": true,否则源码会直接暴露在打包文件中
npm run make
````