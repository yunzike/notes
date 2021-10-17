## 1、项目创建 & 导入

### 1.1 创建项目

- 创建Java SE项目

  1.启动页点击Create new project 

  2.左侧选择Java 

  3.选择JDK，默认为配置的JDK环境 

  4.点击next再点击next，然后设置项目名，项目路径，完成

  

- 创建Java EE项目

  1.启动页点击Create new project 

  2.左侧选择Java 

  3.勾选Java EE->Web Application 

  4.设置Serverlet版本：点击Java   EE，最下方选择Serverlet版本对应的Java EE版本，再点击Web Applic就能看到选择的Serverlet版本了 

  5.点击next，指定项目名字和路径，完成  

### 1.2 导入项目

- 导入eclipse项目

## 2、基本配置

![image-20210928001140281](../../images/image-20210928001140281.png)

### 2.1 主题 & 字体

修改主题：Appearance&Behaivor->Appearance->Theme 
代码字体：Editor->Font 
控制台字体：Editor->Color Scheme->Console Font 
控制台颜色：Editor->Color Scheme->Console Color  

方法间显示分割线：Editor->General->Appearance->Show method separators 
格式化代码空行设置：
Editor->Code Style->Java->Blank Lines
最上面三个改为1，格式化代码后多个空行合并成一个空行  

### 2.2 修改编码

![image-20210928002226003](../../images/image-20210928002226003.png)

### 2.3 自动导包

![image-20210928005639175](../../images/image-20210928005639175.png)

### 2.4 代码提示

- 忽略大小写

  ![image-20210928010001140](../../images/image-20210928010001140.png)

- 显示方法参数

  Editor->General->Code Completion->Parameter Info

- 文档提示（鼠标移到类上或方法上）

  Editor->General->勾上Show quick documentation on mouse move 

### 2.5 配置 jdk、Maven、Git 、Tomcat、SVN

- jdk

  Configure->Structure for new Project->Project Settings->Project->Project SDK

  选择JDK本地安装目录并设置

- 配置 Maven

  下载 Maven 解压并修改仓库配置

  ![image-20210928010208063](../../images/image-20210928010208063.png)

- 配置 git

  ![image-20200724012202452](../../images/image-20200724012202452-2760498.png)

- 配置Tomcat环境

  菜单按钮中方框：Edit Configuraion->添加->Tomcat Server ->local 

  1.设置服务器name:server01 

  2.Server->Application server->Configure    选择本地Tomcat路径 

  3.Open Browser->After launch   设置运行后启动浏览器 

  4.Open Browser->url 设置部署入口的ur 

  5.On 'update' action:修改为Redeploy,On frame deactivation:修改为Update classes and resources 

  6.Http port  配置端口

  7.Deployment 设置服务器运行的项目

- 配置SVN

  ![image-20201218112140716](../../images/image-20201218112140716.png)

### 取消自动保存

![image-20200413215215892](../../images/image-20200413215215892-2759966.png)

![image-20200413215332443](../../images/image-20200413215332443-2759984.png)

### 2.6 去除SQL黄色背景

- 去除SQL黄色背景

  去掉SQL中No data sources configured（没有配置数据源） 选项 和 SQL dialect detection（SQL方言检测）

  ![image-20200103161742806](../../images/image-20200103161742806-2761145.png)

- 再去掉灰色背景色

  ![image-20200103162333693](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20200103162333693.png)

### 2.7 隐藏 .idea 文件和 .iml 等文件

.idea 是对 module 配置信息之意，information of module

.iml 文件是 IntelliJ   IDEA 自动创建的模块文件，用于Java 应用开发，存储一些模块开发相关的信息，比如一个Java组件，插件组件，Maven组件等等，还可能存储一些模块路径信息，依赖信息以及别的一些设置。

这两个文件我们平常几乎不使用，在创建父子工程或者聚合工程时反而会对我们操作产生干扰，所以，一般情况下，我们都将其隐藏掉。

