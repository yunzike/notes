## 1、介绍

### 1.1 Vue

- MVVM思想

  M：即Model，模型，包括数据和一些基本操作，如 Vue 中的 data 。
  V：即view，视图，页面渲染结果。
  VM：即 View-Model，模型与视图间的双向操作（无需开发人员干涉），如 Vue 实例。

  ![image-20200628013207740](../images/image-20200628013207740.png)

  

  在 MVVM 之前，开发人员从后端获取需要的数据模型，然后要通过 DOM 操作 Model 渲染到 View 中。而后当用户操作视图，我们还需要通过 DOM 获取 View 中的数据，然后同步到 Model 中。
  
  而 MVVM 中的 VM 要做的事情就是把 DOM 操作完全封装起来，开发人员不用再关心  Model 和 View 之间是如何互相影响的：
  只要我们 Model 发生了改变，View 上自然就会表现出来。当用户修改了 View，Model 中的数据也会跟着改变。把开发人员从繁琐的DOM操作中解放出来，把关注点放在如何操作Model上。



- Vue简介

  Vue（读音/vju:/，类似于vew）是一套用于构建用户界面的渐进式框架。与其它大型框架不同的是，Vue被设计为可以自底向上逐层应用。vue的核心库只关注视图层，不仅易于上手，还便于与第三方库或既有项目整合。另一方面，当与现代化的工具链以及各种支持类库结合使用时，vue也完全能够为复杂的单页应用提供驱动。

  官网：https://cn.vuejs.or
  参考：https://cn.vuejs.org/v2/guide/ 
  Git 地址：htts:github.com/ues
  尤雨溪，Vue.js创作者， Vue Technology创始人，致力于Vue的研究开发。

### 1.2 Vue 3.0

- Vue 3.0 One Piece

  2020 年 9 月 18 日发布正式版。

- 官网地址

  

- 新特性

  性能提升 1.3 ~ 2x

  与 Vue 2.x 相比，mount 50% 提升，内存占用小 120%

  核心代码 + Composition API : 13.5 kb , 最小 11.75 kb

  所有 Runtime：22.5 kb（Vue 2 是 32 kb）

  

## 2、构建 Vue 项目

### 2.1 环境搭建

- 安装 node.js 并配置淘宝镜像源

- 安装 vue-cli 脚手架

  ```bash
  $ npm install -g @vue/cli
  
  # 查看 vue/cli 版本
  vue --version
  
  # vue-cli 图形管理工具
  $ vue ui
  ```

### 2.2  创建 Vue 项目

- 方式一：使用 vue/cli 创建项目

  ```bash
  $ vue create todo-app
  
  # 运行
  $ cd todo-app
  $ npm run serve
  
  # 浏览器上安装 Vue Devtools 插件方便调试
  ```

- 方式二：使用 Vite 构建项目

  Vue 3 + TypeScript + Vite

  ```bash
  $ npm init @vitejs/app
  ```

### 2.3 Vue 项目结构

![image-20210520004849555](../images/image-20210520004849555.png)

- node_modules：项目的依赖包
- public：index.html（整个项目根组件的挂载点）
- src/assets：静态文件
- src/components：自定义组件
- src/App.vue：整个 Vue 项目的入口，根组件 App
- src/main.js：引入根组件 App，并将其挂载到 public/index.html 上
- package.json：依赖引入管理

### 2.4 Vue 文件结构

- 模板

  ```html
  <template>
    <img alt="Vue logo" src="./assets/logo.png">
    <HelloWorld msg="Welcome to Your Vue.js App"/>
  </template>
  ```

- 脚本

  ```html
  <script>
  import HelloWorld from './components/HelloWorld.vue'
  
  export default {
    name: 'App',
    components: {
      HelloWorld
    }
  }
  </script>
  ```

- 样式

  ```html
  <style>
  #app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
  }
  </style>
  ```



## 3、Vue 基本语法

### 3.1 Vue 实例

- Vue 2.X

  ```html
  <!DOCTYPE html>
  <html>
  <head>
      <meta charset="UTF-8">
      <!-- 以 CDN 包的形式导入 Vue.js -->
      <script src="https://cdn.jsdelivr.net/npm/vue@2.6.14"></script>
      <title>Vue Demo</title>
  </head>
  
  <body>
      <div id="app">
          <!-- 插值表达式使用 Vue 数据 -->
          <p>你好 {{message}}</p>
          <button v-on:click="test">点击</button>
      </div>
  
      <script>
          // 创建一个 Vue 实例，并传入配置对象
          new Vue({
              // el 挂载点，指定Vue实例的作用对象
              // 不能用在html和body上，一般使用id选择器。
              el: "#app",
              // Vue 实例数据
              data: {
                  message: "hello Vue!"
              },
              // Vue 实例方法
              methods: {
                  test: function () {
                      alert("你好");
                  }
              }
          })
      </script>
  </body>
  </html>
  ```

  data 与 el 的 2 种写法:
  1. el 有 2 种写法:
  (1) new Vue 时候直接传递 e1属性（常用）
  (2) 先new Vue 再通过 vm.$mount( ' #root' ) 指定 el 属性 (不常用)
  2. data 有 2 种写法
  (1)对象式：非组件化编码时可以写对象，也可以写函数。
  (2).函数式：组件化编码必须使用函数式的 data 。

