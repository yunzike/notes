## 1、概述

































## 2、使用

#### 整合mybatis-plus

```bash
* 1、整合mybatis-plus
 *    1)导入依赖
 *      <dependency>
 *          <groupId>com.baomidou</groupId>
 *          <artifactId>mybatis-plus-boot-starter</artifactId>
 *          <version>3.3.2</version>
 *      </dependency>
 *    2)配置
 *      配置数据源：
 *          导入数据库的驱动，
 *          在application.yml里面配置数据源相关信息
 *      配置MyBatis-Plus
 *          在SpringBoot启动类中使用@MapperScan("com.atguigu.gulimall.product.dao")配置要扫描的mapper接口
 *          在application.yml中告诉MyBatis-Plus,sql映射文件的位置
 *
 */
```

```yml
spring:
  datasource:
    username: root
    password: root
    url: jdbc:mysql://192.168.56.10:3306/gulimall_pms
    driver-class-name: com.mysql.cj.jdbc.Driver

mybatis-plus:
  # sql映射文件的位置
  mapper-locations: classpath:/mapper/**/*.xml
  # 主键自增
  global-config:
    db-config:
      id-type: auto
```

#### 

- 导入依赖

  ```pom
  
  ```

- 配置数据源

  ```
  ```

- 配置mybatisplus

  包扫描：

  ```java
  @MapperScan("com.yunzike.gulimall.product.dao")
  @SpringBootApplication
  public class GulimallProductApplication {
      
          public static void main(String[] args) {
          SpringApplication.run(GulimallProductApplication.class, args);
      }
  
  }
  ```

  配置SQL映射位置(可省略)

  ```yml
  默认classpath*:/mapper/**/*.xml
  ```

  

















































