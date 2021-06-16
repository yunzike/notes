## 1、POI

### 1.1 介绍



- 官放文档：

- github：

- Meven 依赖

  ```xml
  
  ```

### 1.2 导出 Excel

- 直接导出

  

- 根据入参导出

  ```java
  ```

  

- 下载

  

### 1.3 基于模板导出 Excel



### 1.4 Excel 导入





## 2、EasyExcel

### 2.1 介绍

阿里基于 POI 封装优化的 Excel 处理工具

- 官放文档：https://www.yuque.com/easyexcel/doc/easyexcel

- github：https://github.com/alibaba/easyexcel

- Meven 依赖

  ```xml
  <dependency>
      <groupId>com.alibaba</groupId>
      <artifactId>easyexcel</artifactId>
      <version>2.2.10</version>
  </dependency>
  ```

### 2.2 导出 Excel

- 直接导出

  实体类

  ```java
  package com.yunzike.sprintbootstudy.dto;
  
  import com.alibaba.excel.annotation.ExcelIgnore;
  import com.alibaba.excel.annotation.ExcelProperty;
  import com.alibaba.excel.annotation.format.DateTimeFormat;
  import lombok.Data;
  
  import java.util.Date;
  
  @Data
  public class UserResponseDTO {
  
      /**
       * 忽略该字段
       */
      @ExcelIgnore
      private Integer id;
  
      /**
       * 设置列名
       */
      @ExcelProperty("姓名")
      private String name;
  
      @ExcelProperty("年龄")
      private Integer age;
  
      @ExcelProperty("生日")
      /**
       * 格式化 Date
       */
      @DateTimeFormat("yyyy-MM-dd HH:mm:ss")
      private Date birthday;
  
  }
  ```

  控制层

  ```java
  @RestController
  @RequestMapping("/user")
  public class TestController {
  
      @GetMapping("/download")
      public void download(HttpServletResponse response) throws IOException {
  
        	//获取数据源
          List<UserResponseDTO> data = new ArrayList<>();
          UserResponseDTO user = new UserResponseDTO();
          user.setName("张三");
          user.setId(0001);
          user.setAge(18);
          user.setBirthday(new Date());
          data.add(user);
  
          // 这里注意 有同学反应使用swagger 会导致各种问题，请直接用浏览器或者用postman
          response.setContentType("application/vnd.ms-excel");
          response.setCharacterEncoding("utf-8");
          // 这里URLEncoder.encode可以防止中文乱码 当然和easyexcel没有关系
          String fileName = URLEncoder.encode("测试Excel文件", "UTF-8").replaceAll("\\+", "%20");
          response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
          EasyExcel.write(response.getOutputStream(), UserResponseDTO.class)
            .sheet("表格1").doWrite(data);
      }
  
  }
  ```

- 根据入参导出

  ```java
  @PostMapping("/test1")
  public void test(@RequestBody UserRequestDTO requestDTO, 
                   HttpServletResponse response) throws IOException {
      System.out.println(requestDTO);
      PrintWriter writer = response.getWriter();
      writer.print("bbbb");
  }
  ```

  

- 下载





### 2.3 基于模板导出 Excel



### 2.3 Excel 导入







### 2.4 Docker 部署导出报错

