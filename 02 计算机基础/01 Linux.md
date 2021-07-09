## 1、概述



### 1.1 常见发行版本 & 安装器

- 发行版本

| 发行版本     | 格式 | 包管理工具                 |
| ------------ | ---- | -------------------------- |
| Ubuntu       | .deb | apt,apt-cache,apt-get,dpkg |
| Debian       | .deb | apt,apt-cache,apt-get,dpkg |
| CentOS       | .rpm | yum                        |
| Redhat       | .rpm | yum                        |
| Fedora       | .rpm | dnf                        |
| Oracle Linux |      |                            |
| Mageia       |      |                            |
| ClearOS      |      |                            |

- 常见安装器

  rpm

  yum

  apt-get/dpkg

  weget

  ```bash
  wget https://dl.halo.run/release/halo-1.2.0.jar -O halo-latest.jar
  ```

  

  curl

### 1.2 Linux 虚拟机安装

#### 方式1：使用VirtualBox安装虚拟机

##### 1下载安装Virtual Box

官网下载VirtualBox https://www.virtualbox.org/
安装前要开启CPU虚拟化，即在BIOS的设置里要把Intel Virtualization Technolgy设置为Enabled

##### 2、使用Vagrant在Virtual Box中安装CenterOS

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

##### 3、修改虚拟机的IP地址

默认虚拟机的ip地址不是固定ip，访问虚拟机的MySQL等软件需要在Virtual Box中设置端口转发，开发不方便。
可以通过修改Vagrantfile文件来修改虚拟机的IP地址

```bash
# Vagrantfile 文件位于用户的根目录下
# 其中ip地址，必须和主机 VirtualBox Host-Only Network 的IP地址（如：192.168.56.1）的前三个部分保持相同
config.vm.network "private_network", ip: "192.168.56.10"
```

##### 4、使用Vagrant连接虚拟机

```bash
# cmd 窗口下,连接登陆的用户是vagrant,root用户的密码也是vagrant
vagrant ssh
```

#### 方式2：使用VMWear

### 1.3 Linux虚拟机配置

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



## 2、目录结构



## 3、常用命令

#### 1、关机&重启

- 基本语法

  ```bash
  shutdown [options] [times]
  ```

- 常用选项

  -h：	关机，后面接时间

  -r：	重启，后面接时间

- 应用

  ```bash
  # 立即关机，也可以直接使用 halt 命令
  shutdown -h now
  
  # 1分钟后关机
  shutdown -h 1
  
  # 立即重启,也可以直接使用 reboot 命令
  shutdown -r now
  
  # 注意：关机或重启时，应该先执行sync指令，把内存的数据写入磁盘
  sync
  ```

#### 2、帮助指令

- 基本语法

  ```bash
  man [options] [command]
  
  help [command]
  ```


## 一、用户管理

#### 1、添加用户

- 基本语法

  ```bash
  useradd [options] username
  ```

- 常用选项

  -d：	在创建用户时给该用户指定家目录，不指定则与用户名同名

  -g：	指定用户所在组

- 应用

  ```bash
  # 新增用户wang，并指定为teacher组
  useradd -g teacher wang
  ```

#### 2、给用户指定或修改密码

- 基本语法

  ```bash
  passwd username
  ```


#### 3、删除用户

- 基本语法

  ```bash
  userdel [options] username
  ```

- 常用选项

  -r：	删除用户的同时删除其家目录，一般不这么做


#### 4、查询用户信息

- 基本语法

  ```bash
  # 会依次显示用户id、所在组id、所在组名，不存在则返回无此用户
  id [options] username
  ```


#### 5、修改用户所在的组

- 基本语法

  ```bash
  usermod -g 用户组 username
  ```

#### 6、切换用户

- 基本语法

  ```bash
  su [options] [USER]
  ```

- 常用选项

  -c command：变更为帐号为 USER 的使用者并执行指令（command）后再变回原来使用者

