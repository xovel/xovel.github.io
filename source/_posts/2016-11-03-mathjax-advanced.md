---
title: MathJax进阶
tags: [mathjax, 教程, 参考, 进阶]
categories: [开发, 文档]
date: 2016-11-03 14:57:41
mathjax: true
description: 本文是对之前的文章《MathJax基础教程与快速参考》的扩充。
---

> 之前的文章：[MathJax基础教程与快速参考](/article/mathjax-basic-tutorial-and-quick-reference.html)，本篇文章将对进阶的MathJax语法做一个简单的介绍。大部分内容来自于[MathJax basic tutorial and quick reference](http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference)一文中后面的评论。

### 矩阵

MathJax提供了良好的矩阵支持。矩阵的语法为：`$$\begin{matrix}…\end{matrix}$$`，如：

```mathjax
$$
        \begin{matrix}
        1 & x & x^2 \\
        1 & y & y^2 \\
        1 & z & z^2 \\
        \end{matrix}
$$
```

$$
\begin{matrix}
        1 & x & x^2 \\\\
        1 & y & y^2 \\\\
        1 & z & z^2 \\\\
        \end{matrix}
$$

关于添加括号，除了在基础教程中提到的`\left…\right`方法，还可以使用指定字符串替换上面提到的语法中的`matrix`即可：

- `pmatrix`，$\begin{pmatrix}1&2\\\\3&4\\\\ \end{pmatrix}$
- `bmatrix`，$\begin{bmatrix}1&2\\\\3&4\\\\ \end{bmatrix}$
- `Bmatrix`，$\begin{Bmatrix}1&2\\\\3&4\\\\ \end{Bmatrix}$
- `vmatrix`，$\begin{vmatrix}1&2\\\\3&4\\\\ \end{vmatrix}$
- `Vmatrix`，$\begin{Vmatrix}1&2\\\\3&4\\\\ \end{Vmatrix}$

在矩阵中可以添加点号`\cdots`$\cdots$、`\ddots`$\ddots$、`\vdots`$\vdots$来表示省略的部分：

$$
\begin{pmatrix}
     1 & a_1 & a_1^2 & \cdots & a_1^n \\\\
     1 & a_2 & a_2^2 & \cdots & a_2^n \\\\
     \vdots  & \vdots& \vdots & \ddots & \vdots \\\\
     1 & a_m & a_m^2 & \cdots & a_m^n    
     \end{pmatrix}
$$

增广矩阵则使用格式化的表格：

$$
\left[\begin{array}{cc|c}
  1&2&3\\\\
  4&5&6
  \end{array}\right]
$$

上面的矩阵的具体代码：

```mathjax
$$ \left[
    \begin{array}{cc|c}
      1&2&3\\
      4&5&6
    \end{array}
\right] $$
```


小型行内矩阵的表示方法为`\bigl(\begin{smallmatrix} ... \end{smallmatrix}\bigr)`。例如$\bigl( \begin{smallmatrix} a & b \\\\ c & d \end{smallmatrix} \bigr)$的代码为：

```mathjax
$\bigl( \begin{smallmatrix} a & b \\ c & d \end{smallmatrix} \bigr)$
```

### 对齐的方程式

很多时候，我们想让方程式对齐以显得更加整齐美观。为了达到这样的目的，我们采用语法`\begin{align}…\end{align}`并且在每个换行符`\\`之后，添加一个连接符`&`即可。

举个例子：

$$
\begin{align}
\sqrt{37} & = \sqrt{\frac{73^2-1}{12^2}} \\\\
 & = \sqrt{\frac{73^2}{12^2}\cdot\frac{73^2-1}{73^2}} \\\\ 
 & = \sqrt{\frac{73^2}{12^2}}\sqrt{\frac{73^2-1}{73^2}} \\\\
 & = \frac{73}{12}\sqrt{1 - \frac{1}{73^2}} \\\\ 
 & \approx \frac{73}{12}\left(1 - \frac{1}{2\cdot73^2}\right)
\end{align}
$$

以上方程式的代码为：

```mathjax
\begin{align}
\sqrt{37} & = \sqrt{\frac{73^2-1}{12^2}} \\
 & = \sqrt{\frac{73^2}{12^2}\cdot\frac{73^2-1}{73^2}} \\ 
 & = \sqrt{\frac{73^2}{12^2}}\sqrt{\frac{73^2-1}{73^2}} \\
 & = \frac{73}{12}\sqrt{1 - \frac{1}{73^2}} \\ 
 & \approx \frac{73}{12}\left(1 - \frac{1}{2\cdot73^2}\right)
\end{align}
```