![image-20210928002008415](../../images/image-20210928002008415.png)



### 新项目 jdk

![image-20210928021420237](../../images/image-20210928021420237.png)

![image-20210928021608817](../../images/image-20210928021608817.png)

 

### 其他设置

- 菜单按钮

  View->Toolbar(菜单按钮)和Tool Window Bars(窗口左右菜单项)

- 设置启动显示启动页

  Configure->Settings->Appearance&Behaivor->System settings 

  去掉Reopen last project on startup的勾

- 双斜杠注释紧跟代码头

  ![image-20210928013301838](../../images/image-20210928013301838.png)

- 配置JVM参数

  Help->Editor Custom VM Options 
  -Xms128m 
  -Xmx750m 
  -XX:ReservedCodeCacheSize=240m 
  修改为： 
  -Xms1024m 
  -Xmx2048m 
  -XX:ReservedCodeCacheSize=500m

- Tab 页多行显示

  editor->general->editor tabs->show tabs in one row 前面的勾去掉

  

### 添加第三方依赖

1.webINF目录下新建lib目录，并将依赖jar包复制进去 

2.点击菜单按钮Project Structure 

3.Project Settings->Libraries 
点击加号，Java->选择刚才创建的lib文件夹->OK->OK->Apply 

4.Project Settings->Modules->
Dependencies->勾选刚才添加的lib仓库->Apply

### 云同步设置

- 开启设置云同步

  ![image-20210713172815985](../../images/image-20210713172815985.png)

### 导入导出配置

- 导出

  

- 导入



## 3、快捷键

#### 3.1 基本快捷键

| 操作                   | 说明                                               |
| ---------------------- | -------------------------------------------------- |
| `psvm`                 | main函数                                           |
| `sout`                 | 打印                                               |
| `shift + F10`          | 启动项目                                           |
| `ctrl + F2`            | 停止项目                                           |
| `ctrl + shift + enter` | 语句补全(定义方法，for循环，fori)                  |
| `ctrl + shift + space` | 智能补全(如将之前定义的方法的返回值赋给定义的变量) |
| `alt + enter`          | 代码修复                                           |
| `shift + enter`        | 跳到新的一行                                       |
| `ctrl + y`             | 删除当前行（PS 使用剪切`ctrl + x`更快捷）          |
| `ctrl + d`             | 复制并粘贴当前行（或选中内容）                     |
| `ctrl + alt + L`       | 格式化代码                                         |
| `alt + insert`         | 插入构造方法、get\set方法等                        |
| `ctrl + alt + t`       | 在选中代码块外面包上其他东西如if、trycatch等       |
| `ctrl + shift + v`     | 剪贴板                                             |
| `ctrl + shift + u`     | 大小写转换                                         |
| `shift + alt + u`      | 驼峰转化，需要安装插件`CamelCase`                  |


#### 3.2 重构

| 操作               | 说明                                               |
| ------------------ | -------------------------------------------------- |
| `shift + F6`       | 更改类名或成员变量                                 |
| `ctrl + r`         | 替换当前文件文本                                   |
| `ctrl + shift + r` | 全局替换文本                                       |
| `ctrl + alt + m`   | 方法抽取                                           |
| `alt + j`          | 选中某个文本后，再选中下一个相同文本，可以同时修改 |

#### 3.3 选择与跳转

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

#### 3.4 视图操作

shift+esc：关闭当前视图 
alt+home：显示导航栏
alt+1: 显示项目结构 
alt+4: 显示控制台 
ctrl+E: 显示最近文件  

#### 3.5 查找 

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

#### 3.6 代码提交

ctrl+t：poll 
ctrl+k：commit 
ctrl+shift+k: push  

#### 3.7 列编辑

mac 下，
光标选中连续行相同位置：opt + 鼠标左键拖动
光标选中多个任意位置：shift + opt + 鼠标左键单击
选中相同内容出现的多个位置：选择内容后，cmd + F 查询，然后ctrl + G 光标选择下一个位置 

