### 一、Aop

#### 1、概述

- 问题

  

  

  

- AOP（ aspect object programming）

  AOP面向切面编程，是对面向对象编程的有益补充。
  Spring通常通过AOP来处理一些具有横切性质的系统性服务，如事务管理、安全检查、缓存、对象池管理等。



#### 2、常用术语

- 连接点（Joinpoint）

  程序执行的某个特定位置，如类开始初始化前、类初始化后、类某个方法调用前、调用后、方法抛出异常后，这些代码中的特定点，称为“连接点”。Spring中仅支持方法的连接点。

- 切入点 / 切点（Pointcut）

  Spring中AOP的切入点就是一组连接点（简单的讲是指一些方法的集合）。

- 通知 / 增强（Advice）

  在特定的Joinpoint处运行的代码，AOP框架执行的动作，就是在指定切点上要干些什么。

- 方面（Aspect）

  是Pointcut和Advice的组合，切面由切点和增强组成，它既包括了横切逻辑的定义，也包括连接点的定义。

- 引入 / 引介（Introduction）

  添加方法或字段到被通知的方法。

- 目标对象（Target Object）

  代理的目标对象。

- AOP代理（AOP Proxy）

  AOP框架创建的对象，包含通知。在Spring中，AOP代理可以是JDK动态代理或CGLIB代理。

- 织入（Weaving）

  将增强添加到目标对象来创建新的代理对象的过程。spring 采用动态代理织入，而 AspectJ 采用编译期织入和类装载期织入。


### 二、实现

#### 1、方式一：基于AspectJ注解

- ①导入Spring基本的Jar包和AOP相关和所依赖的Jar包

  ![image-20200406225327143](../../images/image-20200406225327143.png)
  spring-aop-3.2.5.RELEASE.jar
  spring-aspects-5.1.0.jar

  aopalliance.jar 【spring2.5源码/lib/aopalliance】 
  aspectjweaver.jar 【spring2.5源码/lib/aspectj】或【aspectj-1.8.2\lib】：支持切入点表达式等等
  aspectjrt.jar：简单理解，支持aop相关注解等等，该Jar包不需要引入，因为aspectjweaver.jar中包含有。

- ②在Spring的XML配置文件中加入aop的命名空间，并添加开启AspectJ的配置

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <beans xmlns="http://www.springframework.org/schema/beans"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns:aop="http://www.springframework.org/schema/aop"
         xmlns:context="http://www.springframework.org/schema/context"
         xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">
  
      <!-- 配置自动扫描的包 -->
      <context:component-scan base-package="com.yunzike.aop.impl" />
  
      <!-- 开启AOP注解 -->
      <aop:aspectj-autoproxy/>
  
  </beans>
  ```

- ③使用Aspect注解来定义切面，在切面中编写方法声明为通知，并指定切点

  ```java
  package com.yunzike.aop.impl;
  
  
  import org.aspectj.lang.annotation.After;
  import org.aspectj.lang.annotation.Aspect;
  import org.aspectj.lang.annotation.Before;
  import org.springframework.stereotype.Component;
  
  // 需要先使用@Component注解将切面交由Sping容器管理
  @Component
  @Aspect
  public class LoggingAspect {
  
      //使用execution指定切面
      @Before("execution(public void com.yunzike.aop.impl.UserDao.save())")
      public void before(){
          System.out.println("开始事务。。。");
      }
  
      @After("execution(public void com.yunzike.aop.impl.UserDao.save())")
      public void after(){
          System.out.println("开始事务。。。");
      }
  
  }
  ```

  目标对象类和所实现的接口

  ```java
  /**
   * 所实现的接口
   */
  package com.yunzike.aop.impl;
  
  public interface IUser {
      void save();
  }
  
  
  /**
   * 目标对象类
   * 
   */
  package com.yunzike.aop.impl;
  
  import org.springframework.stereotype.Component;
  
  @Component
  public class UserDao implements IUser{
  
      @Override
      public void save() {
          System.out.println("业务代码。。。。");
      }
  }
  ```

  测试类

  ```java
  package com.yunzike.aop.impl;
  
  import org.springframework.context.ApplicationContext;
  import org.springframework.context.support.ClassPathXmlApplicationContext;
  
  public class AopTest {
      public static void main(String[] args) {
          ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
          IUser userDao = (IUser) context.getBean("userDao");
  
          System.out.println(userDao.getClass());
  
          userDao.save();
      }
  }
  ```

  输出

  ![image-20200605010921431](../../images/image-20200605010921431.png)

#### 2、方式二：基于XML配置






#### 3、通知类型

- 前置(Before)通知

  在目标方法开始之前执行

- 后置(After)通知

  在目标方法执行（无论是否发生异常）之后执行，无法访问目标方法执行的结果。

- 异常(Throws)通知

- 最终通知

- 环绕(Around)通知

#### 4、通知配置

- AspectJ切点函数格式

  ①方法签名

  ```java
  /**
   * 任意返回值类型：*
   * 任意方法名：
   *
   */
  
  //所有目标类的public方法
  execution(public * *(..))
  
  //目标类的所有以DAO为后缀的方法
  execution(* *DAO(..))
      
  //类下的
  ```

  

  ②类
  ③包
  ④





  



