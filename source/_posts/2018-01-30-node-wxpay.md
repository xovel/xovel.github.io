---
title: node 下的微信公众号支付初探
tags: [node, wxpay, 公众号]
categories: [Node]
date: 2018-01-30 23:06:50
description: 本文记录一下关于 node/express 下的微信公众号支付测试小 demo 的开发过程。
---

> 那么，就直接开门见山呗。本篇博客根据个人日志记录整理而成。
>
> 项目地址：<https://github.com/xovel/node-wxpay-test>

其实大部分的文档，微信官方开发文档里面都提供了，我们只需要按照其说明严格执行就可以达到目的。

注意，这里只讲述公众号支付相关的情形，其他的基本类似，本人未作深入实践，故此不敢多言。

这次的讲解，主要从四个方面进行说明：

1. 相关账户配置
2. 后台的搭建
3. 前端页面的展示
4. 支付流程

### 账户

首先，肯定是需要一个微信公众号的。公众号的性质需要满足开通商户号和微信支付，并且实际上已经开通好了。这次我用的账号是认证好了的服务号。

进入公众号设置界面，对相关的域名进行配置，本次调试，我使用的域名是 `z.hdk4.com`，故此在公众的管理页面的 `【设置】-【公众号设置】-【功能设置】` 中对 `业务域名`、`JS接口安全域名`、`网页授权域名` 全部进行了相应的设置。

> 至于开发者的添加和公众号密钥和商户号密钥等数据的获取，属于入门级别，这里不再赘述。

要做微信支付，需要事先对 `支付授权目录` 进行设置，在商户号管理页面就能够找得到，直接进行设置即可。注意这里是 `支付目录` 的设置，即浏览器访问下的 `location.pathname` 对应的访问路径，结尾必须以 `/` 结束且**区分大小写**。

### 后台

这一块最为重要也是核心所在，由于只是演示与测验，所以采用了简单粗暴的 `express` 来作为后台服务器。详情容后再禀。

### 前端

前端页面相对来说简单一些，在引入微信的官方 `js`，即 <http://res.wx.qq.com/open/js/jweixin-1.2.0.js> 之后，调用 `WeixinJSBridge` 的 API，发起 `getBrandWCPayRequest` 请求即可。

```js
WeixinJSBridge.invoke('getBrandWCPayRequest', {
  appId: data.appId,
  timeStamp: data.timeStamp,
  nonceStr: data.nonceStr,
  package: data.package,
  signType: data.signType,
  paySign: data.paySign
}, function (res) {
  // ...
});
```

当然，在这里之前，需要先获取用户的 `openid`。

当然，在获取 `openid` 之前，还需要获取一下用户的访问 `code`。

那么，这个访问的 `code` 如何获取呢？

根据微信开发文档提供的链接 <https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421140842>，我们先判断链接是否有 `code` 字段，如果没有则跳转到微信的链接去进行获取。获取到了之后再进行 `openid` 的获取。文档方面的信息这里不详细展开，直接上代码进行说明吧！

```js
var code = getUrlParam('code') || sessionStorage.code;
var openid = sessionStorage.openid;

// 没有 openid 则尝试获取 code
// code 获取之后跳回原链接进行临时存储
if (!openid) {
  if (!code) {
    var redirect_uri = encodeURIComponent('http://z.hdk4.com/d.html');
    window.location.replace('https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxbce0a3daf503097c&redirect_uri=' + redirect_uri + '&response_type=code&scope=snsapi_base&state=7');
  } else if (!sessionStorage.code) {
    sessionStorage.code = code;
    window.location.replace('http://z.hdk4.com/d.html');
  }
}
```

几点说明：

- `redirect_uri` 中的 `state=7` 是随便写的一个值。
- `window.location.replace` 用于直接替换，如果不想要替换效果，可以修改为 `window.location.href = '...'`。
- 采用 `sessionStorage` 进行数据的缓存。
- `getUrlParam` 为提取链接中的 `querystring`。
- ~~不要管 `yoda` 什么的了~~

前端差不多能说的就这么多了。

### 支付流程

整个支付流程浓缩起来就是：

