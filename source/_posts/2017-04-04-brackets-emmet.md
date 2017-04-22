---
title: Brackets的使用与emmet插件安装的一个问题
tags: [brackets, IDE, emmet, plugin, editor]
categories: [开发]
date: 2017-04-04 22:51:51
description: 本文介绍一下自己对于brackets的一些使用的心得，罗列安装的一些的插件，并着重讲述一下emmet这款插件的安装过程出现的问题，以及其对应的解决方案。
---

> 文章来自于本博客的issue，同时也记录到了个人日志的项目中去了。

_以下为正文_

*********************

最近决定将IDE迁移到[brackets](http://brackets.io/)，毕竟是adobe开发的用来替代古老臃肿的Dreamweaver的，口号就是`Code The Web`，为Web编程提供一套完善的IDE。

******

为什么是brackets？其实是可以用sublime的，但是sublime只是一个编辑器，没有IDE的一些特性，即便是有了插件的支持，也很难与大型IDE媲美。

回想我用过的IDE，最开始的FrontPage，到VS，再到后来的初次全面接触前端开发使用的Dreamweaver。而后离开福建回到湖南，开始抛弃Dreamweaver，换了一种非常极端的方式：放弃了IDE，直接采用常规编辑器Notepad++、UltraEdit来进行代码的编写。那滋味其实也还好，毕竟，那个时候最IDE的要求并不高，所使用的后台语言是asp，都用不着开带着各种兼容性问题的Dreamweaver。

之后的正式将主要编辑器从Notepad++转移到Sublime Text 3上面来了。用了很长一段时间的Sublime Text之后被其优雅的处理代码的方式所吸引。当然这过程中间也是过诸多其他的编辑器和IDE，比如Atom，Brackets，VS2012，那个时候还是偏向于使用纯粹的编辑器的。当然Notepad++因为处理多个文件方面的优势，我也一直在使用。

在现在这个公司工作之后，由于项目采用的配套的IDE，也就是可以称得上是超级IDE的WebStorm，重心也就转移到了WebStorm上面了。经过这么三四个月的使用，发现虽然功能强大，但是我依然觉得繁琐，电脑性能问题，并不容易很好的支持超大项目的处理，这个时候Sublime的优势再一次得到展现，处理大量文件毫不费力。

我试图将IDE改成Atom，毕竟这东西是github自家产物，但却不知道为何我迟迟没有进行这一项操作。我想我应该总有一天会使用这一款颇受好评的代码编辑工具的吧。vim这个应该也是差不多，因为现在并没有过多的接触后台操作，也不太习惯纯粹的命令行操作方式，希望以后能有机会成为传说中的vim重度依赖者吧。现阶段的我最多就是在bash里面运行几个简单的命令。

******

之前也不知道为什么，我写markdown的工具都是打开的brackets，这个跟之前sublime的markdown插件的预览带进了巨坑是有一定关系的，至今不想再跳进去，索性就换了个编辑markdown的工具，挑来挑去，最后就是选择了brackets，仅仅是因为其界面的优雅。

其实，现阶段的我依然是各路编辑器和IDE混用的，因为有时候同一个项目要被各种查看，一个IDE并不能胜任，于是就出现了我同时打开了WebStorm、Atom、Brackets、Notepad++、Sublime，甚至还搬出了多年不再使用的UltraEdit，是的，它们同时打开了同一个项目。我都不敢想象为什么我会变得如此疯狂。

既然是要采用Brackets作为近阶段的IDE，那么就安装几个插件来让它如虎添翼吧。官方推荐的插件，我安装了几个自己认为重要的，现在我自己的电脑上的Brackets插件的安装情况大概是这个样子的：

- `brackets-beautify`，官方推荐，代码美化工具，**是的，格式化之后的代码很美！**
- `brackets-display-shortcuts`，显示快捷键列表的插件，安装好之后在帮助菜单里面执行，就可以看到当前所有的快捷键了。
- `brackets-emmet`，是的，这就是本文要提到的核心插件，一个快速写HTML代码的工具，那速度绝对快的飞起。
- `brackets-indent-guides`，显示缩进的指示线。简单又粗暴，绝对是深度依赖者的必装插件。
- `brackets-minimap`，当初是因为什么爱上了sublime？没错，就是因为有代码缩略地图。基本上现在用一款编辑工具，首先会去看看没有代码小地图工具，有的话先装起来再说。
- `pop-up-menu`，这是一个对编辑的工作区域内的右键菜单进行提升的插件，增加了一些便利性操作。
- `exclude-folders`，打开文件夹时，过滤指定文件夹的插件。过滤了`node_modules`文件夹之后，项目的打开速度得到了明显的提升。但是看不到node_modules文件夹还是总觉得有点欠缺的。
- `markdown-preview`，markdown预览插件。作为一个重度markdown使用者，这插件对我来说也是极好的。
- `file-icons`，简单粗暴，给打开的各路文件的前面显示一个图标。优雅美观说的就是这样的效果。
- `monokai-theme`，Sumline Text的爱好者对这个那必须是钟爱莫名的，非常精致的代码配色方案。
- `color-palette`，取色器，好用不解释。

嗯，这些插件的安装其实并不是顺利，因为有~~强大的~~GFW的存在，悲催的brackets因为调用了aws的资源，所以有时候那速度卡的飞起，所以大部分插件我都是通过github的zip链接进行安装的。

安装完毕了之后，慕名已久的emmet插件一直不肯工作，这到底是为什么？

可能是因为疏忽大意了，一直迟迟忘记了brackets是基于HTML/JS构建出来的编辑工具，其界面上面是自带了Chrome DevTools的。为了这个问题，我几乎是找遍了brackets、emmet、stackoverflow上面的所有资源，依然是没有解决这个问题，后来又想，干脆手动安装一次，完全的纯粹的手动方式：

1. 进入brackets的插件目录，我的是win10环境，所以在`C:\Users\xovel\AppData\Roaming\Brackets\extensions`这里。
2. 进入user文件夹，打开bash。
3. 在bash里面执行git clone操作。
4. clone完成之后进入插件目录`brackets-emmet`，继续执行依赖安装操作`npm install`。
5. 安装完毕之后会发现，目录下多了个node_modules文件夹。
6. 进去一看，里面有两个文件夹，分别是`emmet`和`caniuse-db`。
7. 不管那么多，重启brackets。

很遗憾，依然没有emmet功能。

几经周折，我终于看到了调试里面的开发工具，于是调出F12，看看到底是什么错误导致的。

果不其然，在控制台里面有一行错误提示：大意是缺少一个文件，这个文件就是`\brackets-emmet\node_modules\emmet\lib\caniuse.json`，我仔细去看了一遍，确实是没有这个文件。

这就比较尴尬了，会不是我这样的安装方式不对？我决定到一个全新的地方使用命令行的方式从npm上安装全新的emmet，使用`npm install emmet`命令之后，我竟然又执行了`npm install`，把emmet的开发依赖给安装了，甚至还跑了`gulp`任务，结果生成了一个dist文件夹，我感觉我这么做有点走弯路了，~~是的，确实是走弯路，弯的很厉害~~。不过看到dist下的`emmet.js`大小有`1868kb`的时候心里还是很是震惊的。

依然没有看到caniuse.json，我就在想，这个名字跟上面提到的`caniuse-db`，应该是存在着某种关联的吧。果不其然，上emmet的repo上一搜，发现一个[提交记录](https://github.com/emmetio/emmet/pull/385)被接受了，就是提议将`caniuse.json`换成`caniuse-db`的。好家伙，这就很尴尬了。

既然现在的版本已经被替换掉了，那么问题就相对来说简单了，我应该只需要找到这个缺失的文件并将它放到它应该出现的位置上就可以了。于是我通过repo的tag记录依次寻找，发现从1.3.2之后，这个caniuse.json就不见了踪影。也是说从1.4.0版本开始，丢弃了caniuse.json，改为使用caniuse-db进行可用性判定。

于是我复制了一份json到本地目录中，然后重启brackets，甚好，`Emmet`菜单出来了。而后打开一个html文件，飞速敲下`div>ul>li`，然后按下`tab`，一个良好缩进展现的HTML结构跃然纸上。

问题解决了，但我觉得应该不止我一个人被这个问题所困扰，后来我仔细看了一下`brackets-emmet`的插件的package文件，发现里面只有一个依赖：`"emmet": "^1.3.0"`。好家伙，竟然是`"^1.3.0"`！

`^`！！

让我说什么好呢？这语义化的版本控制机制，应该是被npm给更改了操作规则吧。因为安装出来的版本号显示的是1.6.2，这明显不科学。

于是我手动将这一行代码改成了：`"emmet": "1.3.0"`，然后将整个node_modules个删了，并在bash里面重新走了一边安装的操作，这个时候出来的结果是只安装了一个emmet了。怀着一颗激动的心，我重启了brackets，嗯，甚好，Emmet还在。

至此，brackets上的emmet插件算是成功解决了。

*****

总结：瞎折腾之下，获取了宝贵的经验，也算是一种收获。~~虽然内心觉得得不偿失~~

