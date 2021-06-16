## 1、概述

#### Spring MVC



#### MVC



## 2、简单实现

#### IDEA 下 Hello Spring MVC

1. 在 IDEA 中新建项目并导入依赖

2. <img src="../images/image-20201019125806311.png" alt="image-20201019125806311" style="zoom:50%;" />

   新建普通 Java 项目，再选中项目右键选择 Add Framework Support...  添加 Spring MVC 支持则会自动下载相关依赖 Jar 包

   <img src="../images/image-20201018235852892.png" alt="image-20201018235852892" style="zoom:50%;" />

   如果用**Maven**的，那导入**Maven**依赖即可 前**6**个是**Spring**的核心功能包【**IOC**】，第**7**个是关于**web**的包，第**8**个是**SpringMVC**包

   commons-logging-1.1.3.jar
   spring-aop-4.0.0.RELEASE.jar
   spring-beans-4.0.0.RELEASE.jar
   spring-context-4.0.0.RELEASE.jar
   spring-core-4.0.0.RELEASE.jar
   spring-expression-4.0.0.RELEASE.jar 
   spring-web-4.0.0.RELEASE.jar
   spring-webmvc-4.0.0.RELEASE.jar

3. 在 web.xml 中配置 DispatcherServlet

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
            version="4.0">
   
       <!--  配置 DispatcherServlet  -->
       <servlet>
           <servlet-name>dispatcher</servlet-name>
           <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
           <!--   配置初始化参数：配置 SpringMVC 配置文件的位置和名称  -->
           <init-param>
               <param-name>contextConfigLocation</param-name>
               <param-value>classpath:springmvc.xml</param-value>
           </init-param>
           <!--  Servlet 在应用被加载时就创建，而不是等第一次请求时创建  -->
           <load-on-startup>1</load-on-startup>
       </servlet>
       <servlet-mapping>
           <servlet-name>dispatcher</servlet-name>
           <!--  设置可以处理的请求   -->
           <url-pattern>/</url-pattern>
       </servlet-mapping>
   
   </web-app>
   ```

4. 在 springmvc.xml 中配置控制器和视图解析器

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <beans xmlns="http://www.springframework.org/schema/beans"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/mvc https://www.springframework.org/schema/mvc/spring-mvc.xsd">
   
       <!--  配置自动扫描的包  -->
       <!--    <context:component-scan base-package="com.yunzike.controller"/>-->
   
       <!--  配置视图解析器：把 controller 中方法返回值解析为实际的物理视图  -->
       <!--    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">-->
       <!--        <property name="prefix" value="/WEB-INF/views/"></property>-->
       <!--        <property name="suffix" value=".jsp"></property>-->
       <!--    </bean>-->
   
       <!--    <bean id="helloController" class="com.yunzke.controller.HelloController"></bean>-->
       <!--    <bean id="simpleUrlHandlerMapping" class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">-->
       <!--        <property name="mappings">-->
       <!--            <props>-->
       <!--                &lt;!&ndash; /hello 路径的请求交给 id 为 helloController 的控制器处理&ndash;&gt;-->
       <!--                <prop key="/hello">helloController</prop>-->
       <!--            </props>-->
       <!--        </property>-->
       <!--    </bean>-->
   
   
       <!--
       注册控制器
       name属性的值表示的是请求的路径【也就是说，当用户请求到/helloAction时，就交由 HelloAction类进行处理】
       -->
       <bean class="com.yunzke.controller.HelloController" name="/hello"></bean>
   
   
   </beans>
   ```

5. 编写 controller 类

   ```java
   package com.yunzke.controller;
   
   import org.springframework.web.servlet.ModelAndView;
   import org.springframework.web.servlet.mvc.Controller;
   
   /**
    * @author xiongxq
    * @Description HelloSpring
    * @date 2020/10/19 2:55 上午
    * version: 1.0
    */
   public class HelloController implements Controller {
   
       @Override
       public ModelAndView handleRequest(javax.servlet.http.HttpServletRequest httpServletRequest, javax.servlet.http.HttpServletResponse httpServletResponse) throws Exception {
           System.out.println("aaaaa");
           ModelAndView mav = new ModelAndView("/index.jsp");
           mav.addObject("message", "Hello Spring MVC");
   
           return mav;
       }
   }
   ```

#### Spring MVC 原理



## 3、常见注解

### @RequestMapping

作用：建立请求 URL 和处理方法之间的对应关系

使用范围：方法和类

​	作用在类上：第一级的访问目录
​	作用在方法上：第二级的访问目录
​	细节：路径可以不编写/ 表示应用的根目录开始

属性：

​	path：指定请求路径的 url
​	value：value 属性和 path 属性是一样的
​	method：指定该方法的请求方式
​	params：指定限制请求参数的条件
​	headers：发送的请求中必须包含的请求头

### @RequestParam

作用：把请求中的指定名称的参数传递给控制器中的形参赋值

属性：

​		value：请求参数的名称
​		required：请求参数中是否必须提供此参数，默认值是 true

### @RequestBody

作用：用于获取请求体的内容（注意：get 方法不能使用）

属性：
		required：是否必须有请求体，默认值是 true

### @PathVariable

作用：拥有绑定 url 中的占位符。例如：url 中有/delete/{id}，{id} 就是占位符

属性：

​		value：指定 url 中的占位符名称

### @RequestHeader

作用：获取指定请求头的值

属性：

​		value：请求头的名称

### @CookieValue

作用：获取指定 cookie 的名称的值

属性：

​		value：cookie 的名称

### @ModelAttribute

作用：出现在方法上，表示当前方法会在控制器方法执行前执行；出现在参数上，获取指定的数据给参数赋值



### @SessionAttributes

作用：用于多次执行控制器方法间的参数共享

属性：

​	value：指定存入属性的名称



### Spring Boot 封装的注解

@GetMapping

@PostMapping



## 4、映射请求参数&请求头





## 5、处理模型数据







## 6、RESTful CRUD



## 7、视图和视图解析器



## 8、SpringMVC表单标签&处理静态资源



## 9、数据转换&数据格式化&数据校验



## 10、处理JSON：使用HttpMessageConverter

