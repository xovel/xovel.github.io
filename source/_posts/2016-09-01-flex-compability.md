---
title: 弹性布局的兼容性问题
date: 2016-09-01 17:15:31
tags: [css, flex, 兼容]
categories: [WEB, CSS]
---

由于弹性布局方案，各大浏览器厂商跟进的进度不一致，导致了某些情况下，弹性布局方案的css会出现不兼容的情形。尤其是在安卓平台上的部分浏览器（如UC浏览器，微信浏览器）出现弹性布局效果失效的情形。本文针对弹性布局方案的兼容性做一个简短的处理。

<!--more-->

关于弹性布局方案，本博客有文章介绍：[初识Flex布局](/article/css-flex.html)。

在应用弹性布局方案的父元素上，要做兼容性调整，需要在使用`display: flex`加上`display:-webkit-flex`，部分浏览器可能需要添加`display:-webkit-box`才会奏效。

弹性项目（子元素）使用`flex:1`这样的效果时，加上`-webkit-flex:1`，为了兼容某些浏览器，需要添加`-webkit-box-flex:1`。

其他属性的兼容性对应列表：

- `align-items`，对应`-webkit-box-align`
- `flex-direction`，对应`-webkit-box-orient-`/`box-orient`
- `justify-content`，对应`-webkit-box-pack`
- `order`，对应`-webkit-box-ordinal-group`

**参考资料**
- [Flex布局新旧混合写法详解（兼容微信）](http://www.ccwebsite.com/flex-layout-old-and-new-compatible/)
- [解决UC浏览器、微信浏览器使用display:flex;的兼容性问题](http://www.sheng00.com/2148.html)
- [伸缩盒(Flexible Box)(旧)](http://css.doyoe.com/properties/flexible-box/index.htm)