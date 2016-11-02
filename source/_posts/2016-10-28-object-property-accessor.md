---
title: 对象属性访问的两种方式
tags: [object, property, method]
categories: [开发]
date: 2016-10-28 11:24:05
---

在JS中，对象的访问方式通常有两种，本文将对其做一个简单的介绍。

<!--more-->

这两种方式一种是带点号`.`的访问方式，另一种是以方括号`[...]`的方式进行属性访问。

    object.property
    object["property"]

这两种属性访问方式效果等同。

这两种不同的方式的差异性如下：

1. 点号`.`能访问对象的属性的名称必须是严格的JS识别符。这个识别符的具体要求跟变量名类似。
2. 方括号`[]`可以访问包含标准属性在内的一切属性。

~~可以简单粗暴的认为点号的访问方式是方括号访问方式的一种语法糖~~

数字的点号属性访问不能直接跟在后面，需要使用如下方式进行访问：

```js
77 .toExponential();
// or
77
.toExponential();
// or
(77).toExponential();
// or
77..toExponential();
// or
77.0.toExponential();
// because 77. === 77.0, no ambiguity :p
```

方括号可以访问特殊的属性，如可以使用`arr[1]`可以访问到数组arr的第二个下标的值，但是不能使用`arr.1`这种方式。

一些非常规的属性诸如`1$`、`+66`、`.233`，需要使用方括号的形式去访问。

```blockquote 链接 https://github.com/jquery/jquery/blob/1.12-stable/src/selector-sizzle.js#L8
阅读过`jQuery`源码的人，应该都见识过`Sizzle`的`Expr`对象，里面有类似的访问方式：`jQuery.expr[ ":" ] = jQuery.expr.pseudos;`
```

参考资料：[Property accessors - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Property_Accessors)

