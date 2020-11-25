## 一、概述

Ajax：一种不用刷新整个页面便可与服务器通讯的技术。数据在客户端和服务器之间独立传输，服务器不再返回整个页面。

Web的传统方式是：客户端向服务器发送一个请求，服务器返回整个页面。



## 二、实现

#### 1、XMLHttpRequest

- 概述
  
  该对象是JavaScript的一个扩展，可以使网页与服务器通信。是创建Ajax应用的最佳选择，实际上通常把Ajax当成XMLHttpRequest对象的代名词。

- 方法
  
  ```javascript
  open(method,url);           //创建请求调用
  send(content);              //发送请求
  abort();                    //停止当前请求
  
  setRequestHeader(key,value);//设置请求头
  getAllResponseHeaders();    //获取所有响应内容
  getResponseHeader(String headerName);//获取指定响应内容
  ```

- 属性
  
  ```javascript
  onreadystatechange //每个状态改变都会触发这个事件处理器，通常调用一个JavaScript函数
  readyState        //请求的状态，五种：0未初始化、1正在加载、2已经加载、3交互中、4完成
  responseText      //服务器的响应，表示为字符串
  responseXML       //服务器的响应，表示为XML，可以解析为DOM
  status            //服务器HTTP状态码
  statusText        //HTTP状态码相应文本
  ```

#### 2、Ajax的简单使用

```html
<html>
<head>
    <title>首页</title>
    <script type="text/javascript">
        window.onload = function () {
            var aNode = document.getElementsByTagName("a")[0];
            aNode.onclick = function () {
                //1、创建XMLHttpRequest对象
                var request = new XMLHttpRequest();
                //2、调用open方法
                var method = "get";
                var url = this.href;
                request.open(method,url);
                //3、调用send方法
                request.send(null);

                //4、监听响应
                request.onreadystatechange = function () {
                    //判断响应是否完成
                    if(request.readyState == 4){
                        if(request.status == 200 || request.status == 304){
                            //得到响应
                            alert(request.responseText)
                        }
                    }
                }
                //在链接的onclick监听中返回false禁用默认请求
                return false;
            }
        }

    </script>
</head>
<body>
测试JavaEETest
<a href="test.txt">Ajax请求</a>
</body>
</html>
```

#### 2、传输的数据格式

- HTML
  
  请求的内容为HTML时，返回HTML在responseText中，可以直接写入DOM，但无法拆分操作。

- XML
  
  请求的内容为XML时，返回的内容在responseXML中，不能直接使用，必须先使用DOM方法来解析获取其中的内容，再操作。

- JSON
  
  请求的内容是JSON时，返回的JSON会转为字符串在responseText中，不能直接使用，必须先转为JSON对象
  
  ```javascript
  eval();                       //可以字符串转为JS执行
  eval("(" + jsonStr + ")");    //把JSON字符串转为JSON 
  ```
  
  
  
  
  
  


