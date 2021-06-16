### 一、概述

Java 中提供得一套并发工具包，位于 java.util.concurrent 下。

### 二、原子变量和 CAS

#### 1、原子变量

- 什么是原子变量？为什么需要它们？

  对于 count++ 这种操作来说，在多线程程序中，为保证安全而使用 synchronized 成本太高了，需要先获得锁，最后需要释放锁，获取不到锁的情况需要等待，还会有线程的上下文切换，这些都需要成本。

- Java 并发包中的基本原子变量类型

  AtomicBoolean：原子 Boolean 类型，常用来在程序中表示一个标志位。

  AtomicInteger：原子 Integer 类型。

  AtomicLong：原子 Long 类型，常用来在程序中生成唯一序列号。

  AtomicReference：原子引用类型，用来以原子方式更新复杂类型。
  
  **数组相关**：
  
  AtomicLongArray：Long 数组。
  
  AtomicReferenceArray：引用数组。
  
  **用于以原子方式更新对象中的字段的类**：
  
  AtomicIntegerFieldUpdater、AtomicReferenceFieldUpdater 等。
  
  **Java 8 新增，更适合高并发统计汇总场景**：
  
  LongAdder、LongAccumulator、Double-Adder 和 DoubleAccumulator

#### 2、AtomicInteger

- 常用方法

  ```java
  //构造方法
  public AtomicInteger(int initialValue);	//指定初始值
  public AtomicInteger();				   //初始值为 0
  
  //取值和设值
  public final int get();
  public final void set(int newValue);
  
  /** 
   * 原子方式实现组合操作的方法：
   **/
  public final int getAndSet(int newValue);  //以原子方式获取旧值并设置新值
  public final int getAndIncrement();		//以原子方式获取旧值并给当前值加 1
  public final int getAndDecrement();		//以原子方式获取旧值并给当前值减 1
  public final int getAndAdd(int delta);	//以原子方式获取旧值并给当前值加 delta
  public final int incrementAndGet();		//以原子方式给当前值加 1 并获取新值
  public final int decrementAndGet();		//以原子方式给当前值减 1 并获取新值
  public final int addAndGet(int delta);	//以原子方式给当前值加 delta 并获取新值
  
  /**
   * 比较并设置，简称为CAS，以上原子方都依赖这个方法
   * 如果当前值等于 expect ，则更新为 upadte ，否则不更新
   * 更新成功返回 true ,否则返回 false;
   **/
  public final boolean compareAndSet(int expect, int update);	
  ```

- 基本原理

  AtomicInteger 的主要内部成员是：

  ```java
  private volatile int value;
  ```

  它的**声明带有 volatile，这是必需的，以保证内存可见性**。

  大部分更新方法的实现都类似，依赖于`compareAndSet` 方法，例如 `incrementAndGet` 代码为：

  ```java
  public final int incrementAndGet(){
      for(;;){
          int current = get();
          int next = current + 1;
          if(compareAndSet(current, next))
              return next;
      }
  }
  ```

  代码主体是个死循环，先获取当前值 current ，计算期望的值 next，然后调用 CAS 方法进行更新，如果更新没有成功，说明 value 被别的线程改了，则再去取最新值并更新直到成功为止。

  synchronized 是悲观的，它假定更新很可能冲突，所以先获取锁，得到锁后才更新。原子变量的更新逻辑是乐观的，它假定冲突比较少，但使用 CAS 更新，也就是冲突检测，如果确实冲突了也没关系，继续尝试就好了。

  synchronized 代表一种阻塞式算法，得不到锁的时候，进入锁等待队列，等待其他线程唤醒，有上下文切换开销。原子变量的更新逻辑是非阻塞式的，更新冲突的时候就会重试，不会阻塞，不会有上下文切换的开销。对于大部分比较简单的操作，无论是在低并发还是高并发情况下，这种乐观非阻塞方式的性能都远高于悲观阻塞式方式。
  
- compareAndSet 方法的实现

  ```java
  public final boolean compareAndSet(int expect, int update){
      return unsafe.compareAndSwapInt(this, valueOffset, expect， update);
  }
  ```

  它调用 sun.misc.Unsafe的 compareAndSwapInt 方法，定义为：

  ```java
  private static final Unsafe unsafe = Unsafe.getUnsafe();
  ```

  它是 Sun 的私有实现，从名字看，表示的也是”不安全“，一般应用程序不应该直接使用。原理上，一般的计算机系统都在硬件层次上直接支撑 CAS 指令，而 Java 的实现都会利用这些特殊指令。从程序角度看，可以将 compareAndSet 视为计算机的基本操作，直接接纳就好。

#### 3、非阻塞式容器

ConcurrentLinkedQueue 和 ConcurrentLinkedDeque：非阻塞并发队列
ConcurrentSkipListMap 和 ConcurrentSkipListSet：非阻塞并发 Map 和 Set

#### 4、实现锁

基于 CAS ,除了可以实现乐观非阻塞算法之外，还可以实现悲观阻塞式算法，比如锁。实际上，Java 并发包中的所有阻塞式工具、容器、算法

#### 5、ABA 问题



  

  

































### 三、显式锁



### 四、显式条件



