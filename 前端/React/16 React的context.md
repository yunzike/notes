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