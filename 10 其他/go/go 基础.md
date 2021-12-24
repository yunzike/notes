### 1、环境搭建

sdk下载 & 安装：国内地址 https://studygolang.com/dl

```bash
# 查看 go 版本
$ go version
```

设置国内镜像地址：

七牛云：https://goproxy.cn

```bash
# 查看 go 相关环境配置
$ go env

# 其中默认镜像地址设置为：
set GOPROXY=https://proxy.golang.org,direct

# 设置为七牛云镜像地址
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
```

不同于其他语言，**go中没有项目的说法，只有包**，其中有两个重要的路径，***\*`GOROOT`\**** 和 ***\*`GOPATH`\****

- GOROOT：GOROOT就是Go的安装目录，（类似于java的JDK）
- GOPATH：GOPATH是我们的工作空间,保存go项目代码和第三方依赖包

### 2、变量

- 单个变量定义

  ```go
  // 1、基础定义：var 变量名称 数据类型 = 变量值
  var name1 string = "张三"
  
  // 2、编译器自动推导类型：var 变量名称 = 变量值
  var name2 = "李四"
  
  // 3、声明变量但不赋值：var 变量名称 数据类型
  // sting 类型默认值为空串 ""
  var name3 string
  
  // 4、简洁语法，这种方式只能在函数体内部使用
  name4 := "王五"
  ```

- 多个变量定义

  ```go
  // 1、一行定义多个变量
  var age1,age2 int = 18,20
  var birth1,birth2 = "1995-01-01","2000-01-01"
  var sex1,sex2 string
  
  // 2、多行，分组定义()
  var (
      a = 5
      b bool = true
      c string
  )
  ```
  
- 输出

  ```go
  // 普通输出
  fmt.Print("输出", a, b, c)
  
  // 换行输出
  fmt.Println("换行输出", "a =", a)
  
  // 格式化输出
  // %s: 字符串、%c：字符、%q：带双引号字符串
  // %T：类型、%U：UTF8 编码
  fmt.Printf("%q", s)
  fmt.Printf("c = %c", c)
  ```

### 3、基本数据类型

#### 数据类型

- bool 布尔
- string 字符串
- (u)int，(u)int8，(u)int16，(u)int32，(u)int64 整数（u 无符号，有符号）
- uintptr 指针
- float32，float64 浮点数
- complex64，complex128 复数（如： 3 + 2i）

#### 类型转换

只能强制转换，类型(原变量 )

```go
var c int = -18
var cc = int64(c)
```

### 4、常量

- 定义单个常量

  ```go
  // 其他语言习惯常量或枚举使用大写
  // 在 GO 中，如果首字母大写则默认为 public ，其他包可见
  // 因此，使用小写
  
  const pi float64 = 3.14
  ```

- 定义多个常量

  ```go
  // 单行定义多个常量
  const a,b = 1,2
  
  // 分组方式定义多个变量
  const (
      c = 3
      d = 4
  )
  
  // 未指定数据类型的常量会在使用时，自动适配为合适的数据类型
  sqrt:= math.Sqrt(c*c + d*d)
  ```

- 枚举

  ```go
  const (
      langC    = "C"
      langJava = "JAVA"
      langGo   = "GO"
  )
  
  // 自增类型的枚举，使用关键字：iota
  // 每次 const iota 初始化时为 0
  // _ 为占位符
  const (
      tt1 = iota + 1
      tt2
      _
      tt4
      tt5
  )
  // 输出为 1，2，4，5
  fmt.Println(tt1, tt2, tt4, tt5)
  ```

### 5、基本运算法则

- 算数运算符

  ```
  + - * / %
  ```

- 关系运算符

  ```
  == != > < >= <=
  ```

- 逻辑运算符

  ```java
  && || ！
  ```

- 位运算符

  ```
  & | ^ << >>
  ```

- 赋值运算符

  ```
  = += -= /= %= <<= >>= &= ^= |=
  ```

- 其他运算符

  ```
  & * <-
  ```

### 6、流程控制

