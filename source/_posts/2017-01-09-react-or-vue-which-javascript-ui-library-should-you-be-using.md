---
title: "React or Vue: Which Javascript UI Library Should You Be Using?"
tags: [javascript,react, vue, ui, programming, web]
categories: [翻译]
date: 2017-01-09 21:04:07
description: "本文为英文文章《React or Vue: Which Javascript UI Library Should You Be Using?》的原文，并附带有作者介绍和Vue.js的作者的亲自回复。文章主要讲述了React和Vue之间的差异性。"
---

> Source: [React or Vue: Which Javascript UI Library Should You Be Using?](https://medium.com/js-dojo/react-or-vue-which-javascript-ui-library-should-you-be-using-543a383608d)
> Translation: 未完成，敬请期待。

![](http://ww4.sinaimg.cn/large/79be2309gw1fbkp0222bkj20rs0b3gov.jpg)

In 2016 React cemented its position as king of the Javascript web frameworks. This year saw rapid growth of both its web and native mobile libraries, and a comfortable lead over main rival Angular.

But 2016 has been an equally impressive year for Vue. The release of its version 2 made a huge impression on the Javascript community, attested to by the 25,000 extra Github stars it gained this year.

The scope of both React and Vue is undeniably similar: both are lightweight component-based libraries for building user interfaces that focus on the view layer only. Both can be used in a simple project, or be scaled up to a sophisticated app using cutting edge tooling.

As a result, a lot of web developers are wondering which one they should be using. Is one clearly superior over the other? Do they have specific pros and cons to be aware of? Or are they basically the same?

**Two frameworks, two advocates.**

In this article I want to answer those questions with a thorough and fair comparison. The only problem is: I’m an unashamed Vue fan-boy and totally biased. I’ve used Vue heavily in my projects this year, sung its praises here on Medium and even released a [Udemy course](https://www.udemy.com/vuejs-2-essentials).

To even out my biased position I’ve bought in my friend Alexis Mangin who is both a great Javascript developer and a big React fan. He’s similarly immersed in React, using it frequently in both web and mobile projects.

Alexis asked me one day: “why are you so into Vue, and not React?” Since I didn’t know React that well, I couldn’t give a good answer. So I put the idea to him that we sit down one day with our laptops and show each other what our chosen library had to offer.

![](http://ww2.sinaimg.cn/large/79be2309gw1fbkp00ztjzj20m80e2414.jpg)
> Anthony (left) and Alexis (right) comparing React and Vue at Bull and Bear Cafe in Chiang Mai, Thailand

After a lot of discussion and learning from both sides, the following six points are our key findings.

**If you like building apps with templates (or want the option to), go with Vue.**

Putting your markup in an HTML file is the default option for a Vue app. Similar to Angular, moustache braces are used for data-binding expressions, while directives (special HTML attributes) are used for adding functionality to the template.

The follow demonstrates a simple Vue app. It prints a message and has a button that dynamically reverses the message:

```vue
// HTML
<div id="app">
  <p>{{ message }}</p>
  <button v-on:click="reverseMessage">Reverse Message</button>
</div>
// JS
new Vue({
  el: '#app',
  data: {
    message: 'Hello Vue.js!
  },
  methods: {
    reverseMessage: function () {
      this.message = this.message.split('').reverse().join('');
    }
  }
});
```

In contrast, React apps shun templates and require the developer to create their DOM in Javascript, typically aided with JSX. Below is the same simple app implemented with React:

```jsx
// HTML
<div id="app"></div>
// JS (pre-transpilation)
class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      message: 'Hello React.js!'
    };
  }
  reverseMessage() {
    this.setState({ 
      message: this.state.message.split('').reverse().join('') 
    });
  }
  render() {
    return (
      <div>
        <p>{this.state.message}</p>
        <button onClick={() => this.reverseMessage()}>
          Reverse Message
        </button>
      </div>
    )
  }
}
ReactDOM.render(App, document.getElementById('app'));
```

Templates are easier to understand for newer developers who’ve come from the standard web development paradigm. But even some experienced developers prefer them as templates can better seperate layout from functionality and give the option of using pre-processors like Pug.

But templates come at the cost of having to learn all the extended HTML syntax, while render functions only require knowledge of standard HTML and Javascript. Render functions also benefit from easier debugging and testing.

On this point, though, you can’t go wrong with Vue, as it’s introduced the option of using either templates or render functions in version 2.

**If you like simplicity and things that “just work”, go with Vue.**

A simple Vue project can be run directly from a browser with no need of transpilation. This allows Vue to be easily dropped into a project the way jQuery is.

While this is also technically possible with React, typical React code leans more heavily on JSX and on ES6 features like classes and non-mutating array methods.

But Vue’s simplicity runs more deeply in its design. Let’s compare how the two libraries handle application data (i.e. “state”).

State in React is immutable so you can’t directly change it. You need to use the setState API method:

```js
this.setState({ 
    message: this.state.message.split('').reverse().join('') 
});
```

Diff’ing the current and previous state is how React knows when and what to re-render in the DOM, hence the need for immutable state.
In contrast, data is just mutated in Vue. The same data property can be altered far less verbosely in Vue:

```js
// Note that data properties are available as properties of 
// the Vue instance
this.message = this.message.split('').reverse().join('');
```

Before you conclude that Vue’s rendering system must lack the efficiency of React’s, let’s examine how state in Vue is managed under the hood: when you add a new object to the state, Vue will walk through all of its properties and convert them to getter and setters. Vue’s reactivity system now keeps track of the state and will automatically re-render the DOM when it is mutated.

Impressively, altering state in Vue is not only more succinct, but its re-rendering system is actually faster and more efficient than React’s.

Vue’s reactivity system does have caveats, though. For example, it cannot detect property addition or deletion and certain array changes. These cases can be worked around with a React-like set method from the Vue API.

**If you need your application to be as small and fast as possible, go with Vue.**

Both React and Vue will build a virtual DOM and synchronise the real DOM when the app’s state changes. Both have their own means of optimising this process.

Vue core developers have offered a benchmark test that shows Vue’s rendering system to be faster than React’s. In this test a list of 10,000 items are rendered 100 times. The comparison is tabled below.

![](http://ww3.sinaimg.cn/large/79be2309gw1fbkp019rknj20m808dglu.jpg)
> Benchmarks as published on vuejs.org

From a pragmatic standpoint, this kind of benchmark is only relevant in edge cases. Most apps will not need to do this kind of operation routinely so it should generally not be considered an important point of comparison.

Page size, though, is relevant to all projects, and again Vue has the upper hand. Minified, the current release of the Vue library is only 25.6KB.

To get a similar set of functionality in React you need React DOM (37.4KB) and the React with Addons library (11.4KB), which totals 48.8KB, almost double the size of Vue. To be fair you will get a larger API with React, but you don’t get double as much functionality.

**If you plan to build a large scale app, go with React.**

A comparison of a simple app implemented in both Vue and React, like the one at the beginning of this article, may initially bias a developer to favour Vue. This is because template-based apps are easier to understand at first look, and quicker to get up and running with.

But these initial benefits introduce technical debt that can slow development of apps reaching a larger scale. Templates are prone to unnoticed runtime errors, are hard to test, and are not easy to restructure or decompose.

In contrast, Javascript-made templates can be organised into components with nicely decomposed and DRY code that is more reusable and testable.

Vue also has a component system and render functions. But React’s rendering system is more configurable and has features like shallow rendering that, combined with React’s testing utilities, allow for far more testable and maintainable code.

Meanwhile, React’s immutable application data may not be as succinct, but it shines in larger application when transparency and testability become critical.

**If you want a library that is adaptable for both web and native apps, go with React.**

React Native is a library for building native mobile applications with Javascript. It’s the same as React.js, only instead of using web components, it uses native components. If you’ve learnt React.js, you’ll very easily be able to pick up React Native, and vice versa.

```js
// JS
import React, { Component } from 'react'; 
import { AppRegistry, Text, View } from 'react-native';  
class HelloWorld extends Component {   
  render() {     
    return (       
      <View>         
        <Text>Hello, React Native!</Text>
      </View>
    );   
  }
}
AppRegistry.registerComponent('HelloWorld', () => HelloWorld);
```

The significance is that a developer can build an app on either the web or native mobile without requiring a different set of knowledge and tools. Learning React gives you a huge bang for you buck if you intend to develop for both web and mobile.

Alibaba’s Weex is another cross-platform UI project. Currently it considers Vue an “inspiration” and uses a lot of the same syntax, with plans to fully integrate Vue. However, the timeline and specifics of this integration are still unclear.

Since Vue has HTML templates as a core part of its design and does not have custom rendering as a current feature, it’s hard to see that a native counterpart for Vue.js in its current form will be as tight as what React.js and React Native are.

**If you want the biggest ecosystem, go with React.**

There’s no question that React is currently the more popular library with ~2.5M NPM downloads a month as opposed to Vue’s ~225K per month.

![](http://ww1.sinaimg.cn/large/79be2309gw1fbkp01iettj20m8092mxp.jpg)

Popularity is not merely a shallow benefit. It means there are more articles, tutorials and Stack Overflow answers for help. It means there are more tools and add-ons to leverage in a project and save developers from building everything themselves.

Both libraries are open source, but React was born from Facebook and benefits from that patronage. Developers and companies committing to React can be assured of continued maintenance.

In contrast, Vue was created by a single developer, Evan You, and You is currently the only full time maintainer of Vue. Vue has some corporate sponsorship but not on the scale of Facebook or Google.

To the credit of the Vue team, its small size and independence has not materialised as a disadvantage. Vue has a regular release cycle and even more impressively, Vue has only 54 open issues on Github compared to 3456 closed issues, while React has a far larger 530 open issues compared to 3447 closed.

**If you’re already happy with one or the other, there’s no need to switch.**

To recap, our findings, Vue’s strengths are:

- Flexible options for template or render functions
- Simplicity in syntax and project setup
- Faster rendering and smaller size

React’s strengths:

- Better at scale, studier and more testable
- Web and native apps
- Bigger ecosystem with more support and tools available

However, both React and Vue are exceptional UI libraries and have more similarities than differences. Most of their best features are shared:

- Fast rendering with virtual DOM
- Lightweight
- Reactive components
- Server-side rendering
- Easy integration with router, bundler and state management
- Great support and community

If you think we’ve missed something we’d love to hear in the comments. Happy developing!

---

*About the authors*

Anthony Gore
> I’m a Javascript developer and online course instructor. My latest course is Vue.js 2 Essentials: Build Your First Vue App, available on Udemy.

Alexis Mangin
> Alexis helped me write this article with his exceptional knowledge of web development. You should follow him on Medium as he writes his own great tutorials on React.

---

Vue的作者[回复了该文](https://medium.com/@youyuxi/pretty-good-comparison-overall-but-a-few-points-id-like-to-discuss-e4f6460e75d5#.mij64qy5y)，摘录如下：
Pretty good comparison overall, but a few points I’d like to discuss:

> “Templates are prone to unnoticed runtime errors, are hard to test, and are not easy to restructure or decompose.”

These arguments against templates are too broad. Templates are by definition statically analyzable (even more so than dynamic render functions) and Vue provides many compile-time AND runtime warnings for common template syntax errors, and can be further improved in the future. Also, since Vue templates compile into render functions under the hood, a template containing expression syntax errors will be detected at compile time instead of runtime (if you are using a build setup instead of in-browser compilation).

> “In contrast, Javascript-made templates can be organised into components with nicely decomposed and DRY code that is more reusable and testable.”

Organizing your application as decoupled components has little to do with whether you are using templates or JSX, but more with how components are defined as a function of state and prop. In this sense, Vue components and React components are equivalent on the higher level and there’s nothing that makes a React component fundamentally more testable than a Vue component. You can do exactly the same thing with a Vue component: render the virtual DOM with different set of props and assert the output. Admittedly this is may not be very obvious for new users, but we are planning to provide official component testing utilities in the near future.

> “Meanwhile, React’s immutable application data may not be as succinct, but it shines in larger application when transparency and testability become critical.”

This statement lacks the proper context of state management patterns used. In most cases, the built-in state management patterns provided by the frameworks themselves are insufficient for large scale apps, and a dedicated solution like Redux or Vuex must be used. It is very premature to declare that “If you plan to build a large scale app, go with React” without giving a proper discussion about the solutions designed to deal with large scale apps for both frameworks.

> Alibaba’s Weex is another cross-platform UI project. Currently it considers Vue an “inspiration” and uses a lot of the same syntax, with plans to fully integrate Vue. However, the timeline and specifics of this integration are still unclear.

The [roadmap](https://github.com/weexteam/weex-vue-framework/issues/9) is publicly available. In the latest Weex release (0.9.4), Vue 2 is now already officially integrated as a runtime framework which allows the use of the majority of features found in Vue’s API (excluding those that are web-platform-specific). ([examples](https://github.com/alibaba/weex/tree/dev/examples/vue))

> “Since Vue has HTML templates as a core part of its design and does not have custom rendering as a current feature, it’s hard to see that a native counterpart for Vue.js in its current form will be as tight as what React.js and React Native are.”

This is factually wrong. Vue 2.x is designed to support [custom rendering targets](https://github.com/vuejs/vue/tree/dev/src/platforms) from the very beginning, it’s just not exposed via public APIs. Again, templates are compiled into Virtual DOM render functions which allows any type of lower-level customizations needed to adapt to native rendering targets.
