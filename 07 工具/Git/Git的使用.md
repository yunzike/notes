Git是目前世界上最先进的分布式版本控制系统。工作原理图如下图所示：
![](https://ws4.sinaimg.cn/large/006tNc79gy1fzcduerjn8j31f20k6n2w.jpg)

##### SVN与Git的最主要的区别
SVN是集中式版本控制系统，版本库是集中放在中央服务器的，而干活的时候，用的都是自己的电脑，所以首先要从中央服务器哪里得到最新的版本，然后干活，干完后，需要把自己做完的活推送到中央服务器。集中式版本控制系统是必须联网才能工作，如果在局域网还可以，带宽够大，速度够快，如果在互联网下，如果网速慢的话，就纳闷了。

Git是分布式版本控制系统，那么它就没有中央服务器的，每个人的电脑就是一个完整的版本库，这样，工作的时候就不需要联网了，因为版本都是在自己的电脑上。既然每个人的电脑都有一个完整的版本库，那多个人如何协作呢？比如说自己在电脑上改了文件A，其他人也在电脑上改了文件A，这时，你们两之间只需把各自的修改推送给对方，就可以互相看到对方的修改了。
##### 安装配置Git
````java
//首先官网下载安装

//然后设值用户名和邮箱作为Git标识
git config --global user.name "yunzike"
git config --global user.email "1154680537@qq.com"
````

#### 一、创建repository本地仓库（版本库）
````java
//进入本地仓库根目录下使用git init命令，会在本地仓库目录下生成一个.git文件
//用于跟踪管理版本
git init
````

#### 二、添加修改到Stage暂存区
````java
//暂存指定的修改过的文件
git add + 文件名
或者
//暂存所有修改
git add .
````

#### 三、提交到本地仓库
````java
//提交暂存区的文件到本地仓库
git commit -m "提交说明"

<!--其他相关操作-->
//查看未提交到本地仓库的所有暂存修改
git status
//比较差异
git diff + 文件名
````

#### 四、推到远程仓库
````java
 //创建本地仓库秘钥文件
 ssh-keygen -t rsa –C "1154680537@qq.com"
````
#### 一、创建远程空仓库后提交关联本地仓库
````
git add .  //提交到暂存区
git remote add origin https://github.com/yunzike/mywork.git
git push -u origin master //输入用户名和密码
````

#### 二、拷贝远程仓库到本地
````
//git clone + 远程仓库clone URL
git clone master https://github.com/yunzike/yunzike.git
````
要想拷贝到指定目录，可以先进入目录再执行命令

#### 三、提交本地代码到远程仓库
````
进入本地仓库目录下

“git add .”命令。这里的”.”表示将当前目录下所有改动的文件夹及文件添加到版本管理器

执行git commit -m "First commit"命令，提交到本地的版本控制库里，引号里面是你对本次提交的说明信息。

执行” git push origin master“命令将本地仓库提交到远程的GitHub中，这里会用到注册的用户名和密码。输入密码的时候默认是没有任何提示符。
````


#### 四、git全局密码设置
````
//设置用户名和邮箱后，首次输入账号密码后便会存储
git config --global user.name "xiongxiaoqi"

git config --global user.email "1154680537@qq.com"
````



#### 五、修改分支名称

```bash
# Rename branch locally 
git branch -m old_branch new_branch 

# Delete the old branch 
git push origin :old_branch 

# Push the new branch, set local branch to track the new remote
git push --set-upstream origin new_branch 
```

