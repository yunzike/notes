## 一、NoSQL入门概述

#### 1、入门概述



#### 2、3V+3高



#### 3、当下NoSQL经典应用



#### 4、NoSQL数据模型简介



#### 5、NoSQL数据库的四大分类



#### 6、在分布式数据库中CAP原理CAP+BASE

- CAP

  Consistency（强一致性）

  Availability（可用性）

  Partition tolerance（分区容错性）

- CAP的3进2

  CAP理论就是说在分布式存储系统中，最多只能实现上面的两点。而由于当前的网络硬件肯定会出现延迟丢包等问题，所以分区容忍性是我们必须需要实现的。所以我们只能在一致性和可用性之间进行权衡，没有NoSQL系统能同时保证这三点。

- CAP理论

  CAP理论的核心是：一个分布式系统不可能同时很好的满足一致性，可用性和分区容错性这三个需求，

  最多只能同时较好的满足两个。

  C:强一致性 A：高可用性 P：分布式容忍性

  因此，根据 CAP 原理将 NoSQL 数据库分成了满足 CA 原则、满足 CP 原则和满足 AP 原则三 大类：

  CA - 单点集群，满足一致性，可用性的系统，通常在可扩展性上不太强大。

  CP - 满足一致性，分区容忍必的系统，通常性能不是特别高。

  AP - 满足可用性，分区容忍性的系统，通常可能对一致性要求低一些。

  ![image-20200626020355360](../../images/image-20200626020355360.png)

  C：强一致	A：高可用性	P：分布式容忍性

  CA	传统 Oracle数据库

  AP	大多数网站架构的选择

  CP 	Redis、 Mongodb

- BASE

  BASE就是为了解决关系数据库强一致性引起的问题而引起的可用性降低而提出的解决方案。

  BASE其实是下面三个术语的缩写：

  基本可用（Basically Available）

  软状态（Soft state）

  最终一致（Eventually consistent）

  它的思想是通过让系统放松对某一时刻数据一致性的要求来换取系统整体伸缩性和性能上改观。为什么这么说呢，缘由就在于大型系统往往由于地域分布和极高性能的要求，不可能采用分布式事务来完成这些指标，要想获得这些指标，我们必须采用另外一种方式来完成，这里BASE就是解决这个问题的办法

## 二、Redis入门介绍

#### 1、入门概述

Redis是一个开源的，基于内存的数据结构存储，可用作于数据库、缓存、消息中间件。

- 为什么要用Redis（Map与Redis对比）

  1、Redis基于内存，常用作缓存，并且存储的方式为key-value形式。

  2、Java中可以用Map实现缓存，但这种方式是本地缓存，当有多台实例（机器）时，每个实例都需要各自保存一份缓存，缓存不具有一致性。而Redis实现的是分布式缓存，多个实例共享同一份缓存，具有一致性。

  3、Map不是专门用于缓存的，JVM内存太大容易挂掉，且一般只用做容器来存储临时数据，缓存的数据随JVM的销毁而消失，另外缓存过期机制等都需要程序员手动实现。而Redis是专门用来做缓存的，可以使用几十个G内存来用于缓存。支持数据的持久化（将缓存的数据存入磁盘）与重启恢复，并提供了丰富的数据结构、缓存过期机制等便捷的功能。

- 为什么要用缓存？

#### 2、Redis的安装

- 下载并解压(一般解压到/usr/local/)

  ```bash
  //方式一：
  官网https://redis.io/download下载  
  //方式二：
  wget http://download.redis.io/releases/redis-5.0.5.tar.gz 
  
  //解压
  [root@heibaise mypackage]# tar xzvf redis-5.0.5.tar.gz
  [root@heibaise mypackage]# mv redis-5.0.5 /usr/local/
  ```

- 编译和安装

  ```bash
  //进入解压后的目录执行make命令
  [root@heibaise local]# cd redis-5.0.5/
  [root@heibaise redis-5.0.5]# make
  
  //进入src目录并执行安装命令
  [root@heibaise redis-5.0.5]# cd src && make install
  
  //安装之前可以先执行测试命令
  [root@heibaise src]# make test
  ```

- 创建目录存放redis命令和配置文件

  ```bash
  [root@heibaise redis-5.0.5]# mkdir -p /usr/local/redis/bin
  [root@heibaise redis-5.0.5]# mkdir -p /usr/local/redis/etc
  ```

- 移动文件

  ```
  //将redis-5.0.5目录下的配置文件移动到etc目录
  [root@heibaise redis-5.0.5]# mv redis.conf /usr/local/redis/etc
  
  //将src下的所有命令移动到bin目录
  [root@heibaise redis-5.0.5]# mv mkreleasehdr.sh redis-benchmark redis-check-aof redis-check-rdb redis-cli redis-server redis-sentinel redis-trib.rb /usr/local/redis/bin
  ```

