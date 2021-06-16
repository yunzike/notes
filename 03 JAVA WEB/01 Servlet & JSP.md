## 1、入门

###  1.1 概述

- Servlet

  **Servlet**是sun公司提供的一种用于开发动态web资源的技术（静态web资源由Html等技术实现 ）；Servlet是运行在Web服务器端的小程序，是对服务器功能的一个扩展，通过创建一个框架来扩展服务器的能力，以提供在Web上进行请求和响应服务。

- Servlet和JSP的比较

  ① JSP和Servlet没有本质区别，JSP能完成的任务Servlet都能完成，JSP首先会被转化为Servlet才编译运行；

  ② Servlet中使用纯Java代码编写，可以很方便的调用Java的其他组件，而JSP是将Java代码嵌入到HTML代码中，更容易生成复杂的HTML页面；

  ③ 实际使用中通常两者结合，使用Servlet进行业务处理，而JSP用于显示结果或者提供输入界面。

- 工作原理

  ① Web服务器（Servlet容器）接收到客户端请求，容器创建“请求和响应”对象，并判断Servlet对象是否存在。

  ② 如果存在，则直接调用此Servlet对象的service方法（间接调用doPost或doGet等方法），并将“请求和响应”对象作为参数传递。

  ③ 如果不存在，容器负责加载Servlet类，创建Servlet对象并实例化，然后调用Servlet的init方法进行初始化，之后调用service方法。

  ④ 在service方法中，通过“请求”对象获取客户端提交的数据并进行处理，然后通过响应对象将处理结果返回给客户端。

- 生命周期

  ① 初始化阶段：调用init( )方法；

  ② 响应客户请求阶段：调用service( )方法；

  ③ 终止阶段：调用destroy( )方法。

  **【说明】**：在Servlet的生命周期中，同一个Servlet对象可以为多个客户端服务，即多个客户端共用同一个Servlet对象，对不同客户端容器仅仅为每个请求创建不同的请求和响应对象，因此Servlet是线程不安全的。

### 1.2 实现

- 步骤

  ① 创建WEB应用并新建继承HttpServlet类的Servlet类，并覆盖父类的doGet( )和doPost( )方法；

  由于系统只配置了J2SE相关jar包，所以要先把Tomcat中包含的Servlet的jar包配置到系统环境变量中。

  ② 在web应用的配置文件web.xml中为编写好的Servlet类配置一个对外访问的虚拟路径。

  ③ 启动tomcat并访问。

- 简单实现

  ```java
  //Severlet简单实现
  ```

### 1.3 配置文件

