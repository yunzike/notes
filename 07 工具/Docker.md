## 一、Docker安装MySQL

Docker安装文档
https://docs.docker.com/engine/install/centos/

#### 1、卸载旧版本

```bash
$ sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
```

#### 2、安装docker依赖包和设置docker安装地址

```bash
$ sudo yum install -y yum-utils

$ sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```

#### 3、安装docker

```bash
$ sudo yum install docker-ce docker-ce-cli containerd.io
```

#### 4、启动docker

```bash
#启动docker
$ sudo systemctl start docker

#查看docker版本
$ docker -v

#查看当前docker中下载的镜像
$ sudo docker images
```

#### 5、设置docker开机自启

```bash
$ sudo systemctl enable docker
```

#### 6、配置docker阿里云镜像加速

登录阿里云官网打开控制台选择容器镜像服务，在镜像加速菜单中找到centos的操作命令并一一执行即可。

```bash
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://eww2r3jm.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```



## 二、使用Docker安装镜像

#### 1、下载镜像文件

访问docker hub官方镜像，并查找所需要安装的镜像，在镜像详情中选择tags可以查看镜像版本

```bash
# 从镜像仓库下载最新版本的mysql镜像
$ docker pull mysql

# 下载指定版本镜像
$ docker pull mysql:5.7
```

#### 2、创建实例并启动

```bash
# 启动一个mysql容器
# 同时进行文件夹挂载(挂载后在主机可以查看容器中的文件，且修改文件内容等同于在容器中修改)和mysql密码配置
$ docker run -p 3306:3306 --name mysql \
-v /mydata/mysql/log:/var/log/mysql \
-v /mydata/mysql/data:/var/lib/mysql \
-v /mydata/mysql/conf:/etc/mysql \
-e MYSQL_ROOT_PASSWORD=root \
-d mysql:5.7
```

![image-20200529182017203](../../images/image-20200529182017203.png)
参数说明：
	-p 3306:3306	：将容器的3306端口映射到主机的3306端口
	--name mysql	：为当前启动的容器起名为mysql
	-v /mydata/mysql/conf:/etc/mysql\	：将mysql容器的配置文件夹挂载到主机
	-v /mydata/mysql/log:/var/log/mysql\	：将日志文件夹挂载到主机
	-v /mydata/mysql/data:/var/lib/mysql\	：将
	-e MYSQL_ROOT_PASSWORD=root	：初始化mysql的root用户的密码为root
	-d mysql:5.7	：docker run 是启动一个容器，而 -d 是指定以后台方式运行，要运行的镜像是mysql:5.7

```bash
# 查看正在运行中的容器
$ docker ps

# 进入容器内部(每个容器是一个完整的运行环境---Linux环境，相当于一个小型Linux虚拟机)
# -it 以交互模式进入 
# /bin/bash 进入Linux的bash控制台
# 其中容器ID可以不写全，只要没有与之相同的即可，而容器名字需要写全
$ docker exec -it 容器id|容器名字 /bin/bash

# 退出容器
$ exit
```

- **MySQL配置**

  ```bash
  $ vi /mydata/mysql/conf/my.cnf
  ```

  **配置文件内容**

  ①默认字符编码为拉丁文需要改成utf8
  ②解决MySQL连接慢的问题

  ```bash
  [client]
  default-character-set=utf8
  
  [mysql]
  default-character-set=utf8
  
  [mysqld]
  init_connect='SET collation_connection=utf8_unicode_ci'
  init_connect='SET NAMES utf8'
  character-set-server=utf8
  collation-server=utf8_unicode_ci
  skip-character-set-client-handshake
  skip-name-resolve
  ```

  

#### 3、通过容器的mysql命令行工具连接mysql



#### 4、设置root远程访问



#### 5、进入容器文件系统