1. 获取 `code`
2. 获取 `openid`
3. 开始进行支付操作
4. 后台发起预支付订单
5. 后台将获取到的预支付信息返回给前端
6. 前端尝试唤起微信支付
7. 进行支付
8. 前端/后台处理支付回调。是的，都进行处理。前端无所谓，后台必须处理，不然微信会发很多次请求。
9. 支付完成
10. 后续一些相关操作。由于本次只是演示与测验，就不做处理了。

**************

现在来说一下核心的重点，即后台的相关逻辑处理与接口的设计。

### 后台

相关的库的引入与声明，这里就不赘述了。

#### `/api/getopenid` 接口
```js
// 获取 openid
app.get('/api/getopenid', function (req, res) {
  const code = req.query.code;
  const access_token_url = `https://api.weixin.qq.com/sns/oauth2/access_token?appid=${config.app_id}&secret=${config.app_secret}&code=${code}&grant_type=authorization_code`;

  request.post({ url: access_token_url }, function (error, response, body) {
    wFile('openid', body);
    if (error) {
      res.json({ error: body });
    } else if (response.statusCode === 200) {
      if (body.errcode === 40029 ) {
        res.json({ error: body });
      } else {
        body = JSON.parse(body);
        res.json({ data: body });
      }
    } else {
      res.json({ error: -1 });
    }
  });
});
```

> `wFile` 是日志记录相关操作，可以无视。

该接口是用来获取用户的 `openid` 的，要求的东西是 `code`，这个 `code` 就是上面前端花费一番周折得到的东西。

前端调用方式：

```js
function getOpenId() {
  return new Promise(function (resolve, reject) {
    if (sessionStorage.openid) {
      resolve(sessionStorage.openid);
    } else {
      $.get('/api/getopenid?code=' + sessionStorage.code).then(function (res) {
        var data = res.data;
        if (data && data.openid) {
          sessionStorage.openid = data.openid;
          resolve(data.openid)
        } else {
          reject();
        }
      });
    }
  });
}
```

- 是的， `$` 就是大名鼎鼎的 `jQuery`。
- 采用了 `Promise` 对象。

#### `/api/unifiedorder` 接口

```js
// 获取微信支付的统一下单相关数据
app.get('/api/unifiedorder', function (req, res) {
  const openid = req.query.openid;
  const ip = getClientIp(req);

  // 商户订单号
  const out_trade_no = 'test' + new Date().getTime();

  // 统一下单的相关参数
  const paramUnifiedOrder = {
    appid: config.app_id,
    attach: 'test',
    body: 'desc',
    mch_id: config.mch_id,
    nonce_str: createNonceStr(),
    notify_url: config.notify_url, // 微信付款后的回调地址
    openid: openid,
    out_trade_no: out_trade_no,
    spbill_create_ip: ip,
    total_fee: 1,
    trade_type: 'JSAPI'
  };

  // 签名
  paramUnifiedOrder.sign = getSign(paramUnifiedOrder);

  // 请求微信支付下单接口，获取预订单编号
  request.post({ url: 'https://api.mch.weixin.qq.com/pay/unifiedorder', body: JSON.stringify(getUnifiedOrderXml(paramUnifiedOrder)) }, function (error, response, body) {
    wFile('unifiedorder', body);
    if (error) {
      res.json({ error: body });
    } else if (response.statusCode === 200) {
      let prepay_id = ''; // 预订单编号
      // 微信返回的数据为 xml 格式，需要进行解析
      xml2jsparseString(body, { async: true }, function (error, result) {
        prepay_id = result.xml.prepay_id[0]; // 获取预订单编号
        const paramWCPay = {
          appId: config.app_id,
          timeStamp: parseInt(new Date().getTime() / 1000).toString(),
          nonceStr: createNonceStr(),
          package: 'prepay_id=' + prepay_id,
          signType: 'MD5'
        };
        paramWCPay.paySign = getSign(paramWCPay); // 微信支付签名
        res.json({ data: paramWCPay });
      });
    } else {
      res.json({ error: -1 });
    }
  });

});
```

- `getClientIp` 是获取客户端真实 IP 地址的方法。
- `createNonceStr` 是生成随机串的方式，非常简单粗暴。
- `out_trade_no` 是商户自定义的订单号。
- `getUnifiedOrderXml` 是用来拼接发送给微信支付统一下单接口的数据，要 `xml` 格式的，所以就给一个封装。
- `xml2jsparseString` 是解析 `xml` 文件的库。微信支付统一下单接口返回的数据是 `xml` 格式的，需要进行相应的解码。
- `getSign` 是生成签名的方法。

*************

如果不出意外，下单接口会返回一个 `xml` 数据，然后我们就可以提取到 `prepay_id` 这个核心的信息了。

#### `/api/wxresponse` 接口

```js
// 处理微信支付的回调
app.post('/api/wxresponse', function (req, res) {
  wFile('response', req.body);

  let xmlData = req.body.xml;
  let ret = '';
  if (xmlData.sign === getSign(xmlData)) {
    ret = `<xml>
  <return_code><![CDATA[SUCCESS]]></return_code>
  <return_msg><![CDATA[OK]]></return_msg>
</xml>`;
  } else {
    ret = `<xml>
  <return_code><![CDATA[SIGNATRURE_ERROR]]></return_code>
  <return_msg><![CDATA[FAIL]]></return_msg>
</xml>`;
  }
  res.send(ret);

});
```

该接口是用来处理 `notify_url` 指定的回调链接的相关数据的，本次用的具体值就是 <http://z.hdk4.com/api/wxresponse>。

如果不对该接口做回应，微信支付会一直发请求，直至系统判定失败。

> 注意，使用 `express` 进行开发时，会收不到 `req.body`，采用以下方法进行解决即可：

```js
const bodyParser = require('body-parser');
require('body-parser-xml')(bodyParser);