- 基础配置

  可以参考tomcat中web.xml内容，抄文件头和文件尾。

  一个servlet可以映射多个url

  使用通配符*，只能是两种固定格式
  一种格式是*.扩展名，另一种格式是 /开头，/*结尾
  而不能出现/xxx/*.扩展名
  只写/，表示缺省的servlet，用来处理其他所有Servlet都不处理的请求

  ```java
  <servlet>
      <servlet-name>ServletDemo2</servlet-name>
      <servlet-class>com.yunzike.ServletDemo2</servlet-class>
  </servlet>
  
  <servlet-mapping>
      <servlet-name>ServletDemo2</servlet-name>
      <url-pattern>/myServletDemo2</url-pattern>
  </servlet-mapping>
  ```

- load-on-startup

  servlet在浏览器初次访问时，如果没有创建servlet对象则创建对象并调用init方法初始化，否则不创建而是直接调用已经存在的service方法，传入不同的request和response对象，在移除容器时destroy。

  可以通过如果在元素中配置一个load-on-srartup，让servlet在服务器启动时创建并调用init初始化，数字越小优先级越高。

  ```java
  <load-on-startup>2</load-on-startup>
  ```

- ServletConfig 
  实际开发中，有些东西不适合在servlet程序中写死，这类数据就可以通过这个种方式配置给servlet，例如servlet采用哪个码表，servlet连接数据库。可以在中使用一个或多个标签为这个Servlet配置一些初始化参数。

  web容器会在创建servlet对象时将这些参数封装到ServletConfig对象中。

  ```
  <init-param>
    <param-name>data</param-name>
    <param-value>xxx</param-value>
  </init-param>
  ```




## 2、主要接口及实现类

### 2.1 Servlet

- 概述

  javax.servlet.Servlet接口，Servlet类的基本接口，所有定义的Servlet都要直接或间接的实现这个接口。

- 常用方法

  ```java
  /**
   * Servlet接口定义的方法
   */
   
  void init(ServletConfig config);  //Servlet初始化
  void service(ServletRequest req,ServletResponse res);//处理客户端请求
  void destroy( );     //容器检测到一个Servlet要被移除时，做一些收尾工作
  ServletConfig getServletConfig( );//返回初始化Servlet时传入的Servlet版本、作者等
  ```

### 2.2 ServletConfig

- 概述

  javax.servlet.ServletConfig接口，其实例对象在初始化时作为init( )方法的参数传入，用来获取从Servlet容器中读取的其他配置信息。

- 常用方法

  ```java
  /**
   * ServletConfig接口定义的方法
   */
   
  String getInitParameter(String name)；  //返回名字为name的初始化参数
  Enumerartion getInitParameterNames( )； //返回所有参数的名字枚举集合
  ServletContext getServletContext( )；   //返回Servlet上下文的引用
  String getServletName( )；              //返回Servlet实例名
  ```

### 2.3 GenericServlet

- 概述

  javax.servlet.GenericServlet类，一个实现了Servlet接口和ServletConfig接口的抽象类，对除service方法外的所有接口的方法做了缺省实现。

### 2.4 HttpServlet

- 概述

  javax.servlet.http.HttpServlet类，继承自GenericServlet并对HTT进行封装的子类。针对HTTP1.1的7种请求方式(Get、Post等)提供了7种方法（doXXX）来处理。





### 2.5 HttpServletRequest和HttpServletResponse





## 3、Servlet 与客户端通信

### 3.1 request对象



### 3.2 response对象



### 3.3 ServletContext(上下文)

- 概述

  每一个运行在Java虚拟机中的Web应用都有一个与之对应的上下文，通过上下文Servlet可以和容器进行通信并获得运行的环境参数。Servelet中提供ServletContext接口来表示Servlet上下文。上下文路径即访问对应的Web应用的起点（应用的根）。

- 获取方式

  ```java
  可以通过ServletConfig对象的getServletConfig( )方法获取，
  或者GenericServlet的getServletConfig( )方法获取
  ServletContext context = this.getServletContext();
  或
  ServletContext context = this.getServletConfig().getServletContext();
  
  ServletContext context = request.getSession().getServletContext();
  ```

- 定义的方法

  ```java
  String getInitParameter(String name);//返回名字为name的初始化参数
  Enumerartion getInitParameterNames( );//返回所有初始化参数的名字枚举集合
  String getRealPath(String path);//返回真实路径   
  
  setAttribute("data",data);
  getAttribute("data");
  ```

- 获取ServletContext的数据

  ````
  String data = (String)application.getAttribute("data");
  ````

### 3.4 RequestDispatcher(请求转发)

- 概述

  Servlet收到浏览器的请求后产生要返回的数据，但Servlet不适合展示数据，可以将数据转给jsp来展示给浏览器。但是Servlet的产生的数据没有带给jsp，可以通过ServletContext存储（这种方法有线程安全问题）

- 获取调度器并指定转发对象路径

  ```java
  //三种方式获取
  ServletRequest.getRequestDispatcher(String path);
  ServletContext.getRequestDispatcher(String path);
  ServeltContext.getNamedDispather(String path);
  ```

- 调用调度器的forward方法实现转发

  ```java
  void forward(ServletRequest req,ServletResponse res);
  void include(SevletRequest req,ServletResponse res);
  ```

### 3.5 Cookie对象

- 概述

  

- 基本使用

  ```java
  Cookie varName = new Cookie(key,value); //创建Cookie
  response.addCookie(varName); //插入响应
  Cookie[] cks = request.getCookies( ); //读取
  ```

- 生存周期

  创建Cookie对象后应当使用Cookie对象的setMaxAge( )方法为此Cookie对象指定一个有效时间，即Cookie的生命周期，若不指定，则当浏览器关闭后Cookie就失效了





## 4、过滤器

###  4.1 概述

- 过滤器

  过滤器是Java在服务器端的一个可插拔的Web组件，可以截取客户端和请求目标资源之间的请求和响应，并对请求、响应信息进行预处理或过滤。

- 工作原理

  客户端请求目标资源时，容器会首先调用过滤器，对请求数据进行检查和处理，并依次经过过滤器链，在经过每个过滤器时，过滤器可以将请求交给下一个过滤器或目标资源，也可以请求转发，到达预定页面。

- 应用

  记录对特殊资源的请求、处理安全协议、管理会话等如：通过过滤器设置请求和响应对象的字符编码，对某个资源进行保护，如只允许127.0.0.1访问。

### 4.2 实现

- 实现过滤器必须实现javax.servlet.Filter接口

- Filter接口定义的方法

  ```java
  //创建过滤器时进行初始化，通过FilterConfig对象可以获取web.xml中的过滤器初始化参数
  void init(FilterConfig filterConfig);
  
  //容器销毁过滤器实例前调用，释放init( )方法中申请的资源
  void destroy( );
  
  //进行过滤操作，处理完所有信息后，必须调用FilterChain对象的doFilter( )方法将请求传递到过滤器链中的下一个过滤器或者forward( )、sendRedirect( )方法结束过滤器链，将请求转向预定页面。
  void doFilter(ServletRequest req,ServletResponse res,FilterChain chain);
  ```

### 4.3 部署

```java
<!--声明-->
<filter>
         <!--过滤器标识名-->
         <filter-name>filterDemo</filter-name>
         <!--过滤器实现类-->
         <filter-class>com.yunzike.filter.FilterDemo</filter-class>