- 条件语句 if / else if / else

  ```go
  total := 110.0
  discount := 0.0
  
  if total >= 100 && total < 200 {
  		discount = total * 0.9
  } else if total >= 200 {
    	discount = total * 0.8
  } else {
    	discount = 50
  }
  
  // if 语句中可以添加[初始化子句]
  // 放置在if关键字和条件表达式之间
  // 并与前者由空格分隔、与后者由英文分号;分隔
  if number := 4; number > 100 {
      fmt.Println(number)
  }
  ```

- switch

  ```go
  switch {
      case total >= 100 && total < 200:
      discount = total * 0.9
      case total >= 200:
      discount = total * 0.8
      default:
      discount = 50
  }
  ```

- fallthrough

  

### 7、循环

```go
for i := 0; i < 10; i++ {
    if i == 5 {
      	// 结束本次循环的操作然后继续循环
      	continue
    }
    if i == 7 {
        // 结束循环
        break
    }
    fmt.Println(i)
}


// 死循环
for {
  	fmt.Println("会一直执行下去。。。。。。。")
}
```

### 8、函数

- 定义

  ```go
  // func 函数名称(参数列表) 返回值列表{ // 函数体 }
  // go 语言中函数返回值可以为多个，需要加括号，如：(int，int)
  // 可以给函数返回值设置别名，但要加括号，如：(r int)
  func add(a int, b int) int {
  		return a + b
  }
  
  // 匿名函数一
  func1 := func(a int, b int) int {
  	return a + b
  }
  a := func1(3, 4)
  
  // 匿名函数二
  b := func(a int, b int) int {
  	return a + b
  }(10, 20)
  ```

- 可变参数

  

- 匿名函数

  

- 值传递与引用传递

  默认都是值传递

  

  引用传递需要使用指针

- 闭包

  

### 9、指针

- 定义，使用 `*`

  ```go
  // 定义一个指向 int 类型的指针 p
  var p *int
  ```

- 取地址操作符：`&`

- 解地址操作符：`*`

- 指针初始化内存：new(int)





### 10、字符、编码和字符串

```go
s := "你好，hello"
// len() 字符串的长度（字符串的字节数）
fmt.Println("s 长度 =", len(s)) //s 长度 = 14
fmt.Println("s 长度 =", utf8.RuneCountInString(s)) //s 长度 = 8

// byte 字符，长度为1个字节，不能存储中文
var c byte = 'h'
fmt.Println("c =", c)   //c = 104
fmt.Printf("c = %c", c) //c = h

// rune unicode的字符，长度为4个字节，可以保存中文
var ch rune = '中'
fmt.Println("ch =", ch)   // ch = 20013
fmt.Printf("ch = %c", ch) //ch = 中
```

`for range`：

```go
// for range 语法，遍历字符串
s := "你好，hello"
for index, r := range s {
    fmt.Printf("index = %d, r = %c", index, r)
    fmt.Println()
}
```

### 11、数组

- 定义

  ```go
  // 一维数组
  var arr1 [3]int = [3]int{1, 2}
  fmt.Println(arr1) //[1 2 0]
  
  var arr2 = [3]int{1, 2}
  fmt.Println(arr2) //[1 2 0]
  
  var arr [3]int
  fmt.Println(arr) //[0 0 0]
  
  arr3 := [5]int{1, 3}
  fmt.Println(arr3) // [1 3 0 0 0]
  
  arr4 := [...]int{1, 2, 3}
  fmt.Println(arr4) //[1 2 3]
  
  // 多维数组
  arr5 := [2][3]int{{1, 2}, {3, 4, 5}}
  fmt.Println(arr5) //[[1 2 0] [3 4 5]]
  ```

- 数组长度

  ```go
  // 数组长度：len()
  fmt.Println("数组元素个数为：", len(arr4)) //数组元素个数为： 3
  ```

- 遍历

  ```go
  // 数组遍历：for 循环
  for i := 0; i < len(arr4); i++ {
  	fmt.Println(arr4[i])
  }
  
  // for range 遍历
  for index, item := range arr4 {
  	// 第 0 个元素为： 1
  	fmt.Println("第", index, "个元素为：", item)
  }
  ```

### 12、切片

