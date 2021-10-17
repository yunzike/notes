## 1、介绍





## 2、构建 React 项目

### 2.1 环境搭建

1、安装 Node.js 和 npm

2、通过 npm 使用 React

全局安装create-react-app模块

```bash
$ npm install -g create-react-app
```

### 2.2 创建 React 项目

```bash
$ create-react-app my-app
```

运行项目

```bash
$ cd my-app/
$ npm start
```



### 2.2 React 项目结构

![React项目总目录结构](../images/006tNbRwgy1fxv3ha7r97j30m207y0td.jpg?lastModify=1625846474)![React项目总目录结构](../images/006tNbRwgy1fxv3ha7r97j30m207y0td-20191130224134657.jpg?lastModify=1625846474)

- package.json 定义项目所需模块及配置信息

  ![img](../images/006tNbRwgy1fxv3j184d8j30d60kywfl.jpg?lastModify=1625846474)

- public文件夹

  ![img](../images/006tNbRwgy1fxv3js69x5j30n4050dg4.jpg?lastModify=1625846474)

  favicon.ico

  是浏览器tab上图标，也是这个项目的一个标志，也可以说是代表一个公司的标志。可以替换。

  index.html

  项目的入口文件，引用了第三方类库啊，还可以引入cdn

  是项目的总容器，所有的内容存储在这个容器中。这个容器有且只能有一个。

  manifest.json

  允许将站点添加至主屏幕，是 PWA 提供的一项重要功能，当前 manifest.json 的标准仍属于草案阶段，Chrome 和 Firefox 已经实现了这个功能，微软正努力在 Edge 浏览器上实现，Apple 目前仍在考虑中

- src文件夹

  ![img](file:///Users/xiongxq/%E5%9D%9A%E6%9E%9C%E4%BA%91/notes/images/006tNbRwgy1fxv3nyp4mnj30o008fwfc.jpg?lastModify=1625846474?lastModify=1628007897)

  index.js

  存放的是这个项目的核心内容，也就是我们的主要工作区域。其中，index.js文件是和index.html进行关联的文件的唯一接口。能够引用<App />的原因是文档内容的头部，有import App from './App';内容，就是为了将App.js的内容引入到index.js文件中。

  App.js

  该类是继承react提供的component，export default App;是为了将App公开，index.js才能够引用。App.js继承了component的话，必须使用render进行渲染。return的内容是模板，类似于html结构的内容，就是jsx，jsx语法是react的主要语法。在这个文件中，只能用一个div容器，如果在div的同级目录添加别的内容，便会报错。

  className="App"，是引用到App.css的样式。注意，页面内容样式是就近原则，首先用App.css的样式，App.css是组件的样式，index.css是全局的样式。

  内容渲染的方式有两种，jsx语法(上面默认的内容)和React.createElement的方法。

- node_modules文件夹

  包管理工具下载安装了的包，比如webpack、gulp、grunt这些工具



## 3、前端组件化

#### 1、一个简单的点赞功能

假设需要实现一个简单的点赞、取消点赞的功能。  
**HTML：**

````
<body>
    <div class='wrapper'>
      <button class='like-btn'>
        <span class='like-text'>点赞</span>
        <span>👍</span>
      </button>
    </div>
</body>
````

![](https://ws3.sinaimg.cn/large/006tKfTcgy1g0tgtmp8frj306i02ut92.jpg)  
通过以上HTML代码很简单就实现了如上图所示的页面效果，接下来进一步加入JavaScript的行为。  
**JavaScript:**

````
const button = document.querySelector('.like-btn')//获取button元素节点
const buttonText = button.querySelector('.like-text')//获取buttonText元素节点
let isLiked = false//是否点赞，默认未点赞
button.addEventListener('click', () => {//为button元素添加点击监听事件
    isLiked = !isLiked
    if (isLiked) {//点赞后改变buttonText元素的子元素为"取消"
          buttonText.innerHTML = '取消'
    } else {
          buttonText.innerHTML = '点赞'
    }
}, false)

````

到此，简单的点赞和取消按钮的结构和功能都已经实现了。但是如果他人要用到同样的按钮，只能复制该功能代码使用。因此可以考虑怎样更好的实现结构复用。

#### 2、结构复用

首先先写一个点赞按钮的类,其中有一个render方法，用以返回一个点赞按钮的HTML代码的字符串。  
**LikeButton类：**

````
class LikeButton {
    render () {
      return '
        <button id='like-btn'>
          <span class='like-text'>赞</span>
          <span>👍</span>
        </button>
      '
    }
}
````

通过使用LikeButton类达到代码复用：

````
const wrapper = document.querySelector('.wrapper')//通过类选择器获取外层div元素

const likeButton1 = new LikeButton()//通过LikeButton类创建点赞按钮
wrapper.innerHTML = likeButton1.render()//将按钮添加到div中

const likeButton2 = new LikeButton()
wrapper.innerHTML += likeButton2.render()//在div中添加第二个按钮
````

这里非常暴力地使用了innerHTML，把两个按钮粗鲁地插入了 wrapper 当中。勉强了实现了结构的复用，接下来继续优化它。

#### 实现简单组件化

首先，以上结构复用，在wrapper中只是添加了两个点赞按钮的HTML的字符串。根本没能实现功能。  
这就需要 DOM 结构，准确地来说：我们需要这个点赞功能的 HTML 字符串表示的 DOM 结构。假设我们现在有一个函数 createDOMFromString ，你往这个函数传入 HTML 字符串，但是它会把相应的 DOM 元素返回给你。这个问题就可以解决了。  
**createDOMFromString方法：**

````
// String => Document
const createDOMFromString = (domString) => {
  const div = document.createElement('div')
  div.innerHTML = domString
  return div
}
````

以上方法并不能真正实现功能，但可以确实完全可以通过DOM实现，先不用管具体怎么实现。
有了createDOMFromString方法，就可以修改上文的LikeButton类了。
**改写后的LikeButton类：**

````
class LikeButton {
    render () {
      this.el = createDOMFromString(
        '<button class='like-button'>
          <span class='like-text'>点赞</span>
          <span>👍</span>
        </button>'
      )
      this.el.addEventListener('click', () => console.log('click'), false)
      return this.el
    }
}
````

因为现在render方法返回的是DOM元素，所以不能使用innerHTML暴力插入，必须使用DOM API 插入。

````
const wrapper = document.querySelector('.wrapper')

const likeButton1 = new LikeButton()
wrapper.appendChild(likeButton1.render())

const likeButton2 = new LikeButton()
wrapper.appendChild(likeButton2.render())
````

点击这两个按钮，都会在控制台打印 click则说明事件绑定成功了。稍微改动LikeButton实现文本改变，完成完整的功能：  

````
class LikeButton {
    constructor () {
      this.state = { 
        isLiked: false 
      }
    }

    changeLikeText () {
      const likeText = this.el.querySelector('.like-text')
      this.state.isLiked = !this.state.isLiked
      likeText.innerHTML = this.state.isLiked ? '取消' : '点赞'
    }

    render () {
      this.el = createDOMFromString(`
        <button class='like-button'>
          <span class='like-text'>点赞</span>
          <span>👍</span>
        </button>
      `)
      this.el.addEventListener('click', this.changeLikeText.bind(this), false)
      return this.el
    }
}
````

上面改写后给 LikeButton 类添加了构造函数，这个构造函数会给每一个 LikeButton 的实例添加一个对象state，state 里面保存了每个按钮自己是否点赞的状态。还改写了原来的事件绑定函数：原来只打印 click，现在点击的按钮的时候会调用 changeLikeText 方法，这个方法会根据 this.state 的状态改变点赞按钮的文本。

上面这个组件的可复用性已经很不错了，使用时只需要实例化一下然后插入到 DOM 里面去就好了。   

但changeLikeText 函数包含了 DOM 操作，现在看起来比较简单，那是因为现在只有 isLiked 一个状态。由于数据状态改变会导致需要我们去更新页面的内容，所以如果组件依赖了很多状态，那么基本全部都是 DOM 操作。而且一个组件的显示形态由多个状态决定的情况非常常见，手动管理数据和 DOM 之间的关系会导致代码可维护性变差、容易出错。所以上面的例子这里还有优化的空间：如何尽量减少这种手动 DOM 操作？

#### 优化DOM操作

**一种解决方案：状态改变 -> 构建新的 DOM 元素更新页面**  
直接在 render 方法里面使用 this.state的相关状态 来构建DOM元素，一旦状态发生改变，就重新调用 render 方法，构建一个新的 DOM 元素，页面也就更新了。而不是像上面例子中：render方法中没有使用this.state对象中的状态，状态改变->根据不同状态值手动修改DOM中与状态对应的部分的内容。

````
class LikeButton {
    constructor () {
      this.state = { 
        isLiked: false 
      }
    }
    setState (state) {
      this.state = state
      this.el = this.render()
    }
    changeLikeText () {
      this.setState({
        isLiked: !this.state.isLiked
      })
    }
    render () {
      this.el = createDOMFromString(`
        <button class='like-btn'>
          <span class='like-text'>${this.state.isLiked ? '取消' : '点赞'}</span>
          <span>👍</span>
        </button>
      `)
      this.el.addEventListener('click', this.changeLikeText.bind(this), false)
      return this.el
    }
}
````

1、render 函数里面的 HTML 字符串会根据 this.state 不同而不同（这里是用了 ES6 的模版字符串，做这种事情很方便）。  
2、新增一个 setState 函数，这个函数接受一个对象作为参数；它会设置实例的 state，然后重新调用一下 render 方法。  
3、当用户点击按钮的时候， changeLikeText 会构建新的 state 对象，这个新的 state ，传入 setState 函数当中。

这样的结果就是，用户每次点击，changeLikeText 都会调用改变组件状态然后调用 setState ；setState 会调用 render ，render 方法会根据 state 的不同重新构建不同的 DOM 元素。
也就是说，你只要调用setState，组件就会重新渲染。我们顺利地消除了手动的 DOM 操作。



## 4、基础语法

### 4.1 JSX---描述UI信息

#### 如何用js对象表现一个DOM元素的结构？

````
<div class='box' id='content'>
  <div class='title'>Hello</div>
  <button>Click</button>
</div>
````

观察发现，每个DOM元素包含的信息其实只有三个：标签名、属性、子元素。 
其实上面这个 HTML 所有的信息我们都可以用合法的 JavaScript 对象来表示：

````
{
  tag: 'div',
  attrs: { className: 'box', id: 'content'},
  children: [
    {
      tag: 'div',
      arrts: { className: 'title' },
      children: ['Hello']
    },
    {
      tag: 'button',
      attrs: null,
      children: ['Click']
    }
  ]
}
````

但是用 JavaScript 写起来太长了，结构看起来又不清晰，用 HTML 的方式写起来就方便很多了。 
于是 React.js 就把 JavaScript 的语法扩展了一下，让 JavaScript 语言能够支持这种直接在 JavaScript 代码里面编写类似 HTML 标签结构的语法，这样写起来就方便很多了。编译的过程会把类似 HTML 的 JSX 结构转换成 JavaScript 的对象结构。

因此，**所谓的 JSX 其实就是 JavaScript 对象。**



#### JSX编译过程

以下return的JSX代码

````
import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import './index.css'

class Header extends Component {
  render () {
    return (
      <div>
        <h1 className='title'>React 小书</h1>
      </div>
    )
  }
}

ReactDOM.render(
  <Header />,
  document.getElementById('root')
)
````

经过编译以后会变成：

````
import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import './index.css'

class Header extends Component {
  render () {
    return (
     React.createElement(
        "div",
        null,
        React.createElement(
          "h1",
          { className: 'title' },
          "React 小书"
        )
      )
    )
  }
}

ReactDOM.render(
  React.createElement(Header, null), 
  document.getElementById('root')
);
````

React.createElement 会构建一个 JavaScript 对象来描述 HTML 结构的信息，包括标签名、属性、还有子元素等。这样的代码就是合法的 JavaScript 代码了。  
有了这个表示 HTML 结构和信息的对象以后，就可以拿去构造真正的 DOM 元素，然后把这个 DOM 元素塞到页面上。这也是我们最后一段代码中 ReactDOM.render 所干的事情。

**JSX编译过程**
![](../images/006evuW4gy1g0ywgqc5z4j30hm075aaq.jpg)
为什么不直接从 JSX 直接渲染构造 DOM 结构，而是要经过中间这么一层呢？ 

第一个原因是  
当我们拿到一个表示 UI 的结构和信息的对象以后，不一定会把元素渲染到浏览器的普通页面上，我们有可能把这个结构渲染到 canvas 上，或者是手机 App 上。所以这也是为什么会要把 react-dom 单独抽离出来的原因，可以想象有一个叫 react-canvas 可以帮我们把 UI 渲染到 canvas 上，或者是有一个叫 react-app 可以帮我们把它转换成原生的 App（实际上这玩意叫 ReactNative）。

第二个原因是  
有了这样一个对象。当数据变化，需要更新组件的时候，就可以用比较快的算法操作这个 JavaScript 对象，而不用直接操作页面上的 DOM，这样可以尽量少的减少浏览器重排，极大地优化性能。这个在以后的章节中我们会提到。


#### 表达式插入

**在 JSX 当中你可以插入JavaScript的表达式，表达式返回的结果会相应地渲染到页面上，表达式用 {} 包裹。**  
{} 内可以放任何 JavaScript 的代码，包括变量、表达式计算、函数执行等等，render会把这些代码返回的内容如实地渲染到页面上，非常的灵活。表达式插入不仅仅可以用在标签内部，也可以用在标签的属性上。

#### JSX 元素变量

JSX 元素本质上就是 JavaScript 对象。  
因此JSX 元素可以像 JavaScript对象那样自由地赋值给变量，或者作为函数参数传递、或者作为函数的返回值。  

````
const goodWord = <strong> is good</strong>
const badWord = <span> is not good</span>
````

### 4.2 数据处理

1、所有的模板要被一个根节点包含起来

2、模板元素不要加引号

3、{}绑定数据，用this.state.xxx调用

4、绑定属性注意  
class 要变成 className  
for 要变成 htmlFor  
style属性和以前的写法有些不一样,其中外面的花括号表示绑定数据，而里面的花括号表示一个对象  

````
<div style={{'color':'blue'}}>{this.state.title}</div>
<div style={{'color':this.state.color}}>{this.state.title}</div>
````

5、循环数据要加key

6、组件的构造函数中一定要注意 super  
子类必须在constructor方法中调用super方法，否则新建实例时会报错。这是因为子类没有自己的this对象，而是继承父类的this对象，然后对其进行加工。如果不调用super方法，子类就得不到this对象  

````
constructor(props){
    super(props); /*用于父子组件传值 固定写法*/
    this.state={
        userinfo:'张三'
    }
}
````

7、组件名称首字母大写、组件类名称首字母大写

8、在以类继承的方式定义的组件中，为了能方便地调用当前组件的其他成员方法或属性（如：this.state），通常需要将事件处理函数运行时的 this 指向当前组件实例。

绑定事件处理函数this的几种方法：  
第一种方法：

````
run(){
    alert(this.state.name)
}
<button onClick={this.run.bind(this)}>按钮</button>
````

第二种方法：构造函数中改变  

````
this.run = this.run.bind(this);

run(){
alert(this.state.name)
}
<button onClick={this.run>按钮</button>
````

第三种方法：箭头函数

````
run=()=> {
    alert(this.state.name)
}
<button onClick={this.run>按钮</button>
````

9、改变数据

````
setDate = ()=>{
    this.setState({
        msg: "xxxxx"
    })
}
<button onClick={this.setDate}>修改msg的值</button>
````

10、传递参数

````
setDate = (str)=>{
    this.setState({
        msg: str
    })
}
<button onClick={this.setDate.bind(this,参数)}>修改msg的值</button>
````



### 4.3 双向数据绑定实现

双向数据绑定：model改变影响view，view改变影响model

### 4.4 约束性组件和非约束性组件

1、非约束性组件，由原生DOM管理它的value。  
下面这个 defaultValue 其实就是原生DOM中的 value 属性。其value值就是用户输入的内容，React完全不管理输入的过程。  

````java
//用户输入A -> input 中显示A
<input type="text" defaultValue="a" />
````

2、约束性组件，由React管理它的value。  
下面这个value属性由 this.state.name，进而由 this.handleChange 负责管理的。实际上 input 的 value 不是用户输入的内容。而是onChange 事件触发之后，由 this.setState 决定。约束性组件显示的是 this.state.name 的值。

````java
//用户输入A -> 触发onChange事件 -> handleChange 中设置 state.name = “A” -> 渲染input使他的value变成A
<input type="text" value={this.state.name} onChange={this.handleChange} />
//...省略部分代码
handleChange: function(e) {
this.setState({name: e.target.value});
}
````



### 4.5 map---渲染列表数据





### 4.6 事件对象

事件对象(event)：在触发DOM上的某个事件是，会产生一个事件对象event。这个对象中包含着所有与事件有关的信息。

##### input：输入框事件  

通过event获得DOM的value

````
handleUsername = (e)=>{
this.setState({
      username:e.target.value
 })
}
<input onChange={this.handleUsername}/>
````

通过ref获得DOM的value

````
changeUsername=()=>{
this.setState({
      username:this.refs.username.value
}) }
<input ref="username" onChange={this.changeUsername}/>
````

##### 键盘事件(onKeyUp、onKeyDown等)

````
inputKey=(e)=>{
      if(e.keyCode==13)
      {    
            alert(this.state.username)
      }
}
<input onKeyUp={this.inputKey} onChange={this.handleUsername}/>
````

##### 表单事件

单选框

````
handleSex=(e)=>{
      this.setState({ sex:e.target.value })
}
<input type="radio" value="Man" checked={this.state.sex==='Man'} onChange={this.handleSex}/>男
<input type="radio" value="Woman" checked={this.state.sex==='Woman'} onChange={this.handleSex}/>女
````



### 8、事件监听

#### 事件监听on* 

React.js 帮我们封装好了一系列的 on* 的属性，从而不需要手动调用浏览器原生的 addEventListener 进行事件监听，也不需要考虑不同浏览器兼容性的问题。

只需要给需要监听事件的元素**加上类似于onClick、onKeyDown这样的属性，其属性值为一个表达式插入，表达式返回所监听的事件发生后要调用到的实例方法。**


没有经过特殊处理的话，这些 on* 的事件监听**只能用在普通的 HTML 的标签上，而不能用在组件标签上**。但也有办法可以做到这样的绑定。

#### event 对象

和普通浏览器一样，事件监听函数会被自动传入一个 event 对象，这个对象和普通的浏览器 event 对象所包含的方法和属性都基本一致。

不同的是 React.js 中的event对象并不是浏览器提供的，而是它自己内部所构建的。React.js 将浏览器原生的 event 对象封装了一下，对外提供统一的 API 和属性，这样你就不用考虑不同浏览器的兼容性问题。这个 event 对象是符合 W3C 标准（ W3C UI Events）的，它具有类似于event.stopPropagation、event.preventDefault 这种常用的方法。

#### 关于事件中的 this

一般在某个类的实例方法里面的 this 指的是这个实例本身。但是你在上面的 handleClickOnTitle 中把 this 打印出来，你会看到 this 是 null 或者 undefined。  
因为 **React.js 调用你所传给它的方法的时候，并不是通过对象方法的方式调用（this.handleClickOnTitle），而是直接通过函数调用（handleClickOnTitle）**，所以事件监听函数内并不能通过 this 获取到实例。

````
class Title extends Component {
  handleClickOnTitle (e) {
    console.log(this) // => null or undefined
  }

  render () {
    return (
      <h1 onClick={this.handleClickOnTitle}>React 小书</h1>
    )
  }
}
````

如果你想在事件函数当中使用当前的实例,需要绑定this实例到事件处理函数。  
方法一：bind

````
class Title extends Component {
  handleClickOnTitle (e) {
    console.log(this)
  }

  render () {
    return (
      <h1 onClick={this.handleClickOnTitle.bind(this)}>React 小书</h1>
    )
  }
}
````

方法二：构造函数中改变  

````
this.run = this.run.bind(this);

run(){
alert(this.state.name)
}
<button onClick={this.run>按钮</button>
````

方法三：ES6箭头函数(最常用)

````
run=()=> {
    alert(this.state.name)
}
<button onClick={this.run>按钮</button>
````

**给事件监听函数传入参数：**  

````
//bind(this,params1,params2,......)
<h1 onClick={this.handleClickOnTitle.bind(this, 'Hello')}>React 小书</h1>
````

### 9、state vs props



### 10、 配置组件的 props





### 10、state & setState

setState 方法由父类 Component 所提供。当我们调用这个函数的时候，React.js 会更新组件的状态 state ，并且重新调用 render 方法，然后再把 render 方法所渲染的最新的内容显示到页面上。

注意，当我们要改变组件的状态的时候，不能直接用 this.state = xxx 这种方式来修改，如果这样做 React.js 就没办法知道你修改了组件的状态，它也就没有办法更新页面。所以，一定要使用 React.js 提供的 setState 方法，它接受一个对象或者函数作为参数。

调用 setState 的时候，React.js 并不会马上修改 state。而是把这个对象放到一个更新队列里面，稍后才会从队列当中把新的状态提取出来合并到 state 当中，然后再触发组件更新。


````
handleClickOnLikeButton () {
    this.setState((prevState) => {
      return { count: 0 }
    })
    this.setState((prevState) => {
      return { count: prevState.count + 1 } // 上一个 setState 的返回是 count 为 0，当前返回 1
    })
    this.setState((prevState) => {
      return { count: prevState.count + 2 } // 上一个 setState 的返回是 count 为 1，当前返回 3
    })
    // 最后的结果是 this.state.count 为 3
}
````

这样就可以达到上述的利用上一次 setState 结果进行运算的效果。

#### setState的合并

上面代码中进行了三次setState，实际上组件只会重新渲染一次，而不是三次；但这操作的是同一个this.state.count，这是因为在 React.js 内部会把 JavaScript 事件循环中的消息队列的同一个消息中的setState都进行合并以后再重新渲染组件。

### 10、生命周期

#### 组件挂载

**组件的挂载**：React.js 将组件渲染(render方法)，并且构造 DOM 元素然后塞入页面的过程。

````
ReactDOM.render(
 <Header />, 
  document.getElementById('root')
)
````

会被编译为：

````
ReactDOM.render(
  React.createElement(Header, null), 
  document.getElementById('root')
)
````

实际上有如下几个步骤：

````
// React.createElement 中实例化一个 Header
const header = new Header(props, children)
// React.createElement 中调用 header.render 方法渲染组件的内容
const headerJsxObject = header.render()

// ReactDOM 用渲染后的 JavaScript 对象来来构建真正的 DOM 元素
const headerDOM = createDOMFromObject(headerJsxObject)
// ReactDOM 把 DOM 元素塞到页面上
document.getElementById('root').appendChild(headerDOM)
````

#### 组件生命周期

由上面说明组件的调用会经历：

````
-> constructor()//实例化
-> render()//渲染成JavaScript对象
// 构造成 DOM 元素并插入页面
````

为了更好的掌控组件的挂载过程，在挂载之前和之后分别加入了一个生命周期方法：

````
-> constructor()//实例化
-> componentWillMount()
-> render()//渲染成JavaScript对象
// 构造成 DOM 元素并插入页面
-> componentDidMount()
````

一个组件可以插入页面，当然也可以从页面中删除：

````
-> constructor()//实例化
-> componentWillMount()//组件将要挂载
-> render()//渲染成JavaScript对象
// 构造成 DOM 元素并插入页面
-> componentDidMount()//组件挂载后
-> componentWillUnmount()// 组件将要从页面删除
// 组件从页面中删除
````

除了挂载阶段还有“**更新阶段**”：  
**setState 导致 React.js 重新渲染组件并且把组件的变化应用到 DOM 元素上的过程，这是一个组件的变化过程。**

shouldComponentUpdate(nextProps, nextState)：你可以通过这个方法控制组件是否重新渲染。如果返回 false 组件就不会重新渲染。这个生命周期在 React.js 性能优化上非常有用。

componentWillReceiveProps(nextProps)：组件从父组件接收到新的 props 之前调用。

componentWillUpdate()：组件开始重新渲染之前调用。

componentDidUpdate()：组件重新渲染并且把更改变更到真实的 DOM 以后调用。

#### 组件生命周期方法的作用  

**constructor()：**  
一般来说，所有关于**组件自身的状态的初始化**工作都会放在 constructor() 里面去做。

**componentWillMount():**  
组件启动的动作，包括像 Ajax **数据的拉取**操作、一些**定时器的启动**等;

**componentDidMount():**  
一般来说，有些组件的启动工作是依赖 DOM 的，例如**动画的启动**，而 componentWillMount 的时候组件还没挂载完成，所以没法进行这些启动工作，这时候就可以把这些操作放在 componentDidMount 当中。

**componentWillUnmount():**  
在组件销毁的时候，做清场的工作。如**清除组件的定时器**和其他的**数据清理**工作;



### 11、父子组件之间传值

**父子组件**：组件的相互调用中，我们把调用者称为父组件，被调用者称为**子组件**

#### 父组件传值给子组件

在调用子组件的时候定义一个属性，这个属性会存在子组件props对象中。类似于实例化子组件时，给构造函数传参。子组件里面通过 this.props.msg 使用。  

说明：父组件不仅可以给子组件传值，还可以给子组件传方法,以及把整个父组件传给子组件。

````
<Header msg='首页'></Header>  
````

#### 子组件传值给父组件

**React.js是单向数据流的设计**，也就是说只有父组件传数据给子组件这回事。那么子组件传值给父组件，只能采用一种**函数回调**的迂回作法：

在**父组件中设置了一个方法(函数)，然后把这个方法传递给子组件的props**，子组件调用props中的这个方法(函数)。但这中间，this要对应，不然不会正常作用。

但上面这种方法只适用于简单的组件结构，因为它相当麻烦，而且不灵活。如果要作到组件与子组件或者兄弟组件数据传递，一般使用flux或redux来解决。 
**父组件：**

````
import React, { Component } from 'react';
import Child from "./Child";

export default class Parent extends Component {
    constructor(props) {
        super(props);
        this.state = {
            
        }
    }
    
    //父组件传给子组件的回调函数
    handleChildData(comment) {
        console.log(comment)//获取到的子组件数据
    }

    render() {
        return (
            <div className="wrapper">
                <Child onSubmit={this.handleChildData.bind(this)} />
            </div>
        )
    }
}
````

**子组件：**

````
import React, { Component } from 'react';
import "./index.css";

export default class Child extends Component {
    constructor(props) {
        super(props);
        this.state = {
            data1: '我是子组件的数据1',
            data2: '我是子组件的数据2'
        }
    }

    handleSubmit() {
        if (this.props.onSubmit) {
            const { data1, data2 } = this.state;//ES6解构赋值
            this.props.onSubmit({ data1, data2 });//调用父组件方法，传递数据，可以传递对象包含多个数据
        }
    }

    render() {
        return (
            <button onClick={this.handleSubmit.bind(this)}>>
                传值
            </button>
        )
    }
}
````





### 12、高阶组件

**高阶组件就是一个函数，传给它一个组件，它返回一个新的组件。**



### 13、组件编码规范

#### 方法命名规范

组件的私有方法都用 _ 开头  
事件监听的方法都用 handle 开头  
把事件监听方法传给组件的时候，属性名用 on 开头。   
例如：

````
<CommentInput onSubmit={this.handleSubmitComment.bind(this)} />
````

这样统一规范处理事件命名会给我们带来语义化组件的好处，监听（on）CommentInput 的 Submit 事件，并且交给 this 去处理（handle）。这种规范在多人协作的时候也会非常方便。

#### 组件的内容编写顺序如下：

static 开头的类属性，如 defaultProps、propTypes。  
构造函数，constructor。  
getter/setter（还不了解的同学可以暂时忽略）。  
组件生命周期。  
_ 开头的私有方法。  
事件监听方法，handle*。  
render*开头的方法，有时候render()方法里面的内容会分开到不同函数里面进行，这些函数都以 render* 开头。  
render() 方法。  
如果所有的组件都按这种顺序来编写，那么维护起来就会方便很多，多人协作的时候别人理解代码也会一目了然。

### 14、组件参数验证

**组件库名以前为PropTypes现已弃用改为prop-types**

##### 1、安装依赖包

````
npm install --save prop-types
````

##### 2、使用  (如父组件传入参数跟验证类型不符，浏览器f12会警告提示)

````
import React, { Component } from 'react';
import PropTypes from 'prop-types';//1、引入prop-types组件库

class Comment extends Component {
    //方式一：
    static propTypes = {//2、给组件添加propTypes属性
        comment: PropTypes.object//3、设置传入comment值类型为object
    }

    render() {
        const { comment } = this.props
        return (
            <div className='comment'>
                <div className='comment-user'>
                    <span>{comment.username} </span>：
                </div>
                <p>{comment.content}</p>
            </div>
        )
    }
}

//方式二：官方推荐
//Comment.propTypes = {//2、给组件添加propTypes属性
//    comment: PropTypes.object//3、设置传入comment值类型为object
//}

export default Comment;
````

##### 3、提供的验证类型

````
PropTypes.array
PropTypes.bool
PropTypes.func
PropTypes.number
PropTypes.object
PropTypes.string
PropTypes.node
PropTypes.element
......
````

##### 4、更多使用方式





### 6、状态提升

当某个状态被多个组件依赖或者影响的时候，就把该状态提升到这些组件的最近公共父组件中去管理，用 props 传递数据或者函数来管理这种依赖或着影响的行为。


这种无限制的提升不是一个好的解决方案。一旦发生了提升，你就需要修改原来保存这个状态的组件的代码，也要把整个数据传递路径经过的组件都修改一遍，好让数据能够一层层地传递下去。这样对代码的组织管理维护带来很大的问题。到这里你可以抽象一下问题：


如何更好的管理这种被多个组件所依赖或影响的状态？

你可以看到 React.js 并没有提供好的解决方案来管理这种组件之间的共享状态。在实际项目当中状态提升并不是一个好的解决方案，所以我们后续会引入 Redux 这样的状态管理工具来帮助我们来管理这种共享状态，但是在讲解到 Redux 之前，我们暂时采取状态提升的方式来进行管理。

对于不会被多个组件依赖和影响的状态（例如某种下拉菜单的展开和收起状态），一般来说只需要保存在组件内部即可，不需要做提升或者特殊的管理。



### 10、Ref 和 Dom 操作

在 React.js 当中你基本不需要和 DOM 直接打交道。它提供了一系列的 on* 方法进行事件监听；以前通过手动 DOM 操作进行页面更新（例如借助 jQuery），而在 React.js 当中可以直接通过 setState 的方式重新渲染组件，从而达到页面更新的效果。

但有些时候还是需要和 DOM 打交道。比如进入页面以后自动 focus 到某个输入框，需要调用 input.focus() 的 DOM API，动态获取某个 DOM 元素的尺寸来做后续的动画等等。

**React.js 当中提供了ref属性,属性值是一个回调函数,这个回调函数的参数为指定的DOM元素自身或者挂载的组件实例，在组件挂载完成以后或者卸载的时候被调用。**

#### 为DOM元素添加Ref

````
class AutoFocusInput extends Component {
  componentDidMount () {
    this.input.focus()
  }

  render () {
    return (
      <input ref={(input) => this.input = input} />//参数为input自身
    )
  }
}
````

**注意：** 
1、**在组件中使用ref时要求组件必须是class声明的**，而不能在函数式声明组件中使用ref，因为他们不存在实例。 
2、ref遗留的问题：以前的ref属性获取到的是字符串，而DOM节点通过this.refs.textInput来获取。但是因为string类型的ref有一定的问题，在以后的react版本中将会被移除，建使用回调函数来替代。 
3、**能不用 ref 就不用**。特别是要避免用 ref 来做 React.js 本来就可以做到的页面自动更新的操作和事件监听。



### 11、dangerouslySetHTML 和 style 属性





### 12、props.children 和容器类组件





## 5、请求

### 使用axios

**详细使用方法可通过www.npmjs.com查看该模块文档**

````
//安装axios模块
npm install axios --save

//引入axios模块
import Axios form 'axios';
````

##### 1、Performing a GET request

````
// Make a request for a user with a given ID
axios.get('/user?ID=12345')
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
 
// Optionally the request above could also be done as
axios.get('/user', {
    params: {
      ID: 12345
    }
  })
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
````

##### 2、Performing a POST request

````
axios.post('/user', {
    firstName: 'Fred',
    lastName: 'Flintstone'
  })
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
````

##### 3、Performing multiple concurrent requests

````
function getUserAccount() {
  return axios.get('/user/12345');
}
 
function getUserPermissions() {
  return axios.get('/user/12345/permissions');
}
 
axios.all([getUserAccount(), getUserPermissions()])
  .then(axios.spread(function (acct, perms) {
    // Both requests are now complete
  }));
````

### 使用fetch-jsonp









## 6、组件通信

### 父子组件通信



### 发布订阅



## 7、Redux

### 7.1 React 的 Context

**React.js 的 context**：某个组件只要往自己的context里面放了某些状态，这个组件之下的所有子组件都直接访问这个状态而不需要通过中间组件的传递。且只有它的子组件能够访问，它的父组件是不能访问，可以理解每个组件的 context 就是瀑布的源头只能往下流不能往上飞。

````
//父组件
class Index extends Component {
  static childContextTypes = {//3、为getChildContext方法返回给子组件的状态添加类型验证（必写，因为 context 是一个危险的特性，React.js团队想把危险的事情搞复杂一些，提高使用门槛以致不会被滥用）
    themeColor: PropTypes.string
  }
  
  constructor () {
    super()
    this.state = { 
      themeColor: 'red' //1、在父组件中设置要存到context的状态
    }
  }

  getChildContext () {//2、使用getChildContext方法将状态return给子组件的context
    return { themeColor: this.state.themeColor }
  }

  render () {
    return (
      <div>
        <Title />
        <Content />
      </div>
    )
  }
}
//子组件1：Title
class Title extends Component {
  static contextTypes = {//4、子组件中使用contextTypes来声明和验证需要获取的状态的类型
    themeColor: PropTypes.string
  }
  render () {
    return (
      //5、使用this.context.xxx来使用context中的状态
      <h1 style={{ color: this.context.themeColor }}>React.js 小书标题</h1>
    )
  }
}
//子组件2：Content
class Content extends Component {
  render () {
    return (
    <div>
      <h2>React.js 小书内容</h2>
    </div>
    )
  }
}
````





**Redux** 是一种架构模式（Flux架构的一种变种），它不关注你到底用什么库，你可以把它应用到 React 和 Vue，甚至跟 jQuery 结合都没有问题。  
**React-redux** 是把 Redux 这种架构模式和 React.js 结合起来的一个库，就是 Redux 架构在 React.js 中的体现。

### 7.2 动手实现Redux

一个可以被不同模块任意修改共享的数据状态就是魔鬼，一旦数据可以任意修改，所有对共享状态的操作都是不可预料的（某个模块 appState.title = null 你一点意见都没有），出现问题的时候 debug 起来就非常困难，这就是老生常谈的尽量避免全局变量。  
矛盾就是：**“模块（组件）之间需要共享数据”，和“数据可能被任意修改导致不可预料的结果”之间的矛盾。**


**纯函数**：函数的返回结果只依赖于它的参数，并且在执行过程里面没有副作用。
副作用：函数执行过程对产生的外部可观察的变化，如修改外部的变量，调用 DOM API 修改页面，发送 Ajax 请求，调用 window.reload 刷新浏览器，甚至是 console.log 往控制台打印数据。  
纯函数很严格，几乎除了计算数据以外什么都不能干，还不能依赖除了函数参数以外的数据。  
作用：纯函数非常“靠谱”，不会产生不可预料的行为，也不会对外部产生影响。如果应用程序大多数函数都是由纯函数组成，那么程序测试、调试起来会非常方便。

````
function createStore (state, stateChanger) {
  const listeners = []
  const subscribe = (listener) => listeners.push(listener)
  const getState = () => state
  const dispatch = (action) => {
    state = stateChanger(state, action) // 覆盖原对象
    listeners.forEach((listener) => listener())
  }
  return { getState, dispatch, subscribe }
}

function renderApp (newAppState, oldAppState = {}) { // 防止 oldAppState 没有传入，所以加了默认参数 oldAppState = {}
  if (newAppState === oldAppState) return // 数据没有变化就不渲染了
  console.log('render app...')
  renderTitle(newAppState.title, oldAppState.title)
  renderContent(newAppState.content, oldAppState.content)
}

function renderTitle (newTitle, oldTitle = {}) {
  if (newTitle === oldTitle) return // 数据没有变化就不渲染了
  console.log('render title...')
  const titleDOM = document.getElementById('title')
  titleDOM.innerHTML = newTitle.text
  titleDOM.style.color = newTitle.color
}

function renderContent (newContent, oldContent = {}) {
  if (newContent === oldContent) return // 数据没有变化就不渲染了
  console.log('render content...')
  const contentDOM = document.getElementById('content')
  contentDOM.innerHTML = newContent.text
  contentDOM.style.color = newContent.color
}

let appState = {
  title: {
    text: 'React.js 小书',
    color: 'red',
  },
  content: {
    text: 'React.js 小书内容',
    color: 'blue'
  }
}

function stateChanger (state, action) {
  switch (action.type) {
    case 'UPDATE_TITLE_TEXT':
      return { // 构建新的对象并且返回
        ...state,
        title: {
          ...state.title,
          text: action.text
        }
      }
    case 'UPDATE_TITLE_COLOR':
      return { // 构建新的对象并且返回
        ...state,
        title: {
          ...state.title,
          color: action.color
        }
      }
    default:
      return state // 没有修改，返回原来的对象
  }
}

const store = createStore(appState, stateChanger)
let oldState = store.getState() // 缓存旧的 state
store.subscribe(() => {
  const newState = store.getState() // 数据可能变化，获取新的 state
  renderApp(newState, oldState) // 把新旧的 state 传进去渲染
  oldState = newState // 渲染完以后，新的 newState 变成了旧的 oldState，等待下一次数据变化重新渲染
})

renderApp(store.getState()) // 首次渲染页面
store.dispatch({ type: 'UPDATE_TITLE_TEXT', text: '《React.js 小书》' }) // 修改标题文本
store.dispatch({ type: 'UPDATE_TITLE_COLOR', color: 'blue' }) // 修改标题颜色
````

### 7.3 Redux使用







## 8、Mobx





## 9、路由

 react路由的配置：
    1、找到官方文档 https://reacttraining.com/react-router/web/example/basic

    2、安装  cnpm install react-router-dom --save


    3、找到项目的根组件引入react-router-dom
    
       import { BrowserRouter as Router, Route, Link } from "react-router-dom";
    
    4、复制官网文档根组件里面的内容进行修改  （加载的组件要提前引入）


         <Router>
    
                <Link to="/">首页</Link>
    
                <Link to="/news">新闻</Link>
    
                <Link to="/product">商品</Link>


               <Route exact path="/" component={Home} />
               <Route path="/news" component={News} />    
               <Route path="/product" component={Product} />   
         </Router>


         exact表示严格匹配

*/



import React, { Component } from 'react';

import { BrowserRouter as Router, Route, Link } from "react-router-dom";


import './assets/css/index.css'

import Home from './components/Home';
import News from './components/News';
import Product from './components/Product';

class App extends Component {

  render() {
    return (
        <Router>
          <div>           

              <header className="title">
              
                <Link to="/">首页</Link>
    
                <Link to="/news">新闻</Link>
    
                <Link to="/product">商品</Link>
    
              </header>


               <br />
               <hr />
      
               <br />


​      

              <Route exact path="/" component={Home} />
              <Route path="/news" component={News} />    
              <Route path="/product" component={Product} />                 
          </div>
      </Router>
    );

  }
}

export default App;





## 9、ant-design

### 9.1 基本使用



### 9.2 按需引入

- 安装依赖

  ```bash
  $ yarn add react-app-rewired customize-cra babel-plugin-import less less-loader
  ```

- 修改package.json

  ```json
  ....
  "scripts": {
    "start": "react-app-rewired start",
    "build": "react-app-rewired build",
    "test": "react-app-rewired test",
    "eject": "react-scripts eject"
  },
  ....
  ```

- 根目录下创建config-overrides.js

  ```javascript
  //配置具体的修改规则
  const { override, fixBabelImports,addLessLoader} = require('customize-cra');
  module.exports = override(
    fixBabelImports('import', {
      libraryName: 'antd',
      libraryDirectory: 'es',
      style: true,
    }),
    addLessLoader({
      lessOptions:{
        javascriptEnabled: true,
        modifyVars: { '@primary-color': 'green' },
      }
    }),
  );
  ```

- 备注：不用在组件里亲自引入样式了，即：import 'antd/dist/antd.css'应该删掉











