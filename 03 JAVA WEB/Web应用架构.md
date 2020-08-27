![img](../../images/download_file-1.png)

虚拟目录映射：将web应用交给服务器管理

Tomcat服务器配置，在conf\server.xml中的<Host></Host>标签中加入

<Context  path="/itcas" docBase="D:\news"></Context>

其中docBase指定本地web应用路径

path指定虚拟路径

然后需要重启服务器

在浏览器中输入：http：//localhost:8080/itcas/a.html

http: 默认占用端口80

localhost：本主机

8080： Tomcat端口

更方便的方法（还有其他地方可以配置）：

在conf\Catalina\localhost中

添加一个xxx.xml的web应用服务器配置文件

其中添加<Context/>信息，其中不需要添加虚拟路径path

而是以xml文件名为虚拟路径，也不需要重启服务器

多级虚拟目录设置：将xml文件设置成a#b.xml则虚拟路径path为/a/b

缺省虚拟路径设置：xml文件名设置为：ROOT.xml，需要重启

自动映射：不需要配置

将web应用文件复制到webapps下。

配置虚拟主机