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
[root@heibaise src]# tar zxvf pcre-8.35.tar.gz
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
[root@heibaise src]# tar zxvf nginx-1.12.2.tar.gz
```

③编译安装

```bash
[root@heibaise src]# cd nginx-1.12.2	
[root@heibaise nginx-1.6.2]# ./configure
[root@heibaise nginx-1.6.2]# make && make install
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









