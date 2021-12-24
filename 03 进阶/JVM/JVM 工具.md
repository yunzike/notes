### 1、jps

- 作用

  **jps ** (JVM Process Status Tool)：**虚拟机进程状态工具**，可以列出正在运行的虚拟机进程，并显示虚拟机执行主类（Main Class，main()函数所在的类）的名称，以及这些进程的本地虚拟机的唯一ID（**LVMID**,Local Vitual Machine Identifier）,它是使用频率最高的JDK命令行工具，因为其他JDK工具大多需要输入它查询到的LVMID来确定要监控的是哪一个虚拟机进程。

  对于本地虚拟机进程来说，LVMID与操作系统进程ID（PID，Process Identifier）是一致的。

  如果同时启动了多个虚拟机进程，无法根据进程名称定位时，那就只能依靠jps命令显示主类的功能才能区分了。

- 命令格式

  ```bash
  $ jps [options] [hostid]
  ```

- 参数

  | 选项 | 作用                                               |
  | ---- | -------------------------------------------------- |
  | -q   | 只输出LVMID,省略主类的名称                         |
  | -m   | 输出虚拟机进程启动时传递给main()函数的参数         |
  | -l   | 输出主类的全名，如果进程执行的是jar包，输出jar路径 |
  | -v   | 输出虚拟机进程启动时JVM参数                        |

### 2、jstat

- 作用

  用于**监控虚拟机各种运行状态信息**的命令行工具。它可以显示本地或远程虚拟机进程中的**类装载、内存、垃圾收集、JIT编译**等运行数据，它是运行期定位虚拟机性能问题的首选工具。

- 命令格式

  ```bash
  $ jstat [options] 进程ID  [<interval> [<count>]
  ```

  参数 interval 和 count 代表查询间隔和次数，如果省略这两个参数，说明只查询一次。
  若需要每250毫秒查询一次进程2764垃圾收集的情况，一共查询20次，那么命令应该是：**jstat -gc 2764 250 20**

- 参数

  | 选项              | 作用                                                         |
  | ----------------- | ------------------------------------------------------------ |
  | -class            | 监视类装载、卸载数量、中空间及类装载所耗费的时间             |
  | -gc               | 监视Java堆状况，包括Eden区、2个Survivor区、老年代、永久代等容量、已用空间、GC合计时间等信息 |
  | -gccapacity       | 监视内容与-gc基本相同，但输出主要关注java堆各区域使用到的最大和最小空间 |
  | -gcutil           | 监控内容与-gc基本相同，但输出主要关注已使用空间占总空间的百分比 |
  | -gccause          | 与-gcutil功能一样，但是会额外输出导致上一次GC产生的原因      |
  | -gcnew            | 监视新生代GC的状况                                           |
  | -gcnewcapacity    | 监视内容与-gcnew基本相同，输出主要关注使用到的最大和最小空间 |
  | -gcold            | 监视老年代GC的状况                                           |
  | -gcoldcapacity    | 监视内容与-gcold基本相同，输出主要关注使用到的最大和最小空间 |
  | -gcpermcapacity   | 输出永久代使用到的最大和最小空间                             |
  | -compiler         | 输出JIT编译器编译过的方法、耗时等信息                        |
  | -printcompilation | 输出已被JIT编译的方法                                        |

- 示例1：统计加载类的信息

  ```bash
  $ jstat -class 10648
  Loaded  Bytes  Unloaded  Bytes     Time
   15286 28555.8        0     0.0       4.69
   
  # Loaded	装载的类的数量
  # Bytes		装载类所占用的字节数
  # Unloaded	卸载类的数量
  # Bytes		卸载类所占用的字节数
  # Time		装载类和卸载类所耗费的时间(毫秒)
  ```

- 示例2：编译统计

  ```bash
  $ jstat -compiler 10648
  Compiled Failed Invalid   Time   FailedType FailedMethod
     11164      6       0     2.65          1 org/apache/http/client/utils/URLEncodedUtils parse
  
  # Compiled		编译任务执行数量
  # Failed		编译任务执行失败的数量
  # Invalid		编译任务失效的数量
  # Time			编译总耗时（毫秒）
  # FailedType	最后一个编译失败任务的类型
  # FailedMethod	最后一个编译失败任务所在的类及方法
  ```

