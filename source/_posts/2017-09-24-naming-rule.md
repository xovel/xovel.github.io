---
title: 编程命名规则
tags: [naming, case]
categories: [开发]
date: 2017-09-24 12:07:13
description: 编程命名规则有很多种，本文就简单做一个介绍。
---

> There are only two hard things in Computer Science: cache invalidation and naming things. -- Phil Karlton

正如上面这一句经典的话语，道出了计算机领域两个最大的难题：命名与缓存。

本文就“命名”这个东西，做一个浅显的解读。

### 匈牙利命名法

该方法也叫做 `HN 命名法`，通常认为是微软的一个雇员 `Charles Simonyi` 发明的，通过微软的各种产品和文档资料传播开来。这位雇员是一个匈牙利（Hungarian）人，这也就是这个命名方法的名字由来。

匈牙利命名法的基本原则是：变量名依次由属性、类型、描述组成。

这里就通过举例来进行直接的说明：

```cpp
int iUserName; // i 为 int 类型缩写
char cItemList; // c 为 char 类型缩写
```
```js
var bInitLogin; // b 为 布尔值 boolean 缩写
```
```vb
dim frmInfoDetail; ' frm 为窗体 form 的缩写
```

### 驼峰命名法

驼峰命名法 `camelCase`，来自于 Perl 语言普遍使用的大小写混合格式，后来被 Java 广泛采用，逐渐成为更加通用的命名方法。

驼峰命名法的基本规则是变量名或者函数名是由一个或者多个单词连接在一起，构成唯一识别符，第一个单词以小写字母开始，后面的单词首字母大写，这样看起来跟驼峰一样此起彼伏，故此得名。

```java
int myStudentCount;
```
```js
fs.readFileSync
```

### 帕斯卡命名法

跟驼峰命名法类似，帕斯卡命名法 `PascalCase` 的不同之处在于第一个单词首字母为**大写**。在一些构造器命名和全局特殊变量命名的时候通常会采用这种命名方法。

鉴于跟驼峰命名法的相似，也有人将帕斯卡命名法称之为 `大驼峰命名法`，而上面的就称之为 `小驼峰命名法`。

### 蛇形命名法

蛇形命名法 `snake_case`，变量名由多个部分组成，每个部分之间使用下划线 `_` 进行连接，所以也称之为 `下划线命名法`。

### 脊柱命名法

脊柱命名法 `spinal-case`，跟蛇形命名法类似，不过连接符为连接符 `-`。也称之为 `kebab-case`、`train-case`。在 URL 命名，HTML 属性、CSS 属性、Lisp 语言比较常见，所以也称之为 `lisp-case`。

> kebab 意思是阿拉伯烤肉，与 train、spinal 一样，因为其生动的形象，跟连字符风格类似，均以此得名。

### 混杂大小写

`Studly caps`，这一种命名方法，其实我不知道该如何去翻译和描述，算是一种很非主流的命名方式。就是杂乱无章的大小写混拼方式。比如这种命名方式来命名自己的名称，可以是 StUdLyCaPs 或者 STuDLyCaPS。

### 总结

其实上面的种种命名方式，在语义学上面，统称为 `case`。这也是为什么其英文名称中大都出现了 `case` 这个词眼的原因。

现罗列一下常见的各种 `case`，每一种都是用自身的方式进行书写的。

- `CamelCase`
- `snake_case`
- `kebab-case`
- `StUdLyCaPs`

另外加上两个~~凑数~~：

- `lowercase`
- `UPPERCASE`

> 嗯。是的，一个是小写，一个是大写。

********

在如今的编码过程中，并不会总是遵循某一种规则，而是各种风格混合使用，这样也能更好的适应当前的业务场景。
