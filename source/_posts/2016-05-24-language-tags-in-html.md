---
title: HTML的lang标记
date: 2016-05-24 10:58:41
tags: 
- lang
- html
- 前端
categories:
- WEB
- HTML
---

很多网站中，都会对html标签设置一个lang属性，用来指定网页采用的语言类型。英文网站中，这个值通常是en，即`<html lang="en">`，而在中文网站中，这个值就变得光怪陆离了。在以前，最常见的两个设置方式是`<html lang="zh">`和`<html lang="zh-cn">`，那么，这究竟是怎么一回事呢？

<!--more-->

知乎上有一个针对这个问题进行过细致讨论的页面：[网页头部的声明应该是用 lang="zh" 还是 lang="zh-cn"？][1]。本文将根据这个问题的各个答案进行一个综合整理，记录HTML中这些有意思的东西。

### HTML标签的lang属性

HTML标签的lang属性将指定对应元素内容的语言。

```blockquote The lang and xml:lang attributes https://www.w3.org/TR/html5/dom.html#the-lang-and-xml:lang-attributes
The lang attribute (in no namespace) specifies the primary language for the element's contents and for any of the element's attributes that contain text. Its value must be a valid BCP 47 language tag, or the empty string. Setting the attribute to the empty string indicates that the primary language is unknown.
```

大多数情况下，直接对`html`标签指定lang属性，表示当前文档显示的语言。

```html
<html lang="ar">    
```

以上代码意味着该网页的内容显示文本为阿拉伯语。

在一些HTML4/XHTML的页面中，则有使用这样的方式进行指定的：

```html
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN" xml:lang="zh-CN">
```

- en定义语言为英语
- zh-CN定义语言为中文

也有一些多语言的页面会对指定元素的lang属性进行设置，如：

```html 指定该p标签的语言为德语
<p lang="de">Ich bin der brennende Komet</p>
```

#### 指定lang属性的益处

1. 协助搜索引擎
2. 协助语音合成
3. 协助选择符号异体字用于高品质的印刷
4. 协助选择一套引号
5. 协助解决连字符、绑定和空格
6. 协助进行拼写检查和语法检查

### 语言文字标签书写顺序

规定语言标签按以下形式排列：

```blockquote 该顺序由RFC 5646也就是BCP 47指定
language-extlang-script-region-variant-extension-privateuse
```

- language 语言种类
- extlang 扩展语言
- script 书写格式
- region 国家和地区
- variant 变体
- extension 扩展
- privateuse 私有

所有语言标签都是大小写无关的，但是通常约定language标签全部小写，region标签全部大写，script标签只有首字母大写。不同标签之间用连字号-连接。

### 复杂的汉语体系

汉语演进到当今的情形，已经变得十分繁杂，有简体、繁体、各地方言，不同地区的不同汉语也不尽相同，比如东南亚的新加坡、马来西亚等地的汉语，在使用上与其他地方有一定的差异性。在中国，各地方言体系更加繁杂，如普通话、吴语、闽南语、粤语、客家话等。

在2007年公布的ISO标准中，指定了汉语为一个宏语言（macrolanguage），也可以叫做大语种。以下表格列出了13个主要的语种：

值|释义|说明
---|---|---
cmn|普通话|北方话、国语
wuu|吴语|江浙话、上海话
czh|徽语|徽州话、严州话、吴语-徽严片
hak|客家语|
yue|粤语|广东话
nan|闽南语|福建话、台语
cpx|莆仙话|莆田话、兴化语
cdo|闽东语|
mnp|闽北语|
zco|闽中语|
gan|赣语|江西话
hsn|湘语|湖南话
cjy|晋语|山西话、陕北话

看一看BCP 47的解释：

```blockquote BCP 47 https://tools.ietf.org/html/bcp47#section-2.2.2
For example, the macro language Chinese ('zh') encompasses a number of languages. For compatibility reasons, each of these languages has both a primary and extended language subtag in the registry. A few selected examples of these include Gan Chinese ('gan'), Cantonese Chinese ('yue'), and Mandarin Chinese ('cmn'). Each is encompassed by the macro language 'zh' (Chinese). Therefore, they each have the prefix "zh" in their registry records. Thus, Gan Chinese is represented with tags beginning "zh-gan" or "gan", Cantonese with tags beginning either "yue" or "zh-yue", and Mandarin Chinese with "zh-cmn" or "cmn". The language subtag 'zh' can still be used without an extended language subtag to label a resource as some unspecified variety of Chinese, while the primary language subtag ('gan', 'yue', 'cmn') is preferred to using the extended language form ("zh-gan", "zh-yue", "zh-cmn").
```

大意为汉语这个语系太大了，包含了许多语种，为了兼容性与精确性，将之分为一些不同的小语种。所以就出现了形如 `zh-gan`/`gan`、`zh-yue`/`yue`、`zh-cmn`/`cmn`这样的标记方法。推荐使用后者，即不带`zh-`的。

### 到底用哪一个？

既然汉语语种如此之多，在实际运用中我们到底应该怎么处理呢？

