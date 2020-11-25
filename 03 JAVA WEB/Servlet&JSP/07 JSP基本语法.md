## 一、基本格式

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

## 二、JSP元素

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
  <jsp:include  page="path"   flush="true|false"/>
  //或者
  <jsp:include  page="path"   flush="true|false">
          <jsp:param   name="..." value="..."  />
  </jsp:include>
  ```
  
  **include指令和include动作的区别**：
  
  ① 指令发生在JSP页面转换期，动作发生在JSP请求处理期
  
  ② 动作可以向被包含文件传递参数，而指令不能

- forward
  
  请求转发（将浏览器的请求转发到另一个JSP或HTML资源），从而改变客户端页面内容
  
  ```java
  <jsp:forward  page="xxx.jsp"/>
  //或者
  <jsp:forward  page="xxx.jsp">
         <jsp:param  name="..."  value="..."/>
  </jsp:forward>
  ```

- useBean
  
  在JSP页面中访问JavaBean，通过useBean动作实例化一个JavaBean  或者定位一个已经存在的JavaBean实例，并将JavaBean实例的引用赋值给一个变量。
  
  ```java
  <jsp:useBean id="name" [scope="page|request|session|application"]
     class="className" [beanName="beanName"  type="typeName"] /> 
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

## 三、注释

- JSP
  
  JSP中使用：<%-- 注释内容 --%>

- 模板数据
  
  模板数据中使用html注释（注释内容中可以使用JSP表达式来生成动态内容）：<!-- 注释内容 -->

- 脚本段
  
  脚本段中使用所用脚本语言（Java）注释：//注释内容 或 /* 注释内容  */














