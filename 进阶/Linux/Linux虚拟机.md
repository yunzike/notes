虚拟机网络配置

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




xshell连接虚拟机  
测试本机主机是否能ping通虚拟机  
虚拟机是否能ping通本地主机  
如果不能则可能是防火墙的设置问题  




