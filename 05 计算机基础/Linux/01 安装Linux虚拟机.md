### 一、使用VirtualBox安装虚拟机

#### 1、下载安装Virtual Box

官网下载VirtualBox https://www.virtualbox.org/
安装前要开启CPU虚拟化，即在BIOS的设置里要把Intel Virtualization Technolgy设置为Enabled

#### 2、使用Vagrant在Virtual Box中安装CenterOS

①下载&安装Vagrant

https://www.vagrantup.com/downloads.html Vagrant 下载
https://app.vagrantup.com/boxes/search Vagrant 官方镜像仓库

②安装centos
打开window cmd窗口，运行 Vagrant init centos/7，即可初始化一个centos7系统，运行vagrant up即可启动虚拟机。
系统root用户的密码是vagrant

③vagrant其他常用命令

vagrant ssh：自动使用vagrant用户连接虚拟机。
vagrant reload：重启虚拟机
vagrant upload source[destination][namelid]：上传文件
https://www.vagrantup.com/docs/cli/init.html Vagrant 命令行文档

#### 3、修改虚拟机的IP地址

默认虚拟机的ip地址不是固定ip，访问虚拟机的MySQL等软件需要在Virtual Box中设置端口转发，开发不方便。
可以通过修改Vagrantfile文件来修改虚拟机的IP地址

```bash
# Vagrantfile 文件位于用户的根目录下
# 其中ip地址，必须和主机 VirtualBox Host-Only Network 的IP地址（如：192.168.56.1）的前三个部分保持相同
config.vm.network "private_network", ip: "192.168.56.10"
```

#### 4、使用Vagrant连接虚拟机

```bash
# cmd 窗口下,连接登陆的用户是vagrant,root用户的密码也是vagrant
vagrant ssh
```

## 二、使用VMWear







## 三、Linux虚拟机配置

#### 1、网络配置

- 桥接模式

Linux虚拟机桥接模式下无法上网

终端中ping域名 
ping www.baidu.com 
提示：ping: Unknown host www.baidu.com 
测试ping IP地址址 
ping 8.8.8.8 
如果能通，则是dns服务器没有配置好 
vim /etc/resolv.conf 
查看里面是否有nameserver xxx.xxx.xxx.xxx 
比如使用dns服务器 nameserver 8.8.8.8， 
如果有，修改一个可用的dns服务器，如8.8.8.8（Google提供的免费DNS服务器的IP地址，备8.8.4.4）或者4.4.4.4， 
如果没有，添加nameserver 8.8.8.8 
保存退出即可  

常用DNS地址 
114.114.114.114：国内移动、电信和联通通用的DNS，手机和电脑端都可以使用 
百度提供的180.76.76.76 
阿里提供的223.5.5.5和223.6.6.6  

如果连ip都ping 8.8.8.8都ping不通的话，那么就说明网络配置有问题：
可以这样解决：  

#### 2、文件传输

xshell连接虚拟机 
测试本机主机是否能ping通虚拟机 
虚拟机是否能ping通本地主机 
如果不能则可能是防火墙的设置问题  













