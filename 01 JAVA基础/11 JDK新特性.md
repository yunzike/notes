##  一、JDK８

JDK 8 的新特性有如下几个：

- **Lambda 表达式** − Lambda 允许把函数作为一个方法的参数（函数作为参数传递到方法中）。
- **方法引用** − 方法引用提供了非常有用的语法，可以直接引用已有Java类或对象（实例）的方法或构造器。与lambda联合使用，方法引用可以使语言的构造更紧凑简洁，减少冗余代码。
- **默认方法** − 默认方法就是一个在接口里面有了一个实现的方法。
- **新工具** − 新的编译工具，如：Nashorn引擎 jjs、 类依赖分析器jdeps。
- **Stream API** −新添加的Stream API（java.util.stream） 把真正的函数式编程风格引入到Java中。
- **Date Time API** − 加强对日期与时间的处理。
- **Optional 类** − Optional 类已经成为 Java 8 类库的一部分，用来解决空指针异常。

### Lambda 表达式

lambda表达式只能操作那些，只有一个抽象方法的接口，我们可以把它理解为一个匿名内部类，但是注意，他是不是匿名内部类。括号里面的参数可以省略类型，如果只有一个参数可以省略小括号，如果大括号见面只有一句方法体，大括号和分号也可以省略。比如说我们开启线程，就要实现runnable这个接口，但，其实我们就是想重写run方法，lambda表达是就是让我，直接去不在意那些形式，直接重写run方法。



### 方法引用



### 默认方法



### Stream 流

#### 概述 



#### 如何生成流



#### 常用操作

- 排序

  

- 过滤

  

- 去重

  ```java
  //方式一：
  
  //按属性去重
  List<String> exchangeTypeCodes = new ArrayList<>();
          List<ScoreExchangeType> collect = idata.stream().filter(v -> {
              boolean flag = !exchangeTypeCodes.contains(v.getExchangeTypeCode());
              exchangeTypeCodes.add(v.getExchangeTypeCode());
              return flag;
          }).collect(Collectors.toList());
    
  
    
  ```

- 计算



### Date Time



### Optional





## 二、JDK 9



## 三、JDK 15