alt + 鼠标左键拖动或者shift + 上下方向箭：光标选中连续行相同位置
shift + alt + 鼠标左键单击选择：光标选中多个任意位置

选中相同内容出现的所有行：
选择内容后，ctrl+F 查询，然后ctrl + shift + alt + J 光标选中所有查询结果

## 4、Debug

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

https://mp.weixin.qq.com/s/CLw9P7y9ZQfVaxI6GRhoOw    

- 条件断点
- 回到上一步
- 临时执行表达式/修改变量的运行值
- 多线程调试
- 远程调试

## 5、插件

### 插件安装

启动页Configure->Plugins或者Settings->Plugins

### 常用插件

activate-power-mode: 代码编辑特效 
Key promoter：快捷键提示，可以关闭提示，没有快捷键的可以快速设置快捷键 
Alibaba Java Coding Guidelines: 阿里代码规约 
JRebel for IntelliJ：热部署 收费
Material Theme UI:主题插件，修改图标
RestfulToolkit：快速定位接口方法
Mybatis Log Plugin:输出可执行的SQL语句
Lombok：省掉手动的get/set方法
Easy Code：数据库生成JavaBean
.ignore：生成.gitignore文件
Git Commit Template：git commit 模板
GsonFormat：一键根据json文本生成java类
java-bean-to-json：bean 和 json 相互生成
Jclasslib Bytecode Viewer：查看类的字节码文件
Leetcode Editor：LeetCode插件
Nyan progress bar: 进度条美化
GenerateAllSetter：Alt+Enter 一键生成所有方法
Properties to YAML Converter：一键将Propereties配置文件转成YML文件

| 插件名称             | 作用                                                         |
| -------------------- | ------------------------------------------------------------ |
| Free Mybatis plugin: | mapper 和 xml 跳转                                           |
| Rainbow Brackets     | 彩虹括号                                                     |
| CodeGlance           | 代码导航地图                                                 |
| CamelCase:           | 驼峰转化，shift + alt + u                                    |
| Translation          | 翻译                                                         |
|                      |                                                              |
|                      |                                                              |
|                      |                                                              |
|                      |                                                              |
|                      |                                                              |
|                      |                                                              |
|                      |                                                              |
| Save Actions         | 自动优化包导入、给没有修改的变量添加 final 修饰符、调用方法添加 this 等 |
| Grep Console：       | 日志着色控制台显示                                           |
| Statistic            | 代码统计                                                     |
|                      |                                                              |
|                      |                                                              |
|                      |                                                              |
|                      |                                                              |



### Translation 使用

https://ai.youdao.com/gw.s#/

<img src="../../images/image-20201006110356522.png" alt="image-20201006110356522" style="zoom:50%;" />

![image-20201006110513053](../../images/image-20201006110513053.png)



![image-20201006110513053](../../images/image-20201006110513053.png)

<img src="../../images/image-20201006110814114.png" alt="image-20201006110814114" style="zoom:50%;" />



<img src="../../images/image-20201006110854471.png" alt="image-20201006110854471" style="zoom:50%;" />



在应用里我们可以看到应用id和应用密钥，放到idea里面就好了。

6500bb688b84ef2a

A1kby90lsbGlJ8MqIpzfDKfpt0Z8Lmkg

最后我们打开idea看源码之类的就很方便了，选中文本右击会有“translate”，会有快捷键提示



### IDEAVim & AceJump

- IDEAVim

  

- AceJump
  | 快捷键                      | 作用                               |
  | --------------------------- | ---------------------------------- |
  | ctrl+; (可以改为alt+k)      | 进入acejump模式                    |
  | 任一个字符（acejump模式下） | 标记当前文件中该字符出现的所有位置 |
  | shift+标签                  | 选中当前位置到标签处的内容         |