之前提到的知乎上的问题：[网页头部的声明应该是用 lang="zh" 还是 lang="zh-cn"？][1]，里面的大部分回答者都表示题主提到的两种方式已经不赞成被继续使用了。

根据IANA的语言标准注册记录[language-subtag-registry][4]，诸如`zh-Hans, zh-Hans-CN, zh-cmn, zh-cmn-Hans, zh-cmn-Hant, zh-wuu, zh-yue, zh-gan`这些都已经变成了Deprecated状态了。

然而，为了照顾兼容性，很多网页依旧保留了这样的方式。

在BCF 47的文档中，并没有提出形如`lang="zh"`、`lang="zh-CN"`、`lang="zh-cmn-Hans"`这类表述方式不符合要求。如大名鼎鼎的[维基百科](https://zh.wikipedia.org/)，[知乎平台](https://www.zhihu.com/)，更有如今已经被墙的科技巨头的谷歌中文站点，其网页的语言类型使用的都是`lang="zh-CN"`。

关于被废弃（deprecated）的写法，BCP 47里面也做了相应的介绍：
```blockquote BCP 47 http://tools.ietf.org/html/bcp47#section-2.2.8
Many of these registered tags were made redundant by the advent of either RFC 4646 or this document. A redundant tag is a grandfathered registration whose individual subtags appear with the same semantic meaning in the registry. For example, the tag "zh-Hant" (Traditional Chinese) can now be composed from the subtags 'zh' (Chinese) and 'Hant' (Han script traditional variant). These redundant tags are maintained in the registry as records of type 'redundant', mostly as a matter of historical curiosity.
```

大致意思是因为`zh`和`Hans`已经被收录了，再来一个`zh-Hans`就显得有点多余（redundant）了；然而真正使用`lang="zh-Hans"`也是没有什么问题的。

以下列举一下所谓的_符合规范_的写法：
- cms-Hans: 简体普通话，用规范汉子写下来，如“它是一个刮胡刀”，为了兼容，可以使用`zh-cmn-Hans`。
- yue-Hans：粤语用规范汉字写下来，比如“佢系一个须刨嚟嘅”，没必要为兼容而使用`zh-yue-Hans`，因为看得懂`zh-CN`的人，看不懂这些字。
- yue-Hant：粤语用國字写下来，比如“佢係一個鬚刨嚟嘅”。
- lzh-Hans：文言文用规范汉字写下来，比如“驴不胜怒，蹄之”。
- lzh-Hant：文言文用國字写下来，比如“驢不勝怒，蹄之”。

以上示例摘自知乎作者[杨周](https://www.zhihu.com/question/20797118/answer/81543429)的回答。

突然想起了一句诗词（~~内心思想还真是天马行空呐~~）：
```blockquote 曹植,七步诗
本是同根生，相煎何太急。
```

### 总结

针对这个问题，我忍不住翻越了大量的资料，到头来发现自己更加懵懂了。之前我设计网页的时候已经习惯了采用`<html lang="zh-cmn-Hans">`和`<html lang="zh-CN">`了；但是现在更多时候是不指定lang属性。

~~前端是个纷杂的世界，具体需要采用哪一种值，只要**不是太令人费解**，都是可以接受的。~~

有的时候为了照顾兼容性，不得不舍弃了新特性，想想也真是人在江湖，身不由己。有些问题有时候也是一个历史遗留问题，是没有良好的解决办法的，总不能直接全部推倒重来吧。然而社会在往前走，科技也在逐渐更新换代，比如最新的CSS选择器草案里面，已经把之前~~不起眼~~的[:lang选择器](https://drafts.csswg.org/selectors/#lang-pseudo)加入了关于BCP 47的高级匹配算法支持。

---
本文到此结束，以下有诸多资料，诸君自行阅读。

### 参考资料
- [网页头部的声明应该是用 lang="zh" 还是 lang="zh-cn"？][1]
- [BCP47 - Tags for Identifying Languages][2]
- [Language tags in HTML and XML][3]
- [Language Subtag Registry][4]
- [IETF language tag - Wikipedia][5]
- [3 Semantics, structure, and APIs of HTML documents][6]
- [Basic HTML data types][7]
- [ISO 639 macrolanguage][8]
- [语种名称代码][9]
- [Understanding the New Language Tags][10]

[1]: https://www.zhihu.com/question/20797118
[2]: http://tools.ietf.org/html/bcp47
[3]: https://www.w3.org/International/articles/language-tags/
[4]: http://www.iana.org/assignments/language-subtag-registry/language-subtag-registry
[5]: https://en.wikipedia.org/wiki/IETF_language_tag
[6]: https://www.w3.org/TR/html5/dom.html#the-lang-and-xml:lang-attributes
[7]: https://www.w3.org/TR/html4/types.html#h-6.8
[8]: https://en.wikipedia.org/wiki/ISO_639_macrolanguage
[9]: http://www.ruanyifeng.com/blog/2008/02/codes_for_language_names.html
[10]: https://www.w3.org/International/articles/bcp47/