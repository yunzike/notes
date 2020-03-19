下载安装：https://www.eclipse.org/downloads/

不要直接下载安装器

而是选择Download Packages下载for Java EE的完整包

直接解压使用

其他工具准备：

1、安装JDK并配置好环境变量

2、下载好Tomcat服务器解压放D盘

3、安装maven并修改仓库配置

配置JDK(mac下安装前会检测是否安装JDK并自动配置)：

window-->Preferences-->Java-->Installed JREs-->Add-->Standard VM-->Next

--->Directory选择JDK安装路径--->Finish--->Apply and Close

JavaSE开发测试：

新建Java Project：JavaSEDemo

新建Demo1.java

System.out.println("Hello Java");

配置Tomcat服务器：

window-->Preferences-->Server-->Runtime Environments

Add--->选择自己安装的版本--->Next--->Browse选择安装路径--->Finish--->Apply and Close

JavaEE开发测试：

创建Dynamic Web Project项目：JavaEEDemo

![屏幕快照 2019-01-01 下午2.45.19](../../images/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-01-01%20%E4%B8%8B%E5%8D%882.45.19.png)

![屏幕快照 2019-01-01 下午2.46.56](../../images/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-01-01%20%E4%B8%8B%E5%8D%882.46.56.png)

![屏幕快照 2019-01-01 下午2.48.33](../../images/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-01-01%20%E4%B8%8B%E5%8D%882.48.33.png)

new一个servlet文件：

![屏幕快照 2019-01-01 下午2.49.10](../../images/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-01-01%20%E4%B8%8B%E5%8D%882.49.10.png)

Next一两次后Finish

运行测试

其他配置：

1、设置字体大小（四号）：

​    window窗口--->preferences首选项--->general常规--->appearance外观--->

​    colors and fonts颜色和字体--->basic基本--->Text Font 文本字体--->Edit编辑

2、设置代码提示

快捷键：ctrl+空格与输入法冲突

需要配置为：Alt + /

window窗口--->preferences首选项--->general常规--->keys

type filter text文本框输入content

修改Binding为Alt + /

自动提示：

window窗口--->preferences首选项---->Java--->Editor---->Content Assist

在Auto activation triggers for Java：中修改为：.a---zA---Z

其他语言自动提示，如javascript、json、JSP、HTML、XML同上先进入对应语言Editor设置

代码模板设置：

sysout提示输出语句

window窗口--->preferences首选项---->Java--->Editor---->Templates

勾选默认的sysout然后Apply

自定义模板

new新建

常用的private和public的提示

pri提示为private (带空格)、pub提示为public (带空格)

3、断点调试

代码最左边双击加断点

然后Debug模式运行

F5（step into）：跳入方法

F6（step over）：执行下一句

F7（step return）: 跳出方法

F8 （Resume）: 跳到下一个断点

Drop to Frame：跳回当前方法的第一行

查看变量的值：选中右击点watch

注意：断点调试完成后，要在breakpoints视图中清除所有断点，一定要结束运行断点的jvm。

4、修改工作空间字符集为UTF-8

window窗口--->preferences首选项--->general常规--->Workspace

选中Text file encoding的other修改为UTF-8

5、设置全黑主题：

代码的背景主题：

Help > Install New Software-->Work with:输入http://eclipse-color-theme.github.com/update 

-->Add-->ok -->Select All --->Next，等着Color Theme安装完。

重启Eclipse：

Window -> Preference -> General -> Appearance -> Color Theme

选择你们喜欢的主题Apply -> OK

窗口面板为黑色：

同上安装插件

https://raw.github.com/guari/eclipse-ui-theme/master/com.github.eclipseuitheme.themes.updatesite

重启Eclipse：

Window -> Preference -> General -> Appearance

在Theme中选择主题Apply -> OK

安装语言包：切换语言，打开eclipse目录，进cmd，然后执行命令eclipse.exe -nl en/zh切换英中文。

6、重置窗口布局：

​    Window窗口->Perspective透视图 ->Reset Perspective复位透视图

7、常用快捷键

ctrl+1          快速修复

ctrl+shift+O     导包

ctrl+shift+f      格式化代码块

选中按f2        查看方法说明

选中后ctrl+T     查看继承关系

ctrl+shift+L      查看所有快捷键

ctrl+鼠标点击     查看源码

ctrl+shift+t		搜索查看源码

ctrl+shift+X      更改为大写

ctrl+shift+Y      更改为小写

ctrl+alt+向下键   复制当前行

作用域 快捷键 功能

全局 Ctrl+M 最大化/最小化当前视图

全局 Ctrl+= 放大视图

全局 Ctrl+- 缩小视图

文本编辑器 Ctrl+F 查找并替换

文本编辑器 Ctrl+L 转至某行

Java编辑器 Ctrl+Shift+F 代码格式化

Java编辑器 Ctrl+/ 注释/取消注释当前行

Java编辑器 Ctrl+Shift+M 添加导入包

Java编辑器 Ctrl+Shift+O 组织导入包

Java编辑器 Ctrl+Shift+↑ 转至上一个成员

Java编辑器 Ctrl+Shift+↓ 转至下一个成员

Java编辑器 Ctrl+B 重新编译Java程序代码

Java编辑器 Ctrl+F11 运行上次程序

8、导入JAR包

添加第三方jar包：

在项目下新建目录lib，然后把jar包复制到lib下，然后选中所有的jar包，右键BuildPath-->Add to BuildPath。

右击“项目”→选择Properties，选择Java Build Path，Add External JARs，就可以逐个（也可以选择多个jar，但是限制在同一个文件夹中）添加第三方引用jar包。

右击“项目”→选择Properties，选择Java Build Path，选择"Add Library"，弹出如下图所示对话框，选择"User Library"，然后选择→Next