- Vue 3.X

  ```html
  
  ```

### 3.2 插值表达式

> 用于解析**标签体**中的内容

- 格式：{{ 表达式 }}

  说明：该表达式必须有返回结果，支持 Js 语法，可以调用 Js 内置函数。可以直接获取 Vue实例中定义的数据或函数。

- 插值闪烁

  使用 {{}} 方式在网速较慢时可能会出现问题。在数据未加载完成时，页面会显示出原始的{{}}，加载完毕后才显示正确数据，我们称为插值闪烁。

### 3.3 Vue 指令

> 用于解析**标签属性**、**标签内容**、**绑定事件**等

#### v-bind（:）

用于绑定变量到属性，可以简写为 `：`

```html
<div id="root">
  <a v-bind:href="link">url为Vue中的数据</a>
	<a :href="link">url为Vue中的数据</a>
  
  <div :style="{ color: activeColor, fontSize: size }">你好</div>
</div>
<script>
	new Vue({
    el:"#root",
    data:{
      link:"http://www.baidu.com/",
      activeColor: 'red',
      size: '30px'   
    }
  })
</script>
```

#### v-model

用于双向数据绑定，只能用于输入类的元素

```html
<!-- 还可以省略 :value ,只写 v-model ，会自动绑定 value 属性  -->
<input id="username" type="text" v-model:value="name"/>
<script>
	new Vue({
    el:"#username",
    data:{
      name:"张三"
    }
  })
</script>
```

- **单向数据绑定 & 双向数据绑定**

  将 Vue 实例 data 中的变量绑定到页面表单项。

  **单向数据绑定**：data 中变量值的改变会驱动页面表单项的数据改变，而表单项数据的修改不能引起 data 中变量值的改变；如使用 v:bind 绑定。

  **双向数据绑定**： data 中变量的修改会使得表单项数据的改变，同时表单项数据的修改也会使得 data 中变量值的改变。使用 v:model 绑定。

- **React 数据是单向绑定的**

  想要实现数据的双向绑定，必须借助 onChange 事件监听表单项中数据的修改，从而再手动修改 state 中的变量，使得表单项成为受控组件。

- **数据代理**

  关于Vue中的数据代理:
  1.什么是数据代理?
  (1).配置对象data中的数据，会被收集到vm._ data中， 然后通过，Object . defineProperty i让:vm上拥有data中所有的局
  (2).当访间vm的msg时，返回的是_ data 当中同名属性的值
  (3).当修改vm的msg时，修改的是_ data 当中同名属性的值
  2.为什么要数据代理?
  为了更加方便的读取和修改_ data中的数据，不做数据代理，就要: vm.. xx访间数据
  3.扩展思考? -为什么要先收集在data中， 然后再代理出去呢?
  更高效的监视数据(直接收集到vm上会导致监视效率太低)

#### v-text & v-html

v-html 将数据渲染成原始html

```html
<span v-html="rawHtml"></span>
```

#### 5、v-once：一次性插值

```html
<span v-once>这个将不会改变: {{ msg }}</span>
```

#### v-on（@）

接收方法，用于绑定事件，可以简写为@

```html
<div id="app">
	<a v-on:click="doIt">点击</a>
	<a @click="doIt">点击</a>
</div>

<script>
    var vm = new Vue({
        el:"app",
        data:{
            
        },
        methods:{
            doIt: function (){
                alert("绑定点击事件");
            }
        }
    })
</script>
```

#### 7、v-show & v-if

v-show：根据表达式的真假来显示元素，底层修改的是display属性

```html
<p v-show="seen">seen的值为true时显示</p>
```

v-if：根据表达式值的真假来插入/移除指定元素，因为操作了DOM，性能消耗比较大，因此一般使用v-show。

```html
<p v-if="seen">seen的值为true时显示</p>
```

#### 8、v-for

遍历数组、对象

```html
<ul id="example-1">
  <!-- 需要使用数组下标时：(item,index) in items -->
  <li v-for="item in items">
    {{ item.message }}
  </li>
</ul>

<script>
    var example1 = new Vue({
      el: '#example-1', 
      data: {
        items: [
          { message: 'Foo' },
          { message: 'Bar' }
        ]
      }
    })
</script>
```

