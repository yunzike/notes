#### 1. 设置线程名

查看线程名称

```java
Thread.currentThread().getName()
```

设置线程名称

默认主线程名称为main，其他线程名称为Thread-x

```java
/**
 * Thread类源码       
 */
private static int threadInitNumber;
private static synchronized int nextThreadNum() { 
    return threadInitNumber++;
}

//继承Thread类创建线程
public Thread() {//默认方式
     init(null, null, "Thread-" + nextThreadNum(), 0);
}
public Thread(String name) {//创建时设置线程名
     init(null, null, name, 0); 
}

//实现Runnable接口创建线程
public Thread(Runnable target) {//默认方式
        init(null, target, "Thread-" + nextThreadNum(), 0);
}

public Thread(Runnable target, String name) {//创建时设置线程名

        init(null, target, name, 0);
}

//修改线程名
public final synchronized void setName(String name) {
    checkAccess();

    if (name == null) {
        throw new NullPointerException("name cannot be null");

    }


    this.name = name;

    if (threadStatus != 0) {

        setNativeName(name);

    }

}
```

#### 2. 守护线程

- 守护线程：为其他线程服务的线程，例如垃圾回收线程。

- 特点：当别的用户线程执行完了，虚拟机就会退出，守护线程也就会被停止掉。即没有服务对象就没必要再继续运行。

- 设置守护线程的方法：线程启动之前调用setDaemon ( boolean on ) 方法，传入true。

- 注意：使用守护线程不要访问共享资源（数据库、文件等），因为它可能会在任何时候挂掉；守护线程中产生的新线程也是守护线程。

```java
//测试代码
public class TestThread {
    public static void main(String[] args) {
        MyThread thread = new MyThread();
        Thread t1 = new Thread(thread,"线程一");
        Thread t2 = new Thread(thread,"线程二");
        t2.setDaemon(true);
        //先运行用户线程再运行守护线程

        t2.start();
        t1.start();
        System.out.println(Thread.currentThread().getName());
    }
}
//输出结果
//main

//线程二

//线程一

//先运行用户线程再运行守护线程时
t1.start();
t2.start();
//输出结果
//main
//线程一
```

#### 3. 优先级线程

线程优先级仅仅表示线程获取CPU时间片的几率高，但这不是一个确定因素。

线程的优先级高度依赖操作系统，windows和Linux就有所区别（Linux下优先级可能被忽略）

```java
//Thread源码分析

//优先级默认为5，最小为1，最大为10
public final static int MIN_PRIORITY = 1;

public final static int NORM_PRIORITY = 5;

public final static int MAX_PRIORITY = 10;

//设置优先级
public final void setPriority(int newPriority) {
    ThreadGroup g;
    checkAccess();
    //设置的优先级超出范围则抛出异常

    if (newPriority > MAX_PRIORITY || newPriority < MIN_PRIORITY) {
        throw new IllegalArgumentException();
    }
    if((g = getThreadGroup()) != null) {
        //如果存在线程组，则不能比组的优先级高

        if (newPriority > g.getMaxPriority()) {
            newPriority = g.getMaxPriority();
        }
        setPriority0(priority = newPriority);
    }
}
```

#### 4. 线程的生命周期

- sleep方法：调用该方法会让线程进入计时等待状态，时间到了后进入就绪状态。

- yield方法：调用该方法会让先让别的线程执行，但是不会确保真正让出。若让出，则线程进入等待状态，等待结束同样进入就绪状态。

- join方法：调用该方法会等待该线程执行完毕后才执行别的线程

- interrupt方法：

  以前有stop方法，stop方法可以让一个线程A终止掉另一个线程B，被终止的线程B会立即释放锁，可能会让对象处于不一致的状态。由于Stop方法太过暴力，已经设置为过时，现在已经没有强制线程终止的方法了。

  interrupt方法用来请求终止线程，但不会真正停止一个线程，仅仅给线程发送请求终止的信号。具体到底是中断还是继续运行，由被通知的线程自己处理。
