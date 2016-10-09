---
title: Page Visibility API之visibilitychange事件简介
date: 2016-10-08 15:46:39
tags: [event, API]
categories: [WEB]
description: 本文简单介绍一下Page Visibility API，利用document的visibilitychange可以做一些有趣的事情。
---

### 简介

`Page Visibility API`提供了一套让用户获悉当前网页是否可见或是否在焦点中。在多页浏览时，该属性会随着页面的切换而进行改动。当用户最小化页面或者切换至其他页面时，该API会发出一个`visibilitychange`事件告知网页的visibility属性已经发生了改变。

利用这个特性，我们可以针对性的做出一些动作，比如提醒用户已经离开该页面。特别是在播放视频的页面，当页面丢失焦点之后可以利用这个API做出一些特定的动作以提升网页的用户体验，比如暂停视频的播放。

注意：在使用了`iframe`的页面中，iframe的visibility属性跟随父文档。

### 示例

*页面失去焦点后改变文档的标题*

```js
document.addEventListener("visibilitychange", function (){
  document.title = 'new title~';
}, false);
```

### 浏览器兼容性

~~该小节内容改编自MDN文档，请参考最新的兼容性说明页面[Page Visibility - Can I Use]~~

**桌面浏览器**

浏览器|起始版本
--|--
Chrome|13`webkit`
Chrome|33
Firefox (Gecko)|18 (18)
Internet Explorer|10
Opera|12.10
Safari (WebKit)|7

**移动端**

浏览器|起始版本
--|--
Android|4.4`webkit`
Firefox Mobile (Gecko)|18.0 (18)
IE Phone|10
Opera Mobile|12.10
Safari Mobile|7

注意：
- Opera浏览器中，当窗口最小化之后不要触发`visibilitychange`事件，也不要尝试设置`hidden`值
- Firefox浏览器中，版本10-51之间的需要添加私有前缀moz(`-moz-`)
- `webkit`表示需要添加私有前缀`-webkit-`

### 参考资料

- [Page Visibility - The visibilitychange event](https://www.w3.org/TR/page-visibility/#sec-visibilitychange-event)
- [Page Visibility API - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/Page_Visibility_API)
- [Description of the Page Visibility API on the IEBlog](https://blogs.msdn.microsoft.com/ie/2011/07/08/using-pc-hardware-more-efficiently-in-html5-new-web-performance-apis-part-2/ "Using PC Hardware more efficiently in HTML5: New Web Performance APIs, Part 2")
- [Page Visibility - Can I Use]

[Page Visibility - Can I Use]: http://caniuse.com/#feat=pagevisibility