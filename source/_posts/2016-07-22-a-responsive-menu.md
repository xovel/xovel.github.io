---
title: 一个自适应菜单导航的设计实现过程
date: 2016-07-22 09:29:18
tags: [css, responsive, menu, 设计, 横向滚动, 媒体查询, 弹性布局]
categories: [随笔]
---

实现的需求如下：在屏幕宽度较小时，菜单为横向可滑动；屏幕较宽时则变为拉伸充满整屏。知识点：`横向滚动`，`媒体查询`，`弹性布局`。

<!-- more -->

乍一看这个需求，显得有点奇特瑰丽，但作为一个前端工程师，是可以想出各种方案来进行实现的。下面就详细讲述一下实现的过程。

首先，我们搭建一个菜单的结构代码如下：

```html
<div class="nav-menu">
  <div class="nav-item">菜单1</div>
  <div class="nav-item">菜单2</div>
  <div class="nav-item">菜单3</div>
  <div class="nav-item">菜单4</div>
  <div class="nav-item">菜单5</div>
  <div class="nav-item">菜单6</div>
  <div class="nav-item">菜单7</div>
  <div class="nav-item">菜单8</div>
</div>
```

当然，也可以使用`<ul><li>...</li></ul>`的方式。这里我们采用`div`实现子菜单，避免`ul`/`li`的自带的样式影响效果。

接着，**横向滚动**效果的设计与实现。这里分为横向和滚动效果两个。

关于横向布局，网络上有大量的示例参考，使用`float`，`绝对定位`，`inline`，`inline-block`。*如果直接使用的子元素就是行内元素，则无须考虑横向的问题。*

这里采用`inline-block`的方式进行实现：`.nav-item{display: inline-block;}`。

至于滚动效果，需要在父容器上面进行实现，具体方式为：`.nav-menu{overflow: hidden; overflow-x: scroll;white-space: nowrap;}`

注意：**`white-space: nowrap;`**指定元素在同一行内进行显示。更多信息请参考[white-space - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/white-space)。

> 滚动条可以隐藏起来，其语法为`::-webkit-scrollbar{display:none;}`。*在Webkit内核浏览器下有效。*

接下来，就是自适应功能的体现了。所使用到的核心技术：`媒体查询`和`弹性布局`。

根据需求，在屏幕较小时，菜单为横向滚动，屏幕较大则自适应拉伸。这里就有一个临界值了，那么到底是多大的屏幕才去应用自适应布局呢？这个值是**事先预定**的。比如这里我们设计了8个菜单项目，经过计算，这8个菜单的长度约摸为`440px`，我们就用`440px`作为划分临界值进行自适应布局的设计实现。

CSS3提供了一个叫做`Media Query`——翻译过来叫做`媒体查询`——的高级功能。关于媒体查询的详细资料，请参考[Media queries - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/Media_Queries)。

css代码中我们于是就将自适应效果的代码写成这个样子：

```css
@media (min-width: 440px) {
  ...
} 
```

里面的`min-width: 440px`表示花括号里面的代码将在屏幕宽度最小值超过440px时生效。于是，接下来就只剩下一件事情了：拉伸的自适应效果实现。

参考了一下CSS自适应布局，关于自动拉伸的方式，方法众多，比如`table`、`百分比`、`弹性布局`等等。这里我们就使用`弹性布局`进行实现。关于弹性布局的说明，近期本人会整理一篇文章专门进行解读。

> 2016.7.28，文章整理完成，敬请参阅：[初识Flex布局](/article/css-flex.html)。

具体代码如下：

```css
@media (min-width: 440px) {
  .nav-menu{ display: -webkit-flex; display: flex; justify-content: space-around; }
} 
```

`justify-content: space-around;`指定了元素之间的留白方式为等距离并且两边有留白。

那么，这个菜单我们就设计实现完毕了。完整代码如下：

```html
<style type="text/css">
body{ background: #282828; margin:0; font-family:'San Francisco','Noto SansCJK','Microsoft Yahei';}

.nav-menu{ height: 40px; line-height: 40px;overflow: hidden; overflow-x: scroll;white-space: nowrap; background: #333; margin-top: 10px;}
.nav-menu::-webkit-scrollbar{display:none;}
.nav-item{display: inline-block; height: 38px; margin:0 5px; overflow: hidden;text-align: center;color: white;}

@media (min-width: 440px) {
  .nav-menu{ display: -webkit-flex; display: flex; justify-content: space-around; }
}
</style>

<div class="nav-menu">
  <div class="nav-item">菜单1</div>
  <div class="nav-item">菜单2</div>
  <div class="nav-item">菜单3</div>
  <div class="nav-item">菜单4</div>
  <div class="nav-item">菜单5</div>
  <div class="nav-item">菜单6</div>
  <div class="nav-item">菜单7</div>
  <div class="nav-item">菜单8</div>
</div>
```

演示：[一个自适应菜单导航页面](/garden/demo/a-responsive-menu.html)

------
~~打完收工~~

