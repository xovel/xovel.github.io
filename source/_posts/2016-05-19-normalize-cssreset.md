---
title: 从 normalize.css 分析 CSS Reset
date: 2016-05-19 10:38:03
categories:
- WEB
- 前端
tags:
- normalize
- css
---

### 为什么要进行 `CSS Reset` 
目的简单而又粗暴：使CSS样式在各种浏览器下呈现的效果一样。
<!--more-->
当年的一个~~黑魔法~~：
```css
* { margin: 0; padding: 0; }
```
这种粗暴的方式曾经给浏览器带来了很大的负荷，它由曾经的红极一时变成现在不受待见。

后来有了一个更加~~飘逸~~的`CSS Reset`代码，它是这样写的：
```css
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, code, form, fieldset, legend, input, button, textarea, p, blockquote, th, td { margin: 0;padding: 0; }
```
更有甚者，将前面一堆CSS选择器换成了几乎所有HTML标签，与上一个黑魔法并无二致。

这里引用一下[张鑫旭](http://www.zhangxinxu.com/wordpress/2010/04/css-reset%e7%9a%84%e9%87%8d%e6%96%b0%e5%ae%a1%e8%a7%86-%e9%81%bf%e5%85%8d%e6%a0%b7%e5%bc%8f%e9%87%8d%e7%bd%ae/)的吐槽：

> 1. div标签默认有margin值吗？有padding值吗？怎么会想到应用div{margin:0; padding:0;}属性呢？真是画蛇添足，多此一举。
> 2. dt标签有默认的margin与padding值就是0，这里为什么还要使用呢？
> 3. li标签默认有margin值吗？有padding值吗？压根就没有，也不自己测测，还没事找事设置个li{margin:0; padding:0;}属性，真是衰！
> 4. code标签是个属于inline水平的元素，居然也扯到margin与padding的重置，真是好笑。
> 5. 还有，像form, input, button, textarea这样子的表单元素，有margin值吗？有padding值吗？我真是不解！
> 6. fieldset, legend这两个90年代的标签你的网站上使用了吗？使用概率不足1%的标签也拿来重置，我实在无语了。
> 7. 还有th，td这些标签，幸好没有写上table与tr标签，否则我一起痛批一段。

---

### normalize.css是什么？

[normalize.css](https://github.com/necolas/normalize.css)是一个`CSS Reset`项目，由[necolas](https://github.com/necolas)发起并维护。

以下部分文字为`normalize.css`官网的介绍：
> **A modern, HTML5-ready alternative to CSS resets**

> Normalize.css makes browsers render all elements more consistently and in line with modern standards. It precisely targets only the styles that need normalizing.

[知乎](https://www.zhihu.com/question/20094066)上有一段针对normalize.css 的评价：
> Normalize 相对「平和」，注重通用的方案，重置掉该重置的样式，保留有用的 user agent 样式，同时进行一些 bug 的修复，这点是 reset 所缺乏的。


### 参考资料
- [Normalize.css](http://necolas.github.io/normalize.css/)
- [About normalize.css](http://nicolasgallagher.com/about-normalize-css/)
- [来，让我们谈一谈 Normalize.css](http://jerryzou.com/posts/aboutNormalizeCss/)
- [What is the difference between Normalize.css and Reset CSS?](http://stackoverflow.com/questions/6887336/what-is-the-difference-between-normalize-css-and-reset-css)
- [Normalize.css 与传统的 CSS Reset 有哪些区别？](https://www.zhihu.com/question/20094066)
- [The CSS user agent style sheet and presentational hints](https://html.spec.whatwg.org/multipage/rendering.html#the-css-user-agent-style-sheet-and-presentational-hints)
- [CSS reset的重新审视 – 避免样式重置](http://www.zhangxinxu.com/wordpress/2010/04/css-reset%e7%9a%84%e9%87%8d%e6%96%b0%e5%ae%a1%e8%a7%86-%e9%81%bf%e5%85%8d%e6%a0%b7%e5%bc%8f%e9%87%8d%e7%bd%ae/)
- [Reset CSS:只选对的，不选"贵"的](http://www.cnblogs.com/yizuierguo/archive/2009/07/15/1524106.html)
- [NEC : 更好的CSS样式解决方案](http://nec.netease.com/)

---

### `normalize.css v4.1.1` 源码
```css
/*! normalize.css v4.1.1 | MIT License | github.com/necolas/normalize.css */

/**
 * 1. Change the default font family in all browsers (opinionated).
 * 2. Prevent adjustments of font size after orientation changes in IE and iOS.
 */

html {
  font-family: sans-serif; /* 1 */
  -ms-text-size-adjust: 100%; /* 2 */
  -webkit-text-size-adjust: 100%; /* 2 */
}

/**
 * Remove the margin in all browsers (opinionated).
 */

body {
  margin: 0;
}

/* HTML5 display definitions
   ========================================================================== */

/**
 * Add the correct display in IE 9-.
 * 1. Add the correct display in Edge, IE, and Firefox.
 * 2. Add the correct display in IE.
 */

article,
aside,
details, /* 1 */
figcaption,
figure,
footer,
header,
main, /* 2 */
menu,
nav,
section,
summary { /* 1 */
  display: block;
}

/**
 * Add the correct display in IE 9-.
 */

audio,
canvas,
progress,
video {
  display: inline-block;
}

/**
 * Add the correct display in iOS 4-7.
 */

audio:not([controls]) {
  display: none;
  height: 0;
}

/**
 * Add the correct vertical alignment in Chrome, Firefox, and Opera.
 */

progress {
  vertical-align: baseline;
}

/**
 * Add the correct display in IE 10-.
 * 1. Add the correct display in IE.
 */

template, /* 1 */
[hidden] {
  display: none;
}

/* Links
   ========================================================================== */

/**
 * 1. Remove the gray background on active links in IE 10.
 * 2. Remove gaps in links underline in iOS 8+ and Safari 8+.
 */

a {
  background-color: transparent; /* 1 */
  -webkit-text-decoration-skip: objects; /* 2 */
}

/**
 * Remove the outline on focused links when they are also active or hovered
 * in all browsers (opinionated).
 */

a:active,
a:hover {
  outline-width: 0;
}

/* Text-level semantics
   ========================================================================== */

/**
 * 1. Remove the bottom border in Firefox 39-.
 * 2. Add the correct text decoration in Chrome, Edge, IE, Opera, and Safari.
 */

abbr[title] {
  border-bottom: none; /* 1 */
  text-decoration: underline; /* 2 */
  text-decoration: underline dotted; /* 2 */
}

/**
 * Prevent the duplicate application of `bolder` by the next rule in Safari 6.
 */

b,
strong {
  font-weight: inherit;
}

/**
 * Add the correct font weight in Chrome, Edge, and Safari.
 */

b,
strong {
  font-weight: bolder;
}

/**
 * Add the correct font style in Android 4.3-.
 */

dfn {
  font-style: italic;
}

/**
 * Correct the font size and margin on `h1` elements within `section` and
 * `article` contexts in Chrome, Firefox, and Safari.
 */

h1 {
  font-size: 2em;
  margin: 0.67em 0;
}

/**
 * Add the correct background and color in IE 9-.
 */

mark {
  background-color: #ff0;
  color: #000;
}

/**
 * Add the correct font size in all browsers.
 */

small {
  font-size: 80%;
}

/**
 * Prevent `sub` and `sup` elements from affecting the line height in
 * all browsers.
 */

sub,
sup {
  font-size: 75%;
  line-height: 0;
  position: relative;
  vertical-align: baseline;
}

sub {
  bottom: -0.25em;
}

sup {
  top: -0.5em;
}

/* Embedded content
   ========================================================================== */

/**
 * Remove the border on images inside links in IE 10-.
 */

img {
  border-style: none;
}

/**
 * Hide the overflow in IE.
 */

svg:not(:root) {
  overflow: hidden;
}

/* Grouping content
   ========================================================================== */

/**
 * 1. Correct the inheritance and scaling of font size in all browsers.
 * 2. Correct the odd `em` font sizing in all browsers.
 */

code,
kbd,
pre,
samp {
  font-family: monospace, monospace; /* 1 */
  font-size: 1em; /* 2 */
}

/**
 * Add the correct margin in IE 8.
 */

figure {
  margin: 1em 40px;
}

/**
 * 1. Add the correct box sizing in Firefox.
 * 2. Show the overflow in Edge and IE.
 */

hr {
  box-sizing: content-box; /* 1 */
  height: 0; /* 1 */
  overflow: visible; /* 2 */
}

/* Forms
   ========================================================================== */

/**
 * 1. Change font properties to `inherit` in all browsers (opinionated).
 * 2. Remove the margin in Firefox and Safari.
 */

button,
input,
optgroup,
select,
textarea {
  font: inherit; /* 1 */
  margin: 0; /* 2 */
}

/**
 * Restore the font weight unset by the previous rule.
 */

optgroup {
  font-weight: bold;
}

/**
 * Show the overflow in IE.
 * 1. Show the overflow in Edge.
 */

button,
input { /* 1 */
  overflow: visible;
}

/**
 * Remove the inheritance of text transform in Edge, Firefox, and IE.
 * 1. Remove the inheritance of text transform in Firefox.
 */

button,
select { /* 1 */
  text-transform: none;
}

/**
 * 1. Prevent a WebKit bug where (2) destroys native `audio` and `video`
 *    controls in Android 4.
 * 2. Correct the inability to style clickable types in iOS and Safari.
 */

button,
html [type="button"], /* 1 */
[type="reset"],
[type="submit"] {
  -webkit-appearance: button; /* 2 */
}

/**
 * Remove the inner border and padding in Firefox.
 */

button::-moz-focus-inner,
[type="button"]::-moz-focus-inner,
[type="reset"]::-moz-focus-inner,
[type="submit"]::-moz-focus-inner {
  border-style: none;
  padding: 0;
}

/**
 * Restore the focus styles unset by the previous rule.
 */

button:-moz-focusring,
[type="button"]:-moz-focusring,
[type="reset"]:-moz-focusring,
[type="submit"]:-moz-focusring {
  outline: 1px dotted ButtonText;
}

/**
 * Change the border, margin, and padding in all browsers (opinionated).
 */

fieldset {
  border: 1px solid #c0c0c0;
  margin: 0 2px;
  padding: 0.35em 0.625em 0.75em;
}

/**
 * 1. Correct the text wrapping in Edge and IE.
 * 2. Correct the color inheritance from `fieldset` elements in IE.
 * 3. Remove the padding so developers are not caught out when they zero out
 *    `fieldset` elements in all browsers.
 */

legend {
  box-sizing: border-box; /* 1 */
  color: inherit; /* 2 */
  display: table; /* 1 */
  max-width: 100%; /* 1 */
  padding: 0; /* 3 */
  white-space: normal; /* 1 */
}

/**
 * Remove the default vertical scrollbar in IE.
 */

textarea {
  overflow: auto;
}

/**
 * 1. Add the correct box sizing in IE 10-.
 * 2. Remove the padding in IE 10-.
 */

[type="checkbox"],
[type="radio"] {
  box-sizing: border-box; /* 1 */
  padding: 0; /* 2 */
}

/**
 * Correct the cursor style of increment and decrement buttons in Chrome.
 */

[type="number"]::-webkit-inner-spin-button,
[type="number"]::-webkit-outer-spin-button {
  height: auto;
}

/**
 * 1. Correct the odd appearance in Chrome and Safari.
 * 2. Correct the outline style in Safari.
 */

[type="search"] {
  -webkit-appearance: textfield; /* 1 */
  outline-offset: -2px; /* 2 */
}

/**
 * Remove the inner padding and cancel buttons in Chrome and Safari on OS X.
 */

[type="search"]::-webkit-search-cancel-button,
[type="search"]::-webkit-search-decoration {
  -webkit-appearance: none;
}

/**
 * Correct the text style of placeholders in Chrome, Edge, and Safari.
 */

::-webkit-input-placeholder {
  color: inherit;
  opacity: 0.54;
}

/**
 * 1. Correct the inability to style clickable types in iOS and Safari.
 * 2. Change font properties to `inherit` in Safari.
 */

::-webkit-file-upload-button {
  -webkit-appearance: button; /* 1 */
  font: inherit; /* 2 */
}
```