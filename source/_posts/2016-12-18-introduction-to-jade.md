---
title: Jade入门级介绍
tags: [jade, 入门, HTML]
categories: [开发, 文档]
date: 2016-12-18 23:16:51
description: 有一种速写HTML代码的方法，叫做jade，通过严格缩进来控制HTML的层次与顺序。本文针对这个方案做一个简略的说明。
---

### 介绍

最近，到了新的公司上班，接触到的HTML编写方式为使用`jade`。~~习惯了手写HTML硬编码的我，一时之间还不太适应这种快速高效的方式。~~

我们先通过一个例子来讲述一下这款工具的牛逼之处吧！

```jade
div.container#main Content
a.btn(href="javascript:;",title="link") Button
```

经过工具编译后，以上代码将会输出：
```html
<div class="container" id="main">Content</div>
<a class="btn" href="javascript:;" title="link">Button</a>
```

~~是不是有种简单粗暴的即视感？~~

### 基本语法

基本属性的写法如下：

每行开始的第一个单词将会作为HTML标签名，如果没有，则默认为`div`。

类名和ID，同CSS选择器的语法——类名为`.`号开始，如果有多个类名，叠加展示即可。如`section.index.tips`；ID为`#`标识。

HTML元素的其他属性可以写在跟在后面的括号`()`之内。多个属性，可以使用逗号`,`或者空格` `隔开。

元素内的文本则以一个空格后直接书写。

Jade采用对缩进敏感的语法，来划分HTML的层次结构。

```jade
ul
  li A 
    span text
  li B
  li C
```

将会被编译成：
```html
<ul>
  <li>A<span>text</span></li>
  <li>B</li>
  <Li>C</Li>
</ul>
```

### 循环

`jade`支持循环。比如：
```jade
- for (var i = 0; i < 3; i++)
  li item
```

将会被编译成：
```html
<li>item</li>
<li>item</li>
<li>item</li>
```

### 继承

`jade`使用`extends`来继承代码片段，继承可以修改代码片段。

页面中使用`block`标识符，可以指定一个代码片段的名字，比如名字设为`name`。在需要使用该代码片段的地方，直接使用`block name`即可。

### 文件包含

`jade`可以使用`include`语法实现高度复用代码。将这些代码片段保存到不同的文件中，然后在需要的地方进行引入即可。

### 混合宏

`mixin`是`jade`提供的另一个方法，可以很大程度提升HTML编写的效率。语法类似于`sass`和`less`中的混合宏。

混合宏具有高度复用、解耦、可读、可扩、可维护等特点，是众多预编译语言的共同特点。

`jade`中使用`mixin`标识符进行混合宏的创建，在需要的地方使用`+`标识符进行调用即可。

```jade
mixin list
  ul
    li foo
    li bar
    li baz

+list
+list
```

将会被编译成：
```html
<ul>
  <li>foo</li>
  <li>bar</li>
  <li>baz</li>
</ul>
<ul>
  <li>foo</li>
  <li>bar</li>
  <li>baz</li>
</ul>
```

支持参数的传入：
```jade
mixin card(name)
  li.card= name
ul
  +card('A')
  +card('B')
  +card('C')
```

将会被编译成：
```html
<ul>
  <li class="card">A</li>
  <li class="card">B</li>
  <li class="card">C</li>
</ul>
```

还可以使用余参：
```jade
mixin list(id, ...items)
  ul(id=id)
    each item in items
      li= item

+list('example', 1, 2, 3, 4, 5)
```

将会被编译成：
```html
<ul id="example">
  <li>1</li>
  <li>2</li>
  <li>3</li>
  <li>4</li>
  <li>5</li>
</ul>
```

-----

`jade`的入门级介绍到这里就告一段落，还有一些高级语法，可以参考官方文档。


