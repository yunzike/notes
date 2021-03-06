### 一、原理

#### 1、自增变量

- ++i 原理

  ①变量i自增，值加1；

  ②将变量i自增后的值压入操作数栈；

  ③使用栈中存放的变量i自增后的值替代++i来执行所在语句。

- i++ 原理

  ①将变量i的原值压入操作数栈；

  ②变量i自增，值加1；

  ③使用栈中存放的变量i的原值替代i++来执行所在语句。

- 总结

  1、++在前先+1再入栈，++在后，先入栈再+1，最后再使用栈中的值执行语句操作。

  2、复杂四则运算中，等号右边部分会从左至右执行变值及入栈的操作(与四则运算顺序无关)，最后使用各自对应入栈的值进行操作。

- 面试题

  ```java
  int i = 1;
  i = i++;                     //i=1
  int j = i++;                 //i=2,j=1
  int k = i + ++i * i++;       //i=4,k=11
  
  System.out.println("i=" + i);//4
  System.out.println("j=" + j);//1
  System.out.println("k=" + k);//11
  ```

#### 2、单例设计模式(Singleton)

- 原理

  类只有唯一实例对象。

- 实现

  ①构造器私有化

  ②用一个静态变量保存唯一实例

  ③提供一个静态方法，获取这个实例对象

- 饿汉式：直接创建对象，不存在线程安全问题

  ①直接实例化实现（简洁直观）

  ②枚举式（最简洁）

  ③静态代码块饿汉式（适合复杂实例化）

- 懒汉式：延迟创建对象

  ①普通实现（线程不安全，适合单线程模式）

  ②加同步锁（线程安全，适合多线程，存在指令重排序问题，需要加volitile关键字）

  ③静态内部类（使用于多线程）

#### 3、继承代码执行顺序

- 类初始化过程

  ①一个类要创建实例需要先加载并初始化该类，main方法所在的类需要先加载和初始化，一个子类要初始化需要先初始化父类。

  ②一个类初始化就是执行<clinit>( )方法（即classinit方法，由编译器生成到字节码文件中），且只执行一次。

  ③<clinit>( )方法的组成

  静态类变量显式赋值代码和静态代码块 --- 按位置先后执行

- 实例初始化过程

  ①实例初始化就是执行<init>( )方法，<init>( )方法可能重载有多个，有几个构造器就有几个<init>( )方法。每次创建实例对象，调用对应构造器，就执行一次对应的<init>( )方法。

  ②<init>( )方法的组成

  对应父类的<init>( )方法(因为在子类的构造器中一定会在首行调用父类的构造器）--- 最先执行

  非静态实例变量显式赋值代码和非静态代码块 --- 按位置先后执行

  对应构造器代码 --- 最后执行

- 方法的重写(Override)

  ①哪些方法不会被重写

  final方法、静态方法、private等子类中不可见方法

  ②重写的要求

  方法名和形参列表必须相同（即方法签名相同）

  返回值范围必须小于等于父类被重写方法返回值范围

  修饰符的访问权限范围不得小于父类被重写方法

  不能比父类被重写方法抛出的更多或范围更大的异常

  ③对象的多态性

  通过子类调用的方法如果被子类重写，则调用的是子类重写的代码。

  非静态方法默认的调用对象是this

  在构造器（或<init>）中，this表示的是正在创建的对象

- 面试题

  ```java
  //父类
  class Father {
      private int i = test();
      private static int j = method();
  
      static {
          System.out.print("(1)");
      }
      Father(){
          System.out.print("(2)");
      }
      {
          System.out.print("(3)");
      }
      public int test() {
          System.out.print("(4)");
          return 1;
      }
      public static int method() {
          System.out.print("(5)");
          return 1;
      }
  }
  
  //子类
  public class Son extends Father {
      private int i = test();
      private static int j = method();
  
      static {
          System.out.print("(6)");
      }
      Son(){
          System.out.print("(7)");
      }
      {
          System.out.print("(8)");
      }
      public int test(){
          System.out.print("(9)");
          return 1;
      }
      public static int method(){
          System.out.print("(10)");
          return 1;
      }
  
      public static void main(String[] args) {
          Son s1 = new Son();
          System.out.println();
          Son s2 = new Son();
      }
  }
  
  //打印结果
  (5)(1)(10)(6)(9)(3)(2)(9)(8)(7)
  (9)(3)(2)(9)(8)(7)
  ```

#### 4、方法参数传递机制

- 方法的传参机制

  形参是基本类型，传值

  形参是引用类型，传地址

- String、包装类等对象的不可变性

  当String对象改变时，会在常量池中生成新的对像（如果该字符串常量之前在常量池中不存在），并把新对像的引用赋值给原本的字符串变量。

  包装类对象改变时，会创建新的对象并把引用赋值给原包装类变量。

- 面试题

  ```java
  public class Test {
      public static void main(String[] args) {
          int i = 1;
          String str = "hello";
          Integer num = 200;
          int[] arr = {1, 2, 3, 4, 5};
          MyData my = new MyData();
  
          change(i, str, num, arr, my);
  
          System.out.println("i = "+i);        //i = 1
          System.out.println("str = "+str);    //str = hello
          System.out.println("num = "+num);    //num = 200
          System.out.println("arr = "+Arrays.toString(arr));//arr = [2, 2, 3, 4, 5]
          System.out.println("my.a = "+ my.a);    //my.a = 11
      }
  
      private static void change(int i, String str, Integer num, int[] arr, MyData my) {
          i += 1;
          str += "word";
          num += 1;
          arr[0] += 1;
          my.a += 1;
      }
  }
  
  class MyData {
      int a = 10;
  }
  ```

#### 5、递归与迭代

- 递归

  优点：大问题转化为小问题，可以减少代码量，代码精简，可读性好。

  缺点：递归调用浪费了空间，而且递归太深容易造成堆栈的溢出。

- 迭代

  优点：代码运行效率好，因为时间只因循环次数增加而增加，而且没有额外的空间开销。

  缺点：代码不如递归简洁，可读性好。

- 面试题

  有n级台阶，一次只能上1级台阶或者2级台阶。共有多少种走法？

  ```java
  
  ```


### 二、问题

1. String a = "123"; String b = "123"; a==b的结果是什么？这包含了内存，String存储方式等诸多知识点  


2. HashMap里的hashcode方法和equal方法什么时候需要重写？如果不重写会有什么后果？对此大家可以进一步了解HashMap（甚至ConcurrentHashMap）的底层实现  


3. ArrayList和LinkedList底层实现有什么差别？它们各自适用于哪些场合？对此大家也可以了解下相关底层代码。  


4. volatile关键字有什么作用？由此展开，大家可以了解下线程内存和堆内存的差别。  


5. CompletableFuture，这个是JDK1.8里的新特性，通过它怎么实现多线程并发控制？  


6. JVM里，new出来的对象是在哪个区？再深入一下，问下如何查看和优化JVM虚拟机内存。  


7. Java的静态代理和动态代理有什么差别？最好结合底层代码来说。  