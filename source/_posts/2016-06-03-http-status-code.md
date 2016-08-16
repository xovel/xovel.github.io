---
title: HTTP 状态码
date: 2016-06-03 17:29:49
tags:
- http
- rfc
- 状态码
categories:
- WEB
- HTTP

description: HTTP状态码（HTTP Status Code）是一个三位数字，用来表示服务器对HTTP请求的响应状态。大部分HTTP代码经过RFC相关文档定义，其中RFC7231对诸多之前的状态码进行了更加细致的定义。本文将罗列RFC文档中定义过的HTTP状态码，大部分资料参考自网络，部分文字对应的RFC文档可能并不是最新的。一些服务器自己扩展的HTTP状态也进行了收集整理，如Nginx和IIS，尤其是IIS，对其中的xxx.x形式的代码有一个收集列表。

---

## HTTP状态码概念

> The status-code element is a three-digit integer code giving the result of the attempt to understand and satisfy the request.

HTTP状态码（HTTP Status Code）是一个三位数字，用来表示服务器对HTTP请求的响应状态。

HTTP状态由[RFC 2068][rfc2068]定义，经过[RFC 2616][rfc2616]更新，[RFC 2518][rfc2518]、[RFC 2295][rfc2295]、[RFC 2774][rfc2774]、[RFC 4918][rfc4918]等规范进行了扩展。

[RFC 7231][rfc7231]中对HTTP状态码进行了全面更新。

## HTTP状态详解

- 1xx: Informational - Request received, continuing process
- 2xx: Success - The action was successfully received, understood, and accepted
- 3xx: Redirection - Further action must be taken in order to complete the request
- 4xx: Client Error - The request contains bad syntax or cannot be fulfilled
- 5xx: Server Error - The server failed to fulfill an apparently valid request

翻译：
- 1xx：消息，请求已经被接收，正在进一步处理中
- 2xx：成功，请求已成功被接收、理解、并接受
- 3xx：重定向，需要采取进一步的操作才能完成请求
- 4xx：客户端错误，客户端提交的请求有错误
- 5xx：服务器错误，服务器不能完成对请求的处理

<!--more-->

### 1xx Informational 消息

这一类型的状态码，代表请求已经被接收，正在进一步处理中。

这类响应是临时响应，只包含状态行和某些可选的响应头信息，并以空行结束。由于 HTTP/1.0 协议中没有定义任何 1xx 状态码，服务器须杜绝向 HTTP/1.0 客户端发送 1xx 响应。

> The 1xx (Informational) class of status code indicates an interim response for communicating connection status or request progress prior to completing the requested action and sending a final response. 1xx responses are terminated by the first empty line after the status-line (the empty line signaling the end of the header section). Since HTTP/1.0 did not define any 1xx status codes, a server MUST NOT send a 1xx response to an HTTP/1.0 client.

#### 100 Continue

客户端应当继续发送请求。这个临时响应是用来通知客户端它的部分请求已经被服务器接收，且仍未被拒绝。客户端应当继续发送请求的剩余部分，或者如果请求已经完成，忽略这个响应。服务器必须在请求完成后向客户端发送一个最终响应。

> The server has received the request headers and the client should proceed to send the request body (in the case of a request for which a body needs to be sent; for example, a POST request). Sending a large request body to a server after a request has been rejected for inappropriate headers would be inefficient. To have a server check the request's headers, a client must send `Expect: 100-continue` as a header in its initial request and receive a 100 Continue status code in response before sending the body. The response 417 Expectation Failed indicates the request should not be continued.

