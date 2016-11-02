---
title: JS运算符优先级
tags: [js, operator, 优先级, 基础知识]
categories: [WEB, JS]
date: 2016-10-25 11:15:09
description: 运算符的优先级决定了表达式中运算执行的先后顺序，优先级高的运算符最先被执行。
---

> 本文采编自[MDN](https://developer.mozilla.org)：
> - [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence)
> - [运算符优先级](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/Operator_Precedence)

运算符的优先级决定了表达式中运算执行的先后顺序，优先级高的运算符最先被执行。

下面是一个简单的例子：

    3 + 4 * 5 // 计算结果为23

乘法运算符 ("*")比起加法运算符("+")有着更高的优先级，所以它会被最先执行。

### 结合性

结合性决定了拥有相同优先级的运算符的执行顺序。考虑下面这个表达式：

    a OP b OP c

左结合(从左到右计算)相当于把左边的子表达式加上小括号(a OP b) OP c，类似的，右关联(从右到左计算)相当于a OP (b OP c)。赋值运算符是右关联的,所以你可以这么写：

    a = b = 5;

结果 a 和 b 的值都会成为5。这是因为赋值运算符的返回结果就是赋值运算符右边的那个值，具体过程是：b被赋值为5，然后a也被赋值为 b=5 的返回值，也就是5。

### 汇总表

下面的表将所有运算符按照优先级的不同从高到低排列。

![运算符优先级表](http://ww4.sinaimg.cn/large/79be2309gw1f94hwlrlikj20j81i0t9t.jpg)


|优先级 | 运算类型 | 关联性 | 运算符|
| -- | -- | -- | -- |
| 20 | [`分组`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Grouping) | n/a | `( … )`|
| 19 | [`成员访问`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Property_Accessors#Dot_notation "Property accessors provide access to an object's properties by using the dot notation or the bracket notation.") | 从左至右 | `… . …` |
| 19 | [`计算成员访问`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Property_Accessors#Bracket_notation "Property accessors provide access to an object's properties by using the dot notation or the bracket notation.") | 从左至右 | `… [ … ]` |
| 19 | [`new`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new "The new operator creates an instance of a user-defined object type or of one of the built-in object types that has a constructor function.") (带参数) | n/a | `new … ( … )` |
| 18 | [函数调用](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Functions) | 从左至右 | `… ( <var>… </var>)` |
| 18 | [`new`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new "The new operator creates an instance of a user-defined object type or of one of the built-in object types that has a constructor function.") (无参数) | 从右至左 | `new …` |
| 17 | [`后置自增`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Increment "Arithmetic operators take numerical values (either literals or variables) as their operands and return a single numerical value. The standard arithmetic operators are addition (+), subtraction (-), multiplication (*), and division (https://developer.mozilla.org/).") | n/a | `… ++` |
| 17 | [`后置自减`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Decrement "Arithmetic operators take numerical values (either literals or variables) as their operands and return a single numerical value. The standard arithmetic operators are addition (+), subtraction (-), multiplication (*), and division (https://developer.mozilla.org/).") | n/a | `… --` |
| 16 | [逻辑非](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators#Logical_NOT) | 从右至左 | `! …` |
| 16 | [按位取非](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Bitwise_Operators#Bitwise_NOT) | 从右至左 | `~ …` |
| 16 | [一元加法](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Unary_plus) | 从右至左 | `+ …` |
| 16 | [一元剑法](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Unary_negation) | 从右至左 | `- …` |
| 16 | [前置自增](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Increment) | 从右至左 | `++ …` |
| 16 | [前置自减](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Decrement) | 从右至左 | `-- …` |
| 16 | [typeof](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/typeof) | 从右至左 | `typeof …` |
| 16 | [void](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/void) | 从右至左 | `void …` |
| 16 | [delete](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/delete) | 从右至左 | `delete …` |
| 15 | [取幂](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Exponentiation) | 从右至左 | `… ** …` |
| 14 | [乘法](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Multiplication) | 从左至右 | `… * …` |
| 14 | [除法](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Division) | 从左至右 | `… / …` |
| 14 | [取余](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder) | 从左至右 | `… % …` |
| 13 | [加法](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Addition) | 从左至右 | `… + …` |
| 13 | [减法](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Subtraction) | 从左至右 | `… - …` |
| 12 | [按位左移](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Bitwise_Operators) | 从左至右 | `… << …` |
| 12 | [按位右移](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Bitwise_Operators) | 从左至右 | `… >> …` |
| 12 | [无符号右移](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Bitwise_Operators) | 从左至右 | `… >>> …` |
| 11 | [小于](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Less_than_operator) | 从左至右 | `… < …` |
| 11 | [小于等于](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Less_than__or_equal_operator) | 从左至右 | `… <= …` |
| 11 | [大于](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Greater_than_operator) | 从左至右 | `… > …` |
| 11 | [大于等于](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Greater_than_or_equal_operator) | 从左至右 | `… >= …` |
| 11 | [in](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/in) | 从左至右 | `… in …` |
| 11 | [instanceof](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/instanceof) | 从左至右 | `… instanceof …` |
| 10 | [等号](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Equality) | 从左至右 | `… == …` |
| 10 | [不等号](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Inequality) | 从左至右 | `… != …` |
| 10 | [全等](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Identity) | 从左至右 | `… === …` |
| 10 | [非全等](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Nonidentity) | 从左至右 | `… !== …` |
| 9 | [按位与](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Bitwise_Operators#Bitwise_AND) | 从左至右 | `… & …` |
| 8 | [按位异或](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Bitwise_Operators#Bitwise_XOR) | 从左至右 | `… ^ …` |
| 7 | [按位与](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Bitwise_Operators#Bitwise_OR) | 从左至右 | `… \| …` |
| 6 | [逻辑与](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators#Logical_AND) | 从左至右 | `… && …` |
| 5 | [逻辑或](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators#Logical_OR) | 从左至右 | `… \|\| …` |
| 4 | [条件判断](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Conditional_Operator) | 从右至左 | `… ? … : …` |
| 3 | [赋值运算](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Assignment_Operators) | 从右至左 | `… = …` |
| | | | `… += …` |
| | | | `… -= …` |
| | | | `… **= …` |
| | | | `… *= …` |
| | | | `… /= …` |
| | | | `… %= …` |
| | | | `… <<= …` |
| | | | `… >>= …` |
| | | | `… >>>= …` |
| | | | `… &= …` |
| | | | `… ^= …` |
| | | | … \|= … 
| 2 | [yield](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/yield) | 从右至左 | `yield …` |
| 2 | [yield*](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/yield*) | 从右至左 | `yield* …` |
| 1 | [Spread](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_operator) | n/a | `...` … |
| 0 | [逗号运算符](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comma_Operator) | 从左至右 | `… , …` |

> 表格由word制作，导出为图片。

- 取幂运算符`**`为[ES7语法](http://www.ecma-international.org/ecma-262/7.0/index.html#sec-exp-operator)。[浏览器兼容性](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Browser_compatibility)、[exponentiation (**) operator](http://kangax.github.io/compat-table/es2016plus/)
- 取幂赋值`**=`同上。
- 计算成员访问，指的是使用`[...]`的方式访问对象的成员属性。
- 三目运算符为条件判断语句。

---

~~markdown解析表格时出现错误，竖线符识别问题，下次修复。~~

> 2016年10月28日，修复markdown表格中单元格带竖线`|`的问题。
>
> 详情见：<https://github.com/xovel/xovel.github.io/issues/10>