</filter>

<!--引用-->
<filter-mapping>
          <!--引用已定义的过滤器-->
          <filter-name>filterDemo</filter-name>
          <!--目标资源的URI-->
          <url-pattern>/*</url-pattern>
</filter-mapping>
```

### 4.4 过滤器链

在web.xml中按需要的顺序部署多个过滤器，目标资源的URI指向同一个资源或包含指定资源。调用顺序为部署文件中的配置顺序。



## 5、监听器

###   5.1 概述

- 生命周期事件（应用生命周期事件）

  Servlet中应用程序在执行过程中，ServletContext、HttpSession、ServletRequest各对象在其生命周期中状态和属性的改变。

- 监听器

  监听器是对一个或多个Servlet生命周期事件进行监听的类。通过定义监听器，可以监听这些事件的发生，并进行响应，同一事件的多个监听器按照它们部署（注册）的顺序调用。可以更好地进行代码的分解，并在管理Web应用的使用的资源上提高效率。

###  5.2 监听器

#### 1、ServletContext事件及监听器

![image-20191205231652352](../../../../%25E5%259D%259A%25E6%259E%259C%25E4%25BA%2591/images/image-20191205231652352.png)

#### 2、HTTPSession事件及监听器

#### ![image-20191205231635731](../../../%25E5%259D%259A%25E6%259E%259C%25E4%25BA%2591/images/image-20191205231635731.png)

#### 3、ServletRequest事件及监听器

![image-20191205231739562](../../../%25E5%259D%259A%25E6%259E%259C%25E4%25BA%2591/images/image-20191205231739562.png)

![image-20191205231832159](../../../%25E5%259D%259A%25E6%259E%259C%25E4%25BA%2591/images/image-20191205231832159.png)

### 5.3 实现

- 实现监听器接口

  ```java
  /**
   * 监听SevletContext
   * 实现数据库的连接并绑定到上下文和关闭连接
   */
  
  public class DBManagerListener implements ServletContextListener{
  
      public void contextInitialized(ServletContextEvent sce) {
          try {
              String driverName = "com.mysql.jdbc.Driver";
              String url = "jdbc:mysql://120.79.246.19:3306/test?useSSL=false";
              String user = "root";
              String password = "yunzk123";
  
              Class.forName(driverName);
              Connection conn = DriverManager.getConnection(url, user, password);
  
              //获取上下文
              ServletContext context = sce.getServletContext();
              //将连接对象绑定到上下文
              context.setAttribute("DBCon",conn);
              System.out.println("创建数据库连接成功......");
          } catch (Exception e) {
              System.out.println("创建数据库连接失败......");
              e.printStackTrace();
          }
      }
  
      public void contextDestroyed(ServletContextEvent sce) {
          ServletContext context = sce.getServletContext();
  
          Object dbCon = context.getAttribute("DBCon");
          if (dbCon != null) {
              Connection conn = (Connection) dbCon;
              try {
                  if (!conn.isClosed()) {
                      conn.close();
                      System.out.println("关闭数据库连接......");
                  }
              } catch (SQLException e) {
                  e.printStackTrace();
              }
          }
      }
  
  }
  ```

- 监听注册部署

  ```xml
  <listener>
      <listener-class>
      com.yunzike.listener.DBManagerListener
    	</listener-class>
  </listener>
  ```




## 6、JSP 概述

### 6.1 概述

JSP全称Java Server Page，Oracle（原Sun）公司等建立的一种动态网页技术标准，它由Servlet扩展而来，将Java代码和JSP标记嵌入到传统HTML代码中形成JSP文件。

### 6.2 JSP执行流程

① 当客户端向服务器发出一个JSP请求时，服务器首先检查该JSP是否第一次被访问，若是第一次，则先将JSP文件转换为Servlet类文件，若文件存在语法错误则停止转换并将错误信息提交给服务器，然后由服务器转发给客户端；若转换成功，则继续编译成class文件。

② 容器将编译好的Servlet文件加载并常驻内存，并负责提供服务来响应用户的请求。如果多个客户端同时请求该JSP文件，则容器会创建多个线程，每个客户端对应一个线程。

③ 如果JSP文件被修改，服务器将根据设置决定是否重新编译。



## 7、JSP 基本语法

### 7.1 基本格式

```java
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>主页</title>
   </head>
   <body>
      ...
      JSP元素和模板数据
      ...
   </body>