### 3.4 自定义指令



### 3.5 计算属性

//计算属性 类似于data概念
computed: {}

### 3.6 监视属性

//监视data中的数据变化
watch: {}

### 3.6 过滤器





## 4、生命周期

![生命周期](../images/%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F.png)

常用的生命周期钩子：
      1.mounted: 发送ajax请求、启动定时器、绑定自定义事件、订阅消息等【初始化操作】。
      2.beforeDestroy: 清除定时器、解绑自定义事件、取消订阅消息等【收尾工作】。

关于销毁Vue实例
      1.销毁后借助Vue开发者工具看不到任何信息。
      2.销毁后自定义事件会失效，但原生DOM事件依然有效。
      3.一般不会在beforeDestroy操作数据，因为即便操作数据，也不会再触发更新流程了。

```javascript
//生命周期 - 创建完成（可以访问当前this实例）
created() {},
//生命周期 - 挂载完成（可以访问DOM元素）
mounted() {},
beforeCreate() {}, //生命周期 - 创建之前
beforeMount() {}, //生命周期 - 挂载之前
beforeUpdate() {}, //生命周期 - 更新之前
updated() {}, //生命周期 - 更新之后
beforeDestroy() {}, //生命周期 - 销毁之前
destroyed() {}, //生命周期 - 销毁完成
activated() {}, //如果页面有keep-alive缓存功能，这个函数会触发
```



## 5、组件



## 6、父子组件传值

- 父组件 Parent

  ```vue
  <template>
    <div>
      <h3>我是父组件:</h3>
      <div>父组件number值:{{ number }}</div>
  
      <br/><br/><br/><br/>
  
      <!--子组件-->
      <!-- 给子组件传入父组件数据：parentData , 父组件方法：editNuber -->
      <Child :parentData="parentData" @editNumber="editNumber"> </Child>
    </div>
  </template>
  
  <script>
  import Child from "./Child.vue";
  
  export default {
    name: "Parent",
    components: {
      Child,
    },
    data() {
      return {
        parentData: "父组件数据",
        number: 0,
      };
    },
    methods: {
      editNumber(index) {
        console.log("子组件传值：", index);
        this.number = this.number + index;
      },
    },
  };
  </script>
  
  <style scoped></style>
  ```

- 子组件 Child

  ```vue
  <template>
    <div>
      <h3>我是子组件：</h3>
      <div>{{ parentData }}</div>
  
      <!--绑定要求改变父组件值的事件-->
      <button type="primary" @click="change">
        点我改变父组件的值
      </button>
    </div>
  </template>
  
  <script>
  export default {
    name: "Child",
    components: {},
  
    //接收父组件数据
    props: {
      parentData: {
        type: String,
        default: "",
      },
    },
    
    // 接受父组件数据方式二：
    // props: ["parentData"],
    
    data() {
      return {};
    },
    methods: {
      change() {
        console.log("调用子组件 change 方法");
        // 回调父组件方法 editNumber 修改父组件中的数据
        this.$emit("editNumber", 1);
      },
    },
  };
  </script>
  
  <style scoped></style>
  ```



## 7、axious

请求





## 8、vue脚手架配置代理

### 方法一

####  在vue.config.js中添加如下配置：

```javascript
devServer:{
  proxy:"http://localhost:5000"
}
```

#### 说明：

- 优点：配置简单，请求资源时直接发给前端（8080）即可。
- 缺点：不能配置多个代理，不能灵活的控制请求是否走代理。
- 工作方式：若按照上述配置代理，当请求了前端不存在的资源时，那么该请求会转发给服务器 （优先匹配前端资源）

### 方法二

####  编写vue.config.js配置具体代理规则：

```javascript
module.exports = {
	devServer: {
      proxy: {
      '/api1': {// 匹配所有以 '/api1'开头的请求路径
        target: 'http://localhost:5000',// 代理目标的基础路径
        changeOrigin: true,
        pathRewrite: {'^/api1': ''}
      },
      '/api2': {// 匹配所有以 '/api2'开头的请求路径
        target: 'http://localhost:5001',// 代理目标的基础路径
        changeOrigin: true,
        pathRewrite: {'^/api2': ''}
      }
    }
  }
}
/*
   changeOrigin设置为true时，服务器收到的请求头中的host为：localhost:5000
   changeOrigin设置为false时，服务器收到的请求头中的host为：localhost:8080
   changeOrigin默认值为true
*/
```

#### 说明：

- 优点：可以配置多个代理，且可以灵活的控制请求是否走代理。
- 缺点：配置略微繁琐，请求资源时必须加前缀。



## 9、Vue-router

路由



## 9、Vuex





## 10、Mobx

数据管理



## 10、Element-UI

第三方组件库



## 11、Echarts

图表



