## 6、自定义代码模板

#### 1、注释模板

- 类注释

  Editor --> File and Code Templates --> Includes --> File Header

  ```java
  /**
   * 
   * @Description ${NAME} <br>
   * @author xiongxq <br>
   * @date ${DATE} ${TIME} <br>
   * version: 1.0 <br>
   */
  ```

- 方法注释  

  ```java
  //方法注释
  ```

#### 2、Live Templates（代码模板）

![image-20200613204144033](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20200613204144033.png)

或者在代码中使用快捷键 ctrl + j ，然后点击右下角的灯泡图标会出现Edit live templates settings，点击即可进入设置Live Templates。

然后点击右上角的加号选择Template Group新建自己的代码模板分组（也可以直接在原有分组中加，但最好新建分组避免混乱原有设置）custom，选中自己新建的分组，再点击加号选择Live Template即可添加代码模板。

![image-20200613205350974](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20200613205350974.png)

其中，Abbreviation（缩写）：即为代码模板缩写，触发生成代码模板内容的关键字。Description为模板描述。Template text模板代码内容，如下方的日志代码模板，其中可以使用$变量名$来定义变量，然后点击Edit Variables设置该变量对应的值，如所在类名、方法名、方法参数列表等。

```java
private static final Logger logger = LoggerFactory.getLogger($className$.class);
```

左下方如果存在警告：No applicable  contexts. 则需要点击define设置代码模板使用的上下文，即使用的代码类型范围，如Java。另外，还可以勾选Use static import if possible开启静态导入。

常见的设置还有单元测试方法模板如下图：

![image-20200615001903829](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20200615001903829.png)

- `test` 单元测试模板

  ```java
  @Test
  public void test$name$() {
      $END$
  }
  ```

- `list`

  ```java
  List<$String$> $END$ = new ArrayList<>();
  ```

- `map`

  ```java
  Map<String, $Object$> $END$ = new HashMap<>();
  ```

  

  

#### 3、File Templates（文件模板）

![image-20200614141724430](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20200614141724430.png)

或者在项目结构的任意目录上右键单击，选择new，然后选择Edit File Templates，即可进入设置。

如上图中添加Mapper.xml的模板，文件名为Mapper，后缀为xml，填入模板内容，其中新建文件后光标符所在位置为：#[[$namespace$]]#，#[[$END$]]#为最后停留的光标位置。另外需要勾上Enable Live Templates。

使用时直接在目录或包上右键单击，选择new，再选择文件模板的名称即可新建该文件。

## 7、后缀补全（Postfix Complation）

#### 1、变量创建

| 代码格式    | 说明                                                         |
| ----------- | ------------------------------------------------------------ |
| xxx.var     | 创建局部变量，如：new Person.var再回车相当于输入Person person = new Person(); |
| xxx.filed   | 创建全局变量                                                 |
| 类名.new    | 相当于new 类名()                                             |
| xxx.cast    | 类型强转，如：new Object().cast 再回车，填入要强转的类型Person，然后回车输入.var 再回车得到Person person = (Person) new Object(); |
| xxx.castvar | 类型强转+创建局部变量，如：new Object().castvar再回车输入要强转的类型Person，相当于输入Person person = (Person) new Object(); |

#### 2、类型判断

| 代码格式               | 说明       |
| ---------------------- | ---------- |
| xxx.null               | 判空       |
| xxx.notnull 或 xxx.nn  | 判非空     |
| 布尔类型或表达式.if    | if 判断    |
| 布尔类型或表达式.while | while 判断 |
| xxx.not                | 取反       |

#### 3、输出与返回

| 代码格式   | 说明    |
| ---------- | ------- |
| xxx.sout   | 输出xxx |
| xxx.return | 返回xxx |

#### 4、循环

| 代码格式 | 说明             |
| -------- | ---------------- |
| xxx.fori | 从小到大索引遍历 |
| xxx.forr | 从大到小索引遍历 |
| xxx.for  | 增强for循环      |

