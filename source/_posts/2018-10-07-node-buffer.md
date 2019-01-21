---
title: Buffer 简介
tags: [node, buffer]
categories: [Node]
date: 2018-10-07 22:05:26
---

`Buffer` 是 `node` 中的一个全局对象，用来读取或者操作二进制数据流。

<!-- more -->

> 本文直接使用 `Buffer` 讲述这个对象，该对象翻译成中文，可以叫做“缓冲区对象”。

[**官方文档**][buffer]的介绍如下：

> Prior to the introduction of [TypedArray][], the JavaScript language had no mechanism for reading or manipulating streams of binary data. The Buffer class was introduced as part of the Node.js API to enable interaction with octet streams in TCP streams, file system operations, and other contexts.

在 `ECMAScript 2015` 引入 `TypedArray` 之后，`Buffer` 类使用了一种更优化、更适合 `Node.js` 用例的方式实现了 [`Uint8Array`][Uint8Array] API。

`Buffer` 类可以视作一个跟 `Array` 类一样的对象，区别在于 `Buffer` 的大小是固定的，且在 `v8` **堆外**分配物理内存。`Buffer` 的大小在创建时就确定了，无法调整。

先来看一段官方文档提供的示例代码：

```js
// Creates a zero-filled Buffer of length 10.
const buf1 = Buffer.alloc(10);

// Creates a Buffer of length 10, filled with 0x1.
const buf2 = Buffer.alloc(10, 1);

// Creates an uninitialized buffer of length 10.
// This is faster than calling Buffer.alloc() but the returned
// Buffer instance might contain old data that needs to be
// overwritten using either fill() or write().
const buf3 = Buffer.allocUnsafe(10);

// Creates a Buffer containing [0x1, 0x2, 0x3].
const buf4 = Buffer.from([1, 2, 3]);

// Creates a Buffer containing UTF-8 bytes [0x74, 0xc3, 0xa9, 0x73, 0x74].
const buf5 = Buffer.from('tést');

// Creates a Buffer containing Latin-1 bytes [0x74, 0xe9, 0x73, 0x74].
const buf6 = Buffer.from('tést', 'latin1');
```

***************

`Buffer` 实例一般用于表示编码字符的序列，用过指定字符编码，可以在 `Buffer` 实例与常规 `JavaScript` 字符串之间进行相互转换。

这样的描述，可能太过于抽象，直接上代码解释吧：

```js
function btoa(str) {
  const buf = Buffer.from(str);
  return buf.toString('base64');
}

function atob(str) {
  const buf = Buffer.from(str, 'base64');
  return buf.toString();
}
```

上面的代码，是 `node` 环境下关于浏览器 [`atob`][atob] 和 [`btoa`][btoa] 方法的实现。

`Node.js` 目前支持的字符编码如下：

- `ascii`，仅支持 7 位 ASCII 数据。
- `utf8`，多字节编码的 Unicode 字符。许多网页和其他文档格式都使用 `UTF-8`。
- `utf16le`，2 或 4 字节，`little-endian`(小字节序)编码的 Unicode 字符。支持 `U+10000` 到 `U+10FFFF` 的代理对。
- `usc2`，即 `utf16le`。
- `base64`，即 `Base64` 编码。
- `latin1`，即 `Latin-1` 编码，具体由 IANA 在 [RFC1345][] 中定义。
- `binary`，即 `latin1`。
- `hex`，将每个字节编码为两个十六进制字符。

> 注意，现代浏览器遵循 [WHATWG 编码标准][encoding] 将 `latin1` 和 `ISO-8859-1` 别名为 `win-1252`。这意味着在进行例如 `http.get()` 获取到的字符编码在规范列表中，服务器可能返回 `win-1252` 编码的数据，此时如果使用 `latin1` 字符编码，可能会得到错误的解码数据。

`Buffer` 对象可以使用 `for...of` 进行内部迭代。同样的，实例对象的 `.values`、`.keys` 和 `.entries` 方法都可以创建迭代。

使用 `new` 操作符实例化一个 `Buffer` 的方法已经被弃用。注意，**已经弃用的方法本文不做介绍**。

创建 `Buffer` 实例的方法有下面几个：

- `Buffer.from(array)`，从数组进行创建。
- `Buffer.from(arrayBuffer[, byteOffset[, length]])`，从 `arrayBuffer` 的实例进行创建。
- `Buffer.from(buffer)`，直接根据 `buffer` 创建。
- `Buffer.from(string[, encoding])`，根据字符串创建，`encoding` 即使用的编码方式。
- `Buffer.from(object[, offsetOrEncoding[, length]])`，根据对象创建，该对象需要支持 `Symbol.toPrimitive` 或者有 `valueOf()` 方法，比如 `Buffer.from(new String('this is a test'));`。
- `Buffer.alloc(size[, fill[, encoding]])`，创建一个指定长度的对象，`fill` 表示用来填充新建的 `Buffer` 的值，默认为 `0`。
- `Buffer.allocUnsafe(size)`，分配一个大小为 `size` 的对象。该方式创建的 `Buffer` 对象是未经过初始化的，内容未知，可能包含敏感数据。

> 更多的创建方式不在本文的记述范围之内。

创建之后的实例，我们使用 `buf` 进行表示，`buf` 的特性跟数组类似。

`buf.buffer` 指向了 `Buffer` 底层的 `ArrayBuffer` 对象。

可以使用 `fill` 方法进行填充，语法为 `buf.fill(value[, offset[, end]][, encoding])`。

`toString` 可以将 `buf` 转为一个常规字符串，语法为 `buf.toString([encoding[, start[, end]]])`。

之前做了一个简单的获取网页源代码的方法，代码大概是这样的：

```js
const http = require('http');
const https = require('https');

module.exports = function getHTML(url) {

  return new Promise(function (resolve, reject) {
    (/^https/i.test(url) ? https : http).get(url, function (res) {
      var html = '';

      res.on('data', function (chunk) {
        // chunk is a Buffer instance, use the method toString to get the string
        html += chunk;
      });

      res.on('end', function () {
        resolve(html);
      });
    }).on('error', function () {
      reject();
    });
  });
}
```

是的，这里面的 `chunk` 对象就是一个 `Buffer` 实例。

***********

真·简介。本文到此就结束了。

[buffer]: <https://nodejs.org/api/buffer.html>
[TypedArray]: <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/TypedArray>
[Uint8Array]: <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Uint8Array>
[atob]: <https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/atob>
[btoa]: <https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/btoa>
[RFC1345]: <https://tools.ietf.org/html/rfc1345>
[encoding]: <https://encoding.spec.whatwg.org/>