- 应用

  ```bash
  # 查询当前用户
  whoami
  
  # 切换用户，如果不带用户名则默认root，不会改变环境变量和当前所在的目录，只是生成了新的对话进程，拥有该用户的权限
  su root
  
  # 当使用su命令切换了用户，可以不使用 su 命令，而使用exit退出新生成的对话进程回到原先的身份
  exit
  
  # 切换用户，如果不带用户名则默认root，并改变环境变量，相当于换用户登陆，也可以使用exit退回原用户
  su - root
  
  # 变更帐号为 root 并在执行 ls 指令后退出变回原使用者
  su -c ls root
  
  # 当使用su - 命令切换的用户时，可以使用logout注销用户
  logout
  ```

#### 7、用户组管理

- 基本语法

  ```bash
  # 增加组
  groupadd 组名
  
  # 删除组
  groupdel 组名
  ```

#### 8、用户相关的文件

- /etc/passwd文件

  用户的配置文件，记录着用户的各种信息

  每行的含义：用户名:口令:用户标识号:组标识号:注释性描述:主目录:登录shell

- /etc/shadow文件

  口令的配置文件

  每行的含义：登录名:加密口令:最后一次修改的时间:最小时间间隔:最大时间间隔:警告时间:不活动时间:失效时间:标志

- /etc/group文件

  组的配置文件

  每行含义：组名:口令:组标识号:组内用户列表

## 二、文件目录操作

#### 1、显示当前所在目录的绝对路径

- 基本语法

  ```bash
  pwd
  ```

#### 2、切换目录

- 基本语法

  ```bash
  cd [Directory]
  ```

- 应用

  ```bash
  # 切换到当前用户的家目录，也可以直接cd回车
  cd ~ 
  
  # 返回上级目录
  cd ..
  ```

#### 3、列出当前目录下的目录和文件

- 基本语法

  ```bash
  ls [options] [Directory or file]
  ```

- 常用选项

  -a：	显示当前目录所有的文件和目录，包括隐藏的

  -l：	以列表的方式显示当前目录下文件和目录的更多信息，包括文件所有者、权限、最后修改时间等

- 应用

  ```bash
  # 以列表方式显示文件和目录，ls -l的简写
  ll
  ```

#### 4、创建目录

- 基本语法

  ```bash
  mkdir [options] [Directory]
  ```

- 常用选项

  -p：	创建多级目录

#### 5、创建文件

- 基本语法

  ```bash
  # 创建空文件
  touch filename
  
  # 使用vim或vi创建文件，注意必须保存后才能创建成功
  vim filename
  ```

#### 6、删除文件或目录

- 基本语法

  ```bash
  rm [options] name
  ```

- 常用选项

  -i：	删除前逐一询问确认

  -f：	强制删除，无需逐一确认，即使原文件属性为只读，也直接删除

  -r：	递归删除整个文件夹

- 应用

  ```bash
  # 删除当前目录下的所有文件及目录
  rm -r *
  
  # 删除空目录，注意只能删除空目录
  rmdir 目录名
  
  # 删除非空目录且不逐一确认
  rm -rf 目录名
  ```

#### 7、文件拷贝

- 基本语法

  ```bash
  cp [options] source dest
  ```

- 常用选项

  -r：	递归复制整个文件夹，将目录及下级所有文件一并删除

- 应用

  ```bash
  # 将文件a.txt复制到/usr/local目录下
  cp a.txt /usr/local/
  
  # 将text整个目录复制到/usr/local目录下
  cp -r /usr/text/ /usr/local/
  
  # 使用以上命令，如果目标目录下有相同文件时，会询问是否覆盖，可以在cp命令前面加\强制覆盖不提示
  \cp -r /usr/text /usr/local/
  ```

#### 8、文件及目录的移动或重命名

- 基本语法

  ```bash
  mv oldNameFile newNameFile
  mv source dest
  ```

