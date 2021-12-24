## 1、概述

### 1.1 什么是 SpringBoot

- 优点

  

- 缺点

  

### 1.2 微服务



### 1.3 分布式



### 1.4 云原生



## 2、Hello World

### 2.1 创建 Spring Boot 项目

- 方式一：在线创建

- 方式二：使用Spring Initializer

  https://www.jianshu.com/p/e03b474c855a

- 方式三：Maven 创建

  1.创建Maven项目

  2.导入Spring Boot依赖

  3.编写主程序

  ```java
  //src/main/java/com.yunzike.HelloWorldApplication
  @SpringBootApplication//标注主程序类，说明是一个springBoot应用
  public class HelloWorldMainApplication {
      public static void main(String[] args) {
          //传入主程序类，启动SpringBoot应用
          SpringApplication.run(HelloWorldMainApplication.class,args);
      }
  }
  ```

### 2.2 编写代码  

```java
//设置类为控制层
@Controller
public class HelloController {
    //将方法返回内容写到浏览器
    @ResponseBody
    //将浏览器hello请求映射到hello方法
    @RequestMapping("/hello")
    public String hello(){
        return  "hello world!";
    }
}
```

### 2.3 运行





## 3、自动配置原理











## 处理跨域问题

### 3.1 跨域问题



### 3.2 解决方案



- @CrossOrigin

  ```java
  //处理跨域
  @CrossOrigin
  ```



## 4、参数获取方式

### 4.1 路径 /hello/001 取

```java
@GetMapping（"/hello/{id}"）  
public String hello(@PathVariable("id") int id){
    return "hello"+id;
}
```

### 4.2 路径传参（/hello?id=001）

```java
@GetMapping（"/hello"）
public String hello(@RequestParam("id") int id){
    return "hello"+id;
}
```

这种方式如果请求参数名和形参名一样可以省略@RequestParam注解
可以写成

```java
@RequestParam（value="id",defaultValue="默认值"，required=false）
```

@ModelAttribute

### 4.3 RequestBody 

```java
@PostMapping("/postID")
public Map<String,Object> getInteger(@RequestBody Map<String,Object> param){
    System.out.println(param.keySet());
    System.out.println(param.values());
    return param;
}
```



## 5、整合

### 5.1 整合 MyBatis

#### 1、创建Spring Boot项目

#### 2、添加相关依赖

```xml
<dependency>
  <groupId>mysql</groupId>
  <artifactId>mysql-connector-java</artifactId>
  <version>5.1.49</version>
</dependency>

<dependency>
  <groupId>com.alibaba</groupId>
  <artifactId>druid</artifactId>
  <version>1.2.6</version>
</dependency>

<dependency>
  <groupId>org.mybatis.spring.boot</groupId>
  <artifactId>mybatis-spring-boot-starter</artifactId>
  <version>2.2.0</version>
</dependency>
```

#### 3、进行数据源相关配置

在/main/resource下创建application.yml或application.properties配置文件

```yml
spring:
  datasource:
#   数据源基本配置
    username: root
    password: 123456
    driver-class-name: com.mysql.jdbc.Driver
    url: jdbc:mysql://192.168.15.22:3306/mybatis
    type: com.alibaba.druid.pool.DruidDataSource
#   数据源其他配置
    initialSize: 5
    minIdle: 5
    maxActive: 20
    maxWait: 60000
    timeBetweenEvictionRunsMillis: 60000
    minEvictableIdleTimeMillis: 300000
    validationQuery: SELECT 1 FROM DUAL
    testWhileIdle: true
    testOnBorrow: false
    testOnReturn: false
    poolPreparedStatements: true
#   配置监控统计拦截的filters，去掉后监控界面sql无法统计，'wall'用于防火墙
    filters: stat,wall,log4j
    maxPoolPreparedStatementPerConnectionSize: 20
    useGlobalDataSourceStat: true
    connectionProperties: druid.stat.mergeSql=true;druid.stat.slowSqlMillis=500
mybatis:
  # 指定全局配置文件位置
  config-location: classpath:mybatis/mybatis-config.xml
  # 指定sql映射文件位置
  mapper-locations: classpath:mybatis/mapper/*.xml

#    schema:
#      - classpath:sql/department.sql
#      - classpath:sql/employee.sql

```



### 5.2 整合 Redis





## 6、常用注解

### @SpringBootApplication

申明让spring boot自动给程序进行必要的配置，这个配置等同于：

@Configuration ，@EnableAutoConfiguration 和 @ComponentScan 三个配置。

### SpringMVC 相关

@GetMapping



@PostMapping

@RestController

用于标注控制层组件，@ResponseBody和@Controller的合集。

### 其他



## 7、依赖管理

### Pom.xml

#### 1.父项目

```xml
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



## 8、部署

### 8.1 热部署



### 8.2 项目部署

1、打包

使用Maven将应用打包成jar包，可以直接用java -jar的命令运行应用

```xml
 <!--  这个插件，可以将应用打包成一个可执行的jar包  -->
<build>
    <plugins>
        <plugin>
           <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
    </plugins>
</build>
```

2、部署 Spring Boot 到远程 Docker 容器

① 安装 Docker 插件

② 设置 Docker 远程连接地址

③ 准备项目，并编写 Dockerfile 配置文件

```bash
FROM 
```

④ 配置 Maven 插件

```xml
```

⑤ 打包运行

打包时会自动创建镜像并上传

运行
方式一：在 Linux 上创建容器并运行
方式二：在 IDEA 中创建容器并运行
