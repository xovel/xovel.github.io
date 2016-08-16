---
title: 一探究竟：display
date: 2016-05-20 12:35:06
categories:
- WEB
- CSS
tags:
- 前端
- css
- display
description: 关于display的一些知识。
---

### 概述
一句话概括：display属性，设置元素如何显示。

> display属性指定元素渲染使用的类型。

### 语法

*display: none | inline | block | list-item | inline-list-item | inline-block | inline-table | table | table-cell | table-column | table-column-group | table-footer-group | table-header-group | table-row | table-row-group | flex | inline-flex | grid | inline-grid | run-in | ruby | ruby-base | ruby-text | ruby-base-container | ruby-text-container | contents*

```
display: none

display: inline
display: block
display: contents
display: list-item
display: inline-block
display: inline-table
display: table
display: table-cell
display: table-column
display: table-column-group
display: table-footer-group
display: table-header-group
display: table-row
display: table-row-group
display: flex
display: inline-flex
display: grid
display: inline-grid
display: ruby
display: ruby-base
display: ruby-text
display: ruby-base-container
display: ruby-text-container 
display: run-in

display: inherit
display: initial
display: unset
```

### 取值

值 | 释义
---|---
none|隐藏对象。与visibility属性的hidden值不同，其不为被隐藏的对象保留其物理空间
inline|指定对象为内联元素。
block|指定对象为块元素。
list-item|指定对象为列表项目。
inline-block|指定对象为内联块元素。（CSS2）
table|指定对象作为块元素级的表格。类同于html标签`table`（CSS2）
inline-table|指定对象作为内联元素级的表格。类同于html标签`table`（CSS2）
table-caption|指定对象作为表格标题。类同于html标签`caption`（CSS2）
table-cell|指定对象作为表格单元格。类同于html标签`td`（CSS2）
table-row|指定对象作为表格行。类同于html标签`tr`（CSS2）
table-row-group|指定对象作为表格行组。类同于html标签`tbody`（CSS2）
table-column|指定对象作为表格列。类同于html标签`col`（CSS2）
table-column-group|指定对象作为表格列组显示。类同于html标签`colgroup`（CSS2）
table-header-group|指定对象作为表格标题组。类同于html标签`thead`（CSS2）
table-footer-group|指定对象作为表格脚注组。类同于html标签`tfoot`（CSS2）
run-in|根据上下文决定对象是内联对象还是块级对象。（CSS3）
box|将对象作为弹性伸缩盒显示。（伸缩盒最老版本）（CSS3）
inline-box|将对象作为内联块级弹性伸缩盒显示。（伸缩盒最老版本）（CSS3）
flexbox|将对象作为弹性伸缩盒显示。（伸缩盒过渡版本）（CSS3）
inline-flexbox|将对象作为内联块级弹性伸缩盒显示。（伸缩盒过渡版本）（CSS3）
flex|将对象作为弹性伸缩盒显示。（伸缩盒最新版本）（CSS3）
inline-flex|将对象作为内联块级弹性伸缩盒显示。（伸缩盒最新版本）（CSS3）

> 实验性的属性，如grid, ruby, content等这里没有列出，具体请参考[MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/display#Values)页面。

#### _display:none_ vs _visibility:hidden_
- display:none
  - 视为不存在，且不加载！
  - 使用该属性后，HTML元素（对象）的宽度、高度等各种属性值都将“丢失”
  - 消失于视野，不占任何空间
- visibility:hidden
  - 隐藏，但在浏览时保留位置
  - 使用该属性后，HTML元素（对象）仅仅是在视觉上看不见（完全透明），而它所占据的空间位置仍然存在，也即是说它仍具有高度、宽度等属性值。
  - 隐形，虽然视野看不见，但仍有占位符

#### _display:inline-block_相关
- *display:inline-block*：将对象呈递为内联对象，但是对象的内容作为块对象呈递。旁边的内联对象会被呈递在同一行内，允许空格。
- IE6、7支持inline元素转换成inline-block，但不支持block元素转换成inline-block，所以非inline元素在IE6、7下要转换成inline-block，需先转换成inline，然后触发hasLayout，以此来获得和inline-block类似的效果

> 你可以使用以下代码实现上一条效果：

```css
div {
    display: inline-block;
    *display: inline;
    *zoom: 1;
}
```

#### 其他说明
- 如果position既不是static也不是relative或者float不是none或者元素是根元素，当display:inline-table时，display的计算值为table；当display:inline | inline-block | run-in | table-* 系时，display的计算值为block，其它情况为指定值。


### jQuery中对元素display属性的操作
jQuery中对获取元素默认display属性的代码：

```javascript jQuery1.12.2 https://github.com/jquery/jquery/blob/1.12-stable/src/css/defaultDisplay.js
    // 代码太长，请点击右上角link查看。
```
jQuery中调用display默认值进行应用的实现函数：

```javascript jQuery1.12.2 https://github.com/jquery/jquery/blob/1.12-stable/src/css/showHide.js
    // 代码太长，请点击右上角link查看。
```

jQuery通过创建一个新元素，然后获取其默认的display属性值，并加入到缓存中。需要使用时从这个缓存对象中将display默认值取出并使用。最终实现方法为fn.show()、fn.hide()以及fn.toggle()。jQuery中对show/hide/toggle方法在后续处理中进行过动画相关操作，这里不是本文探讨的内容。更多信息请参阅[jQuery官方API文档](http://api.jquery.com/show)。

### QsLinz.js对display的实现
```javascript QsLinz.js https://github.com/xovel/qslinz/blob/master/QsLinz.0.1.1.js#L707
    // 代码太长，请点击右上角link查看。
```

采用强制指定元素display属性的方式，将常见的不同display值存于对象oDisplay中，实现快速获取display值。

```blockquote QsLinz.js https://github.com/xovel/qslinz/
QsLinz.js是仿照jQuery代码风格实现的一个简易Javascript类库，算是一个练手的自定义类库。~~已弃坑，目前未公布版本为0.1.4。~~
```
### 参考资料
- [display - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/display)
- [CSS中display对布局的影响以及元素display的默认值](http://blog.csdn.net/teamlet/article/details/42024995)
- [CSS display property](http://www.w3schools.com/cssref/pr_class_display.asp)
- [.show() | jQuery API Documentation](http://api.jquery.com/show/)
- [display - CSS3参考手册](http://www.css88.com/book/css/properties/layout/display.htm)
- [CSS3 display:flex和display:box有什么区别？](https://www.zhihu.com/question/22991944)