- 服务器中启动Redis服务（默认端口6379）

  ```bash
  [root@heibaise redis-5.0.5]# cd /usr/local/redis-5.0.5/bin
  [root@heibaise bin]# ./redis-server
  
  //指定配置文件启动
  [root@heibaise bin]# ./redis-server ../etc/redis.conf 
  ```

- 验证是否启动成功（另一个终端）

  ```bash
  [root@heibaise ~]# ps -ef | grep redis
  或者
  [root@heibaise ~]# netstat -tunpl | grep 6379
  ```

- 客户端连接

  ```bash
  //连接本机默认6379端口redis服务
  [root@heibaise ~]# /usr/local/redis-5.0.5/bin/redis-cli 
  127.0.0.1:6379> ping    //ping命令  测试是否仍然连接
  PONG
  127.0.0.1:6379> exit    //exit      断开连接
  [root@heibaise ~]# 
  
  //连接指定主机和端口redis服务
  [root@heibaise ~]# /usr/local/redis-5.0.5/bin/redis-cli -h 127.0.0.1 -p 6379
  ```

- 停止Redis服务

  ```bash
  [root@heibaise ~]# /usr/local/redis-5.0.5/bin/redis-cli shutdown
  #或
  [root@heibaise ~]# pkill redis-server
  ```

#### 3、Redis启动后杂项基础知识





## 三、Redis数据类型

#### 1、五大数据类型



#### 2、常用操作命令



#### 3、键（key）



#### 4、字符串（String）



#### 5、列表（List）



#### 6、集合（Set）



#### 7、哈希（Hash）



#### 8、有序集合Zset（sorted set）





## 四、配置文件（redis.conf）

#### 1、概述



#### 2、GENERAL通用



#### 3、SNAPSHOTING快照



#### 4、REPLICATION复制



#### 5、SECURITY安全



#### 6、LIMITS限制



#### 7、APPEND ONLY MODE追加



#### 8、常见配置redis.conf介绍





## 五、持久化（Persistence）

#### 1、总体介绍



#### 2、RDB（Redis DataBase）

在指定的时间间隔内将内存中的数据集快照写入磁盘，也就是行话讲的Snapshot快照，它恢复时是将快照文件直接读到内存里。

Redis会单独创建（fork）一个子进程来进行持久化，会先将数据写入到一个临时文件中，待持久化过程都结束了，再用这个临时文件替换上次持久化好的文件。整个过程中，主进程是不进行任何IO操作的，这就确保了极高的性能如果需要进行大规模数据的恢复，且对于数据恢复的完整性不是非常敏感，那RDB方式要比AOF方式更加的高效。RDB的缺点是最后一次持久化后的数据可能丢失。

- Fork

  fork的作用是复制一个与当前进程一样的进程。新进程的所有数据（变量、环境变量、程序计数器等）数值都和原进程一致，但是是一个全新的进程，并作为原进程的子进程。

  

- rdb 保存的是dump.rdb文件

  

- 如何触发RDB快照

  配置文件中默认的快照配置--->冷拷贝后重新使用--->可以cp dump.rdb dump_new.rdb

  

- 恢复



- 禁用

  不要设置任何save指令或者给save传入一个空字符串参数

- 优势

  

- 劣势

  

#### 3、AOF（Append Only File）



#### 4、总结





## 六、Redis事务



## 七、Redis的发布订阅

- 进程间的一种消息通信模式：发送者(pub)发送消息，订阅者(sub)接收消息。

- 订阅/发布消息图

- 命令

  ```bash
  # 1 先订阅后发布后才能收到消息，可以一次性订阅多个
  SUBSCRIBE c1 c2 c3
  
  # 2 消息发布，
  PUBLISH c2 hello-redis
  
  # 3 订阅多个，通配符*， 
  PSUBSCRIBE new*
  
  # 4 收取消息， 
  PUBLISH new1 redis2015
  ```

## 八、Redis的复制（Master/Slave）

#### 1、主从复制

主机数据更新后根据配置和策略，自动同步到备机的master/slaver机制，Master以写为主，Slave以读为主。

作用：读写分离、容灾恢复

#### 2、使用

配从(库)不配主(库)

```bash
# 从库配置，每次与master断开之后，都需要重新连接，除非你配置进redis.conf文件
slaveof 主库IP 主库端口

# 查看数据库信息
info replication
```

修改配置文件细节操作

```bash
拷贝多个redis.conf文件

开启daemonize yes

pid文件名字

指定端口

log文件名字

dump.rdb名字
```

#### 3、常用模式

