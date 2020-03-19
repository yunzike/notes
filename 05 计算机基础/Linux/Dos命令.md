```
e：                     ：切换到E盘  
cd 当前盘下目录         ：切换到当前盘符下目录 
cd /d 其他盘下目录      ：不用先切换盘符，直接切换到新目录
cd..                    ：退回上一级目录  
cd\                     ：退回到根目录  

dir                     ：列出当前目录下文件及文件夹  
md                      ：创建文件或文件夹  
rd                      ：删除文件或文件夹  
del                     ：删除文件  
exit                    ：退出dos命令行   
help                    ：查看所有命令  
help cd                 ：查看cd命令的用法  
cls                     ：clear screen 清屏  
*                       ：通配符      

copy 路径\文件名 路径\文件名 ：复制
move 路径\文件名 路径\文件名 ：移动
```
- 查看端口占用情况  
netstat -ano					列出所有端口情况  
netstat -ano|findstr "8000" 		查看8000端口被占用情况  

记下PID

tasklist|findstr "pid号"			查看是哪个进程占用了对应端口号  

打开任务管理器结束进程  
或者  
taskkill /f/t/im 进程名 			kill进程  




