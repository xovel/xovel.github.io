---
title: HTTP1.1协议更新，RFC2616被废弃
date: 2016-06-15 12:16:12
tags: 
- http
- rfc
- 协议
- http1.1
categories:
- WEB
- HTTP

---

2014年年中，IETF更新了HTTP/1.1协议：将原来的HTTP/1.1协议（[RFC2616](https://tools.ietf.org/html/rfc2616)）拆开，分成了六个单独的协议。在这六个新的协议说明中，重点对之前语义模糊的部分进行了重新诠释。更新之后的协议变得更易懂、易读。

<!--more-->

以下是新的六个协议：

- RFC7230 - [HTTP/1.1: Message Syntax and Routing](http://tools.ietf.org/html/rfc7230) - low-level message parsing and connection management
- RFC7231 - [HTTP/1.1: Semantics and Content](http://tools.ietf.org/html/rfc7231) - methods, status codes and headers
- RFC7232 - [HTTP/1.1: Conditional Requests](http://tools.ietf.org/html/rfc7232) - e.g., If-Modified-Since
- RFC7233 - [HTTP/1.1: Range Requests](http://tools.ietf.org/html/rfc7233) - getting partial content
- RFC7234 - [HTTP/1.1: Caching](http://tools.ietf.org/html/rfc7234) - browser and intermediary caches
- RFC7235 - [HTTP/1.1: Authentication](http://tools.ietf.org/html/rfc7235) - a framework for HTTP authentication

正如Mark Nottingham在其个人博客中的一篇文章（[RFC2616 is Dead](https://www.mnot.net/blog/2014/06/07/rfc2616_is_dead)）中的吐槽一样：

> Don’t use RFC2616. Delete it from your hard drives, bookmarks, and burn (or responsibly recycle) any copies that are printed out.

> 不要再使用RFC2616了。将它从你的磁盘、书签中删除，并将打印出来的任何副本烧掉，当然你也可以回收再利用。

RFC2616已经变为废弃状态。

其实早在2007年，IETF内部就针对HTTP/1.1的修订展开了工作，他们成立了一个名字叫做[HTTPbis](https://tools.ietf.org/wg/httpbis/)的工作小组，目的是让HTTP/1.1协议规范更加清晰易读，并非对之前的协议进行升级或者添加新的特性。在这个修订过程中，小组成员发布了数十个草稿版本，并处理了[550+问题](https://trac.tools.ietf.org/wg/httpbis/trac/report/19)。

> HTTPbis就是现在的HTTP Working Group，其官方主页为：http://httpwg.org/

> 关于为何取名HTTPbis，stackoverflow上有个讨论：[HTTPbis - what does bis mean?](http://stackoverflow.com/questions/9105639/httpbis-what-does-bis-mean)

在文档整理过程中，HTTPbis也对HTTP/1.1协议中的一些不合理或者不安全的地方进行了修正与完。在官方文档中描述了对应于RFC2616的变更部分：[Changes from RFC 2616](http://tools.ietf.org/html/rfc7230#appendix-A.2)。Evert在其博客（[HTTP/1.1 just got a major update](https://evertpot.com/http-11-updated/)）中有一番总结，指出了其中的一些重大变更：

> - Clarifications around dealing with unexpected whitespace, which should fix response splitting vulnerabilities.
> - The limit of two connections per server has been removed.
> - HTTP/0.9 support has been dropped.
> - Default charset of ISO-8859-1 has been removed.
> - Servers are no longer required to handle all `Content-*` header fields.
> - `Content-Range` has been explicitly banned in PUT requests.
> - It’s now suggested to use the `about:blank` uri in the `Referer` header when no referer exists, to distinguish between “there was no referrer” and “I don’t want to send a referrer”.
> - The `204`, `404`, `405`, `414` and `501` status codes are now cachable.
> - The status codes `301` and `302` have been changed to allow user agents to rewrite the method from `POST` to `GET`. This is a good example of a case where everybody has been (incorrectly) already doing this, and the spec now reflects the real world implementation.
> - The `Location` header can now contain relative uri’s as well as fragment identifiers.
> - `Content-MD5` has been removed.

翻译如下：

- 明确了针对未预期空格的处理，以修复`HTTP Response Splitting`漏洞。
- 每个服务器两个连接数的限制被移除。
- 放弃对`HTTP/0.9`的支持。
- `ISO-8859-1`不再是默认的字符集。
- 服务器不再需要去处理所有的`Content-*`请求头内容。
- 明确禁止在`PUT`请求中使用`Content-Range`。
- 当referer不存在时，为了区分“这里没有referrer”和“我不想发送referrer”，建议在请求头`Referer`中使用`about:blank`这个uri。
- 状态码`204`、`404`、`405`、`414`以及`501`现在可以缓存了。
- 状态码`301`、`302`现在允许用户代理将请求方式从`POST`重写为`GET`。*人们之前早就这样做了（~~尽管当时是不正确的~~），现在现实世界中的操作被规范重新表述，这个就是一个很好的例子。*
- 现在请求头`Location`可以包含相对URI和片段标识符。
- `Content-MD5`被移除。

------
参考资料：
- [RFC2616 is Dead](https://www.mnot.net/blog/2014/06/07/rfc2616_is_dead)
- [HTTP/1.1 just got a major update](https://evertpot.com/http-11-updated/)