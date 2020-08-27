## 一、Maven的安装

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



#### 5、使用阿里云下载镜像

```bash
<mirror>
	<id>nexus-aliyun</id>    
	<mirrorOf>central</mirrorOf>
	<name>Nexus aliyun</name>  
	<url>http://maven.aliyun.com/nexus/content/groups/public</url>    
</mirror>
```

#### 6、配置jdk1.8编译项目

```bash
<profiles>
	<profile>
		<id>jdk-1.8</id>
		<activation>
			<activeByDefault>true</activeByDefault>
			<jdk>1.8</jdk>
		</activation>
		<properties>
			<maven.compiler.source>1.8</maven.compiler.source>
			<maven.compiler.target>1.8</maven.compiler.target>
			<maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>
			# 下面这行可以不要
			<encoding>UTF-8</encoding>
		</properties>
	</profile>
</profiles>
```







## 二、Maven命令