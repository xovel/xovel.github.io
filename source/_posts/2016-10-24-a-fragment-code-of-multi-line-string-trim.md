---
title: 一段处理多行文本的代码
tags: [code, string, markdown]
categories: [随笔]
date: 2016-10-24 15:28:18
description: 针对markdown语法解析的过程中的一个代码片段，今天无意中看到了，做个记录。
---

### 概述

因为一些事情，本人搁置了`zmd.js`的开发。今天查阅资料时，发现一段代码，针对多行文本进行处理的。

### 代码片段

```js
function rTrimInputText(text) {
  var rsp = text.match(/^\s*/)[0].length,
  rgx = new RegExp('^\\s{0,' + rsp + '}', 'gm');
  return text.replace(rgx, '');
}
```

> 代码来自：<https://github.com/showdownjs/showdown/blob/master/dist/showdown.js#L884>

### 代码的功能

去除多行文本中的前置空格。

### 示例

以下的文本：

```plaintext
code:
  aaa
    bbb
   ccc
```

在使用上面的一段代码处理后得到的结果为：

```plaintext
result:
aaa
  bbb
 ccc
```

即去除了每一行前面的两个空格。

### 应用场景

在针对嵌套的语法中，比如嵌套列表，在针对被嵌套的列表进行的解析的时候，就需要先去掉前面的缩进。这一段代码正好可以满足这个需求。

```markdown
- list1
  * list1-1
  * list1-2
  * list1-3
- list2
- list3
  + list3-1
  + list3-2
```


