---
title: URLSearchParams 简介
tags: [web, URLSearchParams]
categories: [开发, 文档]
date: 2017-09-12 7:52:10
description: 本文简单介绍一下 URLSearchParams。
---

> 本文根据 `URLSearchParams` 的[官方规范文档][spec]和 [MDN 文档][mdn]整理而成。

URLSearchParams 是一个 WEB 接口，它定义了一些方法来处理 URL 的查询字符串。

构造函数 `URLSearchParams()` 返回一个 URLSearchParams 对象，这个对象没有特别的属性，也不继承任何方法。

URLSearchParams 的构造实例的方法如下：

### `append`

插入一个新的搜索参数。该方法接受两个参数，无返回值，调用形式为 `URLSearchParams.append(name, value)`，`name` 为插入搜索参数的键名，`value` 为对应的值。

### `delete`

删除指定名称的**所有**搜索参数。接受一个参数 `name` 即要删除的键值名称，无返回值。

### `entries`

**不同于** `Object.entries`，这里的 `entries` 方法会返回一个 `iterator`，可以遍历所有键值对的对象。每一个键值对均为 `USVString` 对象。

> - iterator 是迭代协议 Iterator 对象的实例。
> - `entries` 方法通常在 `Web Workers` 中使用。
> - `USVString` 为 unicode 标量值（unicode scalar values）。

代码示例：

```js
// Create a test URLSearchParams object
var searchParams = new URLSearchParams("key1=value1&key2=value2");

// Display the key/value pairs
for(var pair of searchParams.entries()) {
   console.log(pair[0]+ ', '+ pair[1]);
}
```

### `get`

获取指定搜索参数的第一个值。

### `getAll`

获取指定搜索参数的所有值。返回一个数组。

### `has`

判断是否存在指定的搜索参数。

### `keys`

返回 iterator 对象，包含了键/值对的所有键名。其他说明与上面的 `entries` 一样。

### `set`

设置指定搜索参数对应的值。接受的参数跟 `append` 中的一样，如果存在多个搜索参数对应的值，则删除其他所有值。

### `sort`

按键名排序。排序规则为按键名的 `unicode` 码点，该规则是稳定排序，对相等的键值的相对顺序不做变更。

### `toString`

返回一个字符串，由所有搜索参数组成的字符串，可以直接用在 URL 上。

### `values`

返回 iterator 对象，包含了键/值对的所有值。其他说明与上面的 `entries` 和 `keys` 一样。

### `forEach`

扩展方法，提供接近于数组 forEach 的遍历方式，~~但它并不是一个数组，也不是一个类数组~~。

```js
searchParams.forEach((...args)=>console.log(args))
```

> 上面的代码中，`args` 依次为键名、值、对应的 searchParam。

*参考资料*：

- [URL Standard][spec]
- [URLSearchParams - Web APIs | MDN][mdn]
- [URL | Node.js v8.4.0 Documentation](https://nodejs.org/api/url.html#url_class_urlsearchparams)
- [Can I use - Feature: URLSearchParams](http://caniuse.com/#feat=urlsearchparams)

[spec]: https://url.spec.whatwg.org/#urlsearchparams
[mdn]: https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams
