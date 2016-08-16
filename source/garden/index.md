---
title: 花园/竹林 - 自定义
comments: false
keywords: 作品,设计,自定义
description: 这里存放一些自己设计过的页面，仅此而已。

bamboo: h3
number: true
liststyle: circle
---

**这里存放一些自己设计过的页面，仅此而已。**

------

### [宇成朝阳广场页面](demo/plaza-cy)

- 全屏滚屏方式，引用[fullpage](https://github.com/powy1993/fullpage)
- 自定义动画，翻屏提示条、翻屏时的特效、播放音乐时的无限旋转等
- 首屏自动播放的`slide`
- 播放音频。BGM为`7AND5`的作品`A is A`，版权归原作者所有。*该文件进行过压缩，码率降低为32kbps。*
- 侧边栏导航：上一屏、下一屏、目录

> 之前的宇成朝阳广场手机端页面重构而来。
> 调用的fullpage有坑：在移动端开启触摸滚屏功能时内容超出部分不可自动滚动查看，链接无法愉快的点击触发。详情可自行前往github页面搜索issue。
> 修正方案：取消触摸功能；引入jQuery的swipe事件类库监听触屏滑动事件；在内容超出的滚屏页面，加入一个“查看更多”，点击后提取内容并进行覆盖弹出。
> 引用的两个jQuery插件分别为[jquery.event.move](https://github.com/stephband/jquery.event.move)和[jquery.event.swipe](https://github.com/stephband/jquery.event.swipe)
> 如果你需要更加完善的滚动效果，请使用[Alvaro Trigo](https://github.com/alvarotrigo)编写的功能强大的[fullPage.js](https://github.com/alvarotrigo/fullPage.js)进行替代。

**该demo页面仅作演示，严禁转载，其内图片与文字有版权，请勿盗用。**

------

### [图片转Base64编码工具](tool/img2base64.html)

- 使用了[URL](https://developer.mozilla.org/en-US/docs/Web/API/URL)对象和[FileReader](https://developer.mozilla.org/en-US/docs/Web/API/FileReader)对象。
- 支持图片文件的编码
- 实时预览图片
- 计算图片的大小

------

### [风华60年投票活动分类入口](demo/fh60-category.html)

- 背景图片自适应宽高。*顶部与底部有固定模块*
- `nth-child`伪类的使用。
- `tranform:ratote`实现返回的尖角小箭头。
- 主背景图图片仅作测试，经过高强度压缩。

------

### [一个错视的旋转动画](demo/animation-optical-illusion.html)

通过一组直线动画营造一种旋转动画的错视。~~雄兔脚扑朔，雌兔眼迷离。双兔傍地走，安能辨我是雄雌。~~本示例仅作演示，请使用现代浏览器访问~~部分浏览器可能会有兼容性问题~~。可点击演示界面的`错视演示`按钮观看演示。

------

### [一个自适应菜单导航页面](demo/a-responsive-menu.html)

实现的需求如下：在屏幕宽度较小时，菜单为横向可滑动；屏幕较宽时则变为拉伸充满整屏。知识点：`横向滚动`，`媒体查询`，`弹性布局`。详细说明请访问[一个自适应菜单导航页面](/article/a-responsive-menu.html)。

### [移动端下拉刷新操作](demo/pull-refresh.html)

没什么好解释的，原生JS实现的下拉刷新操作插件。`No dependency`。项目地址：[PullRefresh](https://github.com/xovel/PullRefresh)



