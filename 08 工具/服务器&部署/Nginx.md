## 一、概述

#### 1、什么是Nginx

Nginx是高性能的HTTP和反向代理的服务器，占用内存少，处理高并发能力是十分强大的，能经受高负载的考验，有报告表明能支持高达50000个并发来连接数。支持热部署。

#### 2、正向代理与反向代理

- 正向代理

  在客户端（浏览器 ）配置代理服务器，通过代理服务器进行互联网的访问。如通过VPN访问google。

- 反向代理

  客户端直接访问某个域名，域名被解析成对应的IP地址，从而访问特定互联网资源。如果资源的提供者使用了反向代理，则客户端的请求其实是发送到了反向代理服务器，由反向代理服务器去选择目标服务器获取数据，再返回给客户端。
  此时反向代理服务器和目标资源服务器对外就是一个服务器，暴露的也是代理服务器的地址，隐藏了真实服务器的IP地址，客户端对于反向代理是无感知的。

#### 3、负载均衡

增加服务器的数量，然后将请求分发到各个服务器上，将原先的请求集中到单个服务器上的情况改为将请求分发到多个服务器上，将负载分发到不同服务器，即负载均衡。

#### 4、动静分离

为了加快网站的解析速度，可以把动态页面（JSP、Servlet）和静态页面（HTML、CSS、JS）由不同的服务器来解析，从而加快解析的速度，降低原来单个服务器的压力。

## 二、Nginx 的安装

### 普通方式：

#### 1、安装编译工具及库文件

```bash
[root@heibaise src]# yum -y install make zlib zlib-devel gcc-c++ libtool  openssl openssl-devel
```

#### 2、安装pcre依赖

①下载pcre安装包

```bash
[root@heibaise src]# cd /usr/local/src/
[root@heibaise src]# wget http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz
```

②解压安装包

```bash
[root@heibaise src]# tar -zxvf pcre-8.35.tar.gz
```

③编译安装

```bash
[root@heibaise src]# cd pcre-8.35
[root@heibaise pcre-8.35]# ./configure
[root@heibaise pcre-8.35]# make && make install

# 安装完成之后查看版本
[root@heibaise pcre-8.35]# pcre-config --version
```

#### 3、安装nginx

①下载nginx安装包

```bash
[root@heibaise src]# cd /usr/local/src/
[root@heibaise src]# wget http://nginx.org/download/nginx-1.12.2.tar.gz
```

②解压安装包

```bash
[root@heibaise src]# tar -zxvf nginx-1.12.2.tar.gz
```

③编译安装

```bash
[root@heibaise src]# cd nginx-1.12.2	
[root@heibaise nginx-1.6.2]# ./configure
[root@heibaise nginx-1.6.2]# make && make install
```

### 使用Docker 安装

#### 1、下载镜像

```bash
$ docker pull nginx
```

#### 2、配置

##### 建目录用于存放nginx配置文件、证书文件

```bash
mkdir /nginx/conf.d -p
touch /nginx/conf.d/nginx.conf
mkdir /nginx/cert -p
```

##### 编辑 nginx.conf

```bash
vim /opt/docker/nginx/conf.d/nginx.conf
```

- 不需要 SSL 的情况

  将访问`example.com`、`www.example.com` 的请求会被转发到服务器的`8090`端口

  ```yml
  server {
    listen 80;  # 监听80端口
    listen [::]:80;
    server_name yunzike.com; # 自己的域名
    client_max_body_size 1024m;  # 上传文件限制
    location / {
      proxy_set_header HOST $host;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  
      proxy_pass http://172.17.0.9:8090;  # 需要代理的地址:端口
    }
  }
  ```