- 示例3：垃圾回收统计

  ```bash
  $ jstat -gc 10648
   S0C    S1C    S0U    S1U      EC       EU        OC         OU       MC     MU    CCSC   CCSU   YGC     YGCT    FGC    FGCT     GCT
  49152.0 35328.0  0.0   35314.4 573440.0 308474.1  220672.0   75739.5   83968.0 79714.5 10752.0 9965.8     15    0.132   3      0.145    0.277
  
  
  ```

  

- 示例4：统计gc信息

- 示例5：堆内存统计

- 示例6：新生代垃圾回收统计

- 示例7：新生代内存统计

- 示例8：老年代垃圾回收统计

- 示例9：老年代内存统计

- 示例10：永久代内存统计

- 示例11：最近二次gc统计

- 示例12：JVM编译方法统计



### 3、jinfo

- 作用

  jinfo（Configuration Info for Java）的作用是实时地查看和调整虚拟机的各项参数。

- 命令格式

  ```bash
  # 打印所有的jvm参数信息
  $ jinfo -flags <pid>
  
  # 打印指定的jvm参数信息
  $ jinfo -flag <name> <pid>
  
  # 启用或者禁用指定的jvm参数
  $ jinfo -flag [+|-] <name> <pid>
  
  # 给指定的jvm参数设置值
  $ jinfo -flag <name>=<value> <pid>
  
  # 打印系统参数信息
  $ jinfo -sysprops <pid>
  
  # 打印以上所有配置信息
  $ jinfo <pid>
  ```



### 4、jmap

- 作用

  jmap 命令(Memory Map for Java)：主要用于打印指定 Java 进程(或核心文件、远程调试服务器)的共享对象内存映射或堆内存细节。可以获得运行中的jvm的堆的快照，从而可以离线分析堆，以检查内存泄漏，检查一些严重影响性能的大对象的创建，检查系统中什么对象最多，各种对象所占内存的大小等等。可以使用 jmap 生成Heap Dump。

  如果不想使用 jmap 命令，要想获取 Java 堆转储快照还有一些比较“暴力”的手段：譬如在前面用过的 -`XX:+HeapDumpOnOutOfMemoryError`参数，可以让虚拟机在 OOM 异常出现之后自动生成 dump 文件，通过-`XX:+HeapDumpOnCtrlBreak` 参数可以使用`[ctrl]+[Break]`键让虚拟机生成 dump 文件，又或者在 Linux 系统下通过 `Kill -3` 命令发送进程退出信息“恐吓”一下虚拟机，也能拿到 dump 文件。

  jmap 的作用并不仅仅是为了获取 dump 文件，他还可以查询 finalize 执行队列，java 堆和永久代的详细信息，如空间使用率、当前用的是哪种收集器等。

- 命令格式

  ```bash
  $ jmap [options] ...
  ```

- 参数

  | 选项           | 作用                                                         |
  | -------------- | ------------------------------------------------------------ |
  | -dump          | 生成 java 堆转储快照，格式为：-dump:[live,]format=b,file=<filename>,其中live子参数说明是否只 dump 出存活对象 |
  | -finalizerinfo | 显示在F-Queue中等待Finalizer线程执行finalize方法的对象，只在 linux/solaris 平台下有效 |
  | -heap          | 显示堆详细信息，如使用哪种回收期、参数配置、分带状况等，只在 linux/solaris 平台下有效 |
  | -histo         | 显示堆中对象统计信息，包括类、实例数量和合计容量             |
  | -permstat      | 以 ClassLoader 为统计口径显示永久代内存状况，只在 linux/solaris 平台下有效 |
  | -F             | 当虚拟机进程对 -dump 选项没有响应时，可以使用这个选项强制生成 dump 快照，只在linux/solaris 平台下有效 |

- 示例1：生成java堆转储快照

  ```bash
  $ jmap -dump:live,format=b,file=D:\1.hprof 9840
  Dumping heap to D:\1.hprof ...
  Heap dump file created
  ```

  可以使用 jdk 提供的 jvisualvm.exe 查看 hprof 文件