### 分段函数

分段函数使用的语法为：`\begin{cases}…\end{cases}`，在带有换行符`\\`的一行中，在分段处加入连接符`&`。

```mathjax
f(n) =
\begin{cases}
n/2,  & \text{if $n$ is even} \\
3n+1, & \text{if $n$ is odd}
\end{cases}
```

展示为：

$$
f(n) =
\begin{cases}
n/2,  & \text{if $n$ is even} \\\\
3n+1, & \text{if $n$ is odd}
\end{cases}
$$

也可以将括号放在右边：

```mathjax
\left.
\begin{array}{l}
\text{if $n$ is even:}&n/2\\
\text{if $n$ is odd:}&3n+1
\end{array}
\right\}
=f(n)
```

$$
\left.
\begin{array}{l}
\text{if $n$ is even:}&n/2\\\\
\text{if $n$ is odd:}&3n+1
\end{array}
\right\\}
=f(n)
$$

要使得分段函数中间的空隙更大，可以使用`\\[2ex]`替换`\\`，如要得到：

$$
f(n) =
\begin{cases}
\frac{n}{2},  & \text{if $n$ is even} \\\\\[2ex\]
3n+1, & \text{if $n$ is odd}
\end{cases}
$$

使用以下代码即可：

```mathjax
f(n) =
\begin{cases}
\frac{n}{2},  & \text{if $n$ is even} \\[2ex]
3n+1, & \text{if $n$ is odd}
\end{cases}
```

### 数组表格化

先看一个例子：

$$
\begin{array}{c|lcr}
n & \text{Left} & \text{Center} & \text{Right} \\\\
\hline
1 & 0.24 & 1 & 125 \\\\
2 & -1 & 189 & -8 \\\\
3 & -20 & 2000 & 1+10i
\end{array}
$$

其代码为：

```mathjax
\begin{array}{c|lcr}
n & \text{Left} & \text{Center} & \text{Right} \\
\hline
1 & 0.24 & 1 & 125 \\
2 & -1 & 189 & -8 \\
3 & -20 & 2000 & 1+10i
\end{array}
```

在上面的矩阵中，提到了格式化表格的方式。格式化代码`\begin{array}{c|lcr}`中`c`表示居中对齐，`l`表示左对齐，`r`表示右对齐。`\hline`表示横向的水平线。

格式化的数组可以嵌套：

$$
\begin{array}{c}
\begin{array}{cc}
\begin{array}{c|cccc}
\text{min} & 0 & 1 & 2 & 3\\\\
\hline
0 & 0 & 0 & 0 & 0\\\\
1 & 0 & 1 & 1 & 1\\\\
2 & 0 & 1 & 2 & 2\\\\
3 & 0 & 1 & 2 & 3
\end{array}
&
\begin{array}{c|cccc}
\text{max}&0&1&2&3\\\\
\hline
0 & 0 & 1 & 2 & 3\\\\
1 & 1 & 1 & 2 & 3\\\\
2 & 2 & 2 & 2 & 3\\\\
3 & 3 & 3 & 3 & 3
\end{array}
\end{array}
\\\\
\begin{array}{c|cccc}
\Delta&0&1&2&3\\\\
\hline
0 & 0 & 1 & 2 & 3\\\\
1 & 1 & 0 & 1 & 2\\\\
2 & 2 & 1 & 0 & 1\\\\
3 & 3 & 2 & 1 & 0
\end{array}
\end{array}
$$

以上代码省略。

### 带颜色的文本

MathJax支持HTML颜色代码来对文本进行染色显示。

语法为`\color{black}{text}`。black为颜色的名称，text为进行染色的文本。

$$
\begin{array}{|rc|}
\hline
\verb+\color{black}{text}+ & \color{black}{text} \\\\
\verb+\color{gray}{text}+ & \color{gray}{text} \\\\
\verb+\color{silver}{text}+ & \color{silver}{text} \\\\
\verb+\color{white}{text}+ & \color{white}{text} \\\\
\hline
\verb+\color{maroon}{text}+ & \color{maroon}{text} \\\\
\verb+\color{red}{text}+ & \color{red}{text} \\\\
\verb+\color{yellow}{text}+ & \color{yellow}{text} \\\\
\verb+\color{lime}{text}+ & \color{lime}{text} \\\\
\verb+\color{olive}{text}+ & \color{olive}{text} \\\\
\verb+\color{green}{text}+ & \color{green}{text} \\\\
\verb+\color{teal}{text}+ & \color{teal}{text} \\\\
\verb+\color{aqua}{text}+ & \color{aqua}{text} \\\\
\verb+\color{blue}{text}+ & \color{blue}{text} \\\\
\verb+\color{navy}{text}+ & \color{navy}{text} \\\\
\verb+\color{purple}{text}+ & \color{purple}{text} \\\\ 
\verb+\color{fuchsia}{text}+ & \color{magenta}{text} \\\\
\hline
\end{array}
$$

