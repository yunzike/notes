#### IDEA的安装

#### JDK环境配置
Configure->Structure for new Project->Project Settings->Project->Project SDK  
选择JDK本地安装目录并设置

#### 配置Tomcat环境
菜单按钮中方框：Edit Configuraion->添加->Tomcat Server ->local  
1.设置服务器name:server01  
2.Server->Application server->Configure    选择本地Tomcat路径  
3.Open Browser->After launch   设置运行后启动浏览器  
4.Open Browser->url 设置部署入口的ur  
5.On 'update' action:修改为Redeploy,On frame deactivation:修改为Update classes and resources  
6.Http port  配置端口  
7.Deployment 设置服务器运行的项目

#### 配置maven
1.下载Maven解压并修改仓库配置  
2.设置直接搜索Maven  
3.修改Maven home directory为本地Maven路径  
4.修改User settings file为settings.xml并勾选后面的override  
5.Local repository为配置的本地仓库并勾选后面的override 


#### git的使用
设置中配置本地安装的git

菜单栏VCS选择git

#### 创建Java SE项目
1.启动页点击Create new project  
2.左侧选择Java  
3.选择JDK，默认为配置的JDK环境  
4.点击next再点击next，然后设置项目名，项目路径，完成

#### 创建Java EE项目
1.启动页点击Create new project  
2.左侧选择Java  
3.勾选Java EE->Web Application  
4.设置Serverlet版本：点击Java   EE，最下方选择Serverlet版本对应的Java EE版本，再点击Web Applic就能看到选择的Serverlet版本了  
5.点击next，指定项目名字和路径，完成  

#### 编码界面设置
打开菜单按钮（默认关闭）  
View->Toolbar(菜单按钮)和Tool Window Bars(窗口左右菜单项)

#### 设置启动显示启动页而不是直接打开项目
Configure->Settings->Appearance&Behaivor->System settings  
去掉Reopen last project on startup的勾

#### IDEA中的.iml和.idea文件
.iml文件  
iml文件是IntelliJ   IDEA自动创建的模块文件，用于Java应用开发，存储一些模块开发相关的信息，比如一个Java组件，插件组件，Maven组件等等，还可能存储一些模块路径信息，依赖信息以及别的一些设置。  

.idea文件夹  
idea对module配置信息之意，information of module

**隐藏**  
这两个文件我们平常几乎不使用，在创建父子工程或者聚合工程时反而会对我们操作产生干扰，所以，一般情况下，我们都将其隐藏掉，步骤如下：  
File——>settings——>Editor——>File Types——>Ignore files and foloders中输入*.iml和.idea,以 ; 结尾

#### 配置JVM参数
Help->Editor Custom VM Options  
-Xms128m  
-Xmx750m  
-XX:ReservedCodeCacheSize=240m  
修改为：  
-Xms1024m  
-Xmx2048m  
-XX:ReservedCodeCacheSize=500m

#### 添加第三方依赖
1.webINF目录下新建lib目录，并将依赖jar包复制进去  
2.点击菜单按钮Project Structure  
3.Project Settings->Libraries  
点击加号，Java->选择刚才创建的lib文件夹->OK->OK->Apply  
4.Project Settings->Modules->
Dependencies->勾选刚才添加的lib仓库->Apply  

#### 快捷键
IDEA不需要Ctrl+S保存，每做一步操作软件会自动保存（可设置成手动保存）  
psvm：main函数  
sout：打印    
shift+f10：运行  
ctrl+f2：停止  

ctrl+shift+enter 语句补全(定义方法，for循环，fori)  
ctrl+shift+space 智能补全(如将之前定义的方法的返回值赋给定义的变量)     
alt+enter：代码修复  
shift+enter: 跳到新的一行  
ctrl+y：删除当前行（PS 使用剪切更快捷）
ctrl+D：复制并粘贴当前行（或选中内容）
ctrl+alt+L：格式化代码  
alt+insert: 插入构造方法、get\set方法等  
ctrl+alt+t: 在选中代码块外面包上其他东西如if、trycatch等  
ctrl+shift+v：剪切板  

后缀补全：  
xxx.if：if(xxx) 
xxx.null：判空  
xxx.nn：判非空  
xxx.var：变量声明  
xxx.for：遍历  
xxx.fori：索引遍历  



重构：  
shift+F6： 更改类名或成员变量  
ctrl+alt+m： 方法抽取   
ctrl+r：替换本文件文本  
ctrl+shift+r：全局替换文本  
alt+j：选中某个文本后，再选中下一个相同文本，可以同时修改  

选择与跳转：    
ctrl+w:选择代码  
ctrl+shift+w:释放代码  
ctrl+left/right: 移动到单词前面/后面   
ctrl+shift+left/right：选择单词   
ctrl+[/]: 移动到代码块前面/后面    
ctrl+shift+[/]：选择代码块

