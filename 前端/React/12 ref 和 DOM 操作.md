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