{% raw %}
$$
\begin{array}{|rrrrrrrr|}
\hline
\verb+#000+ & \color{#000}{text} & \verb+#005+ & \color{#005}{text} & \verb+#00A+ & \color{#00A}{text} & \verb+#00F+ & \color{#00F}{text}  \\
\verb+#500+ & \color{#500}{text} & \verb+#505+ & \color{#505}{text} & \verb+#50A+ & \color{#50A}{text} & \verb+#50F+ & \color{#50F}{text}  \\
\verb+#A00+ & \color{#A00}{text} & \verb+#A05+ & \color{#A05}{text} & \verb+#A0A+ & \color{#A0A}{text} & \verb+#A0F+ & \color{#A0F}{text}  \\
\verb+#F00+ & \color{#F00}{text} & \verb+#F05+ & \color{#F05}{text} & \verb+#F0A+ & \color{#F0A}{text} & \verb+#F0F+ & \color{#F0F}{text}  \\
\hline
\verb+#080+ & \color{#080}{text} & \verb+#085+ & \color{#085}{text} & \verb+#08A+ & \color{#08A}{text} & \verb+#08F+ & \color{#08F}{text}  \\
\verb+#580+ & \color{#580}{text} & \verb+#585+ & \color{#585}{text} & \verb+#58A+ & \color{#58A}{text} & \verb+#58F+ & \color{#58F}{text}  \\
\verb+#A80+ & \color{#A80}{text} & \verb+#A85+ & \color{#A85}{text} & \verb+#A8A+ & \color{#A8A}{text} & \verb+#A8F+ & \color{#A8F}{text}  \\
\verb+#F80+ & \color{#F80}{text} & \verb+#F85+ & \color{#F85}{text} & \verb+#F8A+ & \color{#F8A}{text} & \verb+#F8F+ & \color{#F8F}{text}  \\
\hline
\verb+#0F0+ & \color{#0F0}{text} & \verb+#0F5+ & \color{#0F5}{text} & \verb+#0FA+ & \color{#0FA}{text} & \verb+#0FF+ & \color{#0FF}{text}  \\
\verb+#5F0+ & \color{#5F0}{text} & \verb+#5F5+ & \color{#5F5}{text} & \verb+#5FA+ & \color{#5FA}{text} & \verb+#5FF+ & \color{#5FF}{text}  \\
\verb+#AF0+ & \color{#AF0}{text} & \verb+#AF5+ & \color{#AF5}{text} & \verb+#AFA+ & \color{#AFA}{text} & \verb+#AFF+ & \color{#AFF}{text}  \\
\verb+#FF0+ & \color{#FF0}{text} & \verb+#FF5+ & \color{#FF5}{text} & \verb+#FFA+ & \color{#FFA}{text} & \verb+#FFF+ & \color{#FFF}{text}  \\
\hline
\end{array}
$$
{% endraw %}