#### 5、异常捕获

| 代码格式 | 说明                                    |
| -------- | --------------------------------------- |
| xxx.try  | 捕获异常，如调用xxx方法，但需要捕获异常 |

#### 6、自定义Postfix Complation

![image-20200614221851405](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20200614221851405.png)

如上图，关键字为list，即使用xxx.list回车创建xxx类型的List集合，其中$EXPR$为.list前的表达式，$END$​为光标最后停留的位置。

```java
List<$END$> $EXPR$ =  new ArrayList<>();


Map<String, $END$> $EXPR$ = new HashMap<>();
```



## 8、Maven依赖自动提示

#### 1、自动提示

windows下：ctrl+alt+空格
mac下：ctrl+长按空格

#### 2、快速搜索

alt+insert，然后选择dependcy

## 9、Inject Language

### 1、构造JSON字符串

输入如下代码，将光标停留在字符串的双引号内

```java
String json = "";
```

然后按alt + 回车，选择Inject Language or reference。再选择json后回车，即可将该字符串标记成一个JSON字符串，再按alt + 回车可以添加注释，再按alt + 回车，选择Edit JSON Fragment则会打开JSOM编辑视图，可以再视图中直接书写原JSON格式的代码。注意：选择时可以直接输入字母快速选中要选的选项。

![image-20200615004433330](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20200615004433330.png)

按alt + 回车，选择Uninject Language or reference，则可以将该字符串的JSON标记取消。

### 2、构造HTML 字符串

构造HTML字符串的操作同上，只是将选择json的操作改成选择html。



## 10、Git相关操作

### 11.1 提交与回滚

已经 commit 但没 push ，撤销 commit 

- 方式一：

  

- 方式二：



多次commit 但没 push，想要合并 commit





已经 push，想要取消push

- 方式一：直接使用命令

  ① 获取想要回滚到的版本号：b10887366ef1b68e047e959265d8424a8686baab

  ② git reset --hard b10887366ef1b68e047e959265d8424a8686baab

  ③ git push -f

- 方式二：

  





























### 11.2 分支管理

https://www.cnblogs.com/java688/p/13373269.html







## 11、热部署

一个java web项目，在写的过程中我们需要不断调试，如果没有热部署，则我们每修改一次项目要重启一次，验证问题有没有得到解决。如果项目很小，启动只要几秒或十几秒，可能感觉影响不是很大；但当项目变大了，重启一次需要几十秒，几分钟，甚至十几分钟，每次修改后都需要重启无疑会严重影响我们的工作效率。

正常情况下，我们使用IDEA（或Eclipse等IDE)+tomcat部署web项目时，如果只是方法内部作修改或只是修改web页面，按Ctrl+shift+F9（Eclipse按Ctrl+S即可)重新编译，无须重新启动，即可使修改的代码生效，这对我们的开发调试有了很大的帮助。但当我们在java文件中增加方法，增加变量，修改配置文件等大部分操作时，都需要重启服务器，而Jrebel使绝大部分操作都不需要重启，只要重新编译即可将更新部署到服务器上，大大节省了我们工作花在重启服务器上的时间。

### 12.1 Jrebel

#### 安装与激活



<img src="../../images/image-20200912105804154.png" alt="image-20200912105804154" style="zoom:50%;" />

```
https://jrebel.qekang.com/3fc1c149-026f-4704-80c4-2b75a14d7b1a
```



#### 配置与使用

1、在左下角的窗口边栏中找到JRebel，点击进入设置面板，将每个模块都开启 Jrebel。只有开启了开关的模块才会被 jrebel 监听。

<img src="../../images/image-20200912102352200.png" alt="image-20200912102352200" style="zoom:50%;" />

2、启动项目时不再用原来的 Run 和 Debug ，改用 JRebel 的按钮启动，在原来的图标右边，火箭带虫子的图案就是 Debug

