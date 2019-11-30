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