- 应用

  ```bash
  # 将a.txt重命名为b.txt
  mv a.txt b.txt
  
  # 将a.txt移动到/usr目录下
  mv /usr/local/a.txt /usr/
  
  # 将a.txt移动到/usr目录下并重命名为b.txt
  mv /usr/local/a.txt /usr/b.txt
  ```

#### 9、查看文件内容

##### 1、cat：只读查看

- 基本语法

  ```bash
  cat [options] filename
  ```

- 常用选项

  -n：	显示行号

- 应用

  ```bash
  # 使用管道命令分页浏览文件
  cat -n /etc/profile | more
  ```

##### 2、more：全屏幕按页显示

- 基本语法

  ```bash
  more filename
  ```

- 常用操作

  | 操作   | 功能说明                 |
  | ------ | ------------------------ |
  | 空格   | 向下翻一页               |
  | 回车   | 向下翻一行               |
  | q      | 退出                     |
  | ctrl+f | 向下滚动一屏             |
  | ctrl+b | 向上滚动一屏             |
  | =      | 输出当前行号             |
  | :f     | 输出文件名和当前行的行号 |

##### 3、less

- 基本语法

  ```bash
  # 分屏查看文件内容，功能与more差不多，但更强大，因为其在加载文件时是按需加载的，所以对大文件具有更高的效率
  less filename
  ```

- 常用操作

  | 操作     | 功能说明                                 |
  | -------- | ---------------------------------------- |
  | 空格     | 向下翻一页                               |
  | pagedown | 向下翻一页                               |
  | pageup   | 向上翻一页                               |
  | /字符串  | 向下查找字符串，n：向下查找；N：向上查找 |
  | ?字符串  | 向上查找字符串，n：向上查找；N：向下查找 |
  | q        | 退出                                     |
  | u        | 向上翻半页                               |
  | d        | 向下翻半页                               |

##### 4、head

- 基本语法

  ```bash
  head [options] filename
  ```

- 常用选项

  -n 行数：	查看文件的前多少行的内容，不指定则默认10行

- 应用

  ```bash
  # 查看前10行内容
  head /etc/profile
  
  # 查看前5行内容
  head -n 5 /etc/profile
  ```

##### 5、tail

- 基本语法

  ```bash
  tail [options] filename
  ```

- 常用选项

  -n 行数：	查看文件的末尾多少行的内容，不指定则默认10行

  -f：实时追踪该文档的所有更新，工作中常用

- 应用

  ```bash
  # 实时追踪log.txt文件最后10行的内容
  tail -f log.txt
  ```

#### 10、> 指令和>> 指令

- 基本语法

  ```bash
  > 指令：输出重定向，会将原来的文件内容覆盖
  >> 指令：追加，不会覆盖原来的文件内容，而是添加在末尾
  ```

- 应用

  ```bash
  # 将列出的结果写入a.txt文件（会覆盖），如果a.txt不存在则会先创建
  ls -l > a.txt
  
  # 将/etc/profile文件的内容写入a.txt文件（追加），如果a.txt不存在则会先创建
  cat /etc/profile >> a.txt
  ```

#### 11、软链接（符号链接）

- 基本语法

  ```bash
  # 软连接，类似于windows中的快捷方式
  ln [options] 原文件或目录 软链接名
  ```

- 常用选项

  -s：	创建软链接，不加该参数则是创建硬链接

- 应用

  ```bash
  # 给文件创建软链接
  ln -s log2013.log link2013
  
  # 删除软链接，注意不管是不是目录的软链接，删除时后面不要加/，否则提示资源忙
  rm -rf link2013
  ```

#### 12、echo指令

- 基本语法

  ```bash
  echo [options] [输出内容]
  ```

- 应用

  ```bash
  # 输出环境变量到控制台
  echo $PATH
  ```

#### 13、文件打包和压缩

##### 1、gzip/gunzip