- 一主二仆

  Init

  一个Master两个Slave

  日志查看：主机日志、备机日志、info replication

  1 切入点问题？slave1、slave2是从头开始复制还是从切入点开始复制?比如从k4进来，那之前的123是否也可以复制

  

  2 从机是否可以写？set可否？

  

  3 主机shutdown后情况如何？从机是上位还是原地待命

  

  4 主机又回来了后，主机新增记录，从机还能否顺利复制？

  

  5 其中一台从机down后情况如何？依照原有它能跟上大部队吗？

  

- 薪火相传

  上一个Slave可以是下一个slave的Master，Slave同样可以接收其他slaves的连接和同步请求，那么该slave作为了链条中下一个的master,可以有效减轻master的写压力。

  中途变更转向:会清除之前的数据，重新建立拷贝最新的

  slaveof 新主库IP 新主库端口

- 反客为主

  SLAVEOF no one：使当前数据库停止与其他数据库的同步，转成主数据库

  

- **哨兵模式(sentinel)**

  反客为主的自动版，能够后台监控主机是否故障，如果故障了根据投票数自动将从库转换为主库。

  自定义的/myredis目录下新建sentinel.conf文件，名字绝不能错。
  
  配置哨兵,填写内容
  
  ```bash
  # 最后一个数字1，表示主机挂掉后salve投票看让谁接替成为主机，得票数多少后成为主机
  sentinel monitor 被监控数据库名字(自己起名字) 127.0.0.1 6379 1
  ```
  
  启动哨兵
  
  ```bash
  redis-sentinel /myredis/sentinel.conf
  ```
  
  问题：如果之前的master重启回来，会不会双master冲突？
  
  
  
  一组sentinel能同时监控多个Master

#### 4、复制原理

slave启动成功连接到master后会发送一个sync命令。

Master接到命令启动后台的存盘进程，同时收集所有接收到的用于修改数据集命令，在后台进程执行完毕之后，master将传送整个数据文件到slave,以完成一次完全同步。

全量复制：而slave服务在接收到数据库文件数据后，将其存盘并加载到内存中。

增量复制：Master继续将新的所有收集到的修改命令依次传给slave,完成同步

但是只要是重新连接master,一次完全同步（全量复制)将被自动执行。

#### 5、复制的缺点

复制延时：由于所有的写操作都是先在Master上操作，然后同步更新到Slave上，所以从Master同步到Slave机器有一定的延迟，当系统很繁忙的时候，延迟问题会更加严重，Slave机器数量的增加也会使这个问题更加严重。

## 九、Redis的Java客户端

#### 1、Jedis所需要的jar包

commons-pool-1.6.jar
jedis-2.1.0.jar

#### 2、Jedis常用操作

- 测试连通性

  ```java
  public class Demo01 {
      public static void main(String[] args) {
          //连接本地的 Redis 服务<br><br>        
          Jedis jedis = new Jedis("127.0.0.1",6379);
          //查看服务是否运行，打出pong表示OK
          System.out.println("connection is OK==========>: "+jedis.ping());
      }
  }
  ```

- key以及五大数据类型

  ```java
  
  ```

- 事务提交

  ```java
  // 日常
  
  
  
  // 加锁
  
  
  ```

- 主从复制

  ```java
  
  ```

#### 3、JedisPool

获取Jedis实例需要从JedisPool中获取	

用完Jedis实例需要返还给JedisPool

如果Jedis在使用过程中出错，则也需要还给JedisPool

案例见代码

```java
// JedisPoolUtil


```

配置总结

```bash
JedisPool的配置参数大部分是由JedisPoolConfig的对应项来赋值的。

maxActive：控制一个pool可分配多少个jedis实例，通过pool.getResource()来获取；如果赋值为-1，则表示不限制；如果pool已经
分配了maxActive个jedis实例，则此时pool的状态为exhausted。

maxIdle：控制一个pool最多有多少个状态为idle(空闲)的jedis实例；

whenExhaustedAction：表示当pool中的jedis实例都被allocated完时，pool要采取的操作；默认有三种。

WHEN*EXHAUSTED*FAIL --> 表示无jedis实例时，直接抛出NoSuchElementException；

WHEN*EXHAUSTED*BLOCK --> 则表示阻塞住，或者达到maxWait时抛出JedisConnectionException；

WHEN*EXHAUSTED*GROW --> 则表示新建一个jedis实例，也就说设置的maxActive无用；

maxWait：表示当 borrow一个 jedis实例时，最大的等待时间，如果超过等待时间，则直接抛 JedisConnection Exception 

testOnBorrow：获得一个jeds实例的时候是否检查连接可用性（ping（）；如果为true，则得到的jdis实例均是可用的

testOnReturn:return一个 jedis实例给poo时，是否检查连接可用性（ping（）；
```



