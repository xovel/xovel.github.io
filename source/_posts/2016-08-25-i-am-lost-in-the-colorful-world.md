---
title: 迷失在这五彩斑斓的世界
date: 2016-08-25 16:43:44
tags: [生活, 迷失]
categories: [随笔]
description: 人生总是在各种迷失，面对这花花世界，我似乎又迷失了方向。《迷失》第一篇。

---

《迷失》应该是一个系列，这里是第一篇。

没有想过要叙写这样一个系列的文章，但最近发生的太多事情让我不得不重新考虑。

要说最近能够令自己后悔的事情，就要回到三个多月之前了。当时刚从上一个公司离职出来，迫于经济压力，出来重新找工作。几经周折，去了新环境那边面试。然而当天的状态不是太好，一个很简单的效果没有及时做出来，现在想想也不知道自己当时到底是一个什么样的状态。没有把自己应有的实力表现出来，遗憾的与新环境擦身而过。

回忆袭来，我大概还能想起当时那个面试考官出的题目：H5实现图片半屏倒影效果，并在下拉时文字半透明。很久没有专门针对移动端H5页面功能做开发的我有点慌张，实现了图片倒影效果（`-webkit-reflect`），可能是由于太紧张，半屏效果忘记给`height:50%`了，如此的失误事后回想起来也是很忧伤。

下拉时文字半透明，我说了思路，但由于时间问题，没有做实现。作为一个很少使用jQuery这种框架的人来说，突然要写代码实现这种效果，还是有点措手不及的感觉呢。但这个其实并不难，只是监听下拉事件，然后给对应元素一个`opacity`实现透明度效果；或者使用CSS3的渐变；甚至使用蒙层遮盖效果。

考官看我太紧张，便说这个确实有点麻烦，换一个简单一点的题目吧：实现元素hover时（已经转移到PC端，可见考官的要求已然变得很低很低了）图标上下循环波动的效果。我果然还是太紧张了呢，竟然都忘记了`background-position`这个东西了。当时用的是`position`和`top`来实现位置的变化。无奈由于对相对位置的模糊，仓促之间，失败了。

心灰意冷的我，便跟那个考官说一点其他的事情，然后就离开了。

下楼之后，我回头望了一眼那一座大楼，恨恨的回去了。作为一个有过面试别人经验的人来说，自己也无法通过自己这样的状态。

虽然后来我还是实现了上述效果，关于倒影的效果在本人的实验项目中有体现[Carousel3D](https://github.com/xovel/Carousel3D)，关于动画，也整理过相关的文章：[CSS - animation简介](http://xovel.cn/article/css-animation.html)。

**但这又能改变什么！**

不得不说新环境公司最近的发展势头还是挺厉害的，没能展现自己良好的一面固然是我的命运，现在也只能感慨嘘唏，当作是一个不大不小的遗憾了。

我是一个程序员，多么嘲讽的现实。总是在各种迷失之间徘徊。

以上，此为《迷失》第一篇，当作是一个吐槽。