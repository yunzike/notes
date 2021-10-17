## 1、Maven的安装

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

```xml
<mirrors>
    <mirror>
        <id>nexus-aliyun</id>
        <mirrorOf>central</mirrorOf>
        <name>Nexus aliyun</name>
        <url>http://maven.aliyun.com/nexus/content/groups/public</url>
    </mirror>
</mirrors>
```

#### 6、配置jdk1.8编译项目

```xml
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
        </properties>
    </profile>
</profiles>
```



## 2、Maven命令





## 3、坐标和依赖



### 3.1 坐标



### 3.2 依赖范围





### 3.3 依赖传递





### 3.4 依赖调解

现实中可能存在这样的情况：
A->B->C->Y(1.0)，
A->D->Y(2.0)，
此时 Y 出现了 2 个版本，1.0 和 2.0，此时 maven 会选择 Y 的哪个版本？ 解决这种问题，maven有2个原则：

#### 路径最近原则

上面 A->B->C->Y(1.0)，A->D->Y(2.0) 
Y的2.0版本距离A更近一些，所以maven会选择2.0。 

但是如果出现了路径是一样的，
如： A->B->Y(1.0)，A->D->Y(2.0) ，此时maven又如何选择呢？

#### 最先声明原则

如果出现了路径一样的，此时会看 A 的 pom.xml 中所依赖的 B、D在 dependencies 中的位置，谁的声明 在最前面，就以谁的为主，比如 A->B 在前面，那么最后Y会选择 1.0 版本。

### 3.5 可选依赖



### 3.6 排除依赖

A项目的pom.xml中

```xml
<dependency>
    <groupId>com.javacode2018</groupId>
    <artifactId>B</artifactId>
    <version>1.0</version>
</dependency>
```

B 项目1.0 版本的 pom.xml 中

```xml
<dependency>
    <groupId>com.javacode2018</groupId>
    <artifactId>C</artifactId>
    <version>1.0</version>
</dependency>
```

上面 A->B 的 1.0 版本，B->C  的 1.0 版本，而 scope 都是默认的 compile ，根据前面讲的依赖传递性，C 会传递给 A ，会被 A 自动依赖，但是 C 此时有个更新的版本 2.0，A 想使用 2.0 的版本，此时 A 的 pom.xml 中可以这么写：

```xml
<dependency>
    <groupId>com.javacode2018</groupId>
    <artifactId>B</artifactId>
    <version>1.0</version>
    <exclusions>
        <exclusion>
            <groupId>com.javacode2018</groupId>
            <artifactId>C</artifactId>
        </exclusion>
    </exclusions>
</dependency>
```

上面使用使用 exclusions 元素排除了 B->C 依赖的传递，也就是 B->C 不会被传递到 A 中。 exclusions 中可以有多个 exclusion 元素，可以排除一个或者多个依赖的传递，声明 exclusion 时只需要写上 groupId、artifactId 就可以了，version 可以省略。



## 4、仓库





## 5、私服







## 6、生命周期和插件



## 7、聚合、继承、剪裁



### 7.4 依赖管理

















