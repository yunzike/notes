#### 1.父项目
```
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>2.1.5.RELEASE</version>
    <relativePath/> <!-- lookup parent from repository -->
</parent>

它的父项目是





真正管理依赖



```
SpringBoot的版本仲裁中心；
导入依赖默认不需要写版本（但没有在dependencies里面管理的依赖需要声明版本号）

#### 2.导入的依赖
```
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
</dependencies>
```
spring-boot-starter-web：
spring-boot-starter：Spring Boot场景启动器；帮我们导入web模块正常运行所依赖的组件。

Spring Boot将所有的功能场景都抽取出来，做成一个个的Starters（启动器），只需要在项目里面引入这些starter相关场景的所有依赖都会导入进来。要用什么功能就导入什么场景启动器。