```bash
java.lang.NullPointerException: null
        at sun.awt.FontConfiguration.getVersion(FontConfiguration.java:1264) ~[na:1.8.0_212]
        at sun.awt.FontConfiguration.readFontConfigFile(FontConfiguration.java:219) ~[na:1.8.0_212]
        at sun.awt.FontConfiguration.init(FontConfiguration.java:107) ~[na:1.8.0_212]
        at sun.awt.X11FontManager.createFontConfiguration(X11FontManager.java:774) ~[na:1.8.0_212]
        at sun.font.SunFontManager$2.run(SunFontManager.java:431) ~[na:1.8.0_212]
        at java.security.AccessController.doPrivileged(Native Method) ~[na:1.8.0_212]
        at sun.font.SunFontManager.<init>(SunFontManager.java:376) ~[na:1.8.0_212]
        at sun.awt.FcFontManager.<init>(FcFontManager.java:35) ~[na:1.8.0_212]
        at sun.awt.X11FontManager.<init>(X11FontManager.java:57) ~[na:1.8.0_212]
        at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method) ~[na:1.8.0_212]
        at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62) ~[na:1.8.0_212]
        at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45) ~[na:1.8.0_212]
        at java.lang.reflect.Constructor.newInstance(Constructor.java:423) ~[na:1.8.0_212]
        at java.lang.Class.newInstance(Class.java:442) ~[na:1.8.0_212]
        at sun.font.FontManagerFactory$1.run(FontManagerFactory.java:83) ~[na:1.8.0_212]
        at java.security.AccessController.doPrivileged(Native Method) ~[na:1.8.0_212]
        at sun.font.FontManagerFactory.getInstance(FontManagerFactory.java:74) ~[na:1.8.0_212]
        at java.awt.Font.getFont2D(Font.java:491) ~[na:1.8.0_212]
        at java.awt.Font.canDisplayUpTo(Font.java:2060) ~[na:1.8.0_212]
        at java.awt.font.TextLayout.singleFont(TextLayout.java:470) ~[na:1.8.0_212]
        at java.awt.font.TextLayout.<init>(TextLayout.java:531) ~[na:1.8.0_212]
        at org.apache.poi.ss.util.SheetUtil.getDefaultCharWidth(SheetUtil.java:275) ~[poi-3.17.jar!/:3.17]
        at org.apache.poi.xssf.streaming.AutoSizeColumnTracker.<init>(AutoSizeColumnTracker.java:117) ~[poi-ooxml-3.17.jar!/:3.17]
        at org.apache.poi.xssf.streaming.SXSSFSheet.<init>(SXSSFSheet.java:82) ~[poi-ooxml-3.17.jar!/:3.17]
        at org.apache.poi.xssf.streaming.SXSSFWorkbook.createAndRegisterSXSSFSheet(SXSSFWorkbook.java:658) ~[poi-ooxml-3.17.jar!/:3.17]
        at org.apache.poi.xssf.streaming.SXSSFWorkbook.createSheet(SXSSFWorkbook.java:679) ~[poi-ooxml-3.17.jar!/:3.17]
        at org.apache.poi.xssf.streaming.SXSSFWorkbook.createSheet(SXSSFWorkbook.java:90) ~[poi-ooxml-3.17.jar!/:3.17]
        at com.alibaba.excel.util.WorkBookUtil.createSheet(WorkBookUtil.java:66) ~[easyexcel-2.2.10.jar!/:na]
        at com.alibaba.excel.context.WriteContextImpl.createSheet(WriteContextImpl.java:205) ~[easyexcel-2.2.10.jar!/:na]
        at com.alibaba.excel.context.WriteContextImpl.initSheet(WriteContextImpl.java:185) ~[easyexcel-2.2.10.jar!/:na]
        at com.alibaba.excel.context.WriteContextImpl.currentSheet(WriteContextImpl.java:122) ~[easyexcel-2.2.10.jar!/:na]
        at com.alibaba.excel.write.ExcelBuilderImpl.addContent(ExcelBuilderImpl.java:53) ~[easyexcel-2.2.10.jar!/:na]
        at com.alibaba.excel.ExcelWriter.write(ExcelWriter.java:161) ~[easyexcel-2.2.10.jar!/:na]
        at com.alibaba.excel.ExcelWriter.write(ExcelWriter.java:146) ~[easyexcel-2.2.10.jar!/:na]
        at com.alibaba.excel.write.builder.ExcelWriterSheetBuilder.doWrite(ExcelWriterSheetBuilder.java:61) ~[easyexcel-2.2.10.jar!/:na]
        at com.jusekj.merchant.web.util.ExcelUtils.exportExcel(ExcelUtils.java:43) ~[classes!/:0.0.1-SNAPSHOT]
        at com.jusekj.merchant.web.service.management.impl.DrugCenterServiceImpl.export(DrugCenterServiceImpl.java:167) ~[classes!/:0.0.1-SNAPSHOT]
        at com.jusekj.merchant.web.controller.management.DrugCenterController.exportByPost(DrugCenterController.java:50) ~[classes!/:0.0.1-SNAPSHOT]
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:1.8.0_212]
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[na:1.8.0_212]
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:1.8.0_212]
        at java.lang.reflect.Method.invoke(Method.java:498) ~[na:1.8.0_212]
        at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190) ~[spring-web-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138) ~[spring-web-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105) ~[spring-webmvc-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:878) ~[spring-webmvc-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:792) ~[spring-webmvc-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87) ~[spring-webmvc-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040) [spring-webmvc-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943) [spring-webmvc-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006) [spring-webmvc-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:909) [spring-webmvc-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:652) [tomcat-embed-core-9.0.38.jar!/:4.0.FR]
        at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883) [spring-webmvc-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:733) [tomcat-embed-core-9.0.38.jar!/:4.0.FR]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53) [tomcat-embed-websocket-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100) [spring-web-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119) [spring-web-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93) [spring-web-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119) [spring-web-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201) [spring-web-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119) [spring-web-5.2.9.RELEASE.jar!/:5.2.9.RELEASE]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:97) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:143) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:78) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:374) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149) [na:1.8.0_212]
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624) [na:1.8.0_212]
        at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61) [tomcat-embed-core-9.0.38.jar!/:9.0.38]
        at java.lang.Thread.run(Thread.java:748) [na:1.8.0_212]
```

因为alpine中缺少FontConfiguration，https://www.jianshu.com/p/c05b5fc71bd0

https://blog.csdn.net/lin521lh/article/details/78498733

```bash
FROM openjdk:8-jdk-alpine
RUN echo -e "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main\n\
https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/community" > /etc/apk/repositories
RUN apk --update add curl bash ttf-dejavu && rm -rf /var/cache/apk/*
```



在服务器适当位置位置创建一个Dockerfile，内容为：

```bash
FROM java:8-jre-alpine
# Install cURL
RUN echo -e "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main\n\
https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/community" > /etc/apk/repositories

RUN apk --update add curl bash ttf-dejavu && \
      rm -rf /var/cache/apk/*
```

在同一位置执行：

```bash
docker build -t docker.io/java-font:8-jre-alpine .
```

执行完毕后会有一个新的java的镜像：

```bash
REPOSITORY   IMAGE ID            CREATED             SIZE
java-font    8-jre-alpine        dc7703ec6f07        31 hours ago        131.5 MB
```

然后修改项目的 Docerfile，从 `java-font:8-jre-alpine` 构建镜像

```bash
FROM java-font:8-jre-alpine
VOLUME /tmp
ARG JAR_FILE
ADD ${JAR_FILE} app.jar
EXPOSE 8090
ENTRYPOINT ["java","-jar","/app.jar"]
```

