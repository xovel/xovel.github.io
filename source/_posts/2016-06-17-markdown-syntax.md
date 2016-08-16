---
title: markdown语法说明
date: 2016-06-17 13:41:41
tags:
- markdown
- 语法
- 百科
- 资料
categories:
- 开发
- 文档
description: Markdown是一款轻量级文本标记语言。使用Markdown进行写作，你可以轻松的使用纯文本格式编辑HTML代码；本文对Markdown语法进行一个说明，会涉及大部分常见Markdown语法，增强语法与进阶语法部分请在使用时结合当前解析工具进行，部分可能不支持或者效果不对应。
---

Markdown是一款轻量级文本标记语言。使用Markdown进行写作，你可以轻松的使用纯文本格式编辑HTML代码。

```blockquote What is Markdown https://guides.github.com/features/mastering-markdown/#what
`Markdown` is a way to style text on the web. You control the display of the document; formatting words as bold or italic, adding images, and creating lists are just a few of the things we can do with Markdown. Mostly, Markdown is just regular text with a few non-alphabetic characters thrown in, like `#` or `*`.
```

关于Markdown的介绍与优势，这里就不深入详细讨论了，在本文末尾有参考资料，可自行参阅。本文主要讲述Markdown的相关语法。话不多说，直接上干货吧！

## Markdown基本语法

### 段落

普通文本即为段落，没有任何语法修饰。

### 标题

标题使用1到6个符号`#`来表示。标题的级别由`#`的数量决定。标题文本与`#`之间由一个空格隔开。


    # 标题1
    ## 标题2
    ### 标题3
    #### 标题4
    ##### 标题5
    ###### 标题6


标题还可以使用另一种方式：在文字的下一行使用符号`=`或者`-`。`=`为一级标题，`-`为二级标题。原则上任意数量的符号都是可行的，不过建议至少使用**3**个（部分Markdown工具不会处理只有一个符号的情形）。


    这里是标题1
    ===========
    这里是标题2
    -----------


