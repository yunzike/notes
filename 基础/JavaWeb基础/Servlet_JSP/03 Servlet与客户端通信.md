#### 1、request对象



#### 2、response对象



#### 3、ServletContext(上下文)

- 概述
  
  每一个运行在Java虚拟机中的Web应用都有一个与之对应的上下文，通过上下文Servlet可以和容器进行通信并获得运行的环境参数。Servelet中提供ServletContext接口来表示Servlet上下文。上下文路径即访问对应的Web应用的起点（应用的根）。

- 获取方式
  
  ```java
  可以通过ServletConfig对象的getServletConfig( )方法获取，
  或者GenericServlet的getServletConfig( )方法获取
  ```

- 定义的方法
  
  ```java
  String getInitParameter(String name);//返回名字为name的初始化参数
  Enumerartion getInitParameterNames( );//返回所有初始化参数的名字枚举集合
  String getRealPath(String path);//返回真实路径    
  ```
  
  

#### 4、RequestDispatcher(请求转发)

- 概述
  
  

- 获取方式
  
  ```java
  //三种方式获取
  ServletRequest.getRequestDispatcher(String path);
  ServletContext.getRequestDispatcher(String path);
  ServeltContext.getNamedDispather(String path);
  ```

- 使用
  
  ```java
  void forward(ServletRequest req,ServletResponse res);
  void include(SevletRequest req,ServletResponse res);
  ```

#### 5、Cookie对象

- 概述
  
  

- 基本使用
  
  ```java
  Cookie varName = new Cookie(key,value); //创建Cookie
  response.addCookie(varName); //插入响应
  Cookie[] cks = request.getCookies( ); //读取
  ```

- 生存周期
  
  创建Cookie对象后应当使用Cookie对象的setMaxAge( )方法为此Cookie对象指定一个有效时间，即Cookie的生命周期，若不指定，则当浏览器关闭后Cookie就失效了