- 示例2：显示堆详细信息

  ```bash
  $ jmap -heap 9840
  Attaching to process ID 9840, please wait...
  Debugger attached successfully.
  Server compiler detected.
  JVM version is 25.291-b10
  
  using thread-local object allocation.
  Parallel GC with 6 thread(s)
  
  Heap Configuration:
     MinHeapFreeRatio         = 0
     MaxHeapFreeRatio         = 100
     MaxHeapSize              = 4261412864 (4064.0MB)
     NewSize                  = 88604672 (84.5MB)
     MaxNewSize               = 1420296192 (1354.5MB)
     OldSize                  = 177733632 (169.5MB)
     NewRatio                 = 2
     SurvivorRatio            = 8
     MetaspaceSize            = 21807104 (20.796875MB)
     CompressedClassSpaceSize = 1073741824 (1024.0MB)
     MaxMetaspaceSize         = 17592186044415 MB
     G1HeapRegionSize         = 0 (0.0MB)
  
  Heap Usage:
  PS Young Generation
  Eden Space:
     capacity = 554696704 (529.0MB)
     used     = 37040400 (35.32447814941406MB)
     free     = 517656304 (493.67552185058594MB)
     6.677595113310787% used
  From Space:
     capacity = 29884416 (28.5MB)
     used     = 0 (0.0MB)
     free     = 29884416 (28.5MB)
     0.0% used
  To Space:
     capacity = 52428800 (50.0MB)
     used     = 0 (0.0MB)
     free     = 52428800 (50.0MB)
     0.0% used
  PS Old Generation
     capacity = 350748672 (334.5MB)
     used     = 81947136 (78.15087890625MB)
     free     = 268801536 (256.34912109375MB)
     23.36349145179372% used
  
  39810 interned Strings occupying 4105584 bytes.
  ```

- 示例3：显示堆中对象统计信息

  ```bash
  $ jmap -histo 9840
  
   num     #instances         #bytes  class name
  ----------------------------------------------
     1:         15365       33092368  [I
     2:        287261       32877448  [C
     3:        103397        9098936  java.lang.reflect.Method
     4:         24019        7654568  [B
     5:        252550        6061200  java.lang.String
     6:        147268        4712576  java.util.concurrent.ConcurrentHashMap$Node
     7:         75549        4096168  [Ljava.lang.Object;
     8:         75582        3023280  java.util.LinkedHashMap$Entry
     9:         59182        2840736  org.aspectj.weaver.reflect.ShadowMatchImpl
    10:         27226        2223424  [Ljava.util.HashMap$Node;
    11:         59182        1893824  org.aspectj.weaver.patterns.ExposedState
    12:         16363        1845472  java.lang.Class
    13:          1889        1772864  [Ljava.util.concurrent.ConcurrentHashMap$Node;
    14:         30160        1688960  java.util.LinkedHashMap
    15:         67910        1629840  java.util.ArrayList
    16:         63400        1424584  [Ljava.lang.Class;
    17:         40067        1282144  java.util.HashMap$Node
    ......
  ```

  

### 5、jhat

  - 作用

    jhat也是jdk内置的工具之一。主要是用来分析java堆的命令，可以将堆中的对象以html的形式显示出来，包括对象的数量，大小等等，并支持对象查询语言。

    使用jmap等方法生成java的堆文件后，使用其进行分析。

  

###   6、jstack

- 作用

  jstack（stack trace for java）是 java 虚拟机自带的一种堆栈跟踪工具。jstack用于打印出给定的java进程ID或core file 或远程调试服务的 Java 堆栈信息，如果是在64位机器上，需要指定选项”-J-d64”，Windows 的 jstack使用方式只支持以下的这种方式：jstack [-l] pid

  主要分为两个功能：

  1. 针对活着的进程做本地的或远程的线程dump
  2. 针对core文件做线程dump

  jstack 用于生成java虚拟机当前时刻的线程快照。
  线程快照是当前java虚拟机内每一条线程正在执行的方法堆栈的集合，生成线程快照的主要目的是定位线程出现长时间停顿的原因，如线程间死锁、死循环、请求外部资源导致的长时间等待等。
  线程出现停顿的时候通过 jstack 来查看各个线程的调用堆栈，就可以知道没有响应的线程到底在后台做什么事情，或者等待什么资源。
  如果java程序崩溃生成 core 文件，jstack工具可以用来获得 core 文件的 java stack 和 native stack 的信息，从而可以轻松地知道java程序是如何崩溃和在程序何处发生问题。
  另外，jstack 工具还可以附属到正在运行的 java 程序中，看到当时运行的 java 程序的 java stack 和 native stack 的信息, 如果现在运行的 java 程序呈现 hung 的状态，jstack是非常有用的。

- 

  

  