- `#`形式的标题来源于[`atx`](http://www.aaronsw.com/2002/atx/)
- `=`和`-`形式的标题来源于[`Setext`](http://docutils.sourceforge.net/mirror/setext.html)
- `#`形式的标题可以主动闭合，即文本后面也可以跟`#`，通常这样做是为了文本看起来更加美观。如`## 这里是标题2 ##`，标题的级别由开头的`#`数量决定。
- `=`和`-`的方式看起来就像是给文字加了一条下划线。不过`#`显得更加直观

### 块引用

使用符号`>`表示块引用。


    > 这里是块引用


- 语法来源于早期的邮件文本格式。
- 使用块引用语法后，如果下一行紧跟的依然是文本，那么这一段文本将会跟在上一行后面，同样被当作块引用的内容。
- 文本的每一行前面都可以使用`>`，这样做可以让文本更直观，也更美观。但是这些文本将会在同一行内呈现。
    - 如果需要分行显示，请直接在文本之间使用换行符或者在以`>`作为单独的一行插入。
    - 注意：部分markdown处理工具会有不同的效果，请根据相关文档自行选用具体方式。
- 块引用可以嵌套使用，在`>`后再跟`>`即可。
- 建议文本与符号`>`之间留出一个空格。
- 块引用的内容可以包含标题、列表、代码块等Markdown元素。

以下为示例代码：

    > 白日依山尽，
    > 黄河入海流。
    > 欲穷千里目，
    > 更上一层楼。

分行语法：

    > 白日依山尽，
    >
    > 黄河入海流。
    >
    > 欲穷千里目，
    >
    > 更上一层楼。


### 列表

无序列表与有序列表两种均可支持。

**无序列表**

无序列表语法为文本前面使用符号`-`、`+`和`*`。文本与符号之间由一个空格隔开。


    * 列表项1
    * 列表项2
    * 列表项3

    + 列表项1
    + 列表项2
    + 列表项3

    - 列表项1
    - 列表项2
    - 列表项3

**有序列表**

有序列表语法为文本前面使用阿拉伯数字和符号`.`。与无序列表一样，文本与符号之间须有一个空格。

    1. 列表项1
    2. 列表项2
    3. 列表项3

如果你不想使用递增的数字，可以这样做：


    1. 列表项1
    1. 列表项2
    1. 列表项3


甚至，这样做（不建议）：

    9. 列表项1
    3. 列表项2
    5. 列表项3


**注意事项**

使用列表时，分行的文本会自动处理为一行显示，这一点与块引用语法类似。

如果为了美观，你可以在多行列表文本的前面添加缩进。


    * 列表项1的文本，
      我也是1的文本，
      好巧我也是。
    * 列表项2的文本，
      我是2的文本。


你还可将各个列表之间使用换行符隔开，这样它们将会变为段落性质的列表。


    - 列表项1
    - 列表项2

这段代码将被转换成：

```html
<ul>
  <li>列表项1</li>
  <li>列表项2</li>
</ul>
```

而这段代码

    - 列表项1

    - 列表项2

将被转换成：

```html
<ul>
  <li><p>列表项1</p></li>
  <li><p>列表项2</p></li>
</ul>
```

如果列表项内容为多行，对每一行进行缩进即可。段落中有多行的情况时可以一并缩进也可以不用缩进。

列表项的内容可以嵌套其他markdown语法，如块引用，代码块等。

无序列表的三个不同的符号避免在同一列表中交叉使用，不同的符号生成的列表是独立的，这可能会对样式的渲染造成一定的干扰。

如果某一段文本本身是以列表语法开始的，如：


    2016. 我不知会遇见你


请使用反斜杠对符号`.`进行取消转义。

    2016\. 我不知会遇见你


### 代码块

在文本的前面使用至少4个空格或者1个Tab。

代码块的内容将会处理成被`<pre>`和`<code>`标签包裹。


    This is a normal paragraph:

        This is a code block.

这段代码将被转换成：

```html
<p>This is a normal paragraph:</p>

<pre><code>This is a code block.
</code></pre>
```

代码块会对里面的一些符号进行转义，变为HTML实体符：

- And连接符`&`将被转换为`&amp;`
- 左尖括号`<`将被转换为`&lt;`
- 右尖括号`>`将被转换为`&gt;`

代码块中的内容不会再进行markdown语法的操作。

### 水平线

水平线，即`<hr>`标签。

在单独的一行里，使用至少三个相同的符号。这些符号可以是：星号`*`、连字符/减号`-`、下划线`_`。

符号之间可以由空格隔开。

下面的代码均会被转换成水平线：

    * * *

    ***

    *****

    - - -

    ---------------------------------------

### 链接

链接的语法有两种：内联方式和引用方式。

内联方式示例：

    Github是一个优秀的平台，[点此访问](https://github.com "github")
    [我不带标题](https://github.com)

引用方式示例：

    Github是一个优秀的平台，[点此访问][github]

    [github]: https://github.com "github"

链接文本使用方括号`[]`定界，内联方式的链接地址与链接标题（即`title`属性）使用圆括号`()`定界；引用方式的链接地址与链接标题使用另一个方括号`[]`进行引用，被引用的内容在文档中单独列出。

- 链接标题使用双引号`""`定界，也可以使用单引号`''`进行定界。
- 可以不需要链接标题，只保留链接地址即可。
- 链接标题应与链接地址之间使用空格隔开。
- 如果链接地址在本域，可以使用相对链接的形式。
- 可以使用尖括号`<>`对链接地址进行定界。
- 引用方式中，方括号后跟一个冒号`:`，冒号后跟一个或多个空格。
- 引用方式中，两组方括号之间可以使用空格分开。
- 引用方式中，被引用的内容部分可以放在文档中的任意位置。
- 引用方式中，链接标题的定界符还可以使用圆括号`()`。
- 引用方式中，标题可以另起一行，可自由缩进。
- 引用方式中，定义的名称不区分大小写。
- 引用方式中，如果链接文本与引用的定义名称一样，后面的方括号内容可以置空。

> 关于使用哪一种方式，这里不做讨论。

### 强调

文本强调的方式分为`加粗`和`斜体`。

使用星号`*`或者下划线`_`对文本定界来表示强调。一对单个符号表示斜体，一对两个符号表示加粗。

    *我是斜体*

    _我也是斜体_

    **我是粗体**

    __我也是粗体__

- 加粗和斜体可以同时使用。
- 强调可以用在单词或者词组的字符中间。如`s*mile*s`，s*mile*s。
- 如果要使用符号本身，请使用转义符反斜杠`\`。

### 代码/行内引用

使用反勾号/反引号/重音号（backtick quote）`` ` ``对文本定界。

    C++中输出操作符为：`cout`

与代码块不同的是，本语法为行内操作，类似于强调的语法。可以放在强调的语法中。

本语法操作的文本中其他的语法将不会被处理，部分HTML符号也会被替换成实体符，这一点跟代码块一样。

如果要在行内引用本语法中的操作符`` ` ``，请使用这样的语法：

    `` ` ``

    示例：`` `我是示例` ``

### 图片

插入图片的语法跟链接的语法几乎一模一样，图像的语法在链接的语法前有一个惊叹号`!`。

链接语法中的说明针对图片均有效。链接与图像对应的关系为：

- 链接文本对应图片说明，即图片的`alt`属性
- 链接地址对应图片地址，即图片的`src`属性
- 链接标题对应图片标题，即图片的`title`属性

示例代码：

    Github的图标：![github icon](https://guides.github.com/favicon.ico)

### 自动链接

文档中的链接可以使用定界符尖括号`<>`实现自动链接效果，不需要额外的链接语法操作。

    <https://github.com/>

将被转换为：

```html
<a href="https://github.com/">https://github.com/</a>
```

对于邮箱地址链接，同样有效。

### 取消转义

使用反斜杠`\`进行语法取消。

使用反斜杠可以使得语法相关符号以字面量进行显示，接受以下符号的取消转义：

- 反斜杠`\`
- 反引号`` ` ``
- 星号`*`
- 下划线`_`
- 花括号`{}`
- 方括号`[]`
- 圆括号`()`
- #号`#`
- 加号`+`
- 减号/连字符`-`
- 数点`.`
- 惊叹号`!`

> 部分增强和进阶语法中使用的特殊符号，也采用反斜杠`\`进行取消转义。

## GitHub上的部分增强语法

GitHub作为一个代码分享平台，其书写格式采用的就是Markdown。Github针对Markdown语法进行了一些扩展，以更好的支持代码方面的写作。

### 自动链接

与基础语法中的自动链接类似，不过不需要额外的语法，识别为链接的文本将自动生成链接。

### 删除线

使用一对`~~`作为定界符，使文本转换后带有删除线。

    ~~我被删除线贯穿~~

删除线作用方式为行内操作，可以放在其他语法内。

### Emoji

可以在文档中插入Emoji表情，语法为对应Emoji表情名称使用一对冒号`:`进行定界即可。

    :smile:

> [Emoji Cheat Sheet](http://www.emoji-cheat-sheet.com/)

### 围栏代码块与语法高亮

使用三个`` ` ``作为定界符，也可以使文本转换为可以代码块。我们可以将之称为围栏代码块。

在第一组`` ` ``后面可以指定高亮采用的语法。

````
    ```javascript
    var now = function(){
        return new Date().getTime()
    }
    ```
````

以上代码将会以javascript语法的方式对代码进行高亮显示。

```javascript
var now = function(){
    return new Date().getTime()
}
```

> We use [Linguist](https://github.com/github/linguist) to perform language detection and syntax highlighting. You can find out which keywords are valid in [the languages YAML file](https://github.com/github/linguist/blob/master/lib/linguist/languages.yml).

常用高亮代码库[Highlight](https://github.com/isagalaev/highlight.js)可以实现多种语法的高亮风格展示，其支持的高亮语法与样式效果请自行参考[官方Demo](https://highlightjs.org/static/demo/)。

### 任务列表

在列表项前面使用`[ ]`和`[x]`可以表示该任务列表的状态。前者为未完成，后者为已完成。

`[ ]`和`[x]`的位置在列表标识符和列表项的中间，均由空格隔开。

    - [ ] 未完成1
    - [x] 已完成1
    - [x] 已完成2

### 表格

通过使用下面的语法方式实现表格：

    | 表头1 | 表头2 |
    | ----- | ----- |
    | A1    | A2    |
    | B1    | B2    |

- 两边的符号竖线`|`可以去掉。
- 第二行符号竖线之间的符号`-`数量至少**1**个，可以是很多个，建议**3**个。
- 表格里面的内容可以使用行内语法。
- 表格模块与其他模块以换行符分开，否则紧跟表格的部分会作为表格的内容进行解析。

如果需要指定对齐方式，可以在代码中的第二行进行指定，语法方式为：

    | 左对齐 | 居中 | 右对齐 |
    | :--- | :---: | ---: |
    | A1   | A2    | A3   |
    | B1   | B2    | B3   |

如果表格内需要使用符号`|`，请使用转义符`\`。

    | 名称   | 符号 |
    | ---    | ---  |
    | 单引号 | '    |
    | 竖线   | \|   |

## 高阶语法

以下列出一些常见的进阶语法。

这些语法是扩展语法，实际使用时请注意采用的Markdown解析工具**是否支持**。

### 定义列表

以下语法实现一个定义列表：

    名称1
    :    A1
    :    A2

    名称2
    :    B1

代码将被转换为：

```html
<dl>
<dt>名称1</dt>
<dd>A1</dd>
<dd>A2</dd>

<dt>名称2</dt>
<dd>B1</dd>
</dl>
```

参考：
- [PHP Markdown Extra - Definition Lists ](https://michelf.ca/projects/php-markdown/extra/#def-list)

### 特殊属性

可以对生成后的元素指定特殊属性，如ID，类名等。

使用花括号`{}`作为定界符对转换后的标签添加特殊属性。

    我是一个段落 {#para .color-red foo=bar}

将被转换为：

```html
<p id="para" class="color-red" foo="bar">我是一个段落</p>
```

### 缩写

可以对指定文本进行缩写提示，转换后对该文本使用`<abbr>`标签包裹，该标签会有一个`title`属性指定其详细名称。

    喜大普奔是一个缩写词。

    *[喜大普奔]: 喜闻乐见、大快人心、普天同庆、奔走相告

将被转换为：
```html
<p><abbr title="喜闻乐见、大快人心、普天同庆、奔走相告">喜大普奔</abbr>是一个缩写词。</p>
```

`*[text]: title`为缩写的描述定义文本语法，`text`为缩写，`title`为描述，跟链接引用的定义文本类似，可以在文档中的任意位置，最终解析出来的文档将会忽略。

### 脚注

脚注的语法：在需要添加脚注的地方使用语法：`[^x]`，在文档的任意位置放置脚注的定义说明即可，如：`[^x]: 我是脚注说明`。

参考：
- [Pandoc - Pandoc User’s Guide - Footnotes](http://pandoc.org/README.html#footnotes)
- [markdown-it/markdown-it-footnote: Footnotes plugin for markdown-it markdown parser](https://github.com/markdown-it/markdown-it-footnote)
- [LouisBarranqueiro/hexo-footnotes: A plugin to support markdown footnotes in your Hexo blog posts](https://github.com/LouisBarranqueiro/hexo-footnotes)

### 目录

自动生成文档的目录。语法格式为：`[TOC]`（Table of Content）。

参考一个目录实现的repo：[jonschlinkert/markdown-toc](https://github.com/jonschlinkert/markdown-toc)

### 下标

使用一对符号`~`对文本定界。如：`H~2~O`。转换后的文本将使用标签`<sub>`包裹。

### 上标

- 使用一对符号`^`对文本定界。如：`21^st^`。转换后的文本将使用标签`<sup>`包裹。
- 使用数学公式实现上标。如：`` `$21^{st}$` ``。

### 下划线

使用一对符号`++`对文本定界。如：`++文本++`。转换后的文本将使用标签`<ins>`包裹。

### 标记块

使用一对符号`==`对文本定界。如：`==标记==`。转换后的文本将使用标签`<mark>`包裹。

### 自定义文本块

    :: info
    这里是信息文本块
    ::

    :: warn
    这里是警告文本块
    ::

### 数学公式

使用一对符号`` `$ ``对文本定界。如：`` `$E=mc^2$` ``。这个公式为行内公式。

块状数学公式语法：
- 一行公式，定界符改为`$$`即可（Mathjax的语法）。
- 多行公式，使用类似语法高亮的语法，反引号后跟`math`即可。

````markdown
    ```math
    这里放置具体公式代码
    ```
````

常见数学公式渲染工具：
- [Mathjax](https://github.com/mathjax/MathJax)
- [LeTeX](http://www.latex-project.org/)
- [KaTeX](https://github.com/Khan/KaTeX)

### 流程图、时序图、甘特图

````markdown
流程图：
```
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

时序图：
```
sequenceDiagram
    Alice->>John: Hello John, how are you?
    John-->>Alice: Great!
```

甘特图：
```
gantt
    title A Gantt Diagram

    section Section
    A task           :a1, 2014-01-01, 30d
    Another task     :after a1  , 20d
    section Another
    Task in sec      :2014-01-12  , 12d
    anther task      : 24d
```

````

参考：
- [adrai/flowchart.js](https://github.com/adrai/flowchart.js)
- [knsv/mermaid](https://github.com/knsv/mermaid)

## 参考资料
- [The Future of Markdown](https://blog.codinghorror.com/the-future-of-markdown/)
- [轻量级标记语言 — GotGitHub](http://www.worldhello.net/gotgithub/appendix/markups.html)
- [Daring Fireball: Markdown Syntax Documentation](https://daringfireball.net/projects/markdown/syntax)
- [html转markdown - 在线工具](http://tool.lu/markdown/)
- [Html转MarkDown代码, Html2MarkDown - aTool在线工具](http://www.atool.org/html2markdown.php)
- [Basic writing and formatting syntax - User Documentation - Github](https://help.github.com/articles/basic-writing-and-formatting-syntax/)
