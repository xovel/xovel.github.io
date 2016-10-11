---
title: 关于undefined与void 0
date: 2016-10-11 15:37:16
tags: [undefined, void]
categories: [WEB, JS]
description: 简单介绍一下undefined与void 0。
---

在JS的通用语法里面，undefined表示未定义。更多资料可以查阅MDN文章：[undefined](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/undefined)

在ES5之前，window下的`undefined`是可以被**重写**的，于是导致了某些极端情况下使用undefined会出现一定的差错。

`void 0`的返回值均是`undefined`，这个是实实在在的undefined。

> 事实上，`void`的返回值都是`undefined`。

> The void operator evaluates the given expression and then returns undefined. [void operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/void)

那么，在某些地方我们看到的`void 0`究竟是什么情况呢？

总结了一下，有一下两个主要原因：

- 防止`undefined`被重写，导致判断不准确。
- 便于压缩。~~论字节长度，void 0果断胜出~~

> 事实上，有很多代码压缩工具会将`undefined`改写为`void 0`。~~黑科技~~

当初我在构建本人的JS类库的时候也采用了void的方式，具体代码可参阅[xovel/qslinz](https://github.com/xovel/qslinz/blob/v0.1.3/QsLinz.0.1.3.js#L341)。

-------

有一个更加黑科技的undefined使用方法，相信很多人都知道jQuery的代码曾经有过这样的书写方式：

```js
(function(window, undefined){
  // ...
})(window)
```
其用意也很明显，直接指定undefined的值。在压缩之后代码变为：

```js
(function(e,t){
  // ...
})(window)
```

ES5之后的标准中，规定了全局变量下的undefined值为只读，不可改写的，但是局部变量中依然可以对之进行改写。jQuery直接指定`undefined`为undefined。