![image-20200912104019586](../../images/image-20200912104019586.png)

3、修改代码后，任何编译（编译项目、编译模块、重编译当前类）都会自动刷新 class，无需重启项目。

![image-20200912104325489](../../images/image-20200912104325489.png)

上图三种编译的区别：

- Build Project - 编译整个工程，增量编译，如果想强制重新编译选择最下方的 Rebuild Project
- Build Module - 编译焦点所在文件的模块，编译模块时只会编译本模块以及模块依赖的其他模块，如编译 svc 模块时会编译 api 模块但不会编译web 模块，增量编译
- Recompile ‘xx.java’ - 重编译当前类文件，只对当前类进行重新编译

开发过程中最常用的应该是Build Module，建议改快捷键为 ctrl+s（原来的保存快捷键并没有什么用，idea 是自动保存的），这样改完代码后 ctrl+s 一下就能触发编译，同时 jrebel 会自动热更新变动的代码（就像曾经的 Eclipse 自动编译的体验）

#### 问题

- WEB 项目启动 Jrebel 不生效

  WEB 默认采用了缓存，需要在WebApplication 的 jvm 启动参数里配置禁用缓存

  ```
  -Dorg.apache.tapestry.disable-caching=true
  ```

- 断网 Jrebel 就无法工作

  可以将 Jrebel 设置成离线模式：

  <img src="../../images/image-20200926002242448.png" alt="image-20200926002242448" style="zoom:50%;" />

- Jrebel 热加载不生效

  检查 Jrebel配置中是否将每个模块都开启了开关（上一章中有介绍），然后再检查各个模块下的 src/main/resources/rebel.xml 文件中的监听路径是否正确，很多同学由 gradle 切换到 idea 编译后各模块下的 rebel.xml 文件配置没有改，还是监听 gradle 的编译输出目录，导致 jrebel 失效

  <img src="../../images/image-20200912104604824.png" alt="image-20200912104604824" style="zoom:50%;" />



### 12.2 Spring Boot devtool







## 12、发布 Docker 镜像

### 1、Docker 开启远程访问

```bash
[root@izwz9eftauv7x69f5jvi96z docker]# vim /usr/lib/systemd/system/docker.service
#修改ExecStart这行
ExecStart=/usr/bin/dockerd  -H tcp://0.0.0.0:2375  -H unix:///var/run/docker.sock
#重新加载配置文件
[root@izwz9eftauv7x69f5jvi96z docker]# systemctl daemon-reload    
#重启服务
[root@izwz9eftauv7x69f5jvi96z docker]# systemctl restart docker.service 
#查看端口是否开启
[root@izwz9eftauv7x69f5jvi96z docker]# netstat -nlpt
#直接curl看是否生效
[root@izwz9eftauv7x69f5jvi96z docker]# curl http://127.0.0.1:2375/info
```

### 2、IDEA 安装 Docker 插件



### 3、启用 Docker

http://139.159.137.19:2375

![image-20210515031552134](../../images/image-20210515031552134.png)

### 4、SpringBoot 项目

- pom.xml 添加插件

  ```xml
  <build>
      <plugins>
          <plugin>
              <groupId>org.springframework.boot</groupId>
              <artifactId>spring-boot-maven-plugin</artifactId>
          </plugin>
          <plugin>
              <groupId>com.spotify</groupId>
              <artifactId>docker-maven-plugin</artifactId>
              <version>1.0.0</version>
              <configuration>
                  <imageName>${docker.image.prefix}/${project.artifactId</imageName>
                  <dockerDirectory></dockerDirectory>
                  <resources>
                      <resource>
                          <targetPath>/</targetPath>
                          <directory>${project.build.directory}</directory>
                          <include>${project.build.finalName}.jar</include>
                      </resource>
                  </resources>
              </configuration>
          </plugin>
      </plugins>
  </build>
  ```

