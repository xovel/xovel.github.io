---
title: GIT使用札记
date: 2016-07-27 11:19:05
tags: [git, notes, github]
categories: [随笔]
---

记录一下使用Git过程的一些不大不小的问题。不算全面，只是记录，详细的Git使用教程请参阅下方的参考资料。

<!--more-->

### 创建SSH Key

使用Git时，本地的Git仓库与远程Git仓库（比如Github）之间的传输是通过SSH加密的，故此需要创建一个SSH Key，在`Shell`/`Git Bash`中输入：

```text
$ ssh-keygen -t rsa -C "youremail@example.com"
```

`youremail@example.com`是你的邮件地址，然后回车。`passphrase`是本地密码，如有需要可以进行设置。

创建成功之后的加密文件放在用户主目录下的`.ssh`目录下，里面有两个密钥文件：`id_rsa`和`id_rsa.pub`。前者是私钥，后者是公钥。远程仓库需要添加公钥到账户中。

> 设置邮箱和用户名：
> - `git config --global user.name [username]`
> - `git config --global user.email [email]`

### 解决冲突

如果本地仓库跟远程仓库对同一个地方都进行了修改，在合并时，系统无法自动判断要选用哪一个修改，于是就出现了冲突。在提交时必须先解决冲突。

修改本地仓库，如果有多个冲突的地方，每一个都需要修改。

### 撤销修改

`git checkout -- <file>...`丢弃工作区的修改。

如果状态已经被缓存，即将提交，可以使用`git reset HEAD file`命令把暂存区的修改撤销掉，重新放回工作区。再使用上面的方法撤销修改。

如果已经提交当前修改到本地仓库，使用版本回退功能，退回到之前的版本即可，命令为`git reset --hard commit_id`，其中`commit_id`如果不知道，可以使用`git reflog`查看命令行的历史记录。`git log`可以查看提交历史。

如果你已经提交到远程库……阿弥陀佛，请自行珍重。

### 参考资料

- [GitHub](https://github.com/)
- [Git](https://git-scm.com/)
- [Git教程 - 廖雪峰的官方网站](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/)
- [图解Git](http://marklodato.github.io/visual-git-guide/index-zh-cn.html)
- [Git 参考手册](http://gitref.justjavac.com/)
- [猴子都能懂的GIT入门](http://backlogtool.com/git-guide/cn/)
