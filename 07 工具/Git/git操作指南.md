### 一、概述

- git原理

  git原理介绍

- SVN与Git的最主要的区别

  SVN是集中式版本控制系统，版本库是集中放在中央服务器的，而干活的时候，用的都是自己的电脑，所以首先要从中央服务器哪里得到最新的版本，然后干活，干完后，需要把自己做完的活推送到中央服务器。集中式版本控制系统是必须联网才能工作，如果在局域网还可以，带宽够大，速度够快，如果在互联网下，如果网速慢的话，就纳闷了。

  Git是分布式版本控制系统，那么它就没有中央服务器的，每个人的电脑就是一个完整的版本库，这样，工作的时候就不需要联网了，因为版本都是在自己的电脑上。既然每个人的电脑都有一个完整的版本库，那多个人如何协作呢？比如说自己在电脑上改了文件A，其他人也在电脑上改了文件A，这时，你们两之间只需把各自的修改推送给对方，就可以互相看到对方的修改了。

### 二 、基本使用

#### 1、安装并配置用户名和邮箱

```bash
//首先官网下载安装，然后设值用户名和邮箱作为Git标识
git config --global user.name "yunzike"
git config --global user.email "1154680537@qq.com"
```

#### 2、初始化本地git仓库

````bash
//进入本地仓库根目录下使用git init命令，会在本地仓库目录下生成一个.git文件
git init
````

#### 3、添加修改到Stage暂存区

````bash
//暂存指定的修改过的文件
git add + 文件名
//暂存所有修改
git add .
````

#### 4、提交到本地仓库

````java
//提交暂存区的文件到本地仓库
git commit -m "提交说明"

<!--其他相关操作-->
//查看未提交到本地仓库的所有暂存修改
git status
//比较差异
git diff + 文件名
````

#### 5、推送到远程仓库

````bash
git push

//新创建的本地仓库需要先关联到远程仓库的一个分支,并且push时要指定分支
git remote add origin https://github.com/yunzike/mywork.git
git push -u origin master //输入用户名和密码
````
#### 6、拷贝远程仓库到本地

````bash
//git clone -b + 分支名 + 远程仓库clone URL,要想拷贝到指定目录，可以先进入目录再执行命令
git clone -b master https://github.com/yunzike/yunzike.git
````
### 三、常用操作

#### 修改分支名称

```bash
# Rename branch locally 
git branch -m old_branch new_branch 

# Delete the old branch 
git push origin :old_branch 

# Push the new branch, set local branch to track the new remote
git push --set-upstream origin new_branch
```

#### 查看本地仓库状态

```bash
//是否有新文件、缓存区状态、是否有新提交等，加-s参数为查看简短描述
git status [-s]
```

#### 查看改动详细信息

```bash
尚未缓存的改动：git diff
已缓存的改动：git diff -cached
未缓存和已缓存的所有改动：git diff -HEAD
显示改动摘要：git diff -stat
```

#### 取消已缓存的内容

```bash
git reset HEAD  
取消指定缓存：git reset HEAD [file name]
```

#### 将文件从仓库跟踪清单中删除

```bash
git rm [file name]
强制删除:git rm -f [file name] 
仅从跟踪清单中删除:git rm --cached [file name]
```

#### 提交合并到其他分支

```bash
//将develop的修改提交到master分支
//在develop分支，查找需要合并的commit记录的commitID
git log
//切换到master分支，使用git cherry-pikc将该条commit记录合并到了本地的master分支
git cherry-pick commitID
//提交到master分支远程仓库
git push
```

