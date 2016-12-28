---
title: 博客优化之压缩HTML静态文件
tags: [blog, 优化, gulp, minify]
categories: [开发]
date: 2016-11-16 17:07:40
description: 博客优化之压缩HTML静态文件，本文介绍一种使用gulp的处理方式来解决这个问题。
---

> 本文来自博客issue[#16](https://github.com/xovel/xovel.github.io/issues/16)

使用了`next`主题之后，默认生成的HTML文件中，会出现大量的空行。直接查看网页源代码就能够看到。

`hexo`默认没有提供压缩HTML/CSS/JS的功能，但我们可以通过另外的途径进行代码的压缩。

> 之前的版本，有一个名为`hexo-generator-minify`的插件，但已经无人维护，不支持hexo 3.x版本。

> [官方插件库](https://hexo.io/plugins/)能搜到的压缩插件，均有不同程度的问题。详情这里不表，具体诸君可以自行安装测试。

这里介绍一种[`gulp`](https://github.com/gulpjs/gulp)自动化任务压缩的方式来处理这个问题，缺陷就是每一次blog在deploy的时候都需要事先执行一次这个压缩任务。

> 本人的博客曾经开启过压缩功能，但后来放弃了。~~一方面是嫌麻烦，一方面也是觉得暂时没有这个必要~~

本人采用的具体压缩工具为：

- [gulp-htmlmin](https://github.com/jonschlinkert/gulp-htmlmin)，该插件对HTML代码进行压缩。
- [gulp-htmlclean](https://github.com/anseki/gulp-htmlclean)，该插件对HTML进行代码清理，去除不必要的空行等。
- [gulp-clean-css](https://github.com/scniro/gulp-clean-css)，该插件对CSS代码进行压缩与清理。

另外有一个图片压缩工具，暂未使用：[gulp-imagemin](https://github.com/sindresorhus/gulp-imagemin)

JS压缩工具可以参考：[gulp-uglify](https://github.com/terinjokes/gulp-uglify)、[UglifyJS2](https://github.com/mishoo/UglifyJS2)。

引入各种插件：
```js
var gulp = require('gulp');

var htmlmin = require('gulp-htmlmin');
var htmlclean = require('gulp-htmlclean');
var cleanCSS = require('gulp-clean-css');
var imagemin = require('gulp-imagemin');
```

本人采用的核心的任务代码如下：

```js
gulp.task('minify-html', function() {
  return gulp.src('./public/**/*.html')
    .pipe(htmlclean())
    .pipe(htmlmin({
         removeComments: true,
         minifyJS: false,
         minifyCSS: true,
         minifyURLs: false,
    }))
    .pipe(gulp.dest('./public'))
});
```

那么，在每一次deploy之前，在`Git Bash`下执行一次`gulp minify-html`即可对所有的HTML代码进行压缩。

CSS和JS的压缩可以编写类似的代码，这里不再赘述。
