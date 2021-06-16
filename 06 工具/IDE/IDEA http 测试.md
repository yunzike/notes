## 1、介绍



### 1.2 使用方式

- 方式一：Controller 请求中打开，会直接生成 http 请求文件

  ![image-20210616145916896](../../images/image-20210616145916896.png)

- 方式二：手动新建 .http 文件

  ![image-20210616152738890](../../images/image-20210616152738890.png)

## 2、 请求命令编写

### 2.1 基本格式

```bash
请求方式 地址
header部分，key=value格式，每个一行

参数部分(注意这个上面要有个空行)
```

- 参考案例

  ![image-20210616151133570](../../images/image-20210616151133570.png)

- 自动生成

  ![image-20210616151210719](../../images/image-20210616151210719.png)

### 2.2 Get 请求

``` bash
### GET 请求（设置了一个Header）
GET https://httpbin.org/ip
Accept: application/json

### 带参数 GET 请求
GET https://httpbin.org/get?show_env=1
Accept: application/json
```

### 2.3 Post 请求

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

### 2.4 文件上传

- 上传接口

  ```java
  //模拟多文件上传，顺便带上表单数据
  @PostMapping("/upload")
  public Map upload(@RequestParam("file1") MultipartFile file1,
                                    @RequestParam("file2") MultipartFile file2,
                                    User user,
                                    HttpServletRequest request) {
  }
  ```

- 对应 http 请求 

  ```java
  ### Send a form with the text and file fields
  POST https://httpbin.org/post
  Content-Type: multipart/form-data; boundary=WebAppBoundary
  
  --WebAppBoundary
  Content-Disposition: form-data; name="element-name"
  Content-Type: text/plain
  
  Name
  --WebAppBoundary
  Content-Disposition: form-data; name="data"; filename="data.json"
  Content-Type: application/json
  
  < ./request-form-data.json
  --WebAppBoundary--
  ```

### 2.5  文件下载



## 3、自定义环境变量和参数

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
      "url": "139.159.137.19:8090",
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJBUFAiLCJpc3MiOiJTZXJ2aWNlIiwiaWQiOiIxMzk4MTA5OTI5MjY4NTgwMzUzIiwiZXhwIjoxNjIzODI3NzAxLCJpYXQiOjE2MjM4MjY1MDF9.uldjwsrIZbEsuSJ05e7SPlMAnzv_pa3VT0maNwz2Dv4"
    }
  }
  ```

- 使用

  ![image-20210616152208952](../../images/image-20210616152208952.png)