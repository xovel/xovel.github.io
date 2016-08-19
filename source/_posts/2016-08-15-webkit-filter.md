---
title: -webkit-filter冰山一角
date: 2016-08-15 18:22:45
tags: [css, filter]
categories: [WEB, CSS]
description: -webkit-filter是css3的一个属性，它为相应元素提供了诸如模糊、色相饱和、反转、灰度化等等之类的图像效果。该属性通常用在对图片、背景、边框这些对象的渲染上面。
---


> 本文根据MDN上的文章[filter - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/filter)翻译/整理而成，去掉了关于`svg`和`url()`方面的内容，并加入了一些自己对CSS Filters的理解。

## 概述

`-webkit-filter`是css3的一个属性，它为相应元素提供了诸如模糊、色相饱和、反转、灰度化等等之类的图像效果。该属性通常用在对图片、背景、边框这些对象的渲染上面。

## 语法

```css
filter: blur(5px);
filter: brightness(0.4);
filter: contrast(200%);
filter: drop-shadow(16px 16px 20px blue);
filter: grayscale(50%);
filter: hue-rotate(90deg);
filter: invert(75%);
filter: opacity(25%);
filter: saturate(30%);
filter: sepia(60%);
```

可以多个属性合并写，如：
```css
filter: contrast(175%) brightness(3%);
```

## 示例

```css
/* 给类名为mydiv的元素50%灰度化的效果  */
.mydiv { filter: grayscale(50%) }

/* 给所有图片50%灰度化并给10像素模糊的效果 */
img {
  filter: grayscale(0.5) blur(10px);
}
```

## 十种效果的详解

### blur()

模糊效果。对元素应用高斯模糊效果。

- 模糊值为CSS距离，*不支持百分比*
- 默认值为`0`，表示没有模糊效果

### brightness()

亮度。

- 取值为数值或者百分比
- 默认值为`1`，表示亮度保持不变
- 为`0`表示没有亮度，呈现为黑色。小于0时视为0。
- 数值越大，越亮。~~可以亮瞎双眼~~

### contrast()

对比度。

- 取值同上
- 默认值为`1`，表示对比度不变
- 为`0`将会完全灰化，灰化后的颜色值为`grey`/`gray`。同样，小于0时视为0。
- 数值越大，对比度越强。

### drop-shadow()

阴影。跟[box-shadow](https://developer.mozilla.org/en-US/docs/Web/CSS/box-shadow)类似。

阴影的具体语法为`drop-shadow(offset-x, offset-y<, blur-radius><, color>)`

- `offset-x`/`offset-y`为必需参数，前者表示阴影的横向偏移量，后者表示纵向偏移量
- `blur-radius`为模糊半径，默认为`0`
- `color`为阴影的CSS颜色值，默认值为黑色`#000000`/`black`

> 与`box-shadow`不同的是，应用多个阴影时，需要额外写`drop-shadow()`，不能向前者一样使用逗号进行分隔。概括的说就是`drop-shadow()`每次只能添加一种阴影效果。

### grayscale()

灰度化。

- 取值为`0`到`1`之间的**数值或百分比**，其他值无效
- 默认值为`0`，没有灰度化效果
- 取值为`1`/`100%`时表示完全灰度化

### hue-rotate()

色相旋转。

- 取值为色相旋转的具体**角度值**
- 默认值为`0deg`，表示色相旋转为0，无变化

### invert()

反色。

- 取值为`0`到`1`之间的**数值或百分比**，其他值无效
- 默认值为`0`/`0%`，维持原样
- 取值为`1`/`100%`时表示完全反色

> 取值为`.5`/`50%`时效果将完全灰化

### opacity()

透明度。与常规的CSS透明度一样，这里不再赘述。

> 尽管效果一样，但某些浏览器在使用Filters时会通过硬件加速的方式使其有更好的展现。

### saturate()

饱和度。

- 取值为数值或者百分比
- 默认值为`1`/`100%`，维持原样
- 为`0`表示没有饱和度，呈现为完全灰度化。~~小于0时视为0~~
- 数值越大，饱和程度越高。

### sepia()

褐色化。

- 取值为`0`到`1`之间的**数值或百分比**，其他值无效
- ~~默认值为`0`，没有褐化效果~~这里的解释有误，参见脚注[^1]
- 取值为`1`/`100%`时表示完全灰度化

[^1]: **注意**：MDN上的默认值解释与浏览器实际展现效果有出入，不给参数时，该值为`1`/`100%`，并非是`0`。

> 该单词的本意为`乌贼墨色/深褐色`，该效果与灰度化类似，不同的是`sepia`是使得元素往褐色去渲染。

> 根据[Encycolorpedia](http://encycolorpedia.com/704214)的解释，`sepia`的十六进制颜色值为`#704214`。

## 参考资料

- [filter - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/filter)
- [Can I Use](http://caniuse.com/#feat=css-filters)
- [CSS3 Filter的十种特效](http://www.w3cplus.com/css3/ten-effects-with-css3-filter)

全文完