##### 2、zip/unzip



##### 3、tar

tar -czvf test.tar.gz a.c   //压缩 a.c文件为test.tar.gz 
tar -xzvf test.tar.gz       //解压



#### 14、历史命令

- 基本语法

  ```bash
  history 数量
  ```

- 应用

  ```bash
  # 显示所有历史执行的命令
  history
  
  # 显示最近执行的10条命令
  histroy 10
  
  # 显示出最近执行的命令后，再选择其中的命令执行
  !最近执行过的命令的编号
  ```

#### 15、时间与日期

- 基本语法

  ```bash
  # 其中格式字符串中，%Y：年、%m：月、%d：天、%H：时、%M：分、%S：秒
  date [options] 时间或输出格式的字符串
  ```

- 常用选项

  -s：	设置系统当前时间

- 应用

  ```bash
  # 输出当前系统时间
  date
  
  # 按格式输出时间,2020-6-20
  date "+%Y-%m-%d"
  
  # 按格式输出时间，18:30:00
  date "+%H:%M:S"
  
  # 设置系统当前时间为2020-06-20 20:30:30
  date -s "2020-06-20 20:30:30"
  ```

#### 16、日历

- 基本语法

  ```bash
  cal [options]
  ```

- 常用选项

  年份：	指定要查看日历的年份，不指定则默认查看当月的日历

- 应用

  ```
  # 查看当前月份的日历
  cal
  
  # 查看2020年的日历
  cal 2020
  ```

#### 16、搜索查找

##### 1、find

- 基本语法

  ```bash
  find 搜索范围 [options]
  ```

- 常用选项

  -name：	按文件名查找

  -user：	按所属用户查找

  -size：	按文件大小查找

- 应用

  ```bash
  # 
  
  ```

  

##### 2、locate



##### 3、grep与管道

| 这个符号叫做管道符号。
管道命令符的作用能用一句话来概括：“把前一个命令原本要输出到屏幕的数据当作是后一个命令的标准输入”。
输入方法是同时按下键盘的“Shift”与“\”键，执行格式为“命令A | 命令B”。
如：history | grep date指从history这条命令运行的结果中显示包含有 “date” 的命令。

grep (global search regular expression(RE) and print out the line,全面搜索正则表达式并把行打印出来)是一种强大的文本搜索工具，它能使用正则表达式搜索文本，并把匹配的行打印出来。




## 三、权限管理

#### 1、Linux下三种用户 

- 文件或目录实际拥有者（也称文件的用户User，缩写u）
- 用户组（Group，缩写g）
- 系统中的其他人（Other，缩写o）  

[注]以上三种（即所有用户,缩写a）  

#### 2、对文件和目录的常用操作属性

- 读（r）： 
  对文件：可以查看； 
  对目录：可以使用ls命令列出其内容。  
- 写（w）： 
  对文件：可以编辑； 
  对目录：可以删除、重命名或添加文件。  
- 执行（x）： 
  对文件：可以作为程序来执行；
  对目录：可以读取它的文件和子目录，或运行文件。  

[注]root用户一直能够对任何文件或目录进行任何操作。  

**+表示增加权限、- 表示取消权限、= 表示唯一设定权限。**  

#### 3、用字母表示法修改权限

命令格式：chmod [ugo][+-=][rwx] fileName|directoryName  

```bash
eg:  
将档案file1.txt设为所有人皆可读取
chmod ugo+r file1.txt
chmod a+r file1.txt

将档案file1.txt、file2.txt设为该档案拥有者及所属用户组可写入，但其他人不可写入
chmod ug+w,o-w file1.txt file2.txt
```

#### 4、用数字表示法修改权限

命令格式：chmod [0-7][0-7][0-7] fileName|directoryName  

