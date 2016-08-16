---
title: CSS - animation简介
date: 2016-07-19 17:51:43
tags:
- css3
- animation
- 前端
categories:
- WEB
- CSS
description: CSS动画现在应用越来越广泛，animation属性是CSS实现动画的一个重要概念；本文将对CSS的属性animation做一个简单的入门介绍。
---

> 本文根据MDN上的文章[animation - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/animation)整理而成。

### 简介

CSS的`animation`属性是一个简写的合集，包括的内容有：`animation-name`，`animation-duration`，`animation-timing-function`，`animation-delay`，`animation-iteration-count`，`animation-direction`，`animation-fill-mode`，`animation-play-state`。

CSS的animation属性可以应用于所有元素上，包括伪元素`::before`和`::after`。

### animation-name

动画的名字，默认值为`none`。这个名字对应的帧动作将在`@keyframes`中进行定义。

### animation-duration

动画的持续时间，默认值为`0`。为`0`表示动画不会执行。非`0`值需要带单位，可以是秒`s`，也可以是毫秒`ms`。如果不给单位将视为一个无效值。

### animation-timing-function

动画的过度函数。

- `linear`: 线性过渡。相当于贝塞尔曲线`(0.0, 0.0, 1.0, 1.0)`
- `ease`: **默认值**。平滑过渡。相当于贝塞尔曲线`(0.25, 0.1, 0.25, 1.0)`
- `ease-in`: 由慢到快。相当于贝塞尔曲线`(0.42, 0, 1.0, 1.0)`
- `ease-out`: 由快到慢。相当于贝塞尔曲线`(0, 0, 0.58, 1.0)`
- `ease-in-out`: 由慢到快再到慢。相当于贝塞尔曲线`(0.42, 0, 0.58, 1.0)`
- `cubic-bezier(number, number, number, number)`: 特定的贝塞尔曲线类型，number 在 [0, 1] 区间内取值

### animation-delay

动画初始的延迟时间，默认为`0`。为`0`时表示动画无延迟，立即执行。跟`duration`一样，非`0`值需要带单位。

可以设置为负值，设置负值时表示起始状态时动画已经执行了指定的时间。

### animation-iteration-count

动画的循环次数，表示循环次数，默认为`1`。负值无效。*可以是小数，如设置为`2.5`，意味着动画执行两圈半。*

设置为`infinite`表示无限循环。

### animation-direction

在循环中是否反向播放动画。*非循环动画该值无效。*

- `normal`，**默认值**。表示动画正方向正常播放。
- `reverse`，动画方向播放。
- `alternate`，每次循环后更换动画播放方向。即在奇数次时正向播放，在偶数次时反向播放。
- `alternate-reverse`，每次循环后更换动画播放方向，但第一次为反向。即动画在奇数次时反向播放，在偶数次时正向播放。

### animation-fill-mode

*这是一个实验技术。*

指定动画对象在动画执行之前或执行之后的样式状态。

- `none`，**默认值**。不设置对象动画之外的状态
- `forwards`，设置对象状态为动画结束时的状态
- `backwards`，设置对象状态为动画开始时的状态
- `both`，设置对象状态为动画结束或开始的状态

### animation-play-state

表示动画的播放状态。

- `running`，**默认值**。动画正在播放。
- `paused`，动画暂停。

### @keyframes

动画帧的定义动作。

其语法简述为：

`@keyframes identifier {selector {style;}}`

- `identifier`，动画的名称，对应于上面提到的`animation-name`。
- `selector`，动画持续时间的百分比。可以使用`from`来表示`0%`、`to`来表示`100%`。
- `style`，合理的CSS样式值，或者组合。

> `selector`可以使用多个进行组合，以逗号`,`分隔。
> 存在多个百分比一样的声明时，以最后一个为准，前面不论设置了什么都将被忽略~~最新版规范没有对此进行说明，但有部分浏览器已经考虑对其实现了~~。
> 使用`!important`声明样式时，该声明将被**忽略**。

格式化语法：

```
@keyframes <identifier> {
  [ [ from | to | <percentage> ] [, from | to | <percentage> ]* block ]*
}
```

### 兼容性

`animation`是CSS3中的新特性，浏览器对其的实现并不统一。具体兼容性情形请参阅[Can I use](http://caniuse.com/#feat=css-animation)

添加浏览器的特定前缀可以使其达到兼容性要求。

- WebKit系浏览器前缀`-webkit-`，包括诸如Safari、Chrome等众多现代浏览器
- Gecko系浏览器前缀`-moz-`，Firefox内核
- Presto系浏览器前缀`-o-`，**已废弃**，Opera之前的内核。Opera内核现在已经转为`Blink`，该内核是WebKit系。
- Trident系浏览器前缀`-ms-`，IE内核

诸如`-khtml-`、`-icab-`诸君可自行搜索。

在上述提到的所有属性以及`@keyframes`，可_在有必要的情况下_添加对应浏览器的私有前缀以实现兼容。

### 示例

```text
/* @keyframes duration | timing-function | delay | 
   iteration-count | direction | fill-mode | play-state | name */
  animation: 3s ease-in 1s 2 reverse both paused slidein;

/* @keyframes duration | timing-function | delay | name */
  animation: 3s linear 1s slidein;

/* @keyframes duration | name */
  animation: 3s slidein;
```

```css
p {
  animation-duration: 3s;
  animation-name: slidein;
}      
@keyframes slidein {
  from {
    margin-left: 100%;
    width: 300%; 
  }

  to {
    margin-left: 0%;
    width: 100%;
  }
}      
```

> 本人制作的一个错视动画:[错视动画演示](/garden/demo/animation-optical-illusion.html)

### 参考资料

- [animation - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/animation)
- [@keyframes - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/@keyframes)
- [animation-name - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/animation-name)
- [animation-duration - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/animation-duration)
- [animation-timing-function - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/animation-timing-function)
- [animation-delay - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/animation-delay)
- [animation-iteration-count - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/animation-iteration-count)
- [animation-direction - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/animation-direction)
- [animation-fill-mode - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/animation-fill-mode)
- [animation-play-state - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/animation-play-state)

### 扩展阅读

- [CSS Animations Level 1](https://drafts.csswg.org/css-animations/#animation "CSS动画草案")
- [Using CSS animations - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/animation)
- [CSS animated properties - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_animated_properties, "可以使用动画的CSS属性")
- [AnimationEvent - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/AnimationEvent "动画事件")

------
全文完。