- 定义

  ```go
  var arr = [5]int{1, 2, 3, 4, 5}
  fmt.Println(arr)      //[1 2 3 4 5]
  fmt.Println(arr[1:3]) // 左闭右开，取索引值：[2 3]
  fmt.Println(arr[:3])  // [1 2 3]
  fmt.Println(arr[1:])  // [2 3 4 5]
  fmt.Println(arr[:])   // [1 2 3 4 5]
  
  // 切片，不指定长度，切片是对数组或切片的全部或部分的引用观察，
  // 容量是从观察开始位置到观察对象的末尾的元素个数
  var s []int
  fmt.Println(s) // []
  s1 := arr[1:3]
  s2 := s1[2:3]
  fmt.Println("切片 s1 =", s1) // [2 3]
  fmt.Println("切片 s2 =", s2) // [4]
  
  // 切片的长度
  fmt.Println("切片 s1 长度为：", len(s1)) // 2
  fmt.Println("切片 s2 长度为：", len(s2)) // 1
  
  //切片的容量 cap()
  fmt.Println("切片 s1 的容量：", cap(s1)) // 4
  fmt.Println("切片 s2 的容量：", cap(s2)) // 2
  ```

- 长度和容量

  ```go
  
  ```

- 基本操作

  ```go
  
  ```

### 13、Map

```go
// map 是一种 key,value 的数据结构
// key 不能使用 map、slice、func

map1 := map[string]int{"a": 1, "b": 2}
fmt.Println(map1) //map[a:1 b:2]

// 分行初始化时，如果结束的花括号不在同一行需要加上逗号
map2 := map[string]int{
	"a": 1,
	"b": 2,
}
fmt.Println(map2) //map[a:1 b:2]

// make
map3 := make(map[string]float32)
fmt.Println("map3 =", map3) // map3 = map[]

// map 取值，不存在的键会输出默认值 0
fmt.Println(map1["b"])     // 2
fmt.Println(map1["不存在的键"]) // 0

value, ok := map1["不存在的键"]
fmt.Println("value =", value) // 0
fmt.Println("是否存在对应的键：", ok)  // false

// map 的遍历，是无序的，和初始化的顺序可能不一样
for key, value := range map1 {
	// a : 1
	// b : 2   
	fmt.Println(key, ":", value)
}

// map 排序后遍历
// 定义一个切片存储 map 所有的 key
var s []string
for key := range map1 {
	s = append(s, key)
}
// 将切片进行排序
sort.Strings(s)
// 遍历切片进行map取值
for _, value := range s {
	fmt.Println(map1[value])
}
```

```go
// make 类似 new, 分配内存，初始化数据
// 适用于：slice, map, channel
// 用法：make(数据类型，[初始化数据长度，总容量])
```



### 14、结构体

- 定义

  ```go
  
  ```

- 方法

  ```go
  
  ```

- 序列化 & 反序列化

  ```go
  
  ```

### 15、自定义类型与类型别名





### 16、依赖管理  & 包初始化

- go.mod

  ```go
  # 新建文件夹后,执行命令，会自动生成 go.mod 文件
  $ go mod init module名称
  
  # 升级和删除没有用到的依赖
  $ go mod tidy
  ```

- go.sum

  记录每个依赖包的哈希值

- 安装依赖

  ```bash
  # 安装依赖，-u 如果本地已经安装，如果有新的会安装更新
  # 然后在 go.mod 文件中会添加：require 依赖名称 版本号
  $ go get -u 依赖名称
  
  # 安装依赖特定版本
  $ go get 依赖名称@版本号
  ```

- 包初始化

  ```go
  package test
  
  type User struct {
  	Id   int
  	Name string
  }
  
  var (
  	// UserInfo 变量
  	UserInfo *User
  )
  
  // 包初始化操作，使用 init()
  // 同一个包内，init() 可以有多个，会按照书写先后顺序执行
  func init() {
  	UserInfo = &User{
  		Id:   1,
  		Name: "测试",
  	}
  }
  
  
  // 在其他地方使用
  package main
  
  import (
  	"fmt"
  	"gostudy/go_base/test"
  )
  
  func main() {
      // &test.User{Id:1, Name:"测试"}
  	fmt.Printf("%#v", test.UserInfo) 
  }
  ```

  

### 17、接口







### 19、错误处理 defer







### 20、错误处理 panic 和 recover



### 21、Goroutine



### 22、channel



### 23、数据竞争与锁







### 24、select





### 25、计时器与定时器





### 26、context





### 27、单元测试与性能测试





### 28、文档和示例



