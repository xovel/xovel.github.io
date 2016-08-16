---
title: MathJax基础教程与快速参考
date: 2016-06-23 10:14:36
tags:
- mathjax
- 教程
- 参考
categories:
- 开发
- 文档
description: MathJax是一个开源JavaScript库，提供优美的数学公式展现，它支持LaTeX、MathML、AsciiMath符号，可以运行于所有流行浏览器上；本文根据Stackexchange上的一篇关于MathJax的基础教程与快速参考的文章整理而成。更多内容可前往Stackexchange的原页面进行详细阅读。
mathjax: true
---

MathJax是一个JavaScript显示引擎，用来在浏览器上显示数学公式。正如它的口号：`Beautiful math in all browsers`，MathJax提供优美的数学公式展现。

> A JavaScript display engine for mathematics that works in all browsers

[Stackexchange](http://stackexchange.com/)上有一篇关于MathJax的基础教程与快速参考的文章：[MathJax basic tutorial and quick reference](http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference)，本文根据这篇文章翻译整理而成。

### 查看公式

如果需要查看MathJax公式是如何编写的，在公式上点击右键，选择`Show Math As`（数学显示形式）、`TeX Commands`（TeX命令）即可。

> 公式编写的代码将会在新窗口弹出，弹出的公式不会包含MathJax的定界符`$`。

### 行内与块状

MathJax的行内公式语法为使用一对`$`作为定界符；块状公式则的定界符为`$$`。

> For inline formulas, enclose the formula in `$...$`. For displayed formulas, use `$$...$$`.

示例：

爱因斯坦质能方程$E=mc^2$

自然数求和公式
$$ \sum_{i=1}^n i=n\cdot(n+1)/2 $$

### 希腊字母

对于小写字母，`\alpha`，`\beta`，……，`\omega`：$\alpha, \beta, … \omega$。

对于大写字母，`\Gamma`，`\Delta`，……，`\Omega`：$\Gamma, \Delta, …, \Omega$。

希腊字母MathJax表格：

| 名称 | 大写 | MathJax | 小写 | MathJax |
| --- | --- | --- | --- | --- |
| alpha | $A$ | A | $\alpha$ | \alpha |
| beta | $B$ | B | $\beta$ | \beta |
| gamma | $\Gamma$ | \Gamma | $\gamma$ | \gamma |
| delta | $\Delta$ | \Delta | $\delta$ | \delta |
| epsilon | $E$ | E | $\epsilon$ | \epsilon |
| zeta | $Z$ | Z | $\zeta$ | \zeta |
| eta | $H$ | H | $\eta$ | \eta |
| theta | $\Theta$ | \Theta | $\theta$ | \theta |
| iota | $I$ | I | $\iota$ | \iota |
| kappa | $K$ | K | $\kappa$ | \kappa |
| lambda | $\Lambda$ | \Lambda | $\lambda$ | \lambda |
| mu | $M$ | M | $\mu$ | \mu |
| nu | $N$ | N | $\nu$ | \nu |
| xi | $\Xi$ | \Xi | $\xi$ | \xi |
| omicron | $O$ | O | $\omicron$ | \omicron |
| pi | $\Pi$ | \Pi | $\pi$ | \pi |
| rho | $P$ | P | $\rho$ | \rho |
| sigma | $\Sigma$ | \Sigma | $\sigma$ | \sigma |
| tau | $T$ | T | $\tau$ | \tau |
| upsilon | $\Upsilon$ | \Upsilon | $\upsilon$ | \upsilon |
| phi | $\Phi$ | \Phi | $\phi$ | \phi |
| chi | $X$ | X | $\chi$ | \chi |
| psi | $\Psi$ | \Psi | $\psi$ | \psi |
| omega | $\Omega $ | \Omega | $\omega$ | \omega |

### 上标与下标

上标使用`^`，下标使用`_`。如`x_i^2`：$x_i^2$，`\log_2 x`：$\log_2 x$。

### 分组与界定

在上标、下标和其他操作中，操作对象仅对下一个“组”有效。这个“组”可以是一个单个符号，或者使用花括号`{...}`包裹起来的内容。

对于10的10次方这样的一个公式，如果使用`10^10`，将会得到$10^10$。对后面的`10`使用花括号包裹即可：`10^{10}`，$10^{10}$。

对于连续上标或者下标的情形，同样需要使用花括号进行定界，`x^5^6`是一个错误的公式。

`{x^y}^z`：${x^y}^z$，`x^{y^z}`：$x^{y^z}$，注意区分两者的不同。

注意区分这两个公式：`x_i^2`，$x\_i^2$ 和`x_{i^2}`，$x_{i^2}$。

### 括号组

圆括号和方括号使用符号`()[]`即可：$(2+3)[4+4]$。

由于花括号`{}`被用来作为分组符号，故而使用`\{`和`\}`来表示：$\\{\\}$。也可以使用`\lbrace`和`\rbrace`来表示：$\lbrace\rbrace$。

尖括号`<>`使用`\langle`和`\rangle`来表示：$\langle x \rangle$。

需要注意的是，括号组的符号在使用时不会根据内容进行缩放。如果需要自适应缩放，请使用`\left`和`\right`。

示例：

- 公式`(\frac{\sqrt x}{y^3})`展示为$(\frac{\sqrt x}{y^3})$。
- 带自适应效果时：$\left(\frac{\sqrt x}{y^3}\right)$

自适应效果除了上面提到的几组括号外，同样可以应用在`|` $|x|$、`\vert` $\vert x \vert$、`\Vert` $\Vert x \Vert$、向上取整`\lceil`和`\rceil` $\lceil x \rceil$、向下取整`\lfloor`和`\rfloor` $\lfloor x \rfloor$。

括号组可以只保留一边，在自适应情形下，另一边使用数点代替即可。示例：`\left.\frac12\right\rbrace`，$\left.\frac12\right\rbrace$。

### 求和与积分

使用`\sum`表示求和$\sum_1^n$，`\int`表示积分$\int_1^\infty$。上标为上限，下标为下限。如果上限与下限包含多个符号，请注意使用花括号进行界定。

同样的操作符还有：`\prod` $\prod$, `\bigcup` $\bigcup$, `\bigcap` $\bigcap$, `\iint` $\iint$。

注意：双重积分与三重积分并非`\int\int`$\int\int$和`\int\int\int`$\int\int\int$，而是`\iint`$\iint$和`\iiint`$\iiint$。

### 分数

有两个方式进行分数的表示。

第一种为`\frac`，如`\frac xy` $\frac xy$。分子和分母分别跟在后面即可，同样注意花括号的使用。

第二种为`\over`，如`{a+1\over b+1}` ${a+1\over b+1}$。分子和分母位于两边。通常在公式很复杂采用。

### 字体

* 使用`\mathbb`或者`\Bbb`来表示黑板粗体`blackboard bold`
    $\mathbb{CHNQRZ}$.
* 使用`\mathbf`表示黑体
    $\mathbf{ABCDEFGHIJKLMNOPQRSTUVWXYZ}$ $\mathbf{abcdefghijklmnopqrstuvwxyz}$.
* 使用`\mathtt`表示打印机字体
    $\mathtt{ABCDEFGHIJKLMNOPQRSTUVWXYZ}$ $\mathtt{abcdefghijklmnopqrstuvwxyz}$.
* 使用`\mathrm`表示罗马字体
    $\mathrm{ABCDEFGHIJKLMNOPQRSTUVWXYZ}$ $\mathrm{abcdefghijklmnopqrstuvwxyz}$.
* 使用`\mathsf`表示无衬线字体
    $\mathsf{ABCDEFGHIJKLMNOPQRSTUVWXYZ}$ $\mathsf{abcdefghijklmnopqrstuvwxyz}$.
* 使用`\mathcal`表示书法体
    $\mathcal{ ABCDEFGHIJKLMNOPQRSTUVWXYZ}$
* 使用`\mathscr`表示手写体
    $\mathscr{ABCDEFGHIJKLMNOPQRSTUVWXYZ}$
* 使用`\mathfrak`表示Fraktur字体（一款德文黑体字）: 
    $\mathfrak{ABCDEFGHIJKLMNOPQRSTUVWXYZ} \mathfrak{abcdefghijklmnopqrstuvwxyz}$.

### 根号

使用`\sqrt`表示根号。如`\sqrt2`，$\sqrt2$。

多次方根在后面使用`[]`指定即可。如`\sqrt[n^2]{\frac xy}`，$\sqrt[3]{\frac xy}$。

### 函数

对于特殊函数，如`sin`、`lim`、`max`、`ln`等，会自动识别，将以常规罗马字体代替斜体进行显示。如正弦函数表示为：`\sin x`$\sin x$，并非`sin x`$sin x$。

极限函数下标跟在后面即可：`\lim`: `\lim_{x\to 0}` $$\lim_{x\to 0}$$

### 特殊符号

MathJax支持大量特殊符号，这里罗列一部分，更多请参考：[this shorter listing](http://pic.plover.com/MISC/symbols.pdf)和[this exhaustive listing](http://mirror.math.ku.edu/tex-archive/info/symbols/comprehensive/symbols-a4.pdf)

*   比较判断符，`\lt \gt \le \ge \neq` $\lt\, \gt\, \le\, \ge\, \neq$. 
    你可以在这些操作符前加入`\not`表示相反的意思: `\not\lt` $\not\lt$，~~然而并不好看~~
*   四则运算符，`\times \div \pm \mp` $\times\, \div\, \pm\, \mp$
    `+`和`-`直接使用即可
    `\cdot`表示一个居中的乘点: $x\cdot y$
*   集合关系与运算符，`\cup \cap \setminus \subset \subseteq \subsetneq \supset \in \notin \emptyset \varnothing` $\cup\, \cap\, \setminus\, \subset\, \subseteq \,\subsetneq \,\supset\, \in\, \notin\, \emptyset\, \varnothing$
*   排列符，`{n+1 \choose 2k}`或`\binom{n+1}{2k}` ${n+1 \choose 2k}$
*   箭头符，`\to \rightarrow \leftarrow \Rightarrow \Leftarrow \mapsto` $\to\, \rightarrow\, \leftarrow\, \Rightarrow\, \Leftarrow\, \mapsto$
*   逻辑操作符，`\land \lor \lnot \forall \exists \top \bot \vdash \vDash` $\land\, \lor\, \lnot\, \forall\, \exists\, \top\, \bot\, \vdash\, \vDash$
*   星号类符号，`\star \ast \oplus \circ \bullet` $\star\, \ast\, \oplus\, \circ\, \bullet$
*   相似运算符，`\approx \sim \simeq \cong \equiv \prec` $\approx\, \sim \, \simeq\, \cong\, \equiv\, \prec$.
*   无穷与阿列夫零，`\infty \aleph_0` $\infty\, \aleph_0$
*   劈形运算符与取部分运算符，`\nabla \partial` $\nabla\, \partial$
*   复数的虚部与实部，`\Im \Re` $\Im\, \Re$
*   模运算符，`\pmod`，`a\equiv b\pmod n` $a\equiv b\pmod n$.
*   多点符，`\ldots`的点的位置偏下：$a_1, a_2, \ldots ,a_n$；`\cdots`点的位置居中：$a_1+a_2+\cdots+a_n$
*   一些具有变体的希腊字母符号: `\epsilon \varepsilon` $\epsilon\, \varepsilon$, `\phi \varphi` $\phi\, \varphi$等等
*   字母`l`的手写体`\ell` $\ell$

在[Detexify](http://detexify.kirelabs.org/classify.html)上你可以画出符号，Detexify会自动识别并给出相似的符号及其代码。但并不能保证该符号在MathJax中可用，你可以参考MathJax的官方文档[list of currently supported $\LaTeX$ commands](http://docs.mathjax.org/en/latest/tex.html#supported-latex-commands)以确定该符号是否可用。也可以参考Dr. Carol JVF Burns's编写的页面：[$\TeX$ Commands Available in MathJax](http://www.onemathematicalcat.org/MathJaxDocumentation/TeXSyntax.htm)。

### 空格

通常情况下MathJax会忽略常规的空格。

空格的表述方式：
- `\,`表示一个细微的空格$a\,b$
- `\;`稍大一点的空格$a\;b$
- `\quad`和`\qquad`表示更大的空格$a\quad b$, $a\qquad b$

在`\text{...}`表示的文本中，空格将会保留。你可以在公式中嵌入`\text{...}`。

### 顶部标记

`\hat`表示这样一个简单的符号：$\hat x$，`\widehat`表示一个长公式$\widehat{xy}$。

同样的有`\bar` $\bar x$和`\overline` $\overline{xyz}$，以及`\vec` $\vec x$ 和`\overrightarrow` $\overrightarrow{xy}$、`\overleftrightarrow` $\overleftrightarrow{xy}$

使用`\dot`和`\ddot`可以将圆点放在上面，如$\frac d{dx}x\dot x = \dot x^2 + x\ddot x$。

### 转义与换行

如果在公式中需要直接使用特殊符号，使用`\`进行转义即可。如`\$`$\\$$、`\_`$\\_$。

如果要使用`\`符号本身，由于`\\`表示的是换行，故而使用`\backslash` $\backslash$。

### 参考资料
- [MathJax](https://www.mathjax.org/)
- [mathjax/MathJax - Github](https://github.com/mathjax/MathJax)
- [MathJax basic tutorial and quick reference](http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference)
- [MathJax Documentation](http://docs.mathjax.org/en/latest/index.html)
- [MathJax 中文文档](http://mathjax-chinese-doc.readthedocs.io/en/latest/index.html)
- [Mathematical Formula Syntax](https://meta.wikimedia.org/wiki/Help:Displaying_a_formula)
- [LATEX and AMS-LATEX Symbols](http://pic.plover.com/MISC/symbols.pdf)
