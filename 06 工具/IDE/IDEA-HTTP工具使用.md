## 1、 简介

开发时，经常需要调试接口，可能会使用`Swagger`、`postman` 等工具，其实在 IDEA 中，也提供了一个类似 VS Code 的`Rest-client`的工具，通过这个工具我们可以完成绝大部分http请求，是一个不错的`postman`替代工具。

## 2、使用方式

- 方式一：Controller 请求中打开，会直接生成 http 请求文件

  ![image-20210616145916896](../../images/image-20210616145916896.png)

- 方式二：手动新建 .http 文件

  ![image-20210616152738890](../../images/image-20210616152738890.png)

## 3、 请求命令编写

### 3.1 基本格式

```bash
请求方式 地址
header部分，key=value格式，每个一行

参数部分(注意这个上面要有个空行)
```

- 参考案例

  ![image-20210616151133570](../../images/image-20210616151133570.png)

- 自动生成

  ![image-20210616151210719](../../images/image-20210616151210719.png)

### 3.2 Get 请求

``` bash
### GET 请求（设置了一个Header）
GET https://httpbin.org/ip
Accept: application/json

### 带参数 GET 请求
GET https://httpbin.org/get?show_env=1
Accept: application/json
```

### 3.3 Post 请求

```bash
### body 参数的 POST 请求
POST http://localhost:8090/post
Content-Type: application/json

{
  "id": 999,
  "value": "content"
}

### Send POST request with body as parameters
POST http://localhost:8090/post
Content-Type: application/x-www-form-urlencoded

id=999&value=content
```

### 3.4 文件上传

- 上传接口

  ```java
  //模拟多文件上传，顺便带上表单数据
  @PostMapping("/upload")
  public Map upload(@RequestParam("file1") MultipartFile file1,
                                    @RequestParam("file2") MultipartFile file2,
                                    User user,
                                    HttpServletRequest request) {
      // 业务代码
  }
  ```

- 对应 http 请求 

  ```java
  ### 多文件上传文件接口测试
  POST http://localhost:8090/upload
  Content-Type: multipart/form-data; boundary=WebAppBoundary
  
  --WebAppBoundary
  Content-Disposition: form-data; name="file1"; filename="pic_1.jpeg"
  
  < C:\Users\Mr.X\Desktop\1.jpg
  --WebAppBoundary--
  
  --WebAppBoundary
  Content-Disposition: form-data; name="file2"; filename="pic_2.jpeg"
  
  < C:\Users\Mr.X\Desktop\2.jpg
  --WebAppBoundary--
  
  --WebAppBoundary
  Content-Disposition: form-data; name=accountName
  
  1001007
  --WebAppBoundary--
  
  --WebAppBoundary
  Content-Disposition: form-data; name=password
  
  123456
  --WebAppBoundary--
  ```

  这个请求可以想像成页面中的一个表单，表单有 4 个元素：2 个 File 元素，用来选择需要上传的 2 个文件，2 个输入框，分别用来输入 userName 和 age。请求中需要用--WebAppBoundary 来隔离每个元素，如果有多个元素，都需要用--WebAppBoundary 隔离开来。

### 3.5  文件下载

​	可以请求成功，看到响应信息，但是没法下载文件（Swagger、postman 也不行，貌似只能从浏览器中前端页面中操作 ）。

## 4、自定义环境变量和参数

- 添加配置文件

  ![image-20210616151826266](../../images/image-20210616151826266.png)

  ![image-20210616152427414](../../images/image-20210616152427414.png)

- 配置文件格式

  ```json
  {
    "dev": {
      "url": "http://localhost:8090",
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJBUFAiLCJpc3MiOiJTZXJ2aWNlIiwiaWQiOiIxMzk4MTA5OTI5MjY4NTgwMzUzIiwiZXhwIjoxNjIzODI3NzAxLCJpYXQiOjE2MjM4MjY1MDF9.uldjwsrIZbEsuSJ05e7SPlMAnzv_pa3VT0maNwz2Dv4"
    },
    "test": {
      "url": "xxx.xxx.xxx.xx:8090",
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJBUFAiLCJpc3MiOiJTZXJ2aWNlIiwiaWQiOiIxMzk4MTA5OTI5MjY4NTgwMzUzIiwiZXhwIjoxNjIzODI3NzAxLCJpYXQiOjE2MjM4MjY1MDF9.uldjwsrIZbEsuSJ05e7SPlMAnzv_pa3VT0maNwz2Dv4"
    }
  }
  ```

- 使用

  ![image-20210616152208952](../../images/image-20210616152208952.png)