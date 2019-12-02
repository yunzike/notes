---
title: git命令  
date: 2019-01-25 10:00:29  
categories: 开发工具   
tags:  
 - git
---
初始化（任一文件夹目录下执行该命令，则该文件夹加入到git仓库管理）
````
git init
````
添加本地改动文件到缓存区
````
指定文件：git add [file name]
所有改动文件：git add .
````
查看本地仓库状态（是否有新文件、缓存区状态、是否有新提交等，加-s参数为查看简短描述）
````
git status [-s]
````
使用git diff 来查看执行 git status 的结果的详细信息
````
尚未缓存的改动：git diff
已缓存的改动：git diff -cached
未缓存和已缓存的所有改动：git diff -HEAD
显示改动摘要：git diff -stat
````
将缓存区中的改动提交到本地仓库中
````
git commit -m "注释"
````
取消已缓存的内容
````
git reset HEAD  
取消指定缓存：git reset HEAD [file name]
````
将文件从仓库跟踪清单中删除
````
git rm [file name]
强制删除:git rm -f [file name] 
仅从跟踪清单中删除:git rm --cached [file name]
````
克隆远程项目到本地（默认是master分支）
````
git clone [remote repository address]
````
克隆远程项目指定分支到本地
````
git clone -b [branch name] [remote repository address]
````
