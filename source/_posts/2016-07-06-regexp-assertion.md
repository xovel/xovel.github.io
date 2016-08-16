---
title: 正则表达式之零宽断言
date: 2016-07-06 11:48:12
tags:
- 正则表达式
- 断言
- 零宽断言
categories:
- 开发
- 文档
description: 断言在正则表达式里面有着举足轻重的作用。通常情况下指的是在目标字符串的当前位置进行的一种判断测试，但这种测试不会占用目标字符串，这意味着不会移动目标字符串在当前匹配中的位置。本文对断言进行一个简单的收集与整理，以巩固学到的有关正则表达式高级语法方面的知识。

---

> 本篇文章提到的零宽断言是正则表达式高级语法，阅读此文需要有一定的正则表达式基础。

### 关于断言

断言（`assertion`）在正则表达式里面有着举足轻重的作用。通常情况下指的是在目标字符串的当前位置进行的一种判断测试，但这种测试不会占用目标字符串，这意味着不会移动目标字符串在当前匹配中的位置。

### 断言元字符

最常用的两个断言元字符是`^`和`$`，它们分别表示字符串开始和字符串结束。

其他一些断言元字符参见下表：

- `\b`，单词分界符
- `\B`，非单词分界符
- `\A`，字符串的开头，忽略`multiline`标识
- `\Z`，字符串的结尾或者字符串结尾的换行符`\n`之前，忽略`multiline`标识
- `\z`，字符串的结尾，忽略`multiline`标识
- `\G`，字符串的第一个位置

> `\A`、`\Z`、`\z`、`\G`很少使用。

### 捕获与非捕获组

非捕获组`(?:pattern)`不是本文的知识点，这里不做详细讲解，文章后面有参考资料可自行参阅。

### 零宽断言

断言元字符通常是基于当前位置的测试，断言也可以支持更加复杂的判断条件。更复杂的断言以子模式来进行表示，包括先行断言和后行断言。两者都是本文要解说的`零宽断言`。

同断言元字符一样，零宽断言的判断匹配只做条件匹配，不会记录匹配结果，也不会匹配字符。

#### 零宽正向先行断言

- 英文：`zero-width positive lookahead assertion`
- 简称：`positive lookahead`
- 语法：`(?=pattern)`
- 概述：从当前位置开始测试后面的字符串**匹配**`pattern`，仅当右侧**匹配成功**时才继续。
- 举例：`[a-zA-Z]+(?=\d)`，匹配一个后面跟着数字的字母，但匹配结果不包含该数字。

#### 零宽负向先行断言

- 英文：`zero-width negative lookahead assertion`
- 简称：`negative lookahead`
- 语法：`(?!pattern)`
- 概述：从当前位置开始测试后面的字符串**不匹配**`pattern`，仅当右侧**不能匹配**时才继续。
- 举例：使用正则表达式`re(?!g)`，匹配字符串`regular expression`，则_**re**gular_中的_re_不会被匹配，_exp**re**ssion_中的_re_将会被匹配。

#### 零宽正向后行断言

- 英文：`zero-width positive lookbehind assertion`
- 简称：`positive lookbehind`
- 语法：`(?<=pattern)`
- 概述：从当前位置开始测试前面的字符串**匹配**`pattern`，仅当左侧*匹配成功*时才继续。

#### 零宽正向后行断言

- 英文：`zero-width negative lookbehind assertion`
- 简称：`negative lookbehind`
- 语法：`(?<!pattern)`
- 概述：从当前位置开始测试前面的字符串*不匹配*`pattern`，仅当左侧*不能匹配*时才继续。

**注意**：后行断言由于存在回溯情况，`JavaScript`**没有对其进行实现**。

> [为什么 JavaScript 的正则不支持 “零宽度正回顾后发断言” ？](https://www.zhihu.com/question/20154937)

### 参考资料

- [RegExr - 在线测试正则表达式](http://regexr.com/)
- [Regexper - 根据正则表达式生成SVG示意图](https://regexper.com)
- [RegExp - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp)
- [Regular Expression Syntax - 微软官方正则表达式参考](https://msdn.microsoft.com/zh-cn/library/ae5bf541(v=vs.100).aspx)
- [Regular-Expressions.info - The Premier website about Regular Expressions](http://www.regular-expressions.info/)
- [Regex Tutorial - Lookahead and Lookbehind Zero-Length Assertions](http://www.regular-expressions.info/lookaround.html)
- [Regex Tutorial - Parentheses for Grouping and Capturing](http://www.regular-expressions.info/brackets.html "分组与捕获")
- [Regular Expression Reference: Capturing Groups and Backreferences](http://www.regular-expressions.info/refcapture.html "捕获组详细介绍，内含各种编程语言对其的实现")
- [regex - What is a non capturing group? (?:) - Stack Overflow](http://stackoverflow.com/questions/3512471/what-is-a-non-capturing-group)
- [To capture or not to capture | getiblog](https://blog.getify.com/to-capture-or-not/)