- Dockerfile 文件：在工程根目录下新建Dockerfile文件

  ```bash
  #指定基础镜像，在其上进行定制
  FROM java:8
  
  #维护者信息
  MAINTAINER wuweixiang <wuweixiang.alex@gmail.com>
  
  #这里的 /tmp 目录就会在运行时自动挂载为匿名卷，任何向 /tmp 中写入的信息都不会记录进容器存储层
  VOLUME /tmp
  
  #复制上下文目录下的target/demo-1.0.0.jar 到容器里
  COPY target/demo-1.0.0.jar demo-1.0.0.jar
  
  #bash方式执行，使demo-1.0.0.jar可访问
  #RUN新建立一层，在其上执行这些命令，执行结束后， commit 这一层的修改，构成新的镜像。
  RUN bash -c "touch /demo-1.0.0.jar"
  
  #声明运行时容器提供服务端口，这只是一个声明，在运行时并不会因为这个声明应用就会开启这个端口的服务
  EXPOSE 8080
  
  #指定容器启动程序及参数   <ENTRYPOINT> "<CMD>"
  ENTRYPOINT ["java","-jar","demo-1.0.0.jar"]
  ```

- 创建docker

  ![image-20210521134123806](../../images/image-20210521134123806.png)

- sfas 

  ![image-20210521134228727](../../images/image-20210521134228727.png)

![image-20210529180028465](../../images/image-20210529180028465.png)





## 13、IDEA-HTTP 工具

### 1、 简介

开发时，经常需要调试接口，可能会使用`Swagger`、`postman` 等工具，其实在 IDEA 中，也提供了一个类似 VS Code 的`Rest-client`的工具，通过这个工具我们可以完成绝大部分http请求，是一个不错的`postman`替代工具。

### 2、使用方式

- 方式一：Controller 请求中打开，会直接生成 http 请求文件

  ![image-20210616145916896](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20210616145916896.png)

- 方式二：菜单栏 Tools -> HTTP Client

  其中：Convert cURL to HTTP Request 还可以将 curl 方式的请求转换为 IDEA HTTP 工具的请求。

- 方式三：手动新建 .http 文件

  ![image-20210616152738890](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20210616152738890.png)

### 3、 请求命令编写

#### 3.1 基本格式

```bash
请求方式 地址
header部分，key=value格式，每个一行

参数部分(注意这个上面要有个空行)
```

- 参考案例

  ![image-20210616151133570](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20210616151133570.png)

- 自动生成

  ![image-20210616151210719](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20210616151210719.png)

#### 3.2 Get 请求

``` bash
### GET 请求（设置了一个Header）
GET https://httpbin.org/ip
Accept: application/json

### 带参数 GET 请求
GET https://httpbin.org/get?show_env=1
Accept: application/json
```

#### 3.3 Post 请求

```bash
### body 参数的 POST 请求
POST http://localhost:8090/post
Content-Type: application/json

{
  "id": 999,
  "value": "content"
}

### Send POST request with body as parameters
POST http://localhost:8090/post
Content-Type: application/x-www-form-urlencoded

id=999&value=content
```

#### 3.4 文件上传

- 上传接口

  ```java
  //模拟多文件上传，顺便带上表单数据
  @PostMapping("/upload")
  public Map upload(@RequestParam("file1") MultipartFile file1,
                                    @RequestParam("file2") MultipartFile file2,
                                    User user,
                                    HttpServletRequest request) {
      // 业务代码
  }
  ```

