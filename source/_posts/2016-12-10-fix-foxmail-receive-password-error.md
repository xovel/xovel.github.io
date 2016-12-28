---
title: Foxmail接收密码错误的处理
tags: [foxmail, 接收密码, 邮箱, SMTP, IMAP, 授权码]
categories: [随笔]
date: 2016-12-10 15:43:49
description: 
---

最近在使用Foxmail邮箱的时候出现了一个问题，在接收邮件的时候会弹出一个提示框，说密码错误。

<!--more-->

![](http://ww3.sinaimg.cn/large/79be2309gw1falr9xhz16j20du09qglx.jpg)

~~一开始我还真以为是密码错误了，~~修改了密码，再去登录，依然有这个提示。

打开搜索引擎搜了一下，发现有这个问题的人并不是只有我一个，看了几篇文章之后发现，竟然是跟一个叫`IMAP`的东西有关的。

> `IMAP`，即**I**nternet **M**essage **A**ccess **P**rotocol（互联网邮件访问协议），您可以通过这种协议从邮件服务器上获取邮件的信息、下载邮件等。IMAP与POP类似，都是一种邮件获取协议。

参考信息来自于：[QQ邮箱帮助中心](http://service.mail.qq.com/cgi-bin/help?subtype=1&&id=28&&no=331)

不管它的目的是什么，总归是为了安全方面的问题，必须要支持。

> 其实在弹出的提示框中有链接，里面就是解决办法，我是舍近求远了。[什么是授权码，它又是如何设置？_QQ邮箱帮助中心](http://service.mail.qq.com/cgi-bin/help?subtype=1&&id=28&&no=1001256)

那么，问题出现了应该怎么去解决呢？

设置这个密码并填写进那个提示框即可，详细步骤如下：

> 我用的是QQ邮箱，这里演示以这个为准，其他邮箱的操作应该是类似的。

首先，登录网页版邮箱，在**帐户设置**相关的页面中，找到`POP3/IMAP/SMTP/Exchange/CardDAV/CalDAV服务`一项，如图：

![](http://ww2.sinaimg.cn/large/79be2309gw1falr9xzlk5j20qk092aas.jpg)

开启`IMAP/SMTP服务`，会要求一个验证：

![](http://ww4.sinaimg.cn/large/79be2309gw1falr9ygetoj20f70adaa6.jpg)

验证一下即可，验证通过后会给出一个验证码：

![](http://ww1.sinaimg.cn/large/79be2309gw1falr9ygsi5j20hv0baq3c.jpg)

将这个验证码输入到Foxmail弹出的那个提示对话框中，确认即可。

![](http://ww3.sinaimg.cn/large/79be2309gw1falr9yygc1j20g506taa2.jpg)

关于`IMAP`和`POP3`的区别，在[QQ邮箱的帮助文档](http://service.mail.qq.com/cgi-bin/help?subtype=1&&id=28&&no=331)中有详细介绍，这里就不赘述了。

----

> 1. 截图看起来有点不对劲，可能是`win10`系统的缘故吧。
> 2. Foxmail的那张截图，中间有乱码，应该是系统编码冲突的原因，暂时不去深究了。

----

本文完。
