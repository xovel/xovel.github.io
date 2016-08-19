---
title: Code Golf - Output Fit Numbers
date: 2016-08-18 17:12:50
tags: [黑科技, Code Golf, 编程]
categories: [随笔]

---


爱下棋的朋友应该对“排局”这个词并不陌生，与“排局”一样，编程领域也有跟这个类似的好玩的东西：有一种故意出一种看起来不切合实际的问题，要求使用尽量短的代码来实现对应的功能。这个叫做“Code Golf”的黑科技却吸引着众多的程序员参与其中，今天我们就来看看其中的一个例子。

<!--more-->

> 本文根据[Stack Exchange](http://stackexchange.com/)上的[code golf - Output "Fit" numbers](http://codegolf.stackexchange.com/questions/90067/output-fit-numbers)翻译/整理而成。

## 题目

现有这个一个需求，编程实现[OEIS数列A090078](https://oeis.org/A090078)。

这里简单介绍一下数列`A090078`，从基数开始，将序号转为二进制，再将二进制中的连在一起的`0`进行合并，得到的新的二进制再转换为十进制，便就是该数列的值。

示例：
```text
1 -> 1 -> 1 -> 1
9 -> 1001 -> 101 -> 5
15 ->1111 -> 1111 -> 15
13 ->1101 -> 1101 -> 13
16 -> 10000 -> 10 -> 2
17 -> 10001 -> 101 -> 5
65535 -> 1111111111111111 -> 1111111111111111 -> 65535
65000 -> 1111110111101000 -> 11111101111010 -> 16250
```

我们姑且把这种转换称之为`fit`，得到的数值叫做`fit number`。那么上面提到的需求就可以描述为：

> 给定一个值，求该值的`fit number`。

下面就来看看各路大牛各显神通吧！

## 代码实现

### Bash + GNU utilities

```text
dc -e2o?p|tr -s 0|dc -e2i?p
```

仅27字节。

### 05AB1E

```text
b00¬:C
```

这简直黑科技中的黑科技，仅仅8个字节就实现了。[在线测试](http://05ab1e.tryitonline.net/#code=YjAwwqw6Qw&input=NjUwMDA)。

> [05AB1E](https://github.com/Adriandmen/05AB1E)这门编程语言，本身也是娱乐品，有兴趣的可以点击访问其项目主页。

### Jellyfish

```text
p
d
# S
,1
*
\dbi
 2
```

仅20个字节。又是一款黑魔法，[Jellyfish](https://github.com/iatorm/jellyfish)是一款来自于`J`语言的用`Python 3`编写的编程语言。

### JavaScript

```text
n=>+`0b${n.toString(2).replace(/0+/g,0)}`
```
```text
n=>'0b'+n.toString(2).replace(/0+/g,0)-0
```

这是ES6的语法，走了个捷径，不能算作是正确答案，~~因为没有输出语句，看不到结果~~，不过这里也贴出来。

### Bash (sed + bc)

```text
echo $[2#`bc<<<obase=2\;$1|sed s/00\*/0/g`]
```

### MATL

传说中的MATLAB，看看：

```text
BFFOZtXB
```

**仅仅只有8个字节**

难以置信吧？看看其解读：

```text
    % Implicitly grab input
B   % Convert decimal to binary
FF  % Create the array [0 0]
O   % Number literal
Zt  % Replaces all [0 0] with [0] (will replace any number of 0's with 0)
XB  % Convert binary to decimal
    % Implicitly display
```

可能你不信，那么请访问在[线测试页面](http://matl.tryitonline.net/#code=Qm9GRk9adFhC&input=OQ)。

~~BoFFOZtXB~~

~~o   % Convert from logical to double (due to a bug)...有个双精度的BUG~~

### Python 3

```python
import re
f=lambda x:eval(re.sub('0+','0',bin(x)))
```

简单直接并粗暴，50字节的Python解决方案奉上。

### Perl 6

```perl
{:2(.base(2)~~{S:g/0+/0/})}
```

解释：
```text
-> $_ {
  # convert from base 2
  :2(

    # convert to base 2
    $_.base(2)

    # substitute
    .subst(
      :global,
      / 0+ /,  # all substrings made of 0s
      '0'      # with one 0
    )
  )
}
```

示例：
```text
my &fit-compress = {:2(.base(2)~~{S:g/0+/0/})}
say fit-compress 1;     # 1
say fit-compress 9;     # 5
say fit-compress 15;    # 15
say fit-compress 13;    # 13
say fit-compress 16;    # 2
say fit-compress 17;    # 5
say fit-compress 65535; # 65535
say fit-compress 65000; # 16250

# number created with ｢:2( [~] <0 1>.roll: 256 )｣
say fit-compress 80794946326210692074631955353531749442835289622757526957697718534769445507500
# 4240335298301026395935723255481812004519990428936918
```

### Ruby

```ruby
->n{eval ("0b%b"%n).squeeze ?0}
```

Ruby的解决方案，31字节实现，[在线测试](https://repl.it/CnnQ/2)。

### Jelly

```text
BŒgḄBFḄ
```

黑科技无疑，~~代码里面有叫不出名字的字母~~。[在线测试](http://jelly.tryitonline.net/#code=QsWSZ-G4hEJG4biE&input=&args=NjUwMDA)。

这个`Jelly`是个什么鬼？请参阅其项目主页：[DennisMitchell/jelly](https://github.com/DennisMitchell/jelly)。

### PHP

```php
<?=bindec(preg_replace("/0+/",0,decbin($argv[1])));
```

PHP作为一个有逼格的编程语言，自然不能示弱，51字节实现，~~虽然跟Javascript一样很尴尬~~。

### C#

```text
int x(int x)=>Convert.ToInt32(Regex.Replace(Convert.ToString(x,2),"0+","0"),2);
```

### Java

```java
int f(Integer x){return x.valueOf(x.toString(x,2).replaceAll("0+","0"),2);}
```

java不甘寂寞，也来一份，但也只有语法实现，并不能愉快的直接测试。

测试代码：
```java
public class Fit {
    int f(Integer x){return x.valueOf(x.toString(x,2).replaceAll("0+","0"),2);}

    public static void main(final String... args) {
        final Fit x = new Fit();
        System.out.println(x.f(65000));
    }
}
```

这里还有一份很短的Java代码：
```java
interface C{static void main(String[]b){Integer i=0;System.out.print(i.parseInt(i.toString(i.parseInt(b[0]),2).replaceAll("0+","0"),2));}}
```

### PowerShell v2+

```text
[convert]::ToInt32(([convert]::ToString($args[0],2)-replace'0+',0),2)
```

年长的PowerShell同样的不敢寂寞，然而这测试过程也是有点无奈：

```text
PS C:\Tools\Scripts\golfing> 1,9,15,13,16,17,65535,65000|%{"$_ -> " +(.\output-fit-number.ps1 $_)}
1 -> 1
9 -> 5
15 -> 15
13 -> 13
16 -> 2
17 -> 5
65535 -> 65535
65000 -> 16250
```

### Pyth

```text
i:.BQ"0+"\02
```

这什么语言瞅着眼熟的很，然而这并不是`Python`，该语言的项目主页：[Pyth](https://github.com/isaacg1/pyth)。

代码解释：
```text
  .BQ            # Convert input from base 10 to base 2
 :   "0+"\0      # Replace multiple zeroes with single zero
i          2     # Convert back from base 2 to base 10
```
[在线测试](https://pyth.herokuapp.com/?code=i%3A.BQ%220%2B%22%5C02&input=65000&test_suite=1&test_suite_input=1%0A9%0A15%0A13%0A16%0A17%0A65535%0A65000&debug=0)。

### Retina

```text
.+
$*1;
+`(1+)\1
$1;
1;
1
;+
0
```

讲真，我已经目瞪口呆。[Retina](https://github.com/m-ender/retina)似乎又是一款自编编程语言。[在线测试](http://retina.tryitonline.net/#code=LisKJCoxOworYCgxKylcMQokMTsKMTsKMQo7Kwow&input=NjUwMDA)。

### Dyalog APL

[Dyalog APL](http://goo.gl/9KrKoM)来露个脸，19字节：

```text
{2⊥⍵/⍨~0 0⍷⍵}2∘⊥⍣¯1
```

~~明显黑科技~~

### CJam

```text
q~2b1+0a%0a*);2b
```

[CJam](https://sourceforge.net/projects/cjam/)，[在线测试](http://cjam.aditsu.net/#code=q~2b1%2B0a%250a*%29%3B2b&input=65000)。

代码解释：
```text
q~     read and evaluate the input number
2b     convert to base 2 (array of 1s and 0s)
1+     append a 1 to deal with trailing zeros
0a%    split by [0], dropping empty pieces; only chunks of 1s are left
0a*    join by [0]
);     discard the 1 we appended before
2b     convert back from base 2
```

## 后记

~~抄了这么多的编程语言的实现之后~~，颇有一种井底之蛙的感觉。还有很多编程语言也可以很简洁的实现该需求，这里就不再继续贴出了，有兴趣的可自行访问[该页面的源地址](http://codegolf.stackexchange.com/questions/90067/output-fit-numbers)。


全文完~