```bash
 数字权限是基于二进制数字系统而创建的，读（read，r）的值是4，写（write，w）的值是2，执行（execute，x）的值是1，没有授权的值是0。数字权限对应关系是：
0 ---
1 --x
2 -w-
3 -wx
4 r--
5 r-x
6 rw-
7 rwx

一般用3个数字来设置权限，分别给拥有者，组用户（拥有者所在组其他用户）、其他人

虽然可以设置各式各样的权限，但常用的权限只有几种。它们的含义是：
400   -r--------   拥有者能够读，其他任何人不能进行任何操作；
644   -rw-r--r--   拥有者都能够读，但只有拥有者可以编辑；
660   -rw-rw----   拥有者和组用户都可读和写，其他人不能进行任何操作；
664   -rw-rw-r--   所有人都可读，但只有拥有者和组用户可编辑；
700   -rwx------   拥有者能够读、写和执行，其他用户不能任何操作；
744   -rwxr--r--   所有人都能读，但只有拥有者才能编辑和执行；
755   -rwxr-xr-x   所有人都能读和执行，但只有拥有者才能编辑；
777   -rwxrwxrwx   所有人都能读、写和执行（该设置通常不是好想法）。
```

## 四、进程管理

#### 1、查看进程

ps -ef 

#### 2、杀掉进程



## 五、下载与安装

#### 1、wget

Linux wget是一个下载文件的工具，它用在命令行下。



#### 2、yum



#### 3、rpm







## 六、防火墙操作

#### 1、查看防火墙状态

```bash
$ systemctl status firewalld
```

#### 2、打开防火墙

```bash
$ systemctl start firewalld
```

#### 3、关闭防火墙

```bash
$ systemctl stop firewalld
```

#### 4、查看开放的端口号

```bash
$ firewall-cmd --list-all
```

#### 5、设置开放的端口号

```bash
$ sudo firewall-cmd --add-port=80/tcp -permanent
```

#### 6、重启防火墙

```bash
$ firewall-cmd --reload
```



## 七、磁盘分区、挂载

#### 1、查看内存

free

#### 2、查看磁盘

df -h









## 八、网络配置

#### 1、ip addr









## 九、其他命令

#### 1、清屏

clear 清屏，向上翻一页，可使用快捷键ctrl+l代替
reset 刷新





## 4、Shell 脚本

### 4.1 介绍

- Shell编程

  Shell脚本即Linux脚本（.sh的文件），编写Linux脚本也就是Shell编程。

- Shell

  Shell是一个命令行解释器，它为用户提供了一个向Linux内核发送请求以便运行程序的界面系统级程序，用户可以用Shell来启动、挂起、停止甚至是编写一些程序。

### 4.2 语法

#### 1、Shell脚本格式

- 脚本以#!/bin/bash开头
- 脚本需要可执行权限才能执行，一般编写好后设置744的权限，也可以不赋予脚本执行权限，但要使用sh xxx.sh才能执行，不推荐这么做。

#### 2、Shell的变量

- 系统变量

  $HOME、$PWD、$SHELL、$USER、$PATH等等，可以直接使用。

  可以使用set命令显示当前Shell中所有变量。

- 用户自定义变量

  ①变量名可以由字母、数字和下划线组成，但是不能以数字开头。

  ②定义时等号两侧不能有空格

  ③变量名一般大写

  ```bash
  # 定义变量
  变量名=值
  
  # 撤销变量
  unset 变量名
  
  # 声明静态变量，注意：静态变量不能撤销
  readonly 变量名=值
  
  # 将命令的返回值赋给变量，使用反引号``或者$()将命令包起来
  A=`ls -la`
  A=$()
  
  # 提升变量为全局环境变量，可供其他Shell程序使用
  
  
  ```

- 位置参数变量

  

- 预定义变量

  

#### 3、运算符



#### 4、条件判断



#### 5、流程控制

- if判断

  

- case语句

  

- for循环

  

- while循环



#### 6、read读取控制台输入



#### 7、函数

- 系统函数

  

- 自定义函数

  





