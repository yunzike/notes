##  1、JDK８

JDK 8 的新特性有如下几个：

- **Lambda 表达式** − Lambda 允许把函数作为一个方法的参数（函数作为参数传递到方法中）。
- **方法引用** − 方法引用提供了非常有用的语法，可以直接引用已有Java类或对象（实例）的方法或构造器。与lambda联合使用，方法引用可以使语言的构造更紧凑简洁，减少冗余代码。
- **默认方法** − 默认方法就是一个在接口里面有了一个实现的方法。
- **新工具** − 新的编译工具，如：Nashorn引擎 jjs、 类依赖分析器jdeps。
- **Stream API** −新添加的Stream API（java.util.stream） 把真正的函数式编程风格引入到Java中。
- **Date Time API** − 加强对日期与时间的处理。
- **Optional 类** − Optional 类已经成为 Java 8 类库的一部分，用来解决空指针异常。

### 1.1 Lambda 表达式

lambda表达式只能操作那些，只有一个抽象方法的接口，我们可以把它理解为一个匿名内部类，但是注意，他是不是匿名内部类。括号里面的参数可以省略类型，如果只有一个参数可以省略小括号，如果大括号见面只有一句方法体，大括号和分号也可以省略。比如说我们开启线程，就要实现runnable这个接口，但，其实我们就是想重写run方法，lambda表达是就是让我，直接去不在意那些形式，直接重写run方法。



### 1.2 方法引用



### 1.3 默认方法



### 1.4 Stream 流

![图片](../images/640)

#### 创建流

- 集合

  ```java
  List<String> list = new ArrayList<>();
  // 创建一个顺序流
  Stream<String> stream = list.stream();
  // 创建一个并行流
  Stream<String> parallelStream = list.parallelStream();
  ```

- 数组

  ```java
  int[] array = {1,2,3,4,5};
  IntStream stream = Arrays.stream(array);
  ```

- 静态方法

  ```java
  Stream<Integer> stream = Stream.of(1, 2, 3, 4, 5);
  Stream<Integer> stream = Stream.iterate(0, (x) -> x + 3).limit(3); // 输出 0,3,6
  
  Stream<String> stream = Stream.generate(() -> "Hello").limit(3); // 输出 Hello,Hello,Hello
  Stream<Double> stream = Stream.generate(Math::random).limit(3); // 输出3个随机数
  
  // 生成有限的常量流
  IntStream intStream = IntStream.range(1, 3); // 输出 1,2
  IntStream intStream = IntStream.rangeClosed(1, 3); // 输出 1,2,3
  // 生成一个等差数列
  IntStream.iterate(1, i -> i + 3).limit(5).forEach(System.out::println); // 输出 1,4,7,10,13
  // 生成无限常量数据流
  IntStream generate = IntStream.generate(() -> 10).limit(3); // 输出 10,10,10
  ```

#### 常用操作

```java
public class Demo {
    class User{
        // 姓名
        private String name;
        // 年龄
        private Integer age;
    }

    public static void main(String[] args) {
        List<User> users = new ArrayList<>();
        users.add(new User("Tom", 1));
        users.add(new User("Jerry", 2));
    }
}
```

- 遍历

  ```java
  // 循环输出user对象
  users.stream().forEach(user -> System.out.println(user));
  ```

- 查找

  ```java
  // 取出第一个对象
  User user = users.stream().findFirst().orElse(null); // 输出 {"age":1,"name":"Tom"}
  // 随机取出任意一个对象
  User user = users.stream().findAny().orElse(null);
  ```

- 匹配

  ```java
  // 判断是否存在name是Tom的用户
  boolean existTom = users.stream().anyMatch(user -> "Tom".equals(user.getName()));
  // 判断所有用户的年龄是否都小于5
  boolean checkAge = users.stream().allMatch(user -> user.getAge() < 5);
  ```

- 筛选

  ```java
  // 筛选name是Tom的用户
  users.stream()
          .filter(user -> "Tom".equals(user.name))
          .forEach(System.out::println); // 输出 {"age":1,"name":"Tom"}
  ```

- 映射

  ```java
  // 打印users里的name
  users.stream().map(User::getName).forEach(System.out::println); // 输出 Tom Jerry
  // List<List<User>> 转 List<User>
  List<List<User>> userList = new ArrayList<>();
  List<User> users = userList.stream().flatMap(Collection::stream).collect(Collectors.toList());
  ```

- 规约

  ```java
  // 求用户年龄之和
  Integer sum = users.stream().map(User::getAge).reduce(Integer::sum).orElse(0);
  // 求用户年龄的乘积
  Integer product = users.stream().map(User::getAge).reduce((x, y) -> x * y).orElse(0);
  ```

- 排序

  ```java
  // 按年龄倒序排
  List<User> collect = users.stream()
          .sorted(Comparator.comparing(User::getAge).reversed())
          .collect(Collectors.toList());
  
  //多属性排序
  List<Person> result = persons.stream()
                  .sorted(Comparator.comparing((Person p) -> p.getNamePinyin())
                          .thenComparing(Person::getAge)).collect(Collectors.toList());
  ```

- 其他操作

  

- 收集

- 归集

- 分组

- 拼接

- 规约

- 求最大、最小

- 统计

- 求平均

- 求和

  ```java
  // list转换成map
  Map<Integer, User> map = users.stream()
          .collect(Collectors.toMap(User::getAge, Function.identity()));
  
  // 按年龄分组
  Map<Integer, List<User>> userMap = users.stream().collect(Collectors.groupingBy(User::getAge));
  
  // 求平均年龄
  Double ageAvg = users.stream().collect(Collectors.averagingInt(User::getAge)); // 输出 1.5
  
  // 求年龄之和
  Integer ageSum = users.stream().collect(Collectors.summingInt(User::getAge));
  
  // 求年龄最大的用户
  User user = users.stream().collect(Collectors.maxBy(Comparator.comparing(User::getAge))).orElse(null);
  
  // 把用户姓名拼接成逗号分隔的字符串输出
  String names = users.stream().map(User::getName).collect(Collectors.joining(",")); // 输出 Tom,Jerry
  ```

- 求总的统计数据

  

  

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



### Date Time



### Optional





## 2、JDK 9



## 3、JDK 15



