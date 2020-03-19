## 一、概述

- Spring

- Spring核心主要是两点： 

- **Spring框架结构**

  

## 二、两种容器

- **BeanFactory** 容器

  

- **ApplicationContext** 容器



## 三、Bean

- Bean

  

- 作用域（scope）

  | **作用域**     | **描述**                                                     |
  | -------------- | ------------------------------------------------------------ |
  | singleton      | 在spring IoC容器仅存在一个Bean实例，Bean以单例方式存在，默认值 |
  | prototype      | 每次从容器中调用Bean时，都返回一个新的实例，即每次调用getBean()时，相当于执行newXxxBean() |
  | request        | 每次HTTP请求都会创建一个新的Bean，该作用域仅适用于WebApplicationContext环境 |
  | session        | 同一个HTTP Session共享一个Bean，不同Session使用不同的Bean，仅适用于WebApplicationContext环境 |
  | global-session | 一般用于Portlet应用环境，该运用域仅适用于WebApplicationContext环境 |

- 生命周期

  

- 后置处理器

  

- 定义继承















