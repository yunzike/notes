#### 一、JSP内置对象（共9个，不用声明便可直接使用）

#### 1、out

- 概述
  
  javax.servlet.jsp.JspWriter对象的实例，表示一个输出流，用于向客户端输出东西。javax.servlet.http.HttpServletRequest接口的实例化对象，封装了客户端请求的所有信息（请求头、提交的参数、Cookie信息、客户端浏览器信息等）
  
- 常用方法
  
  ```java
  print();
  println();
  write();
  newline();      //输出一个空行
  close();        //关闭输出流
  ```

#### 2、request

- 概述
  
  javax.servlet.http.HttpServletRequest接口的实例化对象，封装了客户端请求的所有信息（请求头、提交的参数、Cookie信息、客户端浏览器信息等）

- 常用方法
  
  ```java
  void setCharacterEncoding(String); //设置请求信息的编码
  
  Enumeration getParameterNames( );//获取客户端提交的参数名列表
  String getParameter(String);//获取客户端提交的指定参数值
  String[] getParameterValues(String);//获取客户端提交的一组参数值（复选框、列表框）
  
  Cookie[] getCookies( );//获取客户端提交的Cookie
  String getRemoteAddr( );//获取客户端的IP地址
  String getContextPath( );//获取上下文路径
  
  Object getAttribute(String);//获取request中的附加属性
  void setAttribute(String, Object);//向request对象添加一个附加属性
  void removeAttribute(String);//移除一个附加属性
  ```

#### 3、response

- 概述
  
  javax.servlet.http.HttpServletResponse接口的实例，用于对客户端的请求进行响应（设置响应头、向客户端写入Cookie信息、返回处理结果给客户端）

- 常用方法
  
  ```java
  void setContentType(String);//设置响应的MIME类型
  void setCharacterEncoding(String);//设置响应的字符编码
  PrintWriter getWriter( );//获取输出流对象
  
  void addCookie(Cookie);//添加Cookie到响应中
  void sendRedirect(String);//将页面重定向到指定地址
  String encodeRedirectURL(String);//将指定地址进行URL编码以便在sendRedirect方法中使用
  ```

- 重定向和请求转发（forward）
  
  重定向是将新的URL发送给客户端，客户端改变URL然后发起新的请求，最后跳转页面；
  
  forward是将客户端的原请求转发给新的资源，从而实现客户端页面的改变。

#### 4、session

- 概述
  
  javax.servlet.http.HttpSession类的实例，客户第一次访问网站时，服务器端为每个客户端创建一个session对象，用于记录客户的信息以便对用户进行跟踪。这些会话对象通过不同的session ID来区分。 当客户退出服务器时对应该客户的session对象就会被注销。这样一个过程就称为会话。

- 常用方法
  
  ```java
  Enumeration getAttributeNames( );//获取绑定在session对象上的所有对象名称
  void setAttribute(String，Object);//将指定对象绑定到session对象上
  Object getAttribute(String);//通过键名获取session绑定的对象 
  void removeAttribute(String);//移除session绑定的指定对象
  
  long getId( );//获取session的ID
  void invalidate( );//注销session对象
  boolean isNew( );//判断session对象是否为新对象
  
  long getCreationTime( );//获取session创建时间
  long getLastAccessedTime( );//获取客户端最近一次访问时间
  int getMaxInactiveInterval( );//获取最大session等待间隔时间
  void setMaxInactiveInterval( );//设置最大session等待间隔时间
  ```

- 会话失效
  
  ① 客户关闭浏览器；
  
  ② 会话超时（规定时间内没有再次访问网站，默认为30分钟）；
  
  ③ 使用invalidate( ) 方法注销session。

#### 5、application

- 概述
  
  javax.servlet.ServletContext接口的实例化对象，它是一个公共对象，代表整个Web应用程序，存储应用程序相关信息，任何用户在任何页面都可以访问其所有绑定对象信息

- 常用方法
  
  ```java
  void setAttribute(String，Object);//将指定对象绑定到application对象上
  Object getAttribute(String);//通过键名获取session绑定的对象 
  void removeAttribute(String);//移除application绑定的指定对象
  
  String getRealPath(String);//获取指定虚拟路径的真实路径
  String getInitParameter(String);//返回配置文件（web.xml）中指定的上下文参数值
  ```

- 上下文初始化参数配置
  
  ```java
  //在web.xml中
  <context-param>
         <param-name>参数名</param-name>
         <param-value>参数值</param-value>
  </context-param>
  ```

#### 6、page

- 概述
  
  page是java.lang.Object的对象实例，也是当前JSP页面转换后的Servlet类的实例，类似于Java中的this，指代当前JSP页面

#### 7、pageContext

- 概述
  
  pageContext是javax.servlet.jsp.PageContext 的实例，提供JSP页面的上下文，可以实现JSP页面中所有对象和属性的管理和访问

#### 8、exception

- 概述
  
  java.lang.Throwable类的实例，表示运行时的异常，用来处理JSP文件在执行期间发生的错误和异常。该对象只能在使用page指令指定为错误处理页面的JSP中使用。

- 常用方法
  
  ```java
  String getMessage( );     //返回错误信息
  void printStactTrace( );  //输出错误栈
  String toString( );       //以字符串形式返回一个对异常的描述
  ```

#### 9、config



## 二、作用域（即对象范围或数据作用范围）

- page
  
  声明为page范围的对象会被绑定到pageContext对象上。
  
  在客户端每次请求页面时被创建，只能在创建该对象的页面中访问该对象，在页面完成对客户端的响应或者请求被转发时被删除。

- request
  
  声明为request范围的对象会被绑定到request对象上。
  
  在请求对象产生后、响应完成前存在，能在被请求的页面和调用forward之后的页面以及被include的页面中访问。

- session
  
  声明为session范围的对象会被绑定到session对象上。
  
  JSP容器会为每次会话创建一个会话对象，会话期间在每一个JSP页面都可以访问该范围的对象。

- application
  
  声明为application范围的对象会被绑定到application对象上。
  
  整个web程序运行期间，每个JSP页面都可以访问该范围的对象。






