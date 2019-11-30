## 一、概述

- DOM
  
  DOM（Document Object Model），即文本对象模型。DOM把一个文档表示为一棵节点树。

- HTML节点分类
  
  ① 元素节点
  
  ② 属性节点
  
  元素的属性，可以直接通过属性的方式来操作。
  
  ③ 文本节点
  
  元素节点的子节点，其内容是文本。

## 二、DOM基本操作

#### 1、JS代码编写的位置

- 方式一：直接在HTML页面中编写
  
  ① js和html强耦合，不利于代码的维护
  
  ② 当js代码比如函数，较复杂时，需要先定义，然后再引用，比较麻烦。
  
  ```html
  <button id="button" onclick="alert('hello world');">Click Me!</button>
  ```

- 方式二：在head的script标签中直接编写
  
  一般不能再body节点之前来直接获取body内的节点，因为此时html文档树还没有加载完成，获取不到指定的节点。
  
  ```html
  <head>
      ...
      <script type="text/javascript">
          var cityNode = document.getElementById("city");
          //打印为null
          alert(cityNode);
      </script>
  </head>
  ```

- 方式三：在整个html文档的最后编写js代码
  
  不符合习惯

- 方式四：在body节点前，利用window.onload事件
  
  该事件在当前文档完全加载之后被触发
  
  ```html
  <head>
      ...
      <script type="text/javascript">
          window.onload = function(){
              var cityNode = document.getElementById("city");
              alert(cityNode);    
          }
      </script>
  </head>
  ```

#### 2、获取节点

- 获取元素节点
  
  ```javascript
  getElementById();         //通过id获取元素对象（document适用）
  getElementByTagName();    //通过标签名获取元素集合（document和node都适用）
  getElementByClassName();  //通过类名获取元素集合
  
  getElementByName();       //通过元素name属性获取元素集合
  ```

- 获取子节点（只有元素节点才有子节点）
  
  ```javascript
  节点.childNodes;            //获取全部子节点（火狐和IE实现有区别）
  节点.firstNode;             //获取第一个子节点
  节点.lastNode;              //获取最后一个子节点
  节点.getElementByTagName(); //获取节点的指定标签的所有子节点
  ```

- 获取父节点
  
  ```javascript
  节点.parentNode;        //获取节点的父节点
  ```

- 获取属性节点
  
  ```javascript
  节点.属性名              //获取和设置属性节点的值（推荐使用）
  
  getAttributeNode();    //获取属性节点
  nodeValue();           //获取或设置属性节点的值
  ```

- 获取文本节点
  
  ```javascript
  //文本节点的父节点一定是元素节点，且其父节点只有一个子节点
  //因此可以通过其父节点来获取文本节点
  ```

#### 3、节点的属性

- nodeType（只读）
  
  元素节点：1；属性节点：2；文本节点：0。

- nodeName（只读）
  
  元素节点名、属性节点属性名、文本节点：#text

- nodeValue（读写）
  
  元素节点为null、属性节点的属性值、文本节点的文本内容

#### 4、新增节点

- 创建节点
  
  ```javascript
  createElement(String elementName);     //指定标签名创建新元素节点
  createTextNode(String text);           //创建指定内容的文本节点
  ```

- 添加节点
  
  ```javascript
  元素节点.appendChild(node);//添加指定节点为元素节点最后一个子节点
  元素节点.insertBefore(newNode,targetNode); //插入新节点到指定元素指定子节点之前
  元素节点.insertAfter(newNode,targetNode); //插入新节点到指定元素指定子节点之后
  元素节点.属性名 = 属性值;            //添加属性节点
  ```

#### 5、删除节点

```javascript
元素节点.removeChild(childNode);    //删除指定子节点
```

#### 6、替换节点

- 替换子节点
  
  ```javascript
  元素节点.replaceChild(newChild,oldChild); //替换子节点
  ```

- 克隆节点
  
  ```javascript
  节点.clone(boolean flag);    //克隆节点，参数为true深度克隆，否则表层克隆
  ```

#### 7、innerHTML

- innerHTML属性，不是DOM标准组成部分，但浏览器都支持

- 该属性表示元素里所有的HTML内容，可以用来读、写

#### 8、事件

- 事件类型
  
  

- 添加
  
  ```javascript
  addEventListener（envet，fun,capture）
  envet:事件类型
  fun:事件触发后执行的函数
  capture：可选参数，false(默认，冒泡阶段执行函数)或true(捕获阶段执行函数)
  
  节点.事件名 = 函数；        //为节点添加事件监听
  ```

- 取消