</html>
```

### 7.2 JSP元素

#### 1、脚本元素

- 声明（<%!  %>）

  可以声明变量和方法；

  声明的变量或方法为页面共享级变量，并发访问页面时线程不安全；

  可以直接使用变量或者通过this关键字访问变量；

  ```java
  <%! String str = "hello world"; %>
  <%! String getStr( ){
       return "Hello World";
  }%>
  ```

- 脚本段（<%  %>）

  脚本段中间可以自由内嵌模板数据或其他脚本段

  ```java
  <%
       int i = 100;
       if(i>10){
          %>
          <h1>页面文本：i>10</h1>
          <%
       }else{
          %>
          <h1>页面文本：i<10</h1>
          <%
       }
  %>
  ```

- 表达式（<%=   %>）

  表达式由变量、常量、带返回值的方法以及运算符组成；

  表达式后面没有“；”

  ```java
  <%= 表达式 %>
  ```

#### 2、指令元素（<%@   %>）

- 语法格式

  ```java
  <%@ 指令名  属性名1 = "属性值" ; 属性名2 = "属性值" ; ... %>
  ```

- page指令

  常用属性：

  language（指定脚本语言，目前只能是java）

  import（引入类，多个用逗号分隔）

  contentType（指定字符编码和MIME类型:text/html;charset=UTF-8)

  session（当前页面是否参与session会话，默认true)

  errorPage（当前页面异常时跳转页面）

  isErrorPage（当前页面是否为异常处理页面)

  pageEncoding（指定页面字符编码，没指定则以contentType属性为准，都没指定则以默认为准）

- include指令

  作用：

  用于将一个文件内容静态地包含到当前JSP文件的指定位置，文件可以是JSP、HTML、文本文件或一段Java代码，该动作发生在JSP文件被转换阶段。

  语法格式：

  ```java
  <%@ include file="文件path" %>
  ```

- taglib指令

  作用：

  用于在JSP中引入自定义标签库，uri指定网络上的标签库，可以是相对地址或绝对地址，tagdir指定/WEB-INF/tags目录或子目录下的标签库，prefix指定JSP页面中使用标签库的标签前缀。

  语法格式：

  ```java
  <%@ taglib ( uri = "URI" | tagdir = "tagDir" ) prefix="tagPrefix" %>
  ```

#### 3、动作元素（共20个标准动作）

- param

  为其他动作（include、forward）提供参数

  ```java
  <jsp:param   name="属性名", value="属性值"/>
  ```

- include

  在当前JSP中包含一个JSP或者HTML文件,flush设置包含页面之前是否刷新缓存区，默认false。

  ```java
  <jsp:include  page="path"   flush="true|false"/>//或者<jsp:include  page="path"   flush="true|false">        <jsp:param   name="..." value="..."  /></jsp:include>
  ```

  **include指令和include动作的区别**：

  ① 指令发生在JSP页面转换期，动作发生在JSP请求处理期

  ② 动作可以向被包含文件传递参数，而指令不能

- forward

  请求转发（将浏览器的请求转发到另一个JSP或HTML资源），从而改变客户端页面内容

  ```java
  <jsp:forward  page="xxx.jsp"/>//或者<jsp:forward  page="xxx.jsp">       <jsp:param  name="..."  value="..."/></jsp:forward>
  ```

- useBean

  在JSP页面中访问JavaBean，通过useBean动作实例化一个JavaBean  或者定位一个已经存在的JavaBean实例，并将JavaBean实例的引用赋值给一个变量。

  ```java
  <jsp:useBean id="name" [scope="page|request|session|application"]   class="className" [beanName="beanName"  type="typeName"] /> 
  ```

  id（标识JavaBean实例）、scope（JavaBean应用范围，默认为page）、class（指定JavaBean完整限定类名）、  
  beanName（指定Bean的名字，提供给java.beans.Beans类的instantiate()方法，来实例化JavaBean）、  
  type（定义对象的类型，类本身、父类或类实现的接口的类型。默认值为class属性的值）

- setProperty

  为指定JavaBean的属性赋值（底层是通过调用JavaBean的setXXX方法实现）

  ```java
  <jsp:setProperty   name="beanID"    propertyExp />
  ```

  name：bean的实例名（必须在useBean中引入，为useBean的id属性值）
  propertyExp:属性表达式，property="*"（在请求对象中查找所有请求参数，
  看是否有参数名与Bean的属性名相同且参数值不为空，则按照正确类型赋值给Bean的属性）
  或property="属性名"（在请求对象的参数中查找参数名为属性名的参数赋值给Bean）
  或property="属性名" value="属性值"（使用指定的属性值给Bean的指定属性赋值）

- getProperty

  访问Bean的属性并输出到JSP页面（相当于调用getXXX方法）

  ```java
  <jsp:getProperty  name="beanID"  property=""/>
  ```

### 7.3 注释

- JSP

  JSP中使用：<%-- 注释内容 --%>

- 模板数据

  模板数据中使用html注释（注释内容中可以使用JSP表达式来生成动态内容）：<!-- 注释内容 -->

- 脚本段

  脚本段中使用所用脚本语言（Java）注释：//注释内容 或 /* 注释内容  */



## 8、JSP 内置对象

### 8.1 JSP内置对象（共9个，不用声明便可直接使用）

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



### 8.2 作用域

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



## 9、EL

### 9.1 概述

- EL（Expression Language），表达式语言。是JSP2.0规范的一部分，在JSP页面中使用EL表达式可以简化对变量和对象的访问。

- 基本语法

  ${ EL 表达式 }

### 9.2 功能

- 获取域对象中的数据

  使用**域范围.属性名**的方式来获取域对象中的数据，不存在相应的数据则返回""。

  ```java
  <%
      pageContext.setAttribute("name","张三");
      request.setAttribute("name","李四");
      session.setAttribute("name","王五");
      application.setAttribute("name","孙六");
  %>
  
  ${pageScope.name}<br/>
  ${requestScope.name}<br/>
  ${sessionScope.name}<br/>
  ${applicationScope.name}<br/>
  ```

  也可以省略域范围，直接使用属性名。则会调用pageContext.findAttribute( )方法，按顺序从page、request、session、application范围查找相应的属性。

  ```java
  ${name}
  ```

  获取数组、List和Map类型的数据

  ```java
  //数组
  <%
      String[] arr = {"aaa","bbb","ccc"};
      pageContext.setAttribute("arr",arr);
  %>
  ${arr[0]}
  //List
  <%
      List<String> list = new ArrayList<>();
      list.add("11");
      list.add("22");
      list.add("33");
      pageContext.setAttribute("list",list);
  %>
  ${list[1]}
  //Map
  <%
      Map<String, Integer> map = new HashMap<>();
      map.put("a",1);
      map.put("b",2);
      map.put("c.d",3);
      pageContext.setAttribute("map",map);
  %>
  ${map.a}<br/>
   //如果map的key中包含了特殊的字符，则不能使用.而必须使用[]。 
  ${map["c.d"]}
  ```

- 执行运算

  算术运算

  关系运算：< ( lt )、> (gt ) 、== ( eq ) 、>= ( ge ) 、<=  ( le ) 、!= ( ne )

  逻辑运算: && ( and ) 、|| ( or ) 、! ( not )

  三元运算: ? : 

- 获取Web开发常用对象

  EL表达式定义了11个web开发常用对象。使用这些对象可以很方便获取web开发中的一些常见对象，并读取对象中的数据。

  pageContext：相当于JSP内置对象中的pageContext

  pageScope、requestScope、sessionScope、applicationScope：获取指定域下的名称的数据

  param：在页面中接收请求参数（单值参数）

  paramValues：在页面中接收请求参数（多值参数）

  header：在页面中获取请求头参数（单值参数）

  headerValues：在页面中获取请求头参数（多值参数）

  cookie：访问cookie的名称和值（${ cookie.key.name }）

  initParam：获得全局初始化参数的值



## 10、JSTL

### 10.1 概述

JSTL（JavaServer Pages Standard Tag Library） 



### 10.2 使用

- 引入JSTL的Jar包
- 在JSP中引入标签库



