MathJax的HTML颜色，详情请参考[这里](http://www.w3schools.com/html/html_colors.asp)。

### 交叉线

使用`\require{cancel}`开启实现对本文添加交叉线的效果。该语法可以用来展示删除，取消等效果。

如：
{% raw %}
$$
\require{cancel}\begin{array}{rl}
\verb|y+\cancel{x}| & y+\cancel{x}\\
\verb|\cancel{y+x}| & \cancel{y+x}\\
\verb|y+\bcancel{x}| & y+\bcancel{x}\\
\verb|y+\xcancel{x}| & y+\xcancel{x}\\
\verb|y+\cancelto{0}{x}| & y+\cancelto{0}{x}\\
\verb+\frac{1\cancel9}{\cancel95} = \frac15+& \frac{1\cancel9}{\cancel95} = \frac15 \\
\end{array}
$$
{% endraw %}

还可以使用`\require{enclose}`：

{% raw %}
$$
\require{enclose}\begin{array}{rl}
\verb|\enclose{horizontalstrike}{x+y}| & \enclose{horizontalstrike}{x+y}\\
\verb|\enclose{verticalstrike}{\frac xy}| & \enclose{verticalstrike}{\frac xy}\\
\verb|\enclose{updiagonalstrike}{x+y}| & \enclose{updiagonalstrike}{x+y}\\
\verb|\enclose{downdiagonalstrike}{x+y}| & \enclose{downdiagonalstrike}{x+y}\\
\verb|\enclose{horizontalstrike,updiagonalstrike}{x+y}| & \enclose{horizontalstrike,updiagonalstrike}{x+y}\\
\end{array}
$$
{% endraw %}

### 修饰符

下面列出一些常见的文字修饰符：

`\overline` $\overline A$

`\underline` $\underline B$

`\widetilde` $\widetilde C$

`\widehat` $\widehat D$

`\fbox` $\fbox {$E$}$

`\underleftarrow` $\underleftarrow{F}$

`\underrightarrow` $\underrightarrow{G}$

`\underleftrightarrow` $\underleftrightarrow{H}$

`\overbrace` $\overbrace{(n - 2) + \overbrace{(n - 1) + n + (n + 1)} + (n + 2)}$

`\underbrace` $(n \underbrace{- 2) + (n \underbrace{- 1) + n + (n +} 1) + (n +} 2)$

`\overbrace`和`\underbrace`，可以添加上标/下标的文本。如`\underbrace{a\cdot a\cdots a}_{b\text{ times}}`展示为：

$$\underbrace{a\cdot a\cdots a}_{b\text{ times}}$$

音阶修饰符：

`\check` $\check{I}$

`\acute` $\acute{J}$

`\grave` $\grave{K}$

### 标签与标记

一些长公式，可能需要进行一些标注，或者是注明序号。

`a := x^2-y^3 \tag{*}\label{*}`

$$a := x^2-y^3 \tag{\*}\label{\*}$$

方程式等号之上也可以添加一些本文标注：

`a+y^3 \stackrel{\eqref{*}}= x^2`

$$a+y^3 \stackrel{\eqref{*}}= x^2$$

不带括号也可以，使用`\ref{somelabel}`即可。

### 自定义命令

使用`\newcommand`可以进行功能自定义。

`\newcommand{\SES}[3]{ 0 \to #1 \to #2 \to #3 \to 0 }`

定义过的命令`SES`就可以进行调用了：`\SES{A}{B}{C}`

$$ 
\newcommand{\SES}[3]{ 0 \to #1 \to #2 \to #3 \to 0 }
\SES{A}{B}{C}
$$

### 指定操作符

使用`\operatorname{…}`可以指定任意文本作为操作符进行展示。

如`\operatorname{arsinh}(x)`展示为$\operatorname{arsinh}(x)$。

如果写成`arsinh(x)`，会造成字体显示不对：$arsinh(x)$；写成`\arsinh(x)`则会报错。

### 极限

在极限符号`\lim`后再跟一个` \limits`可以添加极限的下标。

`\lim \limits_{x \to 1} \frac{x^2-1}{x-1}`

$\lim \limits_{x \to 1} \frac{x^2-1}{x-1}$

### 高亮

使用`\bbox`可以对方程式进行高亮展示。

如：

```mathjax
\bbox[yellow]
{
e^x=\lim_{n\to\infty} \left( 1+\frac{x}{n} \right)^n
\qquad (1)
}
```

将展示为：

{% raw %}
$$ \bbox[yellow]
{
e^x=\lim_{n\to\infty} \left( 1+\frac{x}{n} \right)^n
\qquad (1)
}
$$
{% endraw %}

可以添加内边距：

```mathjax
$$ \bbox[yellow,5px]
{
e^x=\lim_{n\to\infty} \left( 1+\frac{x}{n} \right)^n
\qquad (1)
}
$$
```

{% raw %}
$$ \bbox[yellow,5px]
{
e^x=\lim_{n\to\infty} \left( 1+\frac{x}{n} \right)^n
\qquad (1)
}
$$
{% endraw %}

也可以指定边框：

```mathjax
$$ \bbox[#1695ea,5px,border:2px solid cyan]
{
e^x=\lim_{n\to\infty} \left( 1+\frac{x}{n} \right)^n
\qquad (2)
}
$$
```

{% raw %}
$$ \bbox[#1695ea,5px,border:2px solid cyan]
{
e^x=\lim_{n\to\infty} \left( 1+\frac{x}{n} \right)^n
\qquad (2)
}
$$
{% endraw %}

------

本文完。





