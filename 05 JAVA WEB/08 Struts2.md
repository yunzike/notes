## 一、概述

- Struts2

  Struts 2是一种表现层框架。在Struts 1的基础上注入了WebWork的先进的设计理念，以WebWork为核心，统一了Struts 1和WebWork两个框架。

- Struts2的优点

  ① 当程序功能很多时，比如CRUD操作，用Servlet实现需要给每一个功能创建一个Servlet，造成维护特别不方便。

  ② **web阶段的解决方案**（使用BaseServlet）
  缺点：需要写底层反射代码来实现；每次都需要继承BaseServlet，且实现的功能也不够强大。 
  ③ **Struts2的解决方案**
  通过封装的**过滤器**来拦截所有请求，对于不同请求在类中写不同方法，根据不同请求执行不同方法。

- 工作原理

  ① 用户提交请求；
  ② 核心控制器（过滤器）StrutsPrepareAndExecuteFilter(2.1.3之前为FilterDispatcher)过滤请求，并调用ActionMapper以确定是否需调用Action。如需调用，ActionMapper通知StrutsPrepareAndExecuteFilter将请求处理交给ActionProxy；

  ③ ActionProxy通过Configuration Manager解析框架的配置文件struts.xml，找到需要调用的Action类。同时，ActionProxy实例化ActionInvocation；
  ④ ActionInvocation实例调用与Action有关的拦截器以及Action类的execute方法。Action执行完毕后，ActionInvocation根据struts.xml中配置的action的相应result，将页面导航到指定URL。

  ![undefined](../../../%25E5%259D%259A%25E6%259E%259C%25E4%25BA%2591/images/006evuW4gy1g9959abgfqj31x20sojzr.jpg)

## 二、实现

- 步骤

  ① 创建web项目，导入Struts2相关jar包

  ② 配置过滤器（web.xml）

  ③ 编写action类和视图文件

  ④ 配置action类的访问路径（struts.xml）

- 简单实现

  ```java
  //简单实现
  ```

## 三、配置文件

- web.xml

  ```java
  <filter>
           <filter-name>struts2</filter-name>
           <filter-class>                              org.apache.struts2.dispatcher.filter.StrutsPrepareAndExecuteFilter
           </filter-class>
  </filter>
  <filter-mapping>
           <filter-name>struts2</filter-name>
           <url-pattern>/*</url-pattern>
  </filter-mapping>
  ```

- struts.xml

  Include（配置其他xml配置文件）、Constant（配置常量）、Bean（配置Bean）、package

  ```java
  <?xml version="1.0" encoding="UTF-8" ?>
  <!DOCTYPE struts PUBLIC
  "-//Apache Software Foundation//DTD Struts Configuration 2.5//EN"
  "http://struts.apache.org/dtds/struts-2.5.dtd">
  
  <struts>
          <package name="fiststruts" extends="struts-default" namespace="/">
                  <action name="hello" class="com.yunzike.action.HelloAction">
                           <result name="ok">/hello.jsp</result>
                  </action>
         </package>
  </struts>
  ```

- struts-defalut.xml

- struts-plugin.xml



## 1、Action

- action请求与Action类

  action：代表一个Struts2的请求

  Action类：能够处理Struts2请求的类

  ①属性的名字必须遵守与JavaBeans属性名相同的命名规则。属性的类型可以是任意类型。从字符串到非字符串（基本数据库类型）之间的数据转换可以自动发生

  ②必须有一个不带参的构造器：通过反射创建实例

  ③同一个Action类可以包含多个action方法

  ④Struts2会为每一个HTTP请求创建一个新的Action实例，即Action不是单例的，是线程安全的。

- 实现(三种方式)

  ① 普通Java类

  

  ② 继承Action接口

  

  ③ 继承ActionSupport

  

- 配置



- 访问WEB资源

  WEB资源：HttpSeruletRequest，HttpSession，ServletContext等原生的Servlet API

  为什么要访问WEB资源：

  访问方式：

  ①

  ②

## 2、获取表单数据

- 原始方式



- 属性封装

- 

- 模型驱动

  ① Action实现接口ModelDriven接口

  ② 实现接口里面的方法（getModel方法，返回实体类对象）

  ③ 在Action类中创建实体类对象，表单输入项name值要与实体类属性值相同

  

- 表达式封装

  ① 在Action中声明实体类

  ② 生成实体类的get、set方法

  ③ 在表单输入项的name属性值里写表达式（实体类.属性名）

## 拦截器

#### 1、拦截器原理

Struts 2拦截器是动态拦截Action调用的对象。拦截器是面向切面编程(Aspect-oriented Programming），简称AOP)的一种实现策略，提供了一种可以提取action中可重用的部分的方式。它工作在Struts2控制器和Action之间，在Action执行前后被执行。在Action执行之前做一些预处理，在Action执行之后做一些后续加工。



#### 2、内建拦截器

- 基本拦截器栈（basicStack）

- 校验器拦截器栈（validationWorkflowStack）

- 文件上传拦截器栈（fileUploadStack）

- 所有通用的拦截器组成的默认拦截器栈（defaultStack）



#### 3、自定义拦截器

自定义一个拦截器类时，该类必须实现Intereptor接口，或者继承抽象拦截器类AbstractInterceptor。Intereptor接口中提供了一个抽象方法：String intercept(ActionInvocation invocation) throws Exception

