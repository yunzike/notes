## 1、JS 基础



### html 中使用 JS

````
JavaScript
内部使用：
<script type="text/javascript"></script>
外部导入：
<script src="test.js" type="text/javascript"></script>
<body>
<div id="wrap"></div>
<script type="text/javascript">
(function(){
// document.write("Abcdldjieuds");
var box = document.getElementById("wrap");
var temp = document.createElement("p");
temp.innerHTML = "nihoa";
box.appendChild(temp);
})();
</script>
````

### 基本语法

#### 变量

````
//es6使用let
var a = 1;
//基本等同于不写var，但不利于表达意图不要这样使用
a = 1；
````

#### 变量提升：JavaScript引擎的工作方式是先解析代码，获取所有变量声明，然后一行一行运行

````
console.log(a);
var a = 1;
//实际运行时为，输出结果为undefined
var a;
console.log(a);
a = 1;
````

#### 变量类型(6种，es6新增symbol类型共7种)

- number：      数字  
- string：      字符串  
- boolean：     布尔值  
- object：      对象  
- undefined：   未定义、已声明未赋值  
- null：        空  

其中number、string和boolean为原始类型，是最基本的数据类型，不能再分；而object为合成类型，分为三个子类型：array（数组）、function（函数）、object（狭义的对象）。

##### 1、获取变量类型：typeof()或者typeof xxx  

其中三种基本类型数值、字符串、布尔值分别返回number、string、boolean 
undefined返回undefined 
function类型对象返回function 
其他object（包括array类型对象）返回object 
而null的返回类型是object（这是由于历史原因造成的。1995年的 JavaScript 语言第一版，只设计了五种数据类型（对象、整数、浮点数、字符串和布尔值），没考虑null，只把它当作object的一种特殊值。后来null独立出来，作为一种单独的数据类型，为了兼容以前的代码，typeof null返回object就没法改变了）


#### 2、instanceof运算符

#### 3、Object.prototype.toString方法


#### 注意

- **null和undefined** 
  1、==判断二者相等，且if语句中都自动转成false； 
  2、null表示无，转成数字时转化为0，5+null的值为0，而undefined表示"此处无定义"的原始值，转为数值时为NaN，5+undefined的值为NaN。 
  3、用法：null表示空，如某函数接受错误为参数，如没有错误则传入空表示未发生错误；undefined表示未定义，变量已声明但未赋值、函数已声明但调用时未提供所需参数、函数没有返回值默认返回undefined、对象中不存在的属性。  

- **Boolean（true/false）** 
  1、JavaScript 预期某个位置应该是布尔值时，以下六个值：false、undefined、null、0、NaN、"" 或 ''(空字符串)都转为false，其他（包括空数组（[]）和空对象（{}））对应的布尔值都为true。 
  2、但在==判断中true转化为1，false转化为0再比较。

- **数值** 
  JavaScript中所有数字都是以64位浮点数形式储存，底层根本没有整数，所有数字都是小数（64位浮点数）。但某些运算(位运算)只有整数才能完成，会自动把64位浮点数，转成32位整数，然后再进行运算。  

    ````
  1 === 1.0 // true，底层为同一个数值
  
    //浮点数不是精确的值，所以涉及小数的比较和运算要特别注意
    0.1 + 0.2 === 0.3 // false
    (0.3 - 0.2) === (0.2 - 0.1) // false
  0.3 / 0.1 // 2.9999999999999996
  
    ````

- **NaN（Not a Number，非数）** 
  计算机科学中数值数据类型的一类值，表示未定义或不可表示的值。 
  1、NaN不等于(包括==和===)自身或者其他任何值,和其他任何值运算后仍为NaN 
  2、x!==x来判断x是否为NaN，x为NaN时表达式的值为true。  


#### 运算符

=       赋值表达式 
==      相等运算符 
===     严格相等运算符（if判断时优先采用）   

