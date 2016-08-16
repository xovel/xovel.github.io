---
title: nodeType属性详解
date: 2016-06-28 12:45:25
tags:
- DOM
- nodetype
- W3C
categories:
- WEB
- DOM
description: 只读属性Node.nodeType是一个整数，用来区分不同类型的节点，如元素，文本，注释等。 
---

只读属性`Node.nodeType`用来表示节点的类型。

### 描述

`nodeType`属性用来区分不同类型的节点，如元素`elements`，文本`text`和注释`comments`等。

### 语法

> var type = node.nodeType;

返回一个整数，表示该节点的类型。下面将列出节点类型常量。

### 常量

- `Node.ELEMENT_NODE`，1，`Element`，`元素`，如`<p>`，`<div>`
- `Node.ATTRIBUTE_NODE`，2，`Attr`，元素的属性。*已废弃*。
- `Node.TEXT_NODE`，3，`Text`，文本。元素或者属性的实际文本。
- `Node.CDATA_SECTION_NODE`，4，`CDATASection`，文档中的 CDATA 部分。*已废弃*。
- `Node.ENTITY_REFERENCE_NODE`，5，`EntityReference`，XML的实体引用节点。*已废弃*。
- `Node.ENTITY_NODE`，6，`Entity`，XML中的`<!ENTITY ...>`节点。*已废弃*。
- `Node.PROCESSING_INSTRUCTION_NODE`，7，`ProcessingInstruction`，XML文档中的处理指令声明，如`<?xml-stylesheet ... ?>`。
- `Node.COMMENT_NODE`，8，`Comment`，注释。
- `Node.DOCUMENT_NODE`，9，`Document`，文档。
- `Node.DOCUMENT_TYPE_NODE`，10，`DocumentType`，描述文档类型，如`HTML5`的声明`<!DOCTYPE html>`。
- `Node.DOCUMENT_FRAGMENT_NODE`，11，`DocumentFragment`，文档片段。
- `Node.NOTATION_NODE`，12，`Notation`，XML的`<!NOTATION ...>`节点。*已废弃*。

> 在[DOM4的规范草案](https://www.w3.org/TR/2015/REC-dom-20151119/#dom-node-nodetype)中，nodeType属性值`2`、`4`、`5`、`6`、`12`均已废弃不再使用。

### 示例

```text
document.nodeType === Node.DOCUMENT_NODE; // true
document.doctype.nodeType === Node.DOCUMENT_TYPE_NODE; // true

var fragment = document.createDocumentFragment();
fragment.nodeType === Node.DOCUMENT_FRAGMENT_NODE; // true

var p = document.createElement("p");
p.textContent = "Once upon a time...";

p.nodeType === Node.ELEMENT_NODE; // true
p.firstChild.nodeType === Node.TEXT_NODE; // true
```

以下示例代码检查文档的第一个节点是否为注释；如果不是，则进行一个提示。

```javascript
var node = document.documentElement.firstChild;
if (node.nodeType != Node.COMMENT_NODE)
  console.log("You should comment your code well!");
```


***

参考文档：
- [Node.nodeType - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeType)
- [Document Object Model (DOM) Level 3 Core Specification - Node.nodeType](https://www.w3.org/TR/DOM-Level-3-Core/core.html#ID-1950641247)