- 对应 http 请求 

  ```java
  ### 多文件上传文件接口测试
  POST http://localhost:8090/upload
  Content-Type: multipart/form-data; boundary=WebAppBoundary
  
  --WebAppBoundary
  Content-Disposition: form-data; name="file1"; filename="pic_1.jpeg"
  
  < C:\Users\Mr.X\Desktop\1.jpg
  --WebAppBoundary--
  
  --WebAppBoundary
  Content-Disposition: form-data; name="file2"; filename="pic_2.jpeg"
  
  < C:\Users\Mr.X\Desktop\2.jpg
  --WebAppBoundary--
  
  --WebAppBoundary
  Content-Disposition: form-data; name=accountName
  
  1001007
  --WebAppBoundary--
  
  --WebAppBoundary
  Content-Disposition: form-data; name=password
  
  123456
  --WebAppBoundary--
  ```

  这个请求可以想像成页面中的一个表单，表单有 4 个元素：2 个 File 元素，用来选择需要上传的 2 个文件，2 个输入框，分别用来输入 accountName 和 password。请求中需要用--WebAppBoundary 来隔离每个元素，如果有多个元素，都需要用--WebAppBoundary 隔离开来。

#### 3.5  文件下载

​	可以请求成功，看到响应信息，但是没法下载文件（Swagger、postman 也不行，貌似只能从浏览器中前端页面中操作 ）。

### 4、自定义环境变量和参数

- 添加配置文件

  ![image-20210616151826266](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20210616151826266.png)

  ![image-20210616152427414](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20210616152427414.png)

- 配置文件格式

  ```json
  {
    "dev": {
      "url": "http://localhost:8090",
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJBUFAiLCJpc3MiOiJTZXJ2aWNlIiwiaWQiOiIxMzk4MTA5OTI5MjY4NTgwMzUzIiwiZXhwIjoxNjIzODI3NzAxLCJpYXQiOjE2MjM4MjY1MDF9.uldjwsrIZbEsuSJ05e7SPlMAnzv_pa3VT0maNwz2Dv4"
    },
    "test": {
      "url": "xxx.xxx.xxx.xx:8090",
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJBUFAiLCJpc3MiOiJTZXJ2aWNlIiwiaWQiOiIxMzk4MTA5OTI5MjY4NTgwMzUzIiwiZXhwIjoxNjIzODI3NzAxLCJpYXQiOjE2MjM4MjY1MDF9.uldjwsrIZbEsuSJ05e7SPlMAnzv_pa3VT0maNwz2Dv4"
    }
  }
  ```

- 使用

  ![image-20210616152208952](https://cdn.jsdelivr.net/gh/yunzike/notes/images/image-20210616152208952.png)







## 14、EasyCode

### juse

- entity

  ```java
  $!init
  
  ##引入宏定义
  $!define
  
  ##使用宏定义设置回调（保存位置与文件后缀）
  #save("/model", ".java")
  
  ##使用宏定义设置包后缀
  #setPackageSuffix("model")
  
  ##使用全局变量实现默认包导入
  $!autoImport
  import java.io.Serializable;
  import com.baomidou.mybatisplus.annotation.*;
  import com.baomidou.mybatisplus.extension.activerecord.Model;
  import lombok.Data;
  import lombok.EqualsAndHashCode;
  import lombok.experimental.Accessors;
  
  ##使用宏定义实现类注释信息
  #tableComment("实体类")
  @Data
  @EqualsAndHashCode(callSuper = false)
  @Accessors(chain = true)
  @TableName("$!{tableInfo.obj.name}")
  public class $!{tableInfo.name} extends Model<$!{tableInfo.name}> {
  
      private static final long serialVersionUID = 1L;
  
  #foreach($column in $tableInfo.fullColumn)
      #if(${column.comment})/**
      * ${column.comment}
      */#end
      #if(${column.name}=="id")
      @TableId(value = "id", type = IdType.AUTO)
      #elseif(${column.name}=="createTime")
      @TableField(value = "create_time",fill = FieldFill.INSERT)
      #elseif(${column.name}=="updateTime")
      @TableField(value = "update_time",fill = FieldFill.UPDATE)
      #end
      private $!{tool.getClsNameByFullName($column.type)} $!{column.name};
      
  #end
      @Override
      protected Serializable pkVal() {
          return this.id;
      }
  
  }
  ```

  