==  数值是否相等，且对于两个不同的数据类型会先进行转化。 
1、null和undefined相等； 
2、数字和字符串，先将字符串转换为数字再比较； 
3、true转换为1，false转换为0再进行比较； 
4、对象和数字或字符串，则将对象通过valueOf()方法或toString()方法转换为原始值，然后再进行比较。除了日期类只使用toString()转换，JavaScript核心的内置类首先尝试使用valueOf()，再尝试使用toString()。而那些不是JavaScript语言核心中的对象则通过各自的实现中定义的方法转换为原始值。
5、如果其中一个值是NaN，或者两个两个值都是NaN，则它们不相等； 
6、其他不同类型之间的比较均不相等。  

=== 表示恒等，数据类型和数值都比较，比较过程没有任何类型转换 
1、如果两个值类型不相同，则它们不相等； 
2、如果其中一个值是NaN，或者两个两个值都是NaN，则它们不相等。
3、如果两个引用指向同一个对象、数组或函数，则它们是相等的。  

##### 常见数据判断

````
//undefined
if(a === undefined)

//null或undefined
if(a == null) 
等同于 
if(a === undefined || a === null)

// String是否为"",null或者undefined    
if(a == "" || a == null || a == undefined)

//""或null或undefined或NaN  
if(!a){ // "",null,undefined,NaN

// "",null,undefined
if(!$.trim(a)){ 

// Array为空[]或String为 ""
if(a.length == 0)
if(!a.length)

// Object为{}
if($.isEmptyObject(a))
// 普通对象使用 for...in 判断，有 key 即为 false
````

#### 三元运算符？：

var n =3; 
var msg = '数字' + n + '是' + (n % 2 === 0 ? '偶数' : '奇数'); 
console.log(msg);  







### DOM

#### 一、概述

- DOM

  DOM（Document Object Model），即文本对象模型。DOM把一个文档表示为一棵节点树。

- HTML节点分类

  ① 元素节点

  ② 属性节点

  元素的属性，可以直接通过属性的方式来操作。

  ③ 文本节点

  元素节点的子节点，其内容是文本。

#### 二、DOM基本操作

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





## 2、ES6

### 1、简介

**ECMAScript 6.0**（以下简称ES6， ECMAScript是一种由Ecma国际（前身为欧洲计算机制造商协会英文名称是 European Computer Manufacturers Association）通过ECMA-262标准化的脚本程序设计语言）**是 JavaScript语言的下一代标准**，已经在2015年6月正式发布了，并且从 ECMAScript 6开始，开始采用年号来做版本。即 ECMAScript2015，就是 ECMAScript 6。它的目标，是使得 JavaScript语言可以用来编写复杂的大型应用程序，成为企业级开发语言。**每年一个新版本。**

### 2、什么是ECMAScript

来看下前端的发展历程：

- web10时代：
  最初的网页以HTML为主，是纯静态的网页。网页是只读的，信息流只能从服务的到客户端单向流通。开发人员也只关心页面的样式和内容即可。
- Web20时代：
  1995年，网景工程师 Brendan Eich花了10天时间设计了 JavaScript语言。
  1996年，微软发布了 JScript.，其实是 JavaScript的逆向工程实现。
  1996年11月， JavaScript的创造者 Netscape公司，决定将 JavaScript提交给标准化组织ECMA，希望这种语言能够成为国际标准。
  1997年，ECMA发布262号标准文件（ECMA-262）的第一版，规定了浏览器脚本语言的标准，并将这种语言称为 ECMAScript，这个版本就是1.0版。 JavaScript和 JScript都是ECMAScript的标准实现者，随后各大浏览器厂商纷纷实现了 ECMAScript标准。

所以， **ECMAScript是浏览器脚本语言的规范，而各种我们熟知的js语言，如 JavaScript则是规范的具体实现。**

### 3、ES6新特性

#### 1、let声明变量

```javascript
//1et声明的变量有严格局部作用域
{
    var a = 1;
    let b = 2;
}
console.log(a);	//1
console.log(b);// Reference Error:b is not defined

//var可以声明多次
//1et只能声明一次
var m= 1;
var m =2;
let n 3;
// let n=4
console.log(m);//2
console.log(n);// Identifier 'n' has already been declared

// var会变量提升
// 1et不存在变量提升
console.log(x);// undefined 
var x= 10;
console.log(y); //ReferenceError:y is not defined
let y = 20;
```

#### 2、const声明常量

```javascript
//1.声明之后不允许改变
//2.一但声明必须初始化，否则会报错
const a = 1;
a = 3; //Uncaught TypeError:Assignment to constant variable
```

#### 3、解构表达式

##### 1）数组解构

```javascript
let arr = [1, 2, 3];
//以前我们想获取其中的值，只能通过角标。ES6可以这样：
const[x, y, z] = arr; //x,y,z将与arr中的每个位置对应来取值
//然后打印
console.log(x, y, z); 
```

##### 2)对象解构

```javascript
const person = {
    name: "jack",
    age: 21,
    language: ["java", "js", "CSS"]
}

//解构表达式获取值，将 person里面每一个属性和左边对应赋值
const { name, age, language } = person;
//等价于下面
// const name= person.name；
// const age= person.age;
// const language= person.language；

//可以分别打印
console.log(language);

//扩展：如果想要将name的值赋值给其他变量，可以如下，nn是新的变量名
const { name: nn, age, language } = person;
console.log(nn);
```

#### 4、字符串扩展

##### 1）几个新的API

```javascript
// ES6为字符串扩展了几个新的API
// includes()：返回布尔值，表示是否找到了参数字符串。
// startsWith()：返回布尔值，表示参数字符串是否在原字符串的头部。
// endsWith()：返回布尔值，表示参数字符串是否在原字符串的尾部。

let str = "hello.vue";

console.log(str.includes("hello"));//true
console.log(str.startsWith("he"));//true
console.log(str.endsWith("vue"));//true
```

##### 2）字符串模板

```javascript
// 模板字符串相当于加强版的字符串，用反引号，除了作为普通字符串，还可以用来定义多行字符串，还可以在字符串中加入变量和表达式。

//1、多行字符串
let ss = `
    <div>
        <span>hello world</span>
    </div>
`;

console.log(ss);

//2、字符串插入变量和表达式。变量名写在${}中，${}中可以放入JavaScript表达式
let name = "张三";
let age = 18;
let info = `我是${name}，今年${age}岁`;
console.log(info);

//3、字符串调用函数
function fun() {
    return "这是一个函数！"
}
let message = `我想说：${fun()}`;
console.log(message);
```

#### 5、函数优化

##### 1）函数参数默认值

```javascript
//在ES6以前，我们无法给一个函数参数设置默认值，只能采用变通写法
function add(a, b) {
    b = b || 1;
    return a + b;
}
//传一个参数
console.log(add(10));


//现在可以这么写：直接给参数写上默认值，没传就自动使用默认值
function add2(a, b = 1) {
    return a + b;
}
//传一个参数
console.log(add2(10));
```

##### 2）不定参数

```javascript
//不定参数
function fun(...values) {
    console.log(values.length);
}
fun(1, 2);//2
fun(1, 2, 3, 4);//4
```

##### 3）箭头函数

```javascript

```

#### 6、对象优化

##### 1）新增的API

```javascript
ES6给 Object 拓展了许多新的方法，如：
- keys（obj）：获取对象的所有key形成的数组
- values（obj）：获取对象的所有vae形成的数组
- entries（obj）：获取对象的所有key和 value形成的二维数组。格式：[[k1,v1],[k2,v2],...]
- assign（dest…sr：将多个src对象的值拷贝到dest中。（第一层为深拷贝，第二层为浅拷贝）

const person = {
    name: "jack",
    age: '21',
    language: ["java", "js", "css"]
};

console.log(Object.keys(person));
console.log(Object.values(person));
console.log(Object.entries(person));

const target = { a: 1 };
const source1 = { b: 2 };
const source2 = { c: 3 };

Object.assign(target, source1, source2);
console.log(target);//{a: 1, b: 2, c: 3}                                        
```

##### 2）声明对象简写

```javascript

```

##### 3）对象的函数属性简写



##### 4）对象拓展运算符

```javascript
let person = person = {
    name: "jack",
    age: '21',
    language: ["java", "js", "css"]
};

let someone = {...person};
```

#### 7、map和reduce

##### 1）map



##### 2）reduce



#### 8、Promise

在 JavaScript的世界中，所有代码都是单线程执行的。由于这个“缺陷"，导致 JavaScript的所有网络操作，浏览器事件，都必须是异步执行。异步执行可以用回调函数实现。一旦有一连串的ajax请求a，b，c，d ...   后面的请求依赖前面的请求结果，就需要层层嵌套。这种缩进和层层嵌套的方式，非常容易造成上下文代码混乱，我们不得不非常小心翼翼处理内层函数与外层函数的数据，一旦内层函数使用了上层函数的变量，这种混乱程度就会加剧......  总之，这种层叠上下文的层层嵌套方式，着实增加了神经的紧张程度。

案例：用户登录，并展示该用户的各科成绩。在页面发送两次请求：

1.查询用户，查询成功说明可以登录
2.查询用户成功，查询科目
3.根据科目的查询结果，获取成绩

分析：此时后台应该提供三个接口，一个提供用户查询接口，一个提供科目的接口，一个提供各科成绩的接口，为了渲染方便，最好响应json数据。在这里就不编写后台接口了，而是提供三个json文件，直接提供json数据，模拟后台接囗：

![image-20200628011423988](../../../%25E5%259D%259A%25E6%259E%259C%25E4%25BA%2591/notes/09%2520%25E5%2589%258D%25E7%25AB%25AF/images/image-20200628011423988.png)

```javascript
//1、查出当前用户信息
//2、按照当前用户的id查出他的课程
//3、按照当前课程id查出分数
$. ajax（（
		url："mock/user json"， success（data）
		console.1og（“查询用户："，data）； 
		s ajax（（
		url:mock/user corse $【data. id）。 json success（data）（
		console.log（"查询到课程："，data）；
		$. ajax（t url:mock/corse score $（data. id. json, success（data）{…
error（error）（
}）
error（eror）{…
}）； error（error）（
}）；
```

##### 1）Promise语法



##### 2）处理异步结果



##### 3）Promise改造以前嵌套方式



##### 4）优化处理结果



#### 9、模块化

##### 1）什么是模块化

模块化就是把代码进行拆分，方便重复利用。类似java中的导包：要使用一个包，必须先导包。而J中没有包的概念，换来的是模块。

模块功能主要由两个命令构成：‘ export和 import'。

export命令用于规定模块的对外接口
import'命令用于导入其他模块提供的功能

##### 2）export



##### 3）import





## 3、数组常用方法

#### 1、创建数组



#### 2、元素添加/删除

- 基本方法（使用索引）

  ```javascript
  var a = new Array(1,2,3);
  
  //添加元素
  a[3] = 4;
  
  //删除元素,等价于 a[2] = undefined , 数组长度不变
  delete a[2];
  ```

- 栈方法

  ```javascript
  var a=new Array(1,2,3);
  
  //在数组末尾添加元素
  a.push(4);
  console.log(a);//[1, 2, 3, 4] 
  console.log(a.length);//4
  
  //删除数组末尾的元素,并返回删除的元素,数组长度减1
  console.log(a.pop(a));//4
  console.log(a); //[1, 2, 3] 
  console.log(a.length);//3
  ```

- 队列方法

  ```javascript
  var a=new Array(1,2,3);
  
  //删除数组首部的元素，并返回删除的元素，数组长度减1，和push()一起使用可以模拟队列
  console.log(a.shift(a));//1
  console.log(a); //[2, 3] 
  console.log(a.length);//2
  
  //另外还可以使用unshift()在数组首部添加元素
  a.unshift(4);
  console.log(a);//[4, 2, 3] 
  console.log(a.length);//3
  ```

- splice方法

  1.开始索引

  2.删除元素的位移

  3.插入的新元素，当然也可以写多个

  ```javascript
  //1.删除
  
  //2.插入与替换
  ```

#### 3、常用方法

- join：以指定字符将数组连接成字符串

  ```javascript
  var a=new Array(1,2,3,4,5);
  
  //将数组以指定字符间隔，再连接成字符串
  console.log(a.join(',')); //1,2,3,4,5 
  console.log(a.join(' ')); //1 2 3 4 5
  ```

- slice：用于返回数组中的子数组，不改变原数组

  ```javascript
  var a=new Array(1,2,3,4,5);
  
  //返回数组中参数1到参数2范围（左闭右开）的子数组
  console.log(a.slice(1,2));//2
  
  //只写一个参数，返回参数到数组结束部分
  console.log(a.slice(2));//[3,4,5]
  
  //参数为负数时，-n 表示倒数第n个数
  console.log(a.slice(1,-1));//[2, 3, 4] 
  
  //如果参数2的位置在参数1的前面，则返回[]
  console.log(a.slice(3,2));//[]
  ```

- concat：用于拼接数组并返回，不改变原数组，也不会递归连接数组内部数组

  ```javascript
  var a=new Array(1,2,3,4,5);
  var b=new Array(6,7,8,9);
  
  //将数组a和数组b拼接成新的数组并返回，不改变原数组，也不会递归连接数组内部数组
  console.log(a.concat(b));//[1, 2, 3, 4, 5, 6, 7, 8, 9] 
  ```

- reverse：用于将数组逆序，修改的是原数组

  ```javascript
  var a=new Array(1,2,3,4,5);
  
  //将数组逆序，修改的是原数组
  a.reverse();
  console.log(a); //[5, 4, 3, 2, 1]
  ```

- sort：用于对数组进行排序

  ```javascript
  //当没有参数的时候会按字母表升序排序，如果含有undefined会被排到最后面，对象元素则会调用其toString方法
  var a=new Array(5,4,3,2,1);
  a.sort();
  console.log(a);//[1, 2, 3, 4, 5]
  
  var a=new Array(7,8,9,10,11);
  a.sort();
  console.log(a);//[10, 11, 7, 8, 9]
  
  //传入自定义排序函数
  var a=new Array(7,8,9,10,11);
  a.sort(function(v1,v2){
      return v1-v2;
  });
  console.log(a);//[7, 8, 9, 10, 11]
  ```

#### 4、数组与字符串的相互转换

- 数组转字符串

  ```javascript
  var a, b;
  a = new Array(0,1,2,3,4);
  b = a.join("-");
  ```

- 字符串转数组

  ```javascript
  var s = "abc,abcd,aaa";
  
  ss = s.split(",");// 在每个逗号(,)处进行分解。
  ```

#### 5、数组的遍历

- for

  ```javascript
  var a=new Array(1,2,3,4,5);
  
  for(var i = 0; i < a.length; i++){
      console.log(a[i]);
  }
  ```

- for in

  ```javascript
  var a=new Array(1,2,3,4,5);
  for (var item in a){
  	console.log(item);
  }
  ```

#### 6、ES5新增方法

- 索引方法

  indexOf：返回要查找的项在数组中首次出现的位置，在没找到的情况下返回-1

  ```javascript
  indexOf()
  array.indexOf(item,start) （从数组的开头（位置 0）开始向后查找）
  item： 必须。查找的元素。
  start：可选的整数参数。规定在数组中开始检索的位置。如省略该参数，则将从array[0]开始检索。
  
  var arr = [1,4,7,10,7,18,7,26];
  console.log(arr.indexOf(7));        // 2
  console.log(arr.lastIndexOf(7));    // 6
  console.log(arr.indexOf(7,4));      // 4
  console.log(arr.lastIndexOf(7,2));  // 2
  console.log(arr.indexOf(5));        // -1	
  ```

  lastIndexOf

  ```javascript
  lastIndexOf()--------array.lastIndexOf(item,start) （从数组的末尾开始向前查找）
  item： 必须。查找的元素。
  start：可选的整数参数。规定在数组中开始检索的位置。如省略该参数，则将从 array[array.length-1]开始检索。
  ```

- 迭代方法

  ***\*currentValue :\**** 必需。当前元素

  ***\*index：\**** 可选。当前元素的索引值。

  ***\*arr :\**** 可选。当前元素所属的数组对象。

  ***\*thisValue：\**** 可选。传递给函数的值一般用 "this" 值。如果这个参数为空， "undefined" 会传递给 "this" 值

  forEach：对数组进行遍历循环，这个方法没有返回值。jquery()也提供了相应的方法each()方法。
  语法：array.forEach(function(currentValue , index , arr){//do something}, thisValue)

  ```javascript
  var Arr = [1,4,7,10];
  Arr.forEach(function(currentValue, index, arr){
     console.log(index+"--"+currentValue+"--"+(arr === Arr));		
  })
  // 输出：
  // 0--1--true
  // 1--4--true
  // 2--7--true
  // 3--10--true	
  ```

  map()：指“映射”，方法返回一个新数组，数组中的元素为原始数组元素调用函数处理后的值。
  语法：array.map(function(\**currentValue\** , \**index\** , \**arr\**){//do something}, \**thisValue\**)

  ```javascript
  var arr = [1,4,8,10];
  var arr2 = arr.map(function(currentValue){
  return currentValue*currentValue;
  });
  console.log(arr2);  // [1, 16, 64, 100]
  ```

  filter()：“过滤”功能，方法创建一个新数组, 其包含通过所提供函数实现的测试的所有元素。和filter() 方法类似，jquery中有个 grep()方法也用于数组元素过滤筛选。

  语法： array.filter(function(\**currentValue\** , \**index\** , \**arr\**){//do something}, \**thisValue\**)

  ```javascript
  var arr = [1,4,6,8,10];
  var result1 = arr.filter(function(currentValue){
  	return currentValue>5;
  });
  console.log(result1);  // [6, 8, 10]
  ```

  some()：判断数组中是否存在满足条件的项，\**只要有一项满足条件\**，就会返回true。

  语法： array.some(function(\**currentValue\** , \**index\** , \**arr\**){//do something}, \**thisValue\**)

  ```javascript
  var arr = [1,4,6,8,10];
  var result1 = arr.some(function(currentValue){
  	return currentValue> 10;
  });
  console.log(result1);  // false
  
  var result2 = arr.some(function(currentValue){
  	return currentValue> 5;
  });
  console.log(result2);  // true
  ```

  every()：判断数组中每一项都是否满足条件，\**只有所有项都满足条件\**，才会返回true。

  语法： array.every(function(\**currentValue\** , \**index\** , \**arr\**){//do something}, \**thisValue\**)

  ```javascript
  var arr = [1,4,6,8,10];
  var result1 = arr.every(function(currentValue){
  	return currentValue< 12;
  });
  console.log(result1);  // true
  
  var result2 = arr.every(function(currentValue){
  	return currentValue> 1;
  });
  console.log(result2);  // false
  ```

- 归并方法

  reduce()

  reduceRight()

  这两个方法都会迭代数组中的所有项，然后生成一个最终返回值。他们都接收两个参数，第一个参数是每一项调用的函数，函数接受四个参数分别是初始值，当前值，索引值，和当前数组，函数需要返回一个值，这个值会在下一次迭代中作为初始值。第二个参数是迭代初始值，参数可选，如果缺省，初始值为数组第一项，从数组第一个项开始叠加，缺省参数要比正常传值少一次运算。

  reduce()方法从数组的第一项开始，逐个遍历到最后。而 reduceRight()则从数组的最后一项开始，向前遍历到第一项。

  reduce()语法：arr.reduce(function(total , cur , index , arr){//do something}, initialValue)

  reduceRight()语法：arr.reduceRight(function(total , cur , index , arr){//do something}, initialValue)

  total ：必需。初始值, 或者计算结束后的返回值。

  cur ：必需。当前元素。

  index ：可选。当前元素的索引。

  arr：可选。当前元素所属的数组对象。

  initialValue：可选。传递给函数的初始值。

  下面代码实现数组求和：

  ```javascript
  var arr = [1,2,3,4,5];
  var result1 = arr.reduce(function(total,cur,index,arr){	
      console.log("total:"+total+",cur:"+cur+",index:"+index);
      return total+cur;
  });
  console.log("结果："+result1);
  // 输出
  // total:1,cur:2,index:1
  // total:3,cur:3,index:2
  // total:6,cur:4,index:3
  // total:10,cur:5,index:4
  // 结果：15
  var result2 = arr.reduce(function(total,cur,index,arr){	
      console.log("total:"+total+",cur:"+cur+",index:"+index);
      return total+cur;
  },10);
  console.log("结果："+result2);
  // 输出
  // total:10,cur:1,index:0
  // total:11,cur:2,index:1
  // total:13,cur:3,index:2
  // total:16,cur:4,index:3
  // total:20,cur:5,index:4
  // 结果：25
  ```

  从上面代码我们可以看出，当我们不给函数传递迭代初始值时初始值 total 为数组第一项，函数从数组第二项开始迭代；若我们给函数传递迭代初始值，则函数从数组第一项开始迭代。

#### 7、ES6新增方法

- Array.from()：用于类似数组的对象（即有length属性的对象）和可遍历对象转为真正的数组。

  ```javascript
  let json ={
      '0':'卢',
      '1':'本',
      '2':'伟',
      length:3
  }
  let arr = Array.from(json);
  console.log(arr); // ["卢", "本", "伟"]
  ```

- Array.of()：将一组值转变为数组，参数不分类型，只分数量，数量为0返回空数组、

  ```javascript
  let arr1 = Array.of(1,2,3);	
  let arr2 = Array.of([1,2,3]);
  let arr3 = Array.of(undefined);
  let arr4 = Array.of();
  
  console.log(arr1); // [1, 2, 3]
  console.log(arr2); // [[1, 2, 3]]
  console.log(arr3); // [undefined]
  console.log(arr4); // []
  ```

- find()：返回通过测试（函数内判断）的数组的第一个元素的值。方法为数组中的每个元素都调用一次函数执行。当数组中的元素在测试条件时返回 true 时, find() 返回符合条件的元素，之后的值不会再调用执行函数。如果没有符合条件的元素返回 undefined。

  回调函数可以接收3个参数，依次为当前的值（currentValue）、当前的位置（index）、原数组（arr）

  ```javascript
  let Arr = [1,2,5,7,5,9];
  let result1 = Arr.find(function(currentValue,index,arr){			
  	return currentValue>5;
  });
  let result2 = Arr.find(function(currentValue,index,arr){			
  	return currentValue>9;
  });
  
  console.log(result1); // 7
  console.log(result2); // undefined
  ```

- findIndex ()：findIndex和find差不多，不过默认返回的是索引，如果没有符合条件的元素返回 -1

  ```javascript
  let Arr = [1,2,5,7,5,9];
  let result1 = Arr.findIndex(function(currentValue,index,arr){			
      return currentValue>5;
  });
  let result2 = Arr.findIndex(function(currentValue,index,arr){			
      return currentValue>9;
  });
  console.log(result1); // 3
  console.log(result2); // -1
  ```

- fill()：用一个固定值填充一个数组中从起始索引到终止索引内的全部元素

  语法：array.fill(value,  start,  end)

  value：必需。填充的值。

  start：可选。开始填充位置。如果这个参数是负数，那么它规定的是从数组尾部开始算起。

  end：可选。停止填充位置 (默认为 array.length)。如果这个参数是负数，那么它规定的是从数组尾部开始算起。

  ```javascript
  let arr = [1,2,3,4,5,6];
  arr.fill(0);  // [0, 0, 0, 0, 0, 0]
  arr.fill(0,1);  // [1, 0, 0, 0, 0, 0] 
  arr.fill(0,1,2);  // [1, 0, 3, 4, 5, 6]
  arr.fill(0,-1);  // [1, 2, 3, 4, 5, 0]
  arr.fill(0,1,-1);  // [1, 0, 0, 0, 0, 6]
  ```

- 遍历数组方法 keys()、values()、entries()

  这三个方法都是返回一个遍历器对象，可用for...of循环遍历，唯一区别：keys()是对键名的遍历、values()对键值的遍历、entries()是对键值对的遍历。

  ```javascript
  let arr = ["a","b","c","d"];
  for(let i of arr.keys()){
  	console.log(i);
  }
  //打印：
  // 0
  // 1
  // 2
  // 3
  
  let arr = ["a","b","c","d"];
  for(let i of arr.values()){
      console.log(i);
  }
  //打印：
  // a
  // b
  // c
  // d
  
  let arr = ["a","b","c","d"];
  for(let i of arr.entries()){
      console.log(i);
  }
  //打印：
  // [0, "a"]
  // [1, "b"]
  // [2, "c"]
  // [3, "d"]
  for(let [idx,item] of arr.entries()){
      console.log(idx+":"+item);
  }
  //打印：
  // 0:a
  // 1:b
  // 2:c
  // 3:d
  ```

- includes()：用来判断一个数组是否包含一个指定的值，如果是返回 true，否则false。

  语法：arr.includes(searchElement ,  fromIndex)

  searchElement ： 必须。需要查找的元素值。

  fromIndex：可选。从该索引处开始查找 searchElement。如果为负值，则按升序从 array.length + fromIndex 的索引开始搜索。默认为 0。

  ```javascript
  let arr = ["a","b","c","d"];
  let result1 = arr.includes("b");
  let result2 = arr.includes("b",2);
  let result3 = arr.includes("b",-1);
  let result4 = arr.includes("b",-3);
  console.log(result1);  // true
  console.log(result2);  // false
  console.log(result3);  // flase
  console.log(result4);  // true
  ```

- copyWithin()：用于从数组的指定位置拷贝元素到数组的另一个指定位置中，会覆盖原有成员

  语法：array.copyWithin(target ,  start ,  end)

  target ：必需。从该位置开始替换数据。

  start ：可选。从该位置开始读取数据，默认为 0 。如果为负值，表示倒数。

  end： 可选。到该位置前停止读取数据，默认等于数组长度。如果为负值，表示倒数。

  ```javascript
  let arr = [1,2,3,4,5,6];
  let result1 = [1,2,3,4,5,6].copyWithin(0);
  let result2 = [1,2,3,4,5,6].copyWithin(0,1);
  let result3 = [1,2,3,4,5,6].copyWithin(1,3,5);
  let result4 = [1,2,3,4,5,6].copyWithin(1,2,-1);
  let result5 = [1,2,3,4,5,6].copyWithin(1,-4,6);
  console.log(result1);  // [1, 2, 3, 4, 5, 6]
  console.log(result2);  // [2, 3, 4, 5, 6, 6]
  console.log(result3);  // [1, 4, 5, 4, 5, 6]
  console.log(result4);  // [1, 3, 4, 5, 5, 6]
  console.log(result5);  // [1, , 5, 6, 6]
  ```





## 4、异步

### 1、概述

JavaScript 是采用的单线程工作模式，JavaScript 是运行在浏览器

JavaScript 是单线程语言，浏览器只分配给js一个主线程，用来执行任务（函数），但一次只能执行一个任务，这些任务形成一个任务队列排队等候执行，但前端的某些任务是非常耗时的，比如网络请求，定时器和事件监听，如果让他们和别的任务一样，都老老实实的排队等待执行的话，执行效率会非常的低，甚至导致页面的假死。所以，浏览器为这些耗时任务开辟了另外的线程，主要包括http请求线程，浏览器定时触发器，浏览器事件触发线程，这些任务是异步的。

JavaScript 语言的一大特点就是单线程，也就是说，同一个时间只能做一件事。那么，为什么JavaScript 不能有多个线程呢 ？这样能提高效率啊。

JavaScript 的单线程，与它的用途有关。作为浏览器脚本语言，JavaScript 的主要用途是与用户互动，以及操作 DOM。这决定了它只能是单线程，否则会带来很复杂的同步问题。比如，假定JavaScript 同时有两个线程，一个线程在某个 DOM 节点上添加内容，另一个线程删除了这个节点，这时浏览器应该以哪个线程为准？

所以，为了避免复杂性，从一诞生，JavaScript 就是单线程，这已经成了这门语言的核心特征，将来也不会改变。

为了利用多核 CPU 的计算能力，HTML5 提出 Web Worker 标准，允许 JavaScript 脚本创建多个线程，但是子线程完全受主线程控制，且不得操作 DOM。所以，这个新标准并没有改变 JavaScript 单线程的本质。

- 同步

  

- 异步

  

- 事件循环与消息队列



























### 2、异步编程的几种方式

















### 3、Promise 异步方案、宏任务/微任务队列













### 4、Generator 异步方案、Async / Await 语法糖

