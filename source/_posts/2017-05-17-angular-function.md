---
title: angular函数组件简介
tags: [angular, function, components, angularjs]
categories: [WEB, JS]
date: 2017-05-17 22:20:40
description: 本文为针对AngularJS中的自带的函数组件的简要介绍。
---

本人前段时间对`angular`进行了一定程度的了解，`angular`系列的博文就从本篇开始吧。本文就对其提供的函数组件做一个入门级的介绍。大部分文档直接翻译自官方文档：[Function components in ng](https://docs.angularjs.org/api/ng/function)。

> 阅读本文需要一定的`jQuery`基础。

在函数组件中，`angular`提供了许多方便使用的功能，下面我将按照官方文档的顺序一一做介绍。

### angular.forEach

遍历数组或对象。功能类似[`jQuery.each`](http://api.jquery.com/each/)。不同的是`angular.forEach`支持传入一个上下文作为第三个参数：`angular.forEach(obj, iterator, [context]);`。

### angular.extend

扩展对象。功能类似`jQuery.extend`，不过这里是个浅复制。

### angular.merge

合并对象，深度合并，可以视为深复制。

### angular.noop

空操作，即：`function () {}`。

### angular.identity

返回第一个参数本身，用于函数式编程。

### angular.isUndefined

判断参数是否为`undefined`。

### angular.isDefined

判断参数是否被定义过，与`angular.isUndefined`的结果相反。

### angular.isObject

判断参数是否为对象。

> 不同于`typeof`，`null`将被视为非对象，数组视为对象。

### angular.isString

判断参数是否为字符串。

### angular.isNumber

判断参数是否为数组，包括`NaN`、`+Infinity`以及`-Infinity`。

### angular.isDate

判断参数是否是一个日期对象。

### angular.isArray

`Array.isArray`的别名，判断是否为数组。

### angular.isFunction

判断是否为函数。

### angular.isElement

判断是否为`DOM`元素或者`jQuery`元素。

### angular.copy

复制对象或数组，深复制。

### angular.equals

判断两个参数是否相等。

符合以下条件之一的均视为相等：

- 通过严格等于`===`的判断
- 对象的类型一样并且其所有属性通过`angular.equals`判断均相等
- 两者均为`NaN`
- 两者为正则表达式，并且其表达式相等

### angular.bind

对函数进行绑定对象。`angular.bind`的参数形式类似函数的`call`方法。

通常用于偏函数和柯里化。

### angular.toJson

转为`JSON`风格的字符串。这个过程可以称之为序列化。

### angular.fromJson

将一个`JSON`字符串还原，即反序列化。

### angular.bootstrap

手动启动`AngularJS`的应用程序。

### angular.reloadWithDebugInfo

以调试模式重载当前的应用程序。

### angular.injector

注入器的声明与使用。详情可参阅：[dependency injection](https://docs.angularjs.org/guide/di)

### angular.element

以`jQuery`风格包裹`DOM`元素或者`HTML String`。如果未引入`jQuery`，则采用`angular`自带的`jqLite`简化版。`jqLite`提供常见的`jQuery API`，可以满足大部分的情况。

### angular.module

`angular`的核心，用于声明或者获取模块。

### angular.errorHandlingConfig

错误处理的配置。

*******

至此，`angular`自带的函数组件就梳理完毕了。更多详细的介绍，就请诸君自行查阅相关文档了。

接下来的空余时间里面，将会逐步针对`angular`里面的知识点做一个全面的介绍。

> 通常来说，本系列博文对应的`angular`的版本为`1.6.x+`。

*******

部分函数，诸如`angular.lowercase`，`angular.uppercase`已经被废弃，故此这里也不再列出。