- 需要 SSL 的情况

  ```yml
  # 非强制重定向https
  server {
      listen 80; #侦听80端口，如果强制所有的访问都必须是HTTPs的，这行需要注销掉
      listen 443 ssl; #侦听443端口，用于SSL
      server_name example.cn;  # 自己的域名
      # 注意文件位置，是从/etc/nginx/下开始算起的
      ssl_certificate 1_example_bundle.crt;
      ssl_certificate_key 2_example.key;
      ssl_session_timeout 5m;
      ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
      ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
      ssl_prefer_server_ciphers on;
  
      client_max_body_size 1024m;
  
      location / {
          proxy_set_header HOST $host;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  	    # 这里写的是我的腾讯云内网地址,不知道为啥,不能用127.0.0.1...
          proxy_pass http://xxx.xx.xx.xx:8090;
      }
  }
  ```

  ```yml
  # 强制重定向
  server {
      listen 443 ssl;
      server_name yunzike.com;  # 自己的域名
      # 注意文件位置，是从/etc/nginx/下开始算起的
      ssl_certificate /nginx/cert/1_yunzike.com_bundle.crt; #.crt 文件路径
      ssl_certificate_key /nginx/cert/2_yunzike.com.key;	#.key 文件路径
      ssl_session_timeout 5m;
      ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
      ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
      ssl_prefer_server_ciphers on;
  
      client_max_body_size 1024m; # 设置上传文件大小限制
  
      location / {
          proxy_set_header HOST $host;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          # 这里写的是我的腾讯云内网地址,不知道为啥,不能用127.0.0.1...
          proxy_pass http://127.0.0.1:8090;
      }
  }
  server {
       listen 80; # 监听80端口
       server_name yunzike.com;  # 绑定证书的域名
       #把http的域名请求转成https
       return 301 https://$host$request_uri; 
  }
  ```

#### 3、启动 Nginx

```bash
docker run -itd --name nginx -p 80:80 -p 443:443 -v /nginx/conf.d/nginx.conf:/etc/nginx/conf.d/nginx.conf -v /nginx/cert:/etc/nginx -m 100m nginx

```

**注：参数说明**

```
-itd    后台运行
-p      指定端口80和443
-v      将本地的文件映射到docker中
        配置文件 /nginx/conf.d/nginx.conf -> /etc/nginx/conf.d/nginx.conf
        证书文件 /nginx/cert -> /etc/nginx
-m      限制使用内存大小
--name  指定名字为nginx
```

























## 三、常用命令

使用命令的前提条件：必须进入/usr/local/nginx/sbin目录下。

#### 查看nginx版本号

```bash
[root@heibaise sbin]# ./nginx -v
```

#### 启动nginx

```bash
[root@heibaise sbin]# ./nginx
```

#### 停止nginx

```bash
[root@heibaise sbin]# ./nginx -s stop
```

#### 重启nginx

```bash
[root@heibaise sbin]# ./nginx -s reopen
```

#### 重新加载nginx配置文件（修改配置文件之后不需要重启nginx）

```bash
[root@heibaise sbin]# ./nginx -s reload
```

## 四、配置文件

nginx的配置文件为nginx.conf，位于/usr/local/nginx/conf/nginx.conf，由三部分组成：全局块、events块、http块

- 全局块

  配置服务器整体运行的配置指令

  比如：worker_process 1;	处理分发数的配置

- events块

  影响Nginxfu服务器与用户的网络连接

  比如：worker_connections 1024;	支持的最大连接数为1024

- http块：包含http全局块和server块两部分

  

## 五、反向代理

#### 1、使用IP地址转发实现反向代理

```bash
## nginx配置反向代理
## 使用192.168.17.129:80的ip转发到127.0.0.1：8080
server {
	listen       80;
	server_name  192.168.17.129;

	location / {
		root   html;
		proxy_pass http://127.0.0.1:8080;
		index  index.html index.htm;
	}
}
```

#### 2、不同路径转发实现反向代理



## 五、负载均衡

多服务器使用nginx来分发



## 六、动静分离



## 七、高可用集群

#### 1、主从模式



#### 2、双主模式



## 八、Nginx原理

#### 1、master和worker



#### 2、连接数和并发数