+ 参考：[RFC7231, Section 6.2.1](http://tools.ietf.org/html/rfc7231#section-6.2.1)

#### 101 Switching Protocols

请求者要求服务器切换不同的协议来完成请求，并且服务器已经同意。

> The requester has asked the server to switch protocols and the server has agreed to do so.

+ 参考：[RFC7231, Section 6.2.2](http://tools.ietf.org/html/rfc7231#section-6.2.2)

> The 101 (Switching Protocols) status code indicates that the server understands and is willing to comply with the client's request, via the Upgrade header field (Section 6.7 of [RFC7230]), for a change in the application protocol being used on this connection. The server MUST generate an Upgrade header field in the response that indicates which protocol(s) will be switched to immediately after the empty line that terminates the 101 response. 

> It is assumed that the server will only agree to switch protocols when it is advantageous to do so. For example, switching to a newer version of HTTP might be advantageous over older versions, and switching to a real-time, synchronous protocol might be advantageous when delivering resources that use such features.

#### 102 Processing

由 WebDAV（Web Distributed Authoring and Versioning）扩展的状态码，代表处理将被继续执行。

> A WebDAV request may contain many sub-requests involving file operations, requiring a long time to complete the request. This code indicates that the server has received and is processing the request, but no response is available yet. This prevents the client from timing out and assuming the request was lost.

+ 参考：[RFC2518, Section 10.1](https://tools.ietf.org/html/rfc2518#section-10.1)

### 2xx 成功

2xx Success，客户端发出的请求已成功被服务器接收、理解、并接受。

> This class of status codes indicates that the client's request was successfully received, understood, and accepted.

#### 200 OK

请求已成功，请求所希望的响应头或数据体将随此响应返回。

> Standard response for successful HTTP requests. The actual response will depend on the request method used. In a GET request, the response will contain an entity corresponding to the requested resource. In a POST request, the response will contain an entity describing or containing the result of the action.

+ 参考：[RFC7231, Section 6.3.1](http://tools.ietf.org/html/rfc7231#section-6.3.1)

#### 201 Created

请求已经被实现，而且有一个新的资源已经依据请求的需要而建立，且其 URI 已经随Location 头信息返回。

假如需要的资源无法及时建立的话，应当返回 '202 Accepted'。

> The request has been fulfilled, resulting in the creation of a new resource.

+ 参考：[RFC7231, Section 6.3.2](http://tools.ietf.org/html/rfc7231#section-6.3.2)

#### 202 Accepted

服务器已接受请求，但尚未处理完毕。正如它可能被拒绝一样，最终该请求可能会也可能不会被执行。在异步操作的场合下，没有比发送这个状态码更方便的做法了。

返回202状态码的响应的目的是允许服务器接受其他过程的请求（例如某个每天只执行一次的基于批处理的操作），而不必让客户端一直保持与服务器的连接直到批处理操作全部完成。在接受请求处理并返回202状态码的响应应当在返回的实体中包含一些指示处理当前状态的信息，以及指向处理状态监视器或状态预测的指针，以便用户能够估计操作是否已经完成。

> The request has been accepted for processing, but the processing has not been completed. The request might or might not be eventually acted upon, and may be disallowed when processing occurs.

+ 参考：[RFC7231, Section 6.3.3](http://tools.ietf.org/html/rfc7231#section-6.3.3)

#### 203 Non-Authoritative Information

服务器已成功处理了请求，但返回的实体头部元信息不是在原始服务器上有效的确定集合，而是来自本地或者第三方的拷贝。

当前的信息可能是原始版本的子集或者超集。例如，包含资源的元数据可能导致原始服务器知道元信息的超级。使用此状态码不是必须的，而且只有在响应不使用此状态码便会返回200 OK的情况下才是合适的。

> The server is a transforming proxy (e.g. a Web accelerator) that received a 200 OK from its origin, but is returning a modified version of the origin's response.

+ 参考：[RFC7231, Section 6.3.4](http://tools.ietf.org/html/rfc7231#section-6.3.4)

#### 204 No Content

服务器成功处理了请求，但不需要返回任何实体内容，并且希望返回更新了的元信息。

响应可能通过实体头部的形式，返回新的或更新后的元信息。如果存在这些头部信息，则应当与所请求的变量相呼应。

如果客户端是浏览器的话，那么用户浏览器应保留发送了该请求的页面，而不产生任何文档视图上的变化，即使按照规范新的或更新后的元信息应当被应用到用户浏览器活动视图中的文档。

由于204响应被禁止包含任何消息体，因此它始终以消息头后的第一个空行结尾。

> The server successfully processed the request and is not returning any content.

+ 参考：[RFC7231, Section 6.3.5](http://tools.ietf.org/html/rfc7231#section-6.3.5)

#### 205 Reset Content

服务器成功处理了请求，且没有返回任何内容。

但是与204响应不同，返回此状态码的响应要求请求者重置文档视图。该响应主要是被用于接受用户输入后，立即重置表单，以便用户能够轻松地开始另一次输入。

与204响应一样，该响应也被禁止包含任何消息体，且以消息头后的第一个空行结束。

> The server successfully processed the request, but is not returning any content. Unlike a 204 response, this response requires that the requester reset the document view.

+ 参考：[RFC7231, Section 6.3.6](http://tools.ietf.org/html/rfc7231#section-6.3.6)

#### 206 Partial Content

服务器已经成功处理了部分 GET 请求。

> The server is delivering only part of the resource (byte serving) due to a range header sent by the client. The range header is used by HTTP clients to enable resuming of interrupted downloads, or split a download into multiple simultaneous streams.

+ 参考：[RFC7233, Section 4.1](http://tools.ietf.org/html/rfc7233#section-4.1)

#### 207 Multi-Status

由 WebDAV 扩展的状态码，代表之后的消息体将是一个XML消息，并且可能依照之前子请求数量的不同，包含一系列独立的响应代码。

+ 参考：[RFC 4918, Section 11.1](http://tools.ietf.org/html/rfc4918#section-11.1)

> The message body that follows is an XML message and can contain a number of separate response codes, depending on how many sub-requests were made.

#### 208 Already Reported

由 WebDAV 扩展的状态码，表示一个DAV的绑定成员被前一个请求枚举，并且没有被再一次包括。

> The members of a DAV binding have already been enumerated in a previous reply to this request, and are not being included again.

+ 参考：[RFC 5842, Section 7.1](http://tools.ietf.org/html/rfc5842#section-7.1)

#### 226 IM Used

由 [RFC 3229](https://tools.ietf.org/html/rfc3229#section-10.4.1) 扩展的状态码，表示服务器已经满足了请求所要的资源，并且响应是一个或者多个实例操作应用于当前实例的结果。

> The server has fulfilled a request for the resource, and the response is a representation of the result of one or more instance-manipulations applied to the current instance.

### 3xx 重定向

3xx Redirection，这类状态码代表需要客户端采取进一步的操作才能完成请求。通常，这些状态码用来重定向，后续的请求地址（重定向目标）在本次响应的 Location 域中指明。

当且仅当后续的请求所使用的方法是 GET 或者 HEAD 时，用户浏览器才可以在没有用户介入的情况下自动提交所需要的后续请求。客户端应当自动监测无限循环重定向（例如：A->A，或者A->B->C->A），因为这会导致服务器和客户端大量不必要的资源消耗。按照 HTTP/1.0 版规范的建议，浏览器不应自动访问超过5次的重定向。

> This class of status code indicates the client must take additional action to complete the request. Many of these status codes are used in URL redirection.

> A user agent may carry out the additional action with no user interaction only if the method used in the second request is GET or HEAD. A user agent may automatically redirect a request. A user agent should detect and intervene to prevent cyclical redirects.

#### 300 Multiple Choices

被请求的资源有一系列可供选择的回馈信息，每个都有自己特定的地址和浏览器驱动的商议信息。用户或浏览器能够自行选择一个首选的地址进行重定向。

> Indicates multiple options for the resource from which the client may choose. For example, this code could be used to present multiple video format options, to list files with different extensions, or to suggest word sense disambiguation.

+ 参考：[RFC7231, Section 6.4.1](http://tools.ietf.org/html/rfc7231#section-6.4.1)

#### 301 Moved Permanently

被请求的资源已永久移动到新位置，并且将来任何对此资源的引用都应该使用本响应返回的若干个 URI 之一。如果可能，拥有链接编辑功能的客户端应当自动把请求的地址修改为从服务器反馈回来的地址。除非额外指定，否则这个响应也是可缓存的。

新的永久性的 URI 应当在响应的 Location 域中返回。除非这是一个 HEAD 请求，否则响应的实体中应当包含指向新的 URI 的超链接及简短说明。

如果这不是一个 GET 或者 HEAD 请求，因此浏览器禁止自动进行重定向，除非得到用户的确认，因为请求的条件可能因此发生变化。 

注意：对于某些使用 HTTP/1.0 协议的浏览器，当它们发送的 POST 请求得到了一个301响应的话，接下来的重定向请求将会变成 GET 方式。

> This and all future requests should be directed to the given URI.

+ 参考：[RFC7231, Section 6.4.2](http://tools.ietf.org/html/rfc7231#section-6.4.2)

#### 302 Found

请求的资源现在临时从不同的 URI 响应请求。

由于这样的重定向是临时的，客户端应当继续向原有地址发送以后的请求。只有在Cache-Control或Expires中进行了指定的情况下，这个响应才是可缓存的。

> This is an example of industry practice contradicting the standard. The HTTP/1.0 specification (RFC 1945) required the client to perform a temporary redirect (the original describing phrase was "Moved Temporarily"), but popular browsers implemented 302 with the functionality of a 303 See Other. Therefore, HTTP/1.1 added status codes 303 and 307 to distinguish between the two behaviours. However, some Web applications and frameworks use the 302 status code as if it were the 303.

> The 302 (Found) status code indicates that the target resource resides temporarily under a different URI. Since the redirection might be altered on occasion, the client ought to continue to use the effective request URI for future requests. The server SHOULD generate a Location header field in the response containing a URI reference for the different URI. The user agent MAY use the Location field value for automatic redirection. The server's response payload usually contains a short hypertext note with a hyperlink to the different URI(s).
> > Note: For historical reasons, a user agent MAY change the request method from POST to GET for the subsequent request. If this behavior is undesired, the 307 (Temporary Redirect) status code can be used instead.

+ 参考：[RFC7231, Section 6.4.3](http://tools.ietf.org/html/rfc7231#section-6.4.3)

#### 303 See Other

对应当前请求的响应可以在另一个 URI 上被找到，而且客户端应当采用 GET 的方式访问那个资源。这个方法的存在主要是为了允许由脚本激活的POST请求输出重定向到一个新的资源。这个新的 URI 不是原始资源的替代引用。同时，303响应禁止被缓存。当然，第二个请求（重定向）可能被缓存。

新的 URI 应当在响应的 Location 域中返回。除非这是一个 HEAD 请求，否则响应的实体中应当包含指向新的 URI 的超链接及简短说明。

注意：许多 HTTP/1.1 版以前的 浏览器不能正确理解303状态。如果需要考虑与这些浏览器之间的互动，302状态码应该可以胜任，因为大多数的浏览器处理302响应时的方式恰恰就是上述规范要求客户端处理303响应时应当做的。

> The response to the request can be found under another URI using a GET method. When received in response to a POST (or PUT/DELETE), the client should presume that the server has received the data and should issue a redirect with a separate GET message.

+ 参考：[RFC7231, Section 6.4.4](http://tools.ietf.org/html/rfc7231#section-6.4.4)

#### 304 Not Modified

304，未修改，表示请求的资源未经过修改。

> Indicates that the resource has not been modified since the version specified by the request headers If-Modified-Since or If-None-Match. In such case, there is no need to retransmit the resource since the client still has a previously-downloaded copy.

> The 304 (Not Modified) status code indicates that a conditional GET or HEAD request has been received and would have resulted in a 200 (OK) response if it were not for the fact that the condition evaluated to false. In other words, there is no need for the server to transfer a representation of the target resource because the request indicates that the client, which made the request conditional, already has a valid representation; the server is therefore redirecting the client to make use of that stored representation as if it were the payload of a 200 (OK) response.

> The server generating a 304 response MUST generate any of the following header fields that would have been sent in a 200 (OK) response to the same request: Cache-Control, Content-Location, Date, ETag, Expires, and Vary.

+ 参考：[RFC7232, Section 4.1](https://tools.ietf.org/html/rfc7232#section-4.1)

#### 305 Use Proxy

305，使用代理，表示被请求的资源必须通过指定的代理才能被访问。

> The requested resource is available only through a proxy, the address for which is provided in the response. Many HTTP clients (such as Mozilla and Internet Explorer) do not correctly handle responses with this status code, primarily for security reasons.

> The 305 (Use Proxy) status code has been deprecated due to security
   concerns regarding in-band configuration of a proxy.
   
> 由于安全原因，该状态已被废弃。

#### 306 ~~Switch Proxy~~ Unused

306，该状态已经不再使用。

> No longer used. Originally meant "Subsequent requests should use the specified proxy."

#### 307 Temporary Redirect

请求的资源现在临时从不同的URI 响应请求。由于这样的重定向是临时的，客户端应当继续向原有地址发送以后的请求。只有在Cache-Control或Expires中进行了指定的情况下，这个响应才是可缓存的。

新的临时性的URI 应当在响应的 Location 域中返回。除非这是一个HEAD 请求，否则响应的实体中应当包含指向新的URI 的超链接及简短说明。因为部分浏览器不能识别307响应，因此需要添加上述必要信息以便用户能够理解并向新的 URI 发出访问请求。

如果这不是一个GET 或者 HEAD 请求，那么浏览器禁止自动进行重定向，除非得到用户的确认，因为请求的条件可能因此发生变化。

> In this case, the request should be repeated with another URI; however, future requests should still use the original URI. In contrast to how 302 was historically implemented, the request method is not allowed to be changed when reissuing the original request. For example, a POST request should be repeated using another POST request.

+ 参考：[RFC7231, Section 6.4.7](http://tools.ietf.org/html/rfc7231#section-6.4.7)

#### 308 Permanent Redirect

308 永久转移，这个请求和以后的请求都应该被另一个URI地址重新发送。307、308和302、301有相同的表现，但是不允许HTTP方法改变。例如，请求表单到一个永久转移的资源将会继续顺利地执行。

> The request and all future requests should be repeated using another URI. 307 and 308 parallel the behaviours of 302 and 301, but do not allow the HTTP method to change. So, for example, submitting a form to a permanently redirected resource may continue smoothly.

+ 参考：[RFC 7538 - The Hypertext Transfer Protocol Status Code 308 (Permanent Redirect)][rfc7538]

### 4xx 客户端错误

这类的状态码代表了客户端看起来可能发生了错误，妨碍了服务器的处理。除非响应的是一个 HEAD 请求，否则服务器就应该返回一个解释当前错误状况的实体，以及这是临时的还是永久性的状况。这些状态码适用于任何请求方法。浏览器应当向用户显示任何包含在此类错误响应中的实体内容。

如果错误发生时客户端正在传送数据，那么使用TCP的服务器实现应当仔细确保在关闭客户端与服务器之间的连接之前，客户端已经收到了包含错误信息的数据包。如果客户端在收到错误信息后继续向服务器发送数据，服务器的TCP栈将向客户端发送一个重置数据包，以清除该客户端所有还未识别的输入缓冲，以免这些数据被服务器上的应用程序读取并干扰后者。
　　
> The 4xx class of status code is intended for situations in which the client seems to have erred. Except when responding to a HEAD request, the server should include an entity containing an explanation of the error situation, and whether it is a temporary or permanent condition. These status codes are applicable to any request method. User agents should display any included entity to the user.

#### 400 Bad Request

400 请求有误，表示服务器因为一个明显的客户端错误不能或者不会处理这个请求。

> The server cannot or will not process the request due to an apparent client error (e.g., malformed request syntax, invalid request message framing, or deceptive request routing).

+ 参考：[RFC7231, Section 6.5.1](http://tools.ietf.org/html/rfc7231#section-6.5.1)

#### 401 Unauthorized

当前请求需要用户验证。该响应必须包含一个适用于被请求资源的 WWW-Authenticate 信息头用以询问用户信息。客户端可以重复提交一个包含恰当的 Authorization 头信息的请求。如果当前请求已经包含了 Authorization 证书，那么401响应代表着服务器验证已经拒绝了那些证书。如果401响应包含了与前一个响应相同的身份验证询问，且浏览器已经至少尝试了一次验证，那么浏览器应当向用户展示响应中包含的实体信息，因为这个实体信息中可能包含了相关诊断信息。

> Similar to 403 Forbidden, but specifically for use when authentication is required and has failed or has not yet been provided. The response must include a WWW-Authenticate header field containing a challenge applicable to the requested resource. See Basic access authentication and Digest access authentication. 401 semantically means "unauthenticated", i.e. the user does not have the necessary credentials.
Note: Some sites issue HTTP 401 when an IP address is banned from the website (usually the website domain) and that specific address is refused permission to access a website.

> The 401 (Unauthorized) status code indicates that the request has not been applied because it lacks valid authentication credentials for the target resource. The server generating a 401 response MUST send a WWW-Authenticate header field containing at least one challenge applicable to the target resource.

+ 参考：[RFC 7235, Section 3.1](https://tools.ietf.org/html/rfc7235#section-3.1)

#### 402 Payment Required

该状态码是为了将来可能的需求而预留的。

> Reserved for future use. The original intention was that this code might be used as part of some form of digital cash or micropayment scheme, but that has not happened, and this code is not usually used. Google Developers API uses this status if a particular developer has exceeded the daily limit on requests.

#### 403 Forbidden

服务器已经理解请求，但是拒绝执行它。与401响应不同的是，身份验证并不能提供任何帮助，而且这个请求也不应该被重复提交。如果这不是一个 HEAD 请求，而且服务器希望能够讲清楚为何请求不能被执行，那么就应该在实体内描述拒绝的原因。当然服务器也可以返回一个404响应，假如它不希望让客户端获得任何信息。

> The request was a valid request, but the server is refusing to respond to it. 403 error semantically means "unauthorized", i.e. the user does not have the necessary permissions for the resource.

+ 参考：[RFC7231, Section 6.5.3](http://tools.ietf.org/html/rfc7231#section-6.5.3)

#### 404 Not Found

404资源不存在，请求失败，请求所希望得到的资源未被在服务器上发现。没有信息能够告诉用户这个状况到底是暂时的还是永久的。假如服务器知道情况的话，应当使用410状态码来告知旧资源因为某些内部的配置机制问题，已经永久的不可用，而且没有任何可以跳转的地址。

404这个状态码被广泛应用于当服务器不想揭示到底为何请求被拒绝或者没有其他适合的响应可用的情况下。

> The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible.

> The 404 (Not Found) status code indicates that the origin server did not find a current representation for the target resource or is not willing to disclose that one exists. A 404 status code does not indicate whether this lack of representation is temporary or permanent; the 410 (Gone) status code is preferred over 404 if the origin server knows, presumably through some configurable means, that the condition is likely to be permanent.

+ 参考：[RFC7231, Section 6.5.4](http://tools.ietf.org/html/rfc7231#section-6.5.4)

#### 405 Method Not Allowed

请求行中指定的请求方法不能被用于请求相应的资源。该响应必须返回一个Allow 头信息用以表示出当前资源能够接受的请求方法的列表。

鉴于 PUT，DELETE 方法会对服务器上的资源进行写操作，因而绝大部分的网页服务器都不支持或者在默认配置下不允许上述请求方法，对于此类请求均会返回405错误。

> A request method is not supported for the requested resource; for example, a GET request on a form which requires data to be presented via POST, or a PUT request on a read-only resource.

> The 405 (Method Not Allowed) status code indicates that the method received in the request-line is known by the origin server but not supported by the target resource. The origin server MUST generate an Allow header field in a 405 response containing a list of the target resource's currently supported methods.

+ 参考：[RFC7231, Section 6.5.5](http://tools.ietf.org/html/rfc7231#section-6.5.5)

#### 406 Not Acceptable

请求的资源的内容特性无法满足请求头中的条件，因而无法生成响应实体。

除非这是一个 HEAD 请求，否则该响应就应当返回一个包含可以让用户或者浏览器从中选择最合适的实体特性以及地址列表的实体。实体的格式由 Content-Type 头中定义的媒体类型决定。浏览器可以根据格式及自身能力自行作出最佳选择。

但是，规范中并没有定义任何作出此类自动选择的标准。

> The requested resource is capable of generating only content not acceptable according to the Accept headers sent in the request.

+ 参考：[RFC7231, Section 6.5.6](http://tools.ietf.org/html/rfc7231#section-6.5.6)

#### 407 Proxy Authentication Required

与401响应类似，只不过客户端必须在代理服务器上进行身份验证。代理服务器必须返回一个 Proxy-Authenticate 用以进行身份询问。客户端可以返回一个 Proxy-Authorization 信息头用以验证。

> The client must first authenticate itself with the proxy.

+ 参考：[RFC7232, Section 4.2](https://tools.ietf.org/html/rfc7235#section-3.2)

#### 408 Request Timeout

请求超时。客户端没有在服务器预备等待的时间内完成一个请求的发送。客户端可以随时再次提交这一请求而无需进行任何更改。

> The server timed out waiting for the request. According to HTTP specifications: "The client did not produce a request within the time that the server was prepared to wait. The client MAY repeat the request without modifications at any later time."

+ 参考：[RFC7231, Section 6.5.7](http://tools.ietf.org/html/rfc7231#section-6.5.7)

#### 409 Conflict

由于和被请求的资源的当前状态之间存在冲突，请求无法完成。这个代码只允许用在这样的情况下才能被使用：用户被认为能够解决冲突，并且会重新提交新的请求。该响应应当包含足够的信息以便用户发现冲突的源头。

冲突通常发生于对 PUT 请求的处理中。例如，在采用版本检查的环境下，某次 PUT 提交的对特定资源的修改请求所附带的版本信息与之前的某个（第三方）请求向冲突，那么此时服务器就应该返回一个409错误，告知用户请求无法完成。此时，响应实体中很可能会包含两个冲突版本之间的差异比较，以便用户重新提交归并以后的新版本。

> Indicates that the request could not be processed because of conflict in the request, such as an edit conflict between multiple simultaneous updates.

+ 参考：[RFC7231, Section 6.5.8](http://tools.ietf.org/html/rfc7231#section-6.5.8)

#### 410 Gone

被请求的资源在服务器上已经不再可用，而且没有任何已知的转发地址。这样的状况应当被认为是永久性的。如果可能，拥有链接编辑功能的客户端应当在获得用户许可后删除所有指向这个地址的引用。如果服务器不知道或者无法确定这个状况是否是永久的，那么就应该使用404状态码。除非额外说明，否则这个响应是可缓存的。

410响应的目的主要是帮助网站管理员维护网站，通知用户该资源已经不再可用，并且服务器拥有者希望所有指向这个资源的远端连接也被删除。这类事件在限时、增值服务中很普遍。同样，410响应也被用于通知客户端在当前服务器站点上，原本属于某个个人的资源已经不再可用。当然，是否需要把所有永久不可用的资源标记为'410 Gone'，以及是否需要保持此标记多长时间，完全取决于服务器拥有者。

> Indicates that the resource requested is no longer available and will not be available again. This should be used when a resource has been intentionally removed and the resource should be purged. Upon receiving a 410 status code, the client should not request the resource in the future. Clients such as search engines should remove the resource from their indices. Most use cases do not require clients and search engines to purge the resource, and a "404 Not Found" may be used instead.

+ 参考：[RFC7231, Section 6.5.9](http://tools.ietf.org/html/rfc7231#section-6.5.9)

#### 411 Length Required

服务器拒绝在没有定义 Content-Length 头的情况下接受请求。在添加了表明请求消息体长度的有效 Content-Length 头之后，客户端可以再次提交该请求。

> The request did not specify the length of its content, which is required by the requested resource.

#### 412 Precondition Failed

服务器在验证在请求的头字段中给出先决条件时，没能满足其中的一个或多个。这个状态码允许客户端在获取资源时在请求的元信息（请求头字段数据）中设置先决条件，以此避免该请求方法被应用到其希望的内容以外的资源上。

> The server does not meet one of the preconditions that the requester put on the request.

+ 参考：[RFC7232, Section 4.2](http://tools.ietf.org/html/rfc7232#section-4.2)

#### 413 Payload Too Large

服务器拒绝处理当前请求，因为该请求提交的实体数据大小超过了服务器愿意或者能够处理的范围。此种情况下，服务器可以关闭连接以免客户端继续发送此请求。

如果这个状况是临时的，服务器应当返回一个 Retry-After 的响应头，以告知客户端可以在多少时间以后重新尝试。

> The request is larger than the server is willing or able to process. Previously called "Request Entity Too Large".

#### 414 URI Too Long

请求的URI 长度超过了服务器能够解释的长度，因此服务器拒绝对该请求提供服务。这比较少见，通常的情况包括：

- 本应使用POST方法的表单提交变成了GET方法，导致查询字符串（Query String）过长。
- 重定向URI “黑洞”，例如每次重定向把旧的 URI 作为新的 URI 的一部分，导致在若干次重定向后 URI 超长。
- 客户端正在尝试利用某些服务器中存在的安全漏洞攻击服务器。这类服务器使用固定长度的缓冲读取或操作请求的 URI，当 GET 后的参数超过某个数值后，可能会产生缓冲区溢出，导致任意代码被执行[1]。没有此类漏洞的服务器，应当返回414状态码。

> The URI provided was too long for the server to process. Often the result of too much data being encoded as a query-string of a GET request, in which case it should be converted to a POST request. Called "Request-URI Too Long" previously.

+ 参考：[RFC7231, Section 6.5.12](http://tools.ietf.org/html/rfc7231#section-6.5.12)

#### 415 Unsupported Media Type

对于当前请求的方法和所请求的资源，请求中提交的实体并不是服务器中所支持的格式，因此请求被拒绝。

> The request entity has a media type which the server or resource does not support. For example, the client uploads an image as image/svg+xml, but the server requires that images use a different format.

+ 参考：[RFC7231, Section 6.5.13](http://tools.ietf.org/html/rfc7231#section-6.5.13)
+ 参考：[RFC7694, Section 3](http://tools.ietf.org/html/rfc7694#section-3)

#### 416 Range Not Satisfiable

如果请求中包含了 Range 请求头，并且 Range 中指定的任何数据范围都与当前资源的可用范围不重合，同时请求中又没有定义 If-Range 请求头，那么服务器就应当返回416状态码。

假如 Range 使用的是字节范围，那么这种情况就是指请求指定的所有数据范围的首字节位置都超过了当前资源的长度。服务器也应当在返回416状态码的同时，包含一个 Content-Range 实体头，用以指明当前资源的长度。这个响应也被禁止使用 multipart/byteranges 作为其 Content-Type。

> The client has asked for a portion of the file (byte serving), but the server cannot supply that portion. For example, if the client asked for a part of the file that lies beyond the end of the file. Called "Requested Range Not Satisfiable" previously.

+ 参考：[RFC7233, Section 4.4](http://tools.ietf.org/html/rfc7233#section-4.4)

#### 417 Expectation Failed

在请求头 Expect 中指定的预期内容无法被服务器满足，或者这个服务器是一个代理服务器，它有明显的证据证明在当前路由的下一个节点上，Expect 的内容无法被满足。

> The server cannot meet the requirements of the Expect request-header field.

#### ~~418 I'm a teapot~~

> This code was defined in 1998 as one of the traditional IETF April Fools' jokes, in RFC 2324, Hyper Text Coffee Pot Control Protocol, and is not expected to be implemented by actual HTTP servers. The RFC specifies this code should be returned by tea pots requested to brew coffee. This HTTP status is used as an easter egg in some websites, including Google.com.

这个代码是在1998年作为传统的IETF April Fools‘ jokes被定义的在RFC2324，超文本咖啡罐控制协议，但是并没有被实际的HTTP服务器实现。RFC指定了这个代码应该是由茶罐返回给速溶咖啡。

~~所以，这条其实是闹着玩的。~~

#### 421 Misdirected Request

从当前客户端所在的IP地址到服务器的连接数超过了服务器许可的最大范围。通常，这里的IP地址指的是从服务器上看到的客户端地址（比如用户的网关或者代理服务器地址）。在这种情况下，连接数的计算可能涉及到不止一个终端用户。

> The request was directed at a server that is not able to produce a response (for example because a connection reuse).

+ 参考：[RFC7540, Section 9.1.2](http://tools.ietf.org/html/rfc7540#section-9.1.2)

#### 422 Unprocessable Entity

WebDAV 扩展，表示请求格式正确，但是由于含有语义错误，无法响应。

> The request was well-formed but was unable to be followed due to semantic errors.

#### 423 Locked

WebDAV 扩展，表示当前资源被锁定。

> The resource that is being accessed is locked.

#### 424 Failed Dependency

WebDAV 扩展，表示由于之前的某个请求发生的错误，导致当前请求失败，例如 PROPPATCH。

> The request failed due to failure of a previous request (e.g., a PROPPATCH).

#### 426 Upgrade Required

客户端应当切换到TLS/1.0。

> The client should switch to a different protocol such as TLS/1.0, given in the Upgrade header field.

#### 428 Precondition Required

原始服务器需要有条件的请求。当客户端GET一个资源的状态的时候，同时又PUT回给服务器，与此同时第三方修改状态到服务器上的时候，为了避免丢失更新的问题发生将会导致冲突。

> The origin server requires the request to be conditional. Intended to prevent "the 'lost update' problem, where a client GETs a resource's state, modifies it, and PUTs it back to the server, when meanwhile a third party has modified the state on the server, leading to a conflict."

+ 参考：[RFC6585, Section 3](https://tools.ietf.org/html/rfc6585#section-3)

#### 429 Too Many Requests

用户已经发送了太多的请求在指定的时间里。用于限制速率。

> The user has sent too many requests in a given amount of time. Intended for use with rate limiting schemes.

+ 参考：[RFC6585, Section 4](https://tools.ietf.org/html/rfc6585#section-4)

#### 431 Request Header Fields Too Large

服务器由于一个单独的请求头部字段或者是全部的字段太大而不愿意处理请求。

> The server is unwilling to process the request because either an individual header field, or all the header fields collectively, are too large.

+ 参考：[RFC6585, Section 5](https://tools.ietf.org/html/rfc6585#section-5)

#### 451 Unavailable For Legal Reasons

被定义在因特网草稿“一个新的HTTP状态码用于法律限制的资源”。被用于当资源的访问由于法律原因被禁止的时候。例如检查制度或者是政府强制要求禁止访问。一个例子是1953年dystopian的小说Fahrenheit 451就是一个非法的资源。

> A server operator has received a legal demand to deny access to a resource or to a set of resources that includes the requested resource. The code 451 was chosen as a reference to the novel Fahrenheit 451.

+ 参考：[RFC7725, Section 3](https://tools.ietf.org/html/rfc7725#section-3)

### 5xx 服务器错误

这类状态码代表了服务器在处理请求的过程中有错误或者异常状态发生，也有可能是服务器意识到以当前的软硬件资源无法完成对请求的处理。除非这是一个HEAD 请求，否则服务器应当包含一个解释当前错误状态以及这个状况是临时的还是永久的解释信息实体。浏览器应当向用户展示任何在当前响应中被包含的实体。

这些状态码适用于任何响应方法。
　　
> The server failed to fulfill an apparently valid request.

> Response status codes beginning with the digit "5" indicate cases in which the server is aware that it has encountered an error or is otherwise incapable of performing the request. Except when responding to a HEAD request, the server should include an entity containing an explanation of the error situation, and indicate whether it is a temporary or permanent condition. Likewise, user agents should display any included entity to the user. These response codes are applicable to any request method.

#### 500 Internal Server Error

服务器遇到了一个未曾预料的状况，导致了它无法完成对请求的处理。一般来说，这个问题都会在服务器的程序码出错时出现。

> A generic error message, given when an unexpected condition was encountered and no more specific message is suitable.

#### 501 Not Implemented

服务器不支持当前请求所需要的某个功能。当服务器无法识别请求的方法，并且无法支持其对任何资源的请求。

> The server either does not recognize the request method, or it lacks the ability to fulfill the request. Usually this implies future availability (e.g., a new feature of a web-service API).

#### 502 Bad Gateway

作为网关或者代理工作的服务器尝试执行请求时，从上游服务器接收到无效的响应。

> The server was acting as a gateway or proxy and received an invalid response from the upstream server.

#### 503 Service Unavailable

由于临时的服务器维护或者过载，服务器当前无法处理请求。这个状况是临时的，并且将在一段时间以后恢复。如果能够预计延迟时间，那么响应中可以包含一个 Retry-After 头用以标明这个延迟时间。如果没有给出这个 Retry-After 信息，那么客户端应当以处理500响应的方式处理它。

注意：503状态码的存在并不意味着服务器在过载的时候必须使用它。某些服务器只不过是希望拒绝客户端的连接。

> The server is currently unavailable (because it is overloaded or down for maintenance). Generally, this is a temporary state.

#### 504 Gateway Timeout

作为网关或者代理工作的服务器尝试执行请求时，未能及时从上游服务器（URI标识出的服务器，例如HTTP、FTP、LDAP）或者辅助服务器（例如DNS）收到响应。

注意：某些代理服务器在DNS查询超时时会返回400或者500错误

> The server was acting as a gateway or proxy and did not receive a timely response from the upstream server.

#### 505 HTTP Version Not Supported

服务器不支持，或者拒绝支持在请求中使用的 HTTP 版本。这暗示着服务器不能或不愿使用与客户端相同的版本。响应中应当包含一个描述了为何版本不被支持以及服务器支持哪些协议的实体。

> The server does not support the HTTP protocol version used in the request.[65]

#### 506 Variant Also Negotiates

由《透明内容协商协议》（[RFC 2295][rfc2295]）扩展，代表服务器存在内部配置错误：被请求的协商变元资源被配置为在透明内容协商中使用自己，因此在一个协商处理中不是一个合适的重点。

> Transparent content negotiation for the request results in a circular reference.

#### 507 Insufficient Storage

服务器无法存储完成请求所必须的内容。这个状况被认为是临时的。WebDAV ([RFC 4918][rfc4918])扩展此状态码。

> The server is unable to store the representation needed to complete the request.

#### 508 Loop Detected 

服务器发现了一个无限的循环档处理请求的时候。

> The server detected an infinite loop while processing the request (sent in lieu of 208 Already Reported).

+ 参考：[RFC5842, Section 7.2](http://tools.ietf.org/html/rfc5842#section-7.2)

#### 510 Not Extended

获取资源所需要的策略并没有没满足。（[RFC 2774](https://tools.ietf.org/html/rfc2774#section-7)）

> Further extensions to the request are required for the server to fulfil it.

#### 511 Network Authentication Required

客户端需要授权去火的网络的访问权限。一般用于代理交互中被用来进行网络的访问控制。（[RFC 6585](https://tools.ietf.org/html/rfc6585#section-6)）

> The client needs to authenticate to gain network access. Intended for use by intercepting proxies used to control access to the network (e.g., "captive portals" used to require agreement to Terms of Service before granting full Internet access via a Wi-Fi hotspot).

### 非官方HTTP状态码

以下HTTP状态码没有被RFC定义，但是有第三方服务使用到了。

#### 103 Checkpoint

> Used in the resumable requests proposal to resume aborted PUT or POST requests.

#### 420 Method Failure (Spring Framework)

> A deprecated response used by the Spring Framework when a method has failed.

#### 420 Enhance Your Calm (Twitter)

> Returned by version 1 of the Twitter Search and Trends API when the client is being rate limited; versions 1.1 and later use the 429 Too Many Requests response code instead.

#### 450 Blocked by Windows Parental Controls (Microsoft)

> A Microsoft extension. This error is given when Windows Parental Controls are turned on and are blocking access to the given webpage.

#### 498 Invalid Token (Esri)

> Returned by ArcGIS for Server. A code of 498 indicates an expired or otherwise invalid token.

#### 499 Token Required (Esri)

> Returned by ArcGIS for Server. A code of 499 indicates that a token is required but was not submitted.

#### 499 Request has been forbidden by antivirus

> Produced by some programs such as Wget when a malicious site is intercepted.

#### 509 Bandwidth Limit Exceeded (Apache Web Server/cPanel)

> The server has exceeded the bandwidth specified by the server administrator; this is often used by shared hosting providers to limit the bandwidth of customers.

#### 530 Site is frozen

> Used by the Pantheon web platform to indicate a site that has been frozen due to inactivity.

### IIS扩展的HTTP状态码

IIS(The Internet Information Services)扩展了部分4xx错误。

#### 440 Login Timeout

你的会话已经超时。

> The client's session has expired and must log in again.

#### 449 Retry With

请求应该在执行适当的动作之后被重试。

> The server cannot honour the request because the user has not provided the required information.

#### 451 Redirect

被用在Exchange ActiveSync中如果一个更有效的服务器能够被使用或者是服务器不能访问用户的邮箱。客户端会假定重新执行HTTP自动发现协议去寻找更适合的服务器。

> Used in Exchange ActiveSync when either a more efficient server is available or the server cannot access the users' mailbox. The client is expected to re-run the HTTP AutoDiscover operation to find a more appropriate server.

### Nginx扩展的HTTP状态码

Nginx服务器针对4xx状态码也进行了部分扩展。

#### 444 No Response

无响应。被使用在Nginx的日志中表明服务器没有返回信息给客户端并且关闭了连接（在威慑恶意软件的时候比较有用）。

> Used to indicate that the server has returned no information to the client and closed the connection.

#### 494 Request Header Too Large

请求头太大。Nginx内置代码和431类似，但是是被更早地引入在版本0.9.4（在2011年1月21日）。

#### 495 SSL Certificate Error

证书错误。Nginx内置的代码，当使用SSL客户端证书的时候错误会出现为了在日志错误中区分它和4XX和一个错误页面的重定向。

> An expansion of the 400 Bad Request response code, used when the client has provided an invalid client certificate.

#### 496 SSL Certificate Required

没有证书。Nginx内置的代码，当客户端不能提供证书在日志中分辨4XX和一个错误页面的重定向。

> An expansion of the 400 Bad Request response code, used when a client certificate is required but not provided.

#### 497 HTTP Request Sent to HTTPS Port

HTTP到HTTPS。Nginx内置的代码，被用于原始的HTTP的请求发送给HTTPS端口去分辨4XX在日志中和一个错误页面的重定向。

> An expansion of the 400 Bad Request response code, used when the client has made a HTTP request to a port listening for HTTPS requests.

#### 499 Client Closed Request

客户端关闭请求。被用在Nginx日志去表明一个连接已经被客户端关闭当服务器仍然正在处理它的请求，是的服务器无法返货状态码。

> Used when the client has closed the request before the server could send a response.

### CloudFlare扩展的HTTP状态码

CloudFlare的服务器针对5xx错误进行了部分扩展。

#### 520 Unknown Error

520错误本质上是一个捕获全部的响应当原始服务器返回一些未知的或者一些不能被忍受或者被解释的(协议违反或者空响应)。

> The 520 error is used as a "catch-all response for when the origin server returns something unexpected", listing connection resets, large headers, and empty or invalid responses as common triggers.

#### 521 Web Server Is Down

> The origin server has refused the connection from CloudFlare.

#### 522 Connection Timed Out

> CloudFlare could not negotiate a TCP handshake with the origin server.

#### 523 Origin Is Unreachable

> CloudFlare could not reach the origin server; for example, if the DNS records for the origin server are incorrect.

#### 524 A Timeout Occurred

> CloudFlare was able to complete a TCP connection to the origin server, but did not receive a timely HTTP response.

#### 525 SSL Handshake Failed

> CloudFlare could not negotiate a SSL/TLS handshake with the origin server.

#### 526 Invalid SSL Certificate

> CloudFlare could not validate the SSL/TLS certificate that the origin server presented.

### 其他HTTP状态码

#### 419 认证超时

并不是HTTP标注的一部分，419认证超时表示以前的有效证明已经失效了。同时也被用于401未认证的替代选择为了从其它被拒绝访问的已认证客户端中指定服务器的资源。

#### 598 网络读取超时异常(未知)

这个状态码也没有在任何RFC中指定，但是被用在微软的HTTP代理中去标注一个网络读取超时在一个客户端之前的代理的后面。

#### 599 网络连接超时异常(未知)

这个状态码也没有在任何RFC中指定，但是被用在微软的HTTP代理中去标注一个网络连接超时在一个客户端之前的代理的后面。

### IIS中更加详细的HTTP状态码（xxx.x形式）

IIS 7.0、IIS 7.5 和 IIS 8.0 中，对 HTTP 状态代码，使用了小数点后的数字来表示更加具体的原因。

#### 400 - 错误的请求

由于语法格式不正确，服务器无法理解该请求。客户端不应在未经修改的情况下重复请求。

- 400.1 - 无效的目的标头。
- 400.2 - 无效的深度标头。
- 400.3 - 无效的如果标头。
- 400.4 - 无效的覆盖标头。
- 400.5 - 无效的转换标头。
- 400.6 - 无效的请求正文。
- 400.7 - 无效的内容长度。
- 400.8 - 无效的超时值。
- 400.9 - 无效的锁定令牌。

#### 401 - 访问被拒绝

- 401.1 - 登录失败。
- 401.2 - 服务器配置导致登录失败。
- 401.3 - 由于 ACL 对资源的限制而未获得授权。
- 401.4 - 筛选器授权失败。
- 401.5 - ISAPI/CGI 应用程序授权失败。

IIS 8.0 中添加的：

- 400.10 - 无效的 XFF 标题
- 400.11 - 无效的 WebSocket 请求

#### 403 - 禁止访问

- 403.1 - 执行访问被禁止。
- 403.2 - 读访问被禁止。
- 403.3 - 写访问被禁止。
- 403.4 - 要求 SSL。
- 403.5 - 要求 SSL 128。
- 403.6 - IP 地址被拒绝。
- 403.7 - 要求客户端证书。
- 403.8 - 站点访问被拒绝。
- 403.9 - 禁止：许多客户端尝试连接到 Web 服务器。
- 403.10 - 禁止访问：配置 Web 服务器为拒绝执行访问。
- 403.11 - 禁止访问：密码已更改。
- 403.12 - 拒绝访问映射表。
- 403.13 - 客户端证书被吊销。
- 403.14 - 拒绝目录列表。
- 403.15 - 禁止访问：客户端访问许可证已超出 Web 服务器上的限制。
- 403.16 - 客户端证书不受信任或无效。
- 403.17 - 客户端证书已过期或尚未生效。
- 403.18 - 在当前的应用程序池中不能执行所请求的 URL。
- 403.19 - 在此应用程序池中不能执行客户端的 CGI 应用程序。
- 403.20 - 禁止访问：护照登录失败。
- 403.21 - 禁止访问：拒绝源访问。
- 403.22 - 禁止访问：拒绝无限深度。
- 403.502 - 禁止访问：太多请求来自同一客户端 IP；已达到动态 IP 限制的限制。

#### 404 - 未找到

- 404.0 - 未找到。
- 404.1 - 站点未找到。
- 404.2 - ISAPI 或 CGI 限制。
- 404.3 - MIME 类型限制。
- 404.4 - 未配置处理程序。
- 404.5 - 被请求筛选器配置拒绝。
- 404.6 - 动词被拒绝。
- 404.7 - 文件扩展名被拒绝。
- 404.8 - 隐藏的命名空间。
- 404.9 - 文件属性被隐藏。
- 404.10 - 请求标头太长。
- 404.11 - 请求包含双转义序列。
- 404.12 - 请求包含高位字符。
- 404.13 - 内容长度太大。
- 404.14 - 请求 URL 太长。
- 404.15 - 查询字符串太长。
- 404.16 - 发送到静态文件处理程序的 DAV 请求。
- 404.17 - 动态内容通过通配符 MIME 映射映射到静态文件处理程序。
- 404.18 - 查询字符串序列被拒绝。
- 404.19 - 被筛选规则拒绝。
- 404.20 - URL 段太多

#### 500 - 内部服务器错误

- 500.0 - 发生模块或 ISAPI 错误。
- 500.11 - 正在 Web 服务器上关闭应用程序。
- 500.12 - 应用程序正忙于在 Web 服务器上重新启动。
- 500.13 - Web 服务器太忙。
- 500.15 - 不允许直接请求 Global.asax。
- 500.19 - 配置数据无效。
- 500.21 - 模块无法识别。
- 500.22 - 无法在托管管道模式下应用 ASP.NET httpModules 配置。
- 500.23 - 无法在托管管道模式下应用 ASP.NET httpHandlers 配置。
- 500.24 - 无法在托管管道模式下应用 ASP.NET impersonation 配置。
- 500.50 - RQ_BEGIN_REQUEST 通知处理期间，发生重写错误。发生配置或入站规则执行错误。
    - 注意此处是为入站和出站规则读取分布规则配置的地方。
- 500.51 - GL_PRE_BEGIN_REQUEST 通知处理期间，发生重写错误。发生全局配置或全局规则执行错误。
    - 注意此处是读取全局规则配置的地方。
- 500.52 - RQ_SEND_RESPONSE 通知处理期间，发生重写错误。发生出站规则执行。
- 500.53 - RQ_RELEASE_REQUEST_STATE 通知处理期间，发生重写错误。发生出站规则执行错误。此规则配置为在更新输出用户缓存之前执行。
- 500.100 - 内部 ASP 错误。

#### 502 - Web 服务器用作网关或代理服务器时收到了无效响应

- 502.1 - CGI 应用程序超时。
- 502.2 - 网关错误：过早退出。
- 502.3 - 网关错误：转发器连接错误 (ARR)。
- 502.4 - 网关错误：无服务器 (ARR)。

#### 503 - 服务不可用

- 503.0 - 应用程序池不可用。
- 503.2 - 超出并发请求限制。
- 503.3 - ASP.NET 队列已满。

#### ARR中添加的

> ARR（Application Request Route）是一个寄宿于 IIS7（及以后的IIS 版本）的一个基于代理的模块，它可以通过判断Http Headers，Server Variables 以及负载均衡算法将 HTTP 的请求转发到不同的处理服务器之上。

- 400.601	错误的客户端请求
- 400.602	无效的时间格式 
- 400.603	解析范围错误 
- 400.604	发往客户端
- 400.605	最大转发数量 
- 400.606	异步完成错误
- 502.2	映射请求失败
- 502.3	WinHTTP 异步完成失败 
- 502.4	无服务器
- 502.5	WebSocket 失败 
- 502.6	转发请求失败 
- 502.7	执行请求失败

更多信息请参阅微软官方文档：[IIS 7.0、IIS 7.5 和 IIS 8.0 中的 HTTP 状态代码][iis]

~~看完中文再看英文，心好累，还是阅读英文的文档吧：[The HTTP status code in IIS 7.0, IIS 7.5, and IIS 8.0][iis2]~~

## IANA中注册在案的HTTP状态码一览

IANA(The Internet Assigned Numbers Authority，互联网数字分配机构)是负责协调一些使Internet正常运作的机构。

以下代码摘自：[Hypertext Transfer Protocol (HTTP) Status Code Registry][iana]

|值|描述|参考|
| --- | --- | --- |
| 100 | Continue | [RFC7231, Section 6.2.1](http://www.iana.org/go/rfc7231) |
| 101 | Switching Protocols | [RFC7231, Section 6.2.2](http://www.iana.org/go/rfc7231) |
| 102 | Processing | [RFC2518](http://www.iana.org/go/rfc2518) |
| 103-199 | Unassigned | &nbsp; |
| 200 | OK | [RFC7231, Section 6.3.1](http://www.iana.org/go/rfc7231) |
| 201 | Created | [RFC7231, Section 6.3.2](http://www.iana.org/go/rfc7231) |
| 202 | Accepted | [RFC7231, Section 6.3.3](http://www.iana.org/go/rfc7231) |
| 203 | Non-Authoritative Information | [RFC7231, Section 6.3.4](http://www.iana.org/go/rfc7231) |
| 204 | No Content | [RFC7231, Section 6.3.5](http://www.iana.org/go/rfc7231) |
| 205 | Reset Content | [RFC7231, Section 6.3.6](http://www.iana.org/go/rfc7231) |
| 206 | Partial Content | [RFC7233, Section 4.1](http://www.iana.org/go/rfc7233) |
| 207 | Multi-Status | [RFC4918](http://www.iana.org/go/rfc4918) |
| 208 | Already Reported | [RFC5842](http://www.iana.org/go/rfc5842) |
| 209-225 | Unassigned | &nbsp; |
| 226 | IM Used | [RFC3229](http://www.iana.org/go/rfc3229) |
| 227-299 | Unassigned | &nbsp; |
| 300 | Multiple Choices | [RFC7231, Section 6.4.1](http://www.iana.org/go/rfc7231) |
| 301 | Moved Permanently | [RFC7231, Section 6.4.2](http://www.iana.org/go/rfc7231) |
| 302 | Found | [RFC7231, Section 6.4.3](http://www.iana.org/go/rfc7231) |
| 303 | See Other | [RFC7231, Section 6.4.4](http://www.iana.org/go/rfc7231) |
| 304 | Not Modified | [RFC7232, Section 4.1](http://www.iana.org/go/rfc7232) |
| 305 | Use Proxy | [RFC7231, Section 6.4.5](http://www.iana.org/go/rfc7231) |
| 306 | (Unused) | [RFC7231, Section 6.4.6](http://www.iana.org/go/rfc7231) |
| 307 | Temporary Redirect | [RFC7231, Section 6.4.7](http://www.iana.org/go/rfc7231) |
| 308 | Permanent Redirect | [RFC7538](http://www.iana.org/go/rfc7538) |
| 309-399 | Unassigned | &nbsp; |
| 400 | Bad Request | [RFC7231, Section 6.5.1](http://www.iana.org/go/rfc7231) |
| 401 | Unauthorized | [RFC7235, Section 3.1](http://www.iana.org/go/rfc7235) |
| 402 | Payment Required | [RFC7231, Section 6.5.2](http://www.iana.org/go/rfc7231) |
| 403 | Forbidden | [RFC7231, Section 6.5.3](http://www.iana.org/go/rfc7231) |
| 404 | Not Found | [RFC7231, Section 6.5.4](http://www.iana.org/go/rfc7231) |
| 405 | Method Not Allowed | [RFC7231, Section 6.5.5](http://www.iana.org/go/rfc7231) |
| 406 | Not Acceptable | [RFC7231, Section 6.5.6](http://www.iana.org/go/rfc7231) |
| 407 | Proxy Authentication Required | [RFC7235, Section 3.2](http://www.iana.org/go/rfc7235) |
| 408 | Request Timeout | [RFC7231, Section 6.5.7](http://www.iana.org/go/rfc7231) |
| 409 | Conflict | [RFC7231, Section 6.5.8](http://www.iana.org/go/rfc7231) |
| 410 | Gone | [RFC7231, Section 6.5.9](http://www.iana.org/go/rfc7231) |
| 411 | Length Required | [RFC7231, Section 6.5.10](http://www.iana.org/go/rfc7231) |
| 412 | Precondition Failed | [RFC7232, Section 4.2](http://www.iana.org/go/rfc7232) |
| 413 | Payload Too Large | [RFC7231, Section 6.5.11](http://www.iana.org/go/rfc7231) |
| 414 | URI Too Long | [RFC7231, Section 6.5.12](http://www.iana.org/go/rfc7231) |
| 415 | Unsupported Media Type | [RFC7231, Section 6.5.13](http://www.iana.org/go/rfc7231), [RFC7694, Section 3](http://www.iana.org/go/rfc7694) |
| 416 | Range Not Satisfiable | [RFC7233, Section 4.4](http://www.iana.org/go/rfc7233) |
| 417 | Expectation Failed | [RFC7231, Section 6.5.14](http://www.iana.org/go/rfc7231) |
| 418-420 | Unassigned | &nbsp; |
| 421 | Misdirected Request | [RFC7540, Section 9.1.2](http://www.iana.org/go/rfc7540) |
| 422 | Unprocessable Entity | [RFC4918](http://www.iana.org/go/rfc4918) |
| 423 | Locked | [RFC4918](http://www.iana.org/go/rfc4918) |
| 424 | Failed Dependency | [RFC4918](http://www.iana.org/go/rfc4918) |
| 425 | Unassigned | &nbsp; |
| 426 | Upgrade Required | [RFC7231, Section 6.5.15](http://www.iana.org/go/rfc7231) |
| 427 | Unassigned | &nbsp; |
| 428 | Precondition Required | [RFC6585](http://www.iana.org/go/rfc6585) |
| 429 | Too Many Requests | [RFC6585](http://www.iana.org/go/rfc6585) |
| 430 | Unassigned | &nbsp; |
| 431 | Request Header Fields Too Large | [RFC6585](http://www.iana.org/go/rfc6585) |
| 432-450 | Unassigned | &nbsp; |
| 451 | Unavailable For Legal Reasons | [RFC7725](http://www.iana.org/go/rfc7725) |
| 452-499 | Unassigned | &nbsp; |
| 500 | Internal Server Error | [RFC7231, Section 6.6.1](http://www.iana.org/go/rfc7231) |
| 501 | Not Implemented | [RFC7231, Section 6.6.2](http://www.iana.org/go/rfc7231) |
| 502 | Bad Gateway | [RFC7231, Section 6.6.3](http://www.iana.org/go/rfc7231) |
| 503 | Service Unavailable | [RFC7231, Section 6.6.4](http://www.iana.org/go/rfc7231) |
| 504 | Gateway Timeout | [RFC7231, Section 6.6.5](http://www.iana.org/go/rfc7231) |
| 505 | HTTP Version Not Supported | [RFC7231, Section 6.6.6](http://www.iana.org/go/rfc7231) |
| 506 | Variant Also Negotiates | [RFC2295](http://www.iana.org/go/rfc2295) |
| 507 | Insufficient Storage | [RFC4918](http://www.iana.org/go/rfc4918) |
| 508 | Loop Detected | [RFC5842](http://www.iana.org/go/rfc5842) |
| 509 | Unassigned | &nbsp; |
| 510 | Not Extended | [RFC2774](http://www.iana.org/go/rfc2774) |
| 511 | Network Authentication Required | [RFC6585](http://www.iana.org/go/rfc6585) |
| 512-599 | Unassigned | &nbsp; |

## HTTPDD：一张HTTP状态码总结图

在Github上发现一张针对HTTP状态码进行一个总结的图。
[for-GET/http-decision-diagram](https://github.com/for-GET/http-decision-diagram)

这里不直接放图了，[点我查看大图](https://raw.githubusercontent.com/for-GET/http-decision-diagram/master/httpdd.png)。~~注意：大图杀猫，请谨慎点击~~

还有一张之前传播甚广的图也一并附上：[HTTP Status Codes Flowchart](http://i.stack.imgur.com/whhD1.png)。~~我不会告诉你前面那张总结更全，效果更好~~

*本节内容2016.6.14新增*

## 参考资料

- [RFC 2616 - Hypertext Transfer Protocol -- HTTP/1.1][rfc2616]
- [RFC 7231 - Hypertext Transfer Protocol (HTTP/1.1): Semantics and Content][rfc7231]
- [Hypertext Transfer Protocol (HTTP) Status Code Registry][iana]
- [List of HTTP status codes - Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/HTTP_status)

[rfc2068]: https://tools.ietf.org/html/rfc2068
[rfc2616]: https://tools.ietf.org/html/rfc2616
[rfc2518]: https://tools.ietf.org/html/rfc2518
[rfc2324]: https://tools.ietf.org/html/rfc2324
[rfc2817]: https://tools.ietf.org/html/rfc2817
[rfc2295]: https://tools.ietf.org/html/rfc2295
[rfc2774]: https://tools.ietf.org/html/rfc2774
[rfc3229]: https://tools.ietf.org/html/rfc3229
[rfc4918]: https://tools.ietf.org/html/rfc4918
[rfc6585]: https://tools.ietf.org/html/rfc6585
[rfc7231]: https://tools.ietf.org/html/rfc7231
[rfc7232]: https://tools.ietf.org/html/rfc7232
[rfc7233]: https://tools.ietf.org/html/rfc7233
[rfc7235]: https://tools.ietf.org/html/rfc7235
[rfc7538]: https://tools.ietf.org/html/rfc7538
[iis]: https://support.microsoft.com/zh-cn/kb/943891
[iis2]: https://support.microsoft.com/en-us/kb/943891
[iana]: http://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml


