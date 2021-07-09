## 1、介绍





## 2、构建 React 项目

### 2.1 环境搭建

1、官网下载安装Node.js
命令行查看是否安装成功
node -v
查看npm是否安装成功
npm -v

2、通过 npm 使用 React

国内使用 npm 速度很慢，设置淘宝定制的 cnpm (gzip 压缩支持) 命令行工具代替默认的 npm。

```
$ npm install -g cnpm --registry=https://registry.npm.taobao.org
$ npm config set registry https://registry.npm.taobao.org
```

全局安装create-react-app模块

```
$ cnpm install -g create-react-app（使用npm则为npm install -g create-react-app）
```

创建项目

```
$ create-react-app my-app
```

运行项目
进入项目路径

```
$ cd my-app/
```

运行

```
$ npm start
```

自动在浏览器中运行http://localhost:3000/ ，显示默认React页面




1.下载最新的nodejs，可以选择nodejs官网的任何一个
  https://nodejs.org/en/
2.通过Win+R进入cmd黑色窗口，假设是第一次创建react工程
   在cmd中查看自己安装的nodejs版本，以及npm版本（安装nodejs的时候包含npm），在cmd中输入
 node -v    --->v8.11.1   注意：node 版本>6
 npm  -v    --->5.6.0       注意：npm版本>3
3.创建全局react，在cmd中输入下列命令行 
   在执行命令之前，先进入node.js的安装目录，然后才可以进行安装react工程.
   npm install -g create-react-app 按回车
  执行结果：

4.然后进入你想创建工程的比如D盘，创建工程名，创建react-basic基础包

进入d盘之后，创建文件夹

完文件夹之后，进入文件夹projects,创建工程名称。
然后输入create-react-app react-basic执行命令，下载脚手架，
出现下面结果，说明执行成功

5.进入react-basic，启动npm

执行完上名命令行，便会自动打开一个本地服务的react页面

打包项目
npm run build 



### 2.2 React 项目结构

![React项目总目录结构](../images/006tNbRwgy1fxv3ha7r97j30m207y0td.jpg?lastModify=1625846474)![React项目总目录结构](../images/006tNbRwgy1fxv3ha7r97j30m207y0td-20191130224134657.jpg?lastModify=1625846474)

#### 1、package.json 定义项目所需模块及配置信息

![img](../images/006tNbRwgy1fxv3j184d8j30d60kywfl.jpg?lastModify=1625846474)![img](../images/006tNbRwgy1fxv3j184d8j30d60kywfl-20191130224147563.jpg?lastModify=1625846474)

#### 2、public文件夹

![img](../images/006tNbRwgy1fxv3js69x5j30n4050dg4.jpg?lastModify=1625846474)![img](../images/006tNbRwgy1fxv3js69x5j30n4050dg4-20191130224201307.jpg?lastModify=1625846474)

1)favicon.ico

是浏览器tab上图标，也是这个项目的一个标志，也可以说是代表一个公司的标志。可以替换。

2)index.html

项目的入口文件，引用了第三方类库啊，还可以引入cdn



是项目的总容器，所有的内容存储在这个容器中。这个容器有且只能有一个。



3)manifest.json

允许将站点添加至主屏幕，是 PWA 提供的一项重要功能，当前 manifest.json 的标准仍属于草案阶段，Chrome 和 Firefox 已经实现了这个功能，微软正努力在 Edge 浏览器上实现，Apple 目前仍在考虑中

#### 3、src文件夹

![img](../images/006tNbRwgy1fxv3nyp4mnj30o008fwfc.jpg?lastModify=1625846474)![img](../images/006tNbRwgy1fxv3nyp4mnj30o008fwfc-20191130224212969.jpg?lastModify=1625846474)

1).index.js

存放的是这个项目的核心内容，也就是我们的主要工作区域。

其中，index.js文件是和index.html进行关联的文件的唯一接口。

能够引用<App />的原因是文档内容的头部，有import App from './App';内容，就是为了将App.js的内容引入到index.js文件中。

2).App.js

该类是继承react提供的component，export default App;是为了将App公开，index.js才能够引用。App.js继承了component的话，必须使用render进行渲染。return的内容是模板，类似于html结构的内容，就是jsx，jsx语法是react的主要语法。在这个文件中，只能用一个div容器，如果在div的同级目录添加别的内容，便会报错。

className="App"，是引用到App.css的样式。注意，页面内容样式是就近原则，首先用App.css的样式，App.css是组件的样式，index.css是全局的样式。

内容渲染的方式有两种，jsx语法(上面默认的内容)和React.createElement的方法。

#### 4、node_modules文件夹

包管理工具下载安装了的包，比如webpack、gulp、grunt这些工具



## 3、基础语法

### 4、JSX---描述UI信息

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

### 5、数据处理

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



### 6、双向数据绑定实现

双向数据绑定：model改变影响view，view改变影响model

#### 约束性组件和非约束性组件

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



### 7、事件对象

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

### 9、state & setState

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



## 4、组件封装

#### 1、新建组件目录文件并配置github和npm

````
//新建组件目录并初始化git
mkdir mycomponent
cd mycomponet
git init

//新建github仓库并将远程仓库关联至本地仓库
...

//登录npm账号并配置npm
npm login
...
npm init

//配置信息
name: (component-lib)
version: (1.0.0) 0.1.0
description: an example component library built with React!
entry point: (index.js) build/index.js
test command:
git repository:
keywords:
license: (ISC)
About to write to /Users/alanbsmith/personal-projects/trash/package.json:

{
  "name": "component-lib",
  "version": "0.1.0",
  "description": "an example component library built with React!",
  "main": "build/index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "Alan Smith <[alan.smith@example.com](mailto:a.bax.smith@gmail.com)> ([https://github.com/alanbsmith](https://github.com/alanbsmith))",
  "license": "ISC"
}

Is this ok? (yes)
````

#### 2、添加目录和文件




安装依赖包  

````
 "devDependencies": {
   "babel-cli": "^6.0.0",
   "babel-core": "^6.14.0",
   "babel-loader": "^6.2.5",
   "babel-plugin-istanbul": "^2.0.1",
   "babel-preset-es2015": "^6.14.0",
   "babel-preset-react": "^6.24.1",
   "react": "^15.6.1",
   "react-dom": "^15.6.1"
}
````





## 5、Redux





## 6、路由











