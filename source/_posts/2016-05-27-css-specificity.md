---
title: CSS权重
date: 2016-05-27 17:41:51
tags:
- 前端
- css
- specificity
categories:
- WEB
- CSS
description: 一个元素，其对应的CSS选择可以有很多个。如果同一个元素的某个样式，使用了两个不同的CSS选择器进行定义，那么最终使用的到底是哪一个呢？于是这里就引入了一个概念，最初叫做cascade order，后来的官方文档中间叫做specificity。这个单词翻译成中文叫做特异性、特性，其概念与C语言中运算符的优先级类似，所以也称之为CSS优先级。
---


### 起因

我为什么要做这样一个文章？

触发我讨论这个问题的导火线来自于我的个人博客采用的hexo主题中[内容页图片居中问题](https://github.com/iissnan/hexo-theme-next/issues/910)。当时眼睛花了，没看清CSS代码，但也因此牵扯出来一些关于CSS权重（也叫做CSS优先级）的问题。

经过参阅了一些现有的资料与文献，蓦一回头，发现很多经验总结其实并不完善。

### CSS权重的定义

一个元素，其对应的CSS选择可以有很多个。如果同一个元素的某个样式，使用了两个不同的CSS选择器进行定义，那么最终使用的到底是哪一个呢？于是这里就引入了一个概念，最初叫做`cascade order`，后来的官方文档中间叫做`specificity`。这个单词翻译成中文叫做`特异性`、`特性`，其概念与C语言中运算符的优先级类似，所以也称之为CSS优先级。

由于CSS选择器可以很长很复杂，单一的优先级的参数并不能直接表示，还需要与其对应的数量相乘。在数学统计学里，这个概念叫做加权。

> 某个学科的最终成绩分为两部分：平时分和考试分。假设平时分所占的权重为30%，考试成绩所占的权重为70%。现有一名学生，平时分为60，考试分为90。那么其常规平均成绩为(60+90)/2=75；加权成绩为60\*30%+90\*70%=81。

CSS权重这一概念与加权值类似，那么它的具体计算方式是什么呢？

### CSS权重的计算

#### CSS1

在[CSS1][css1]中，将优先级分为了三组：

> To find the specificity, count the number of ID attributes in the selector (a), the number of CLASS attributes in the selector (b), and the number of tag names in the selector (c). Concatenating the three numbers (in a number system with a large base) gives the specificity.

- a：ID选择器
- b：类名选择器
- c：标签选择器

根据具体选择器中a、b、c三组分别出现的数量，依次进行计算，最终得出优先级权重排序。

示例：

    LI            {...}  /* a=0 b=0 c=1 -> specificity =   1 */
    UL LI         {...}  /* a=0 b=0 c=2 -> specificity =   2 */
    UL OL LI      {...}  /* a=0 b=0 c=3 -> specificity =   3 */
    LI.red        {...}  /* a=0 b=1 c=1 -> specificity =  11 */
    UL OL LI.red  {...}  /* a=0 b=1 c=3 -> specificity =  13 */ 
    #x34y         {...}  /* a=1 b=0 c=0 -> specificity = 100 */ 

#### CSS2

在[CSS2][css2]中，加入了行内样式，之前的三组变为四组：

- a：行内样式。由于已经是对应元素了，所以就没有选择器了，后面三组的值均为0。
- b：ID选择器。
- c：除ID之外的其他属性，如`.classname`、`[href]`；伪类，如`:active`、`:first-child`；不包含伪元素。
- d：标签选择器；伪元素，如`:first-letter`、`:before`
- 忽略通配符`*`，即abcd值均为0

示例：

    *             {}  /* a=0 b=0 c=0 d=0 -> specificity = 0,0,0,0 */
    li            {}  /* a=0 b=0 c=0 d=1 -> specificity = 0,0,0,1 */
    li:first-line {}  /* a=0 b=0 c=0 d=2 -> specificity = 0,0,0,2 */
    ul li         {}  /* a=0 b=0 c=0 d=2 -> specificity = 0,0,0,2 */
    ul ol+li      {}  /* a=0 b=0 c=0 d=3 -> specificity = 0,0,0,3 */
    h1 + *[rel=up]{}  /* a=0 b=0 c=1 d=1 -> specificity = 0,0,1,1 */
    ul ol li.red  {}  /* a=0 b=0 c=1 d=3 -> specificity = 0,0,1,3 */
    li.red.level  {}  /* a=0 b=0 c=2 d=1 -> specificity = 0,0,2,1 */
    #x34y         {}  /* a=0 b=1 c=0 d=0 -> specificity = 0,1,0,0 */
    style=""          /* a=1 b=0 c=0 d=0 -> specificity = 1,0,0,0 */

> - 即使选择器中使用的是`[id="foo"]`，它也只是一个**属性选择器**，ID选择器`#foo`的优先级依然较高。
> - ~~选择器`.bar[class="bar"]`计算为2个。~~
> - ~~同一个选择器使用了多次均进行计算。比如`.foo.foo.foo`计算为3个、`[title][title]`计算为2个。~~

#### CSS3

在[CSS3][css3]中，行内样式单独计算，优先级高于选择器。分组变为三组：

- a：ID选择器
- b：除ID之外的其他属性，如`.classname`、`[href]`；伪类，如`:active`、`:first-child`；不包含伪元素。
- c：标签选择器以及伪元素，如`:first-letter`、`:before`
- 忽略通配符`*`

> 本质上跟CSS2里面的规则是一样的。

示例：

    *               /* a=0 b=0 c=0 -> specificity =   0 */
    LI              /* a=0 b=0 c=1 -> specificity =   1 */
    UL LI           /* a=0 b=0 c=2 -> specificity =   2 */
    UL OL+LI        /* a=0 b=0 c=3 -> specificity =   3 */
    H1 + *[REL=up]  /* a=0 b=1 c=1 -> specificity =  11 */
    UL OL LI.red    /* a=0 b=1 c=3 -> specificity =  13 */
    LI.red.level    /* a=0 b=2 c=1 -> specificity =  21 */
    #x34y           /* a=1 b=0 c=0 -> specificity = 100 */
    #s12:not(FOO)   /* a=1 b=0 c=1 -> specificity = 101 */

> 在线演示：[Test 1][test1]

#### 被忽略的

选择器中以下部分在计算优先级时将被忽略：

- 通配符`*`
- 连接符`+`、`' ' `(空格)、`~`、`>`
- 否定伪类`:not()`

> 否定伪类(the negation pseudo-class)即`:not()`在计算优先级时将被忽略，但是其包含的选择器将被作为正常的选择器加入到整体的优先级计算中。如`p:not(.more)`这条规则在实际计算中将当成`p.more`进行优先级计算。

#### 逗号分隔符`,`

~~有部分文章指出，使用逗号分隔符的选择器，里面的所有部分都进入最终的权重计算~~。**没有这回事**，逗号分隔符所隔开的每个选择器将**单独**进行计算。

#### 同权重的情形

根据CSS样式被定义的顺序决定优先级，后面的将会覆盖前面定义过的，一句话概括就是**后来者居上**。

- 页内样式`<style>...</style>`与外联方式`<link rel="stylesheet" type="text/css" href="...">`同样比较谁后应用，摆放在后面的具有更高优先级。
- 在`import`即文件引入方法中，被引入的文件优先级**仅次于**引用的。**不建议使用import方法**，请参阅：[PageSpeed: Avoid CSS @import](https://gtmetrix.com/avoid-css-import.html)、[Why does not recommend the use of CSS @import](http://www.programering.com/a/MjM4kTMwATM.html)

#### 关于一个小BUG

在网上曾有这样的CSS权重计算说明：

> 内联样式的权重值是1000，ID选择器的权重值是100，class选择器的权重值是10，标签选择器的权重值是1。整条规则中的所有选择器权重值相加得到整个样式规则的权重值，数字越大权重值越高。

虽然总结的很不错，但是如果遇到以下的情形，岂不是就~~懵逼~~了？

```css
    html body article div table tr td p a span i{ color: black; }
    .icon-text{ color: white; }
```

那么问题来了：如果以上两条选择器对应着同一个元素，那么它的颜色到底是什么呢？

- ~~我不会告诉你它是白色的~~
- ~~竟然用了11个标签名字~~
- ~~会不会有人用11个类名呢~~
- ~~据说这样的错误的经验同样出现在了《CSS 权威指南》一书中，**第二版已修复**~~
- ~~我的确是钻牛角尖咯~~

> 在线演示：[Test 2][test2]

#### 目空一切的`!important`

`!important`规则在CSS中是一个神奇的存在，它目空一切，凌驾于其他所有规则之上。一般计算机语言中，感叹号表示取非、否定，然而CSS特立独行，专门使用`!important`来提升存在感。我们可以将这个感叹号理解为**着重强调**。

- 多个`!important`怎么计算？
  - 按上面的规则计算权重。这里要建议一下，一个元素的css样式上只出现一个`!important`，就像HTML代码中每个元素只给定一个`ID`一样。~~当然，你非要给定多个ID那也随你咯。~~
- IE6不支持`!important`
  - ~~不支持拉倒~~
- **不建议使用`!important`方法**，~~免得一不小心弄了很多个出来，显得尴尬~~。详情请参阅：[!important CSS Declarations: How and When to Use Them](https://www.smashingmagazine.com/2010/11/the-important-css-declaration-how-and-when-to-use-it/)

#### 继承`inherite`

关于CSS样式继承，由于并非元素本身的样式定义，所以连个优先级都谈不上，其优先级将被直接忽略。

#### “诡异”的伪元素

我们先来看一下一段CSS代码：
```css
    p:first-letter{color:red;}
```

对应的HTML代码：
```html
    <p><span style="color:cyan;">A</span>BCDEFG</p>
```

那么，这个字母A到底会是什么颜色呢？

> 伪元素测试：[Test 4][test4]

从示例中可以看到，A字母的颜色并不是行内样式指定的青色`cyan`，而是红色`red`。

W3的官方文档[Selectors Level 3](https://www.w3.org/TR/2011/REC-css3-selectors-20110929/#pseudo-elements)中指出：


    p { color: red; font-size: 12pt }
    p::first-letter { color: green; font-size: 200% }
    p::first-line { color: blue }

    <P>Some text that ends up on two lines</P>


以上的代码将会以下面的方式进行解析：

    <P>
    <P::first-line>
    <P::first-letter> 
    S 
    </P::first-letter>ome text that 
    </P::first-line> 
    ends up on two lines 
    </P>

多个元素层叠的情况时，以下代码：

    <div>
    <p>The first text.

将被视作：

    <div>
    <p><div::first-letter><p::first-letter>T</...></...>he first text.

之后再计算其CSS规则，所以在[Test 4][test4]中可以看到即使指定了其行内样式，最终css样式应用的却是伪元素指定的那个。

> - After the rule p::before {content: "Note: "}, the selector p::first-letter matches the "N" of "Note".
> - 在before伪元素的内容里面，first-letter伪元素同样会进行匹配。

由于伪元素无法被常规选择器选中，所以其样式一般直接由伪元素选择器进行指定。~~无敌就是寂寞。~~

*更复杂的伪元素情形这里就不做深入讨论了。*

### 总结

写了这么多，再做总结似乎也显得没什么必要。那么，本文到此结束。以下诸多资料请自行参考。~~排序有先后，阅读请注意。~~

---

### 参考资料
- [Cascading Style Sheets, level 1][css1]
- [Cascading Style Sheets Level 2 Revision 1 (CSS 2.1) Specification][css2]
- [Selectors Level 3][css3]
- [Specificity - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity)
- [What the Heck Is CSS Specificity?](https://designshack.net/articles/css/what-the-heck-is-css-specificity/)
- [Selector Specificity](http://juicystudio.com/article/selector-specificity.php)
- [你应该知道的一些事情——CSS权重](http://www.w3cplus.com/css/css-specificity-things-you-should-know.html)
- [CSS Specificity: Things You Should Know](https://www.smashingmagazine.com/2007/07/css-specificity-things-you-should-know/comment-page-2/#comments)
- [!important CSS Declarations: How and When to Use Them](https://www.smashingmagazine.com/2010/11/the-important-css-declaration-how-and-when-to-use-it/)
- [深入解析CSS样式层叠权重值](http://ofcss.com/2011/05/26/css-cascade-specificity.html)
- [CSS: Specificity Wars](https://stuffandnonsense.co.uk/archives/css_specificity_wars.html)
- [CSS Structure and Rules](http://www.htmlhelp.com/reference/css/structure.html)
- [重新认识CSS的权重](http://blog.cssforest.org/2011/05/19/%E9%87%8D%E6%96%B0%E8%AE%A4%E8%AF%86CSS%E7%9A%84%E6%9D%83%E9%87%8D.html)

[css1]: https://www.w3.org/TR/REC-CSS1/#cascading-order
[css2]: https://www.w3.org/TR/2011/REC-CSS2-20110607/cascade.html#specificity
[css3]: https://www.w3.org/TR/2011/REC-css3-selectors-20110929/#specificity
[test1]: http://runjs.cn/code/mkk1w1x5
[test2]: http://runjs.cn/code/1nyatoxb
[test3]: http://runjs.cn/code/7rvnmqjq
[test4]: http://runjs.cn/code/52lchoew

