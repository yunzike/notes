#### 1.下载并解压
官网下载二进制压缩包

#### 2.设置环境变量
Mac下：
```
打开terminel输入以下命令：  
vim ~/.bash_profile

打开.bash_profile文件，在次文件中添加设置环境变量的命令  
export M2_HOME=/Users/xxx/Documents/maven/apache-maven-3.5.0  
export PATH=$PATH:$M2_HOME/bin  

添加之后保存并推出，执行以下命令使配置生效：  
source ~/.bash_profile
```
windows下：  
同mac添加M2_HOME和path即可。

查看配置是否生效：
maven -v

#### 3.修改本地仓库
创建repository目录
然后修改maven下conf/setting.xml文件中的

localRepository中路径为仓库路径

#### 4.idea中使用


