---
title: ServletContext
date: 2019-01-17 15:15:29
tags:
 - ServletContext
categories: Servlet
---
Web容器启动时，会为每个Web应用创建一个对应的ServletContext对象，代表当前Web应用。由于一个Web应用中所有Servlet共享一个Context,所以多个Servlet可以通过ServletContext实现数据共享。
ServletContext对象通常也称之为Context域对象.

四个域：
context、request、session、page


#### 一、获取ServletContext对象
````
ServletContext context = this.getServletContext();
或
ServletContext context = this.getServletConfig().getServletContext();
````
#### 二、使用ServletContext进行存取
##### 1、存入数据
````
String data = "aaa";
this.getServletContext().setAttribute("data",data);
````
##### 2、读取数据
````
ServletContext context = this.getServletContext();
String str = (String) context.getAttribute("data");
````

#### 三、获取Web应用的初始化参数

在web.xml中使用<context-param>为整个web应用配置初始化参数，会在web应用创建时封装到ServletContext对象中。
````
<context-param>
  	<param-name>data</param-name>
  	<param-value>xxx</param-value>
</context-param>
````
然后可以使用获取ServletConfig对象中的初始化参数同样的方式来获取这些参数。



#### 四、实现Servlet的请求转发

Servlet收到浏览器的请求后产生要返回的数据，但Servlet不适合展示数据，可以将数据转给jsp来展示给浏览器。
##### 1、首先获取调度器，指定转发对象路径
````
RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/1.jsp");
````
##### 2、调用调度器的forward方法实现转发
````
dispatcher.forward(request, response);
````
但是Servlet的产生的数据没有带给jsp，可以通过ServletContext存储（这种方法有线程安全问题）

#### 3、jsp中获取ServletContext的数据，显示给浏览器
````
String data = (String)application.getAttribute("data");
````

#### 五、读取资源文件

##### 1、读取properties文件
````
//通过ServletContext读取资源文件转化为输入流
InputStream in = this.getServletContext().getResourceAsStream("/WEB-INF/classes/db.properties");
//或者通过ServletContext获取最终web应用的实际路径，然后通过文件流读取
String realPath = this.getServletContext().getRealPath("/WEB-INF/classes/db.properties");
FileInputStream in = new FileInputStream(realPath);
//通过properties对象的load方法读取流文件，转化为map保存
Properties properties = new Properties();
properties.load(in);
//获取资源文件内容
String url = properties.getProperty("url");
String username = properties.getProperty("username");
String password = properties.getProperty("password");
````
#### 六、在非Servlet程序中读取资源文件
````java
//通过类的装载器获取输入流然后操作
InputStream in = UserDao.class.getClassLoader().getResourceAsStream("/WEB-INF/classes/db.properties");

````










