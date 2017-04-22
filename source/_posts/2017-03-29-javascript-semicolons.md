---
title: JavaScript Semicolon Insertion
tags: [js, semicolon, asi]
categories: [开发]
date: 2017-03-29 19:47:27
description: 这是一篇发表于2010年5月28日的文章，本篇为转载，讲述关于JavaScript语法中的分号方面的问题。最近关于是否要去除不必要的分号的编程风格确认的时候，遇到了一些问题，很多支持去除分号的文章都引用了这一篇文章，故此这里纯粹作一个转载。
---

> 本文转自：[~inimino/blog](http://inimino.org/~inimino/blog/javascript_semicolons)

**JavaScript Semicolon Insertion**

**Everything you need to know**

_Friday, May 28, 2010_

*********

Automatic semicolon insertion is one of JavaScript's most controversial syntactic features. There are also many misconceptions surrounding it.

自动插入分号是JavaScript里最具有争议的语法特性。其周围也存在许多误解。

Some JavaScript programmers use semicolons at the end of every statement, and some use them only where strictly required. Most do something in between, and a few even intentionally add extra semicolons as a matter of style.

一些JavaScript程序员会在每一个语句后面都使用分号，有一些则只在有必要的时候使用。大多数人介于两者之间，也有少数人将特意添加额外的分号作为一种风格。

Even if you use semicolons at the end of every statement, some constructs parse in non-obvious ways. Regardless of your preferences in semicolon usage, you must know the rules to write JavaScript professionally. If you remember a few simple rules, all of which are explained here, you will be able to understand how any program you might encounter will be parsed, and will be an expert on JavaScript automatic semicolon insertion, or ASI.

即便是在每一个语句后面都跟分号，一些构造器依然会不那么明显的进行解析。不顾后果的使用分号，你必须知道专业地编写JavaScript代码的规则。如果能记住本文提出的一些简单的规则，你可以更好的理解程序是如何的解析的，并且可以在JavaScript自动分号插入（或者简称为`ASI`）方面成为专家。

### Where Semicolons are Allowed

**分号在哪里是允许的？**

In the formal language grammar given in the ECMAScript specification, semicolons are shown at the end of each kind of statement in which they can appear. Here is the do-while statement:

根据ECMAScript标准指出的常规的语法，分号在各种语句的后面都可以出现。这里有一个`do-while`语句：


	do Statement while ( Expression ) ;


Semicolons also appear in the grammar at the end of var statements, expression statements (such as "`4+4;`" or "`f();`"), continue, return, and break statements, and throw and debugger statements.

分号也可以出现在`var`声明语句，表达式语句（诸如`4+4;`、`f();`），`continue`、`return`、`break`语句，以及`throw`和`debugger`语句。

The empty statement is just a semicolon by itself, and is a legal statement in JavaScript. For this reason, "`;;;`" is a valid JavaScript program; it parses as three empty statements, and runs by doing nothing three times.

空语句同样可以使用分号，这在JavaScript中也是可行的。鉴于这个原因，`;;;`是有效的JavaScript程序，它会解析成三个空语句，运行时会做三次啥也不做的事情。

Sometimes empty statements are actually useful, at least syntactically. For example, to write an infinite loop, one can write `while(1);`, where the semicolon is parsed as an empty statement, which makes the while statement syntactically valid. If the semicolon was omitted, the while statement would not be complete, because a statement following the loop condition is required.

事实上，至少在语法构成方面，有时候空语句是很有用的。举个例子，编写一个无限循环，可以这么写：`while(1);`，分号将被解析成一个空语句，这样可以使`while`语句的语法变得有效。如果省略分号，这个`while`语句就不完整了，因为后续的循环体是必须的。

Finally, semicolons appear in for loops of the form `for ( Expression ; Expression ; Expression ) Statement`, and of course they may appear as themselves inside strings and regular expression literals.

~~太长，任性不翻译了~~

### Where Semicolons May be Omitted

In the formal grammar used in the ECMAScript specification, the semicolons are included, as described above. However, the specification prose then gives rules which describe how the actual parsing differs from the formal grammar. These are described as though semicolons are inserted into the token stream while parsing, though this is just a specification convenience; in practice, parsers do not need to generate fake semicolon tokens, but can instead regard semicolons as optional in specific places in the grammar (for an example see [this parser expression grammar for ECMAScript](http://boshi.inimino.org/3box/PanPG/grammars/ECMAScript_5.peg), particularly the Statement, EOS, EOSnoLB, and SnoLB rules). Where the specification says that a semicolon is inserted, this simply means that the statement currently being parsed is ended.

These semicolon insertion rules are specified in section 7.9 of [ECMA-262 [pdf]](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-262.pdf).

The section gives three basic rules, followed by two exceptions.

The rules are:

1. When the program contains a token that is not allowed by the formal grammar, then a semicolon is inserted if (a) there is a line break at that point, or (b) the unexpected token was a closing brace.
2. When the end of a file is reached, if the program cannot be parsed otherwise, then a semicolon is inserted.
3. When a "restricted production" is encountered and contains a line terminator in a place where the grammar contains the annotation "[no LineTerminator here]", then a semicolon is inserted.

Approximately, these rules state that a statement can be terminated without a semicolon either (a) before a closing brace, (b) at the end of the program, or (c) when the next token cannot be parsed otherwise, and furthermore that there are certain places in the grammar in which, if a line break appears, it terminates the statement unconditionally. The practical effects of these rules are discussed below.

The exceptions are that a semicolon is never inserted as part of the header of a for loop of the form `for ( Expression ; Expression ; Expression ) Statement`, and a semicolon is never inserted if it would be parsed as an empty statement.

What do these rules and exceptions mean in practice?

Firstly, a semicolon is optional only where there is a line break, a closing brace, or the end of the program. Semicolons are not optional between statements appearing on the same line. Additionally, a semicolon is not implied at the end of a line if the first token of the subsequent line can be parsed as part of the same statement.

`42; "hello!"` is a valid program, as is `42\n"hello!"` (with the "\n" representing an actual linebreak), but `42 "hello!"` is not; the linebreak triggers semicolon insertion but linear whitespace does not. Also valid is "`if(x){y()}`". Here "`y()`" is an expression statement, which can be terminated by a semicolon, but since the next token is a closing brace, the semicolon is optional even though there is no linebreak.

The two exceptions, for loops and empty statements, can be demonstrated together:


	for (node=getNode();
		 node.parent;
		 node=node.parent) ;

This for loop takes the parent of a node repeatedly until a node is reached which has no parent. All of this is done in the header of the for loop, so we have nothing left for the statement inside the for loop to do. However, the for loop syntax requires a statement, so we use an empty statement. Even though all three of the semicolons in this example appear at the end of a line, all three of them are required, since a semicolon is never inserted in a for loop header or to create an empty statement.

### Restricted Productions

Restricted productions are those in which a line break cannot appear in a particular position, so if a line break appears there, it will prevent the program from parsing in that way, though it may still parse another way.

There are five restricted productions in the grammar, they are the postfix operators `++` and `--`, continue statements, break statements, return statements, and throw statements. Break and continue statements have an optional identifier which may be used to break or continue a particular labelled loop in which the statement appears. If this feature is used, the identifier must be used on the same line as the `break` or `continue` token. The following is a valid program:

	var c,i,l,quitchars
	quitchars=['q','Q']
	charloop:while(c=getc()){
		for (i=0; i<quitchars.length; i++){
			if (c==quitchars[i]) break charloop
		}
		/* ... more code to handle other characters here ... */
	}

If `getc()` reads a character from an input device and returns it, then the program will read characters, test each one of them to see if it is in `quitchars`, and if it is, break the input loop. Note that the labelled break statement is necessary to escape from the outer while loop and not only the inner for loop. The following program, differing only in whitespace, will also parse, but will not give the same result:

	var c,i,l,quitchars
	quitchars=['q','Q']
	charloop:while(c=getc()){
		for (i=0; i<quitchars.length; i++){
			if (c==quitchars[i])
				break
					charloop
		}
		/* ... more code to handle other characters here ... */
	}

Specifically, in the latter case, the `charloop` token is not part of the break statement. Since the break statement is restricted, the linebreak at that position terminates the break statement. The `charloop` token simply parses as a reference to a charloop variable, which will never be reached, and the break statement will terminate the inner loop, not the outer loop as was intended.

Here are examples illustrating the other four restricted productions:

	// PostfixExpression :                                            
	//              LeftHandSideExpression [no LineTerminator here] ++
	//              LeftHandSideExpression [no LineTerminator here] --
	var i=1;
	i
	++;

This is a parse error, it does not parse as "`i++`". A line terminator cannot appear before the postfix increment or decrement operator, so a "`++`" or "`--`" token at the start of the line will never parse as part of the preceding line.

	i
	++
	j

This is not a parse error: it parses as "`i; ++j`" The pre-increment and -decrement expressions are not restricted, so a linebreak can occur between the "`++`" or "`--`" token and the expression which it modifies.


	// ReturnStatement: return [no LineTerminator here] Expressionopt ;
	return
	  {i:i, j:j}

This parses as an empty return statement, followed by an expression statement which will never be reached. The following all parse as intended:


	return {
	  i:i, j:j}
	return (
	  {i:i, j:j})
	return {i:i
		   ,j:j}

Note that return statements can contain linebreaks within the expression, just not between the `return` token and the start of the expression. When semicolons are intentionally omitted, it is convenient that the return statement is a restricted production, as it allows the programmer to write an empty return statement without accidentally returning the value of the next line:

	function initialize(a){
	  // if already initialized, do nothing
	  if(a.initialized) return
	  a.initialized = true
	  /* ... initialize a ... */
	}

Continue and throw statements are similar to break and return:

	continue innerloop // correct

	continue
		innerloop;     // incorrect

	// ThrowStatement : throw [no LineTerminator here] Expression ;
	throw                                          // parse error
	  new MyComplexError(a, b, c, more, args);
	// Unlike the return, break, and continue statements, 
	// the expression after "throw" is not optional, 
	// so the above will not parse at all.
	throw new MyComplexError(a, b, c, more, args); // correct
	throw new MyComplexError(
		a, b, c, more, args);                      // also correct
	// Any variation with 'new' and 'throw' on the same line is correct.

Note that indentation has no effect in parsing ECMAScript programs, but the presence or absence of line breaks does. Therefore, any tool that processes JavaScript source code may remove leading whitespace from lines (outside of string literals!) without changing the semantics of the program, but line breaks cannot be indiscriminately removed or replaced with spaces or semicolons. A minification tool that changes the semantics of valid programs is a broken tool, and the only way to write a correct tool is to use a complete and correct parser.

Line breaks following `return`, `break`, and `continue` or preceding `++` and `--` tokens can affect parsing. Since the productions above are the only restricted productions in the language, this implies that whitespace including linebreaks can be freely added anywhere else as desired to improve readability. In particular the logical, arithmetic, and string concatenation operators, the ternary or conditional operator, member access using the dot or bracket notations, function calls, and while loops, for loops, switch statements, and the rest of the control structures, can all be written with linebreaks freely used throughout.

As the specification says:

> The resulting practical advice to ECMAScript programmers is: A postfix `++` or `--` operator should appear on the same line as its operand. An Expression in a return or throw statement should start on the same line as the return or throw token. A Identifier in a break or continue statement should be on the same line as the break or continue token.

The most commonly cited programmer error related to restricted productions is to put the return value on the line after the `return` token, especially common when the returned value is a large object or array literal or multiline string. Line break errors with postfix operators, break, continue, and throw statements are rarely seen in practice, for the simple reason that the erroneous line breaks look unnatural to most programmers and so are unlikely to be written.

The final subtlety of ASI arises from the first rule, which requires that the program contain a token which is not allowed by the formal grammar, before a semicolon will be inserted. When writing code with optional semicolons omitted, it is important to keep this rule in mind so that required semicolons are not inadvertently omitted as well. This rule is what makes it possible to extend statements across multiple lines, as in the following examples:

	return obj.method('abc')
			  .method('xyz')
			  .method('pqr')

	return "a long string\n"
		 + "continued across\n"
		 + "several lines"

	totalArea = rect_a.height * rect_a.width
			  + rect_b.height * rect_b.width
			  + circ.radius * circ.radius * Math.PI

The rule considers only the first token of the following line. If that token can parse as part of the statement, then the statement is continued (even if parsing fails a little further on: the language syntax is designed to only require one token of lookahead in the parser). If the first token cannot extend the statement, then a new statement begins (which the spec describes by saying a semicolon is inserted).

The potential for error arises whenever there is a pair of statements A and B such that both A and B are valid statements standing alone, but the first token of B can also be accepted as an extension of A. In such cases, if a semicolon is not provided, the parser will not parse B as a separate statement, and will either reject the program or parse it in a way that the programmer did not intend. Thus when semicolons are omitted, the programmer must beware any such statement pair separated by a linebreak as:

	A
	B

Where B begins with a token that would be accepted by the parser if it had appeared at the end of line A.

The majority of JavaScript statements begin with an identifier, and the majority of the remainder begin with a keyword such as "var", "function", or "if". For any such statement B beginning with a keyword or identifier, as well as any beginning with a string or number literal, there is no valid complete statement A such that the first token of B would be accepted by the parser as extending A. (The verification of this from the grammar is left as an exercise for the reader.)

	A
	function f(x){return x*x}

	// for any statement A, without any terminating semicolon,
	// all of these examples will parse as intended

	A
	f(7)

	A
	"a string".length

Unfortunately, there are five tokens that can appear both at the start of a statement, and as an extension of some complete statement A. These tokens are the open parenthesis "`(`", open square brace "`[`", slash or solidus "`/`", and "`+`" and "`-`". Of these, the first two are problematic in practice.

This means it is not always the case that a line break can replace a semicolon between statements.

The spec gives the following example:

>		a = b + c
>		(d + e).print()
>
> is not transformed by automatic semicolon insertion, because the parenthesised expression that begins the second line can be interpreted as an argument list for a function call:
> 	
> 		a = b + c(d + e).print

The spec goes on to suggest, "In the circumstance that an assignment statement must begin with a left parenthesis, it is a good idea for the programmer to provide an explicit semicolon at the end of the preceding statement rather than to rely on automatic semicolon insertion." A more robust alternative where semicolons are intentionally omitted is to include the semicolon at the beginning of the line, directly before the token that introduces the potential ambiguity:
					   
					   a = b + c
					   ;(d + e).print()

~~上面的代码前面有很多空格，实际上在marked工具解析的时候会忽略代码前的空格~~

Statements beginning with open parentheses or square braces are somewhat rare, but do arise in practice.

Examples involving open square braces are more common now that "functional" operations such as map, filter, and forEach are common on arrays. It is often convenient to use an array literal with a forEach call which is evaluated for its side-effects, as in the following:

	[['January','Jan']
	,['February','Feb']
	,['March','Mar']
	,['April','Apr']
	,['May','May']
	,['June','Jun']
	,['July','Jul']
	,['August','Aug']
	,['September','Sep']
	,['October','Oct']
	,['November','Nov']
	,['December','Dec']
	].forEach(function(a){ print("The abbreviation of "+a[0]+" is "+a[1]+".") })

	['/script.js'
	,'/style1.css'
	,'/style2.css'
	,'/page1.html'
	].forEach(function(uri){
	   log('Looking up and caching '+uri)
	   fetch_and_cache(uri)})

In cases where array literals are used for their value in an assignment expression, or are passed to a function, they will not appear as the beginning of the statement, so an opening square brace as the first token is rare, but does occur.

The final troublesome token is the slash, and this one can be highly counterintuitive. Consider the following example:

	var i,s
	s="here is a string"
	i=0
	/[a-z]/g.exec(s)

On lines 1-3 we set up some variables, and on line 4, it appears, we construct a regexp literal `/[a-z]/g` which will globally match a-z, and then we evaluate this regexp against the string with the exec method. Since the return value of the exec() call is not used, this code is not very useful, but we might expect it to compile. However, the slash can not only appear at the beginning of a regexp literal, but also serves as the division operator. That means that the leading slash on line 4 will actually be parsed as a continuation of the assignment statement on the previous line. The entirety of lines three and four parses as the single statement "i equals 0 divided by [a-z] divided by g.exec(s)".

This issue almost never arises in practice because there is seldom a practical reason to begin a statement with a regexp literal. In the example above, the value of the exec() call would usually be passed to a function or assigned to a variable, and in either case the line would no longer begin with a slash. One possible exception is, again, with the forEach Array method, which could be usefully used on the return value of an exec() call directly.

The operators "`+`" and "`-`" can be used as unary operators, to convert a value to the Number type and in the case of "`-`" to reverse the sign. If used at the beginning of a statement with semicolons omitted, these can be interpreted as the corresponding binary operator, as a continuation of the previous statement. Even when semicolons are intentionally omitted, this is rarely a problem, as a leading unary operator is even less likely than a regexp literal to occur as the first token of a statement (and it does not look self-contained in the way that a parenthesized expression does). As with regexps, if the programmer wanted to coerce a value to a Number, it was probably to do something with that Number value, such as assign it to a variable or pass it to a function, and in either case the unary operator would not be the first token of the statement:

	var x,y,z
	x = +y;    // useful
	y = -y;    // useful
	print(-y); // useful
	+z;        // useless

In all such cases, when semicolons are omitted, the safest practice with lines beginning with an open parenthesis or square brace is to precede the token with a semicolon on the line itself. This advice also applies in the unlikely case of statements beginning with an arithmetic operator "`+`", "`-`", or "`/`". In this way, even when semicolons are not used elsewhere, the line will be protected from misparsing regardless of how the line previous to it may change over time.

### Misconceptions

Many new JavaScript programmers are advised to just use semicolons everywhere, and expect that if they do not intentionally use the semicolon insertion rules, they can safely ignore the existence of this entire language feature. This is not the case, because of the restricted productions described above, notably the return statement. When becoming aware of the restricted production issue, programmers may then become overly wary of linebreaks, and avoid them even when they would increase clarity. It is best to be familiar with all the rules for ASI so as to be able to read any code regardless of how it is written, and to write code that is as clear as it can be.

Another misconception is that bugs in browser JavaScript engines mean that using semicolons everywhere is safer, and will protect the developer from compatibility issues between browsers. This is simply not the case. All extant browsers implement the specification correctly with regard to ASI, and any bugs that may have existed are long since lost in the mists of early Web history. There is no reason to be concerned about browser compatibility in regard to semicolon insertion: all browsers implement the same rules and they are the rules given by the spec and explained above.

### Conclusion

Should you omit optional semicolons or not? The answer is a matter of personal preference, but should be made on the basis of informed choice rather than nebulous fears of unknown syntactical traps or nonexistent browser bugs. If you remember the rules given here, you are equipped to make your own choices, and to read any JavaScript easily.

If you choose to omit semicolons where possible, my advice is to insert them immediately before the opening parenthesis or square bracket in any statement that begins with one of those tokens, or any which begins with one of the arithmetic operator tokens "`/`", "`+`", or "`-`" if you should happen to write such a statement.

Whether you omit semicolons or not, you must remember the restricted productions (return, break, continue, throw, and the postfix increment and decrement operators), and you should feel free to use linebreaks everywhere else to improve the readability of your code.

~~全文完~~