// 解决微信支付通知回调数据
app.use(bodyParser.xml({
  limit: '1MB',   // Reject payload bigger than 1 MB
  xmlParseOptions: {
    normalize: true,     // Trim whitespace inside text nodes
    normalizeTags: true, // Transform tags to lowercase
    explicitArray: false // Only put nodes in array if >1
  }
}));
```

#### 签名算法

```js
// 签名算法
function getSign(paramSign) {
  // 按 key 值的 ascii 排序
  const keys = Object.keys(paramSign).sort();
  const temp = [];
  keys.forEach(v => {
    if (paramSign[v] && v !== 'sign') {
      temp.push(`${v}=${paramSign[v]}`);
    }
  });
  temp.push(`key=${config.mch_key}`);

  const ret = temp.join('&');
  // 生成签名
  return crypto.createHash('md5').update(ret, 'utf8').digest('hex').toUpperCase();
}
```

非常~~简单粗暴~~的算法，嗯，如上所示。如果是其他语言，在生成 `MD5` 值的时候方法可能会有所不同，使用对应的方法即可。

#### 随机字符串方法

```js
function createNonceStr() {
  return Math.random().toString(36).substr(2, 15);
}
```

~~是的，这一条是滥竽充数的~~。

### 参考资料

- [获取openid](https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=4_4)
- [微信网页授权](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421140842)
- [微信内H5调起支付](https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=7_7&index=6)
- [签名算法](https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=4_3)
- [统一下单](https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=9_1)
- [wxpay/WXPay-SDK-Node.js](https://github.com/wxpay/WXPay-SDK-Node.js)
- [nodejs 微信公众号支付开发](https://gitee.com/anziguoer/wechatPay)，_大部分代码参考于此_。
- [微信公众号支付开发全过程 --JAVA](https://www.cnblogs.com/yimiyan/p/5603657.html)
- [微信公众号支付详细步骤(整理)](http://blog.csdn.net/aofavx/article/details/52220394)
- [Nginx向ExpressJS转发真实IP地址](https://segmentfault.com/a/1190000005797170)
- [Nodejs 部署到阿里云全过程](https://www.jianshu.com/p/0496ef49b2a5)
- [利用 Express 托管静态文件](http://www.expressjs.com.cn/starter/static-files.html)
- [proxy_pass](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_pass)
