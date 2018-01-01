---
title: PARCEL - 一个极快零配置的打包工具
tags: [parcel, bunlder]
categories: [开发, 文档]
date: 2017-12-12 09:33:28
description: 前端的发展真是日新月异，这不，打包工具方面最近又出了一个爆款，名字叫做 `parcel`。本文转载其说明文档 `README.md`。
---

![](http://wx4.sinaimg.cn/large/79be2309gy1fmdqbevvmgj20m806dmz8.jpg)

> 前端的发展真是日新月异，这不，打包工具方面最近又出了一个爆款，名字叫做 `parcel`。本篇博客转载其 `README.md`，暂不做翻译。原文请移步：[parcel-bundler/parcel](https://github.com/parcel-bundler/parcel)。

*******************

Blazing fast, zero configuration web application bundler <https://parceljs.org>

## Features

* 🚀 **Blazing fast** bundle times - multicore compilation, and a filesystem cache for fast rebuilds even after a restart.
* 📦 Out of the box support for JS, CSS, HTML, file assets, and more - **no plugins to install**.
* 🐠 **Automatically transforms modules** using Babel, PostCSS, and PostHTML when needed - even `node_modules`.
* ✂️ Zero configuration **code splitting** using dynamic `import()` statements.
* 🔥 Built in support for **hot module replacement**
* 🚨 Friendly error logging experience - syntax highlighted code frames help pinpoint the problem.

## Getting started

1. Install with yarn:

```shell
yarn global add parcel-bundler
```
or with npm:
```shell
npm install -g parcel-bundler
```

2. Parcel can take any type of file as an entry point, but an HTML or JavaScript file is a good place to start. If you link your main JavaScript file in the HTML using a relative path, Parcel will also process it for you, and replace the reference with a URL to the output file.

```html
<html>
<body>
  <script src="./index.js"></script>
</body>
</html>
```

3. Parcel has a development server built in, which will automatically rebuild your app as you change files and supports hot module replacement for fast development. Just point it at your entry file:

```shell
parcel index.html
```

4. Now open http://localhost:1234/ in your browser. If needed, you can also override the default port with the -p option.

See [parceljs.org](https://parceljs.org) for more documentation!

## Benchmarks

Based on a reasonably sized app, containing 1726 modules, 6.5M uncompressed. Built on a 2016 MacBook Pro with 4 physical CPUs.

| Bundler                 | Time      |
| ----------------------- | --------- |
| browserify              | 22.98s    |
| webpack                 | 20.71s    |
| **parcel**              | **9.98s** |
| **parcel - with cache** | **2.64s** |

## Why parcel?

There are many web application bundlers out there with huge adoption, including webpack and browserify. So, why do we need another one? The main reasons are around developer experience.

Many bundlers are built around configuration and plugins, and it is not uncommon to see applications with upwards of 500 lines of configuration just to get things working. This configuration is not just tedious and time consuming, but is also hard to get right and must be duplicated for each application. Oftentimes, this can lead to sub-optimized apps shipping to production. `parcel` is designed to need zero configuration: just point it at the entry point of your application, and it does the right thing.

Existing bundlers are also very slow. Large applications with lots of files and many dependencies can take minutes to build, which is especially painful during development when things change all the time. File watchers can help with rebuilds, but the initial launch is often still very slow. `parcel` utilizes worker processes to compile your code in parallel, utilizing modern multicore processors. This results in a huge speedup for initial builds. It also has a file system cache, which saves the compiled results per file for even faster subsequent startups.

Finally, existing bundlers are built around string loaders/transforms, where the transform takes in a string, parses it, does some transformation, and generates code again. Oftentimes this ends up causing many parses and code generation runs on a single file, which is inefficient. Instead, `parcel`'s transforms work on ASTs so that there is one parse, many transforms, and one code generation per file.

## How it works

`parcel` transforms a tree of assets to a tree of bundles. Many other bundlers are fundamentally based around JavaScript assets, with other formats tacked on - for example, by default inlined as strings into JS files. `parcel` is file-type agnostic - it will work with any type of assets the way you'd expect, with no configuration.

`parcel` takes as input a single entry asset, which could be any type: a JS file, HTML, CSS, image, etc. There are various asset types defined in `parcel` which know how to handle specific file types. The assets are parsed, their dependencies are extracted, and they are transformed to their final compiled form. This creates a tree of assets.

Once the asset tree has been constructed, the assets are placed into a bundle tree. A bundle is created for the entry asset, and child bundles are created for dynamic imports, which cause code splitting to occur. Child bundles are also created when assets of a different type are imported, for example if you imported a CSS file from JavaScript, it would be placed into a sibling bundle to the corresponding JavaScript. If an asset is required in more than one bundle, it is hoisted up to the nearest common ancestor in the bundle tree so it is not included more than once.

After the bundle tree is constructed, each bundle is written to a file by a packager specific to the file type. The packagers know how to combine the code from each asset together into the final file that is loaded by a browser.

## Community

All feedback and suggestions are welcome!

* 💬 Chat: Join us on [slack](https://slack.parceljs.org/).
* 📣 Stay up to date on new features and announcements on [@parceljs](https://twitter.com/parceljs).

## License

MIT

****************************

[Parcel 中文文档](http://www.css88.com/doc/parcel/)。不得不佩服这个网站，以飞快之速完成了对文档的翻译。~~当然，现在的官方文档内容其实也不多~~。

目前这个项目吸引了很多的开发者，诸多在 `webpack` 中的特性也会逐步加入进来，不出意外的话，这个是继 `rollup` 之后，又一个与 `webpack` 争天下的项目。