alt+up/down:在不同方法之间跳跃 
alt+shift+up/down：移动当前行  
ctrl+shift+>:代码折叠    
ctrl+alt+鼠标点击：跳到具体实现方法   
ctrl+鼠标点击：跳到调用方法  
ctrl+alt+左方向箭头：back跳到上一个查看位置（需要关闭显卡旋转屏幕快捷键）  
ctrl+alt+右方向箭头：forward前往下一个查看位置（需要关闭显卡旋转屏幕快捷键）  
shift+鼠标滚轮(项目结构视图中可用ctrl+left|right)：移动滚动条  

shift+esc：关闭当前视图  
alt+home：显示导航栏
alt+1: 显示项目结构  
alt+4: 显示控制台  
ctrl+E: 显示最近文件  


查找：    
ctrl+F:当前文件文本搜索    
ctrl+shift+F:全局文本搜索  

ctrl+N:按类名搜索    
ctrl+shift+N:按文件名搜索    
shift+shift：万能搜索（搜索类、资源、配置项、方法、搜索路径）  

alt+7：当前文件结构  
ctrl+F12： 当前类的所有方法  
alt+F7: 查找类或方法在哪里被使用  

Ctrl+Alt+B： 查看接口或者抽象方法的实现（必须先将光标定位到接口或抽象方法行）    
ctrl+h： 当前类的继承关系（只有当前类的继承，不包含层级关系上的接口）    
ctrl+alt+U: 查看UML图（包含该类或接口以上层级的类和接口，其中蓝色实线箭头表示继承类，绿色实线箭头表示继承接口，绿色虚线箭头是实现接口）   


代码提交：  
ctrl+t：poll  
ctrl+k：commit  
ctrl+shift+k: push  

#### Debug
竖排按钮：  
ctrl+F5：重启Debug  
Resume Program (F9)：下一个断点  

Ctrl+F2：停止Debug  
View BreakPoints(ctrl+shift+F8)：查看所有断点  
Mute BreakPoints：禁用所有断点  

横排按钮：  
Show Execution Point (Alt + F10)：跳转当前执行行  
Step Over (F8)： 下一行  
Step Into (F7)： 下一行（进入方法内部，除官方类库方法外）  
Force Step Into (Alt+Shift+F7)：下一行（进入任何方法内部）   
Step Out (Shift+F8)：跳出（退出到方法调用处）      
Drop Frame (默认无快捷键)：回退断点  
Run to Cursor (Alt+F9)：运行到光标处（不需要事先打断点）  
Evaluate Expression (Alt+F8)：计算表达式（可以先选中表达式）  

运行完成：  
方式一：连续点击F9执行完最后一个断点  
方式二：禁用断点然后点击F9  
变量值查看：  
方式一：光标悬停+ctrl+F1  
方式二：Variables视图或Watches视图  
智能步入：  
smart step into(shift+F7)：当前行有多个方法时，自主选择进入的方法（step into会依次进入）    



#### 其他设置
全局设置：  
启动界面Configure->Settings  
编码界面File->Other settings->Settings for new Projects  
项目设置：
编码界面File->Settings

修改主题：Appearance&Behaivor->Appearance->Theme  
代码字体：Editor->Font  
控制台字体：Editor->Color Scheme->Console Font  
控制台颜色：Editor->Color Scheme->Console Color  

编码方式：Editor->File Encordings     
Project Encoding---UTF-8  
Properties Files---UTF-8 并勾上后面的勾


显示行号：
Editor->General->Appearance->Show line numbers  
方法间显示分割线：Editor->General->Appearance->Show method separators  
格式化代码空行设置：
Editor->Code Style->Java->Blank Lines
最上面三个改为1，格式化代码后多个空行合并成一个空行  

代码提示（补全）：
Editor->General->Code Completion->Match case
修改为All letters？  
显示方法参数：
Editor->General->Code Completion->Parameter Info

自动导包：
Editor->General->Auto Import  
Java->Ask改为All并勾选Add unambig...和Optimize imports...

文档提示（鼠标移到类上或方法上）：  
Editor->General->勾上Show quick documentation on mouse move 

#### 添加插件
启动页Configure->Plugins或者Settings->Plugins

常用插件：   
activate-power-mode: 代码编辑特效  
Rainbow Brackets: 彩虹括号  
CodeGlance: 代码导航地图 
Free Mybatis plugin: mapper和xml跳转   
Key promoter：快捷键提示，可以关闭提示，没有快捷键的可以快速设置快捷键    
ECTranslation: 翻译  
Alibaba Java Coding Guidelines: 阿里代码规约  
Nyan progress bar: 进度条美化


CamelCase: 驼峰转化  
JRebel for IntelliJ:热部署 收费  

Material Theme UI:主题插件，修改图标


#### 导入项目
##### 导入eclipse项目


#### 注释模板设置
- 类注释  

Editor --> File and Code Templates --> Includes --> File Header
```
/**
 * 
 * @Description ${NAME} <br>
 * @author xiongxiaoqi <br>
 * @date ${DATE} ${TIME} <br>
 * version: 1.0 <br>
 */
```

- 方法注释  

```
方法注释

```
