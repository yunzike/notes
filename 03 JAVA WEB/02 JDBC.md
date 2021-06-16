## 1、入门

### 1.1 概述

- JDBC

  Java提供的支持数据库应用开发的一组API。提供多种关系数据库统一访问接口，屏蔽了底层技术细节，使得开发者不用关心数据库具体实现和不同数据库的差异。

### 1.2 实现

- 步骤

  ①装载驱动（并注册驱动）

  ②获取数据库连接

  ③编写并执行SQL语句

  ④获取执行结果

  ⑤清理资源

- 简单实现

  ```java
  public class SimpleJdbc {
      public static void main(String[] args) {
          Connection conn = null;
          Statement stm = null;
          ResultSet res = null;
  
          try {
              //1.加载数据库驱动(驱动中自动执行了注册)
              Class.forName("com.mysql.jdbc.Driver");
  
              //2.获取数据库连接
              String url = "jdbc:mysql://120.79.246.19:3306/test?useSSL=false";
              String user = "root";
              String password = "yunzk123";
              conn = DriverManager.getConnection(url, user, password);
  
              //3.编写SQL语句并执行
              stm = conn.createStatement();
              String sql = "SELECT c.`name`,c.email,c.birth FROM customers c WHERE c.id > 2;";
              res = stm.executeQuery(sql);
  
              //4、处理结果数据
              while (res.next()) {
                  String name = res.getString(1);
                  String email = res.getString("email");
                  String birth = res.getString(3);
  
                  System.out.print("name = " + name);
                  System.out.print("email = " + email);
                  System.out.print("birth = " + birth);
                  System.out.println();
              }
          } catch (Exception e) {
              e.printStackTrace();
          } finally {//5、关闭资源
              if (res != null) {
                  try {
                      res.close();
                  } catch (SQLException e) {
                      e.printStackTrace();
                  }
              }
              if (stm != null) {
                  try {
                      stm.close();
                  } catch (SQLException e) {
                      e.printStackTrace();
                  }
              }
              if (conn != null) {
                  try {
                      conn.close();
                  } catch (SQLException e) {
                      e.printStackTrace();
                  }
              }
          }
  
      }
  }
  ```

- 抽取工具类

  ```java
  /**
   * @author xiongxiaoqi
   * @Description JDBCUtils
   * @date 2019/11/22 22:46
   * version: 1.0
   */
  public class JDBCUtils {
  
      /*
      获取数据库连接
       */
      public static Connection getConnection() throws IOException, ClassNotFoundException, SQLException {
          //1、获取数据库连接四要素
          InputStream is = JDBCUtils.class.getClassLoader().getResourceAsStream("jdbc.properties");
          Properties prop = new Properties();
          prop.load(is);
  
          String driverName = prop.getProperty("driverName");
          String url = prop.getProperty("url");
          String user = prop.getProperty("user");
          String password = prop.getProperty("password");
  
          //2、加载驱动
          Class.forName(driverName);
  
          //3、获取连接
          Connection conn = DriverManager.getConnection(url,user,password);
  
          return conn;
      }
  
      /*
      关闭连接和Statement操作
       */
      public static void closeResource(Connection conn, Statement ps){
          try {
              if (ps != null) {
                  ps.close();
              }
          } catch (SQLException e) {
              e.printStackTrace();
          }
          try {
              if (conn != null) {
                  conn.close();
              }
          } catch (SQLException e) {
              e.printStackTrace();
          }
      }
  
      /*
      关闭资源
       */
      public static void closeResource(Connection conn, Statement ps, ResultSet res){
          try {
              if (res != null) {
                  res.close();
              }
          } catch (SQLException e) {
              e.printStackTrace();
          }
          closeResource(conn,ps);
      }
  
  }
  
  
  
  /**
   * @author xiongxiaoqi
   * @Description JdbcUseUtils
   * @date 2019/11/22 23:02
   * version: 1.0
   */
  public class JdbcUseUtils {
      @Test
      public void testJDBCUtils() {
          Connection conn = null;
          PreparedStatement ps = null;
          ResultSet res = null;
          try {
              //1、获取连接
              conn = JDBCUtils.getConnection();
  
              //2、预编译SQL，并返会PrepareStatement的实例对象
              String sql = "SELECT t.`name`,t.email,t.birth FROM customers t WHERE t.id > ?;";
              ps = conn.prepareStatement(sql);
  
              //3、填充占位符
              ps.setInt(1,1);
  
              //4、执行
              res = ps.executeQuery();
  
              //5、处理结果集
              while (res.next()){
                  String name = res.getString(1);
                  String email = res.getString("email");
                  Date date = res.getDate(3);
  
                  System.out.print(name + " ");
                  System.out.print(email + " ");
                  System.out.println(date);
              }
          } catch (Exception e) {
              e.printStackTrace();
          } finally {
              //6、关闭资源
              JDBCUtils.closeResource(conn,ps,res);
          }
      }
  }
  ```

### 1.3 常用接口和对象

- Connection

  ```java
  createStatement();              //创建Statement对象
  prepareStatement(String sql);   //创建PrepareSatement对象并预编译SQL
  prepareCall(String sql);        //创建执行存储过程的callableStatement对象
  
  setAutoCommit(boolean autoCommit);//设置事务自动提交
  commit();                      //提交事务
  rollback();                    //回滚事务
  ```

- Statement

  ```java
  execute(String sql); //任意sql语句都可以，但是目标不明确，很少用
  executeQuery(String sql); //查询
  executeUpdate(String sql); //增删改
  
  addBatch(String sql);    //把多条的sql语句放进同一个批处理中
  executeBatch();            //向数据库发送一批sql语句执行
  ```

- PreparedStatement

  ```java
  //方法
  setObject(int index,Object obj);    //填充指定位置占位符为Object
  setXxx(int index,Xxx parameter);    //填充指定位置占位符为parameter
  ```

- ResultSet

  ```java
  getObject(String columnName);        //获取任意类型的数据
  getXxx(String columnName);           //获取指定Xxx类型的数据
  
  //对结果集进行滚动查看的方法
  next();
  Previous();
  absolute(int row);
  beforeFirst();
  afterLast();
  ```

- Statement和PrepareStatement

  ①PreaparedStatement对象继承自Statement对象，功能更加强大。

  ②Statement对象编译SQL语句时，如果SQL语句有变量，就需要使用分隔符来隔开，如果变量非常多，就会使SQL变得非常复杂。**PreparedStatement可以使用占位符，简化sql的编写**

  ③Statement会频繁编译SQL。**PreparedStatement可对SQL进行预编译，提高效率，预编译的SQL存储在PreparedStatement对象中**

  ④**PreparedStatement防止SQL注入**。【Statement通过分隔符'++',编写永等式，可以不需要密码就进入数据库】



## 2、获取连接

### 2.1 概述

- 获取数据库连接四要素

- 加载并注册驱动

- 获取连接

### 2.2 常用数据库驱动与URL

URL为相应数据库的地址，包含协议、子协议、子名称三部分，其中子名称又包括主机、端口、数据库名等。

- MySQL

  ```java
  //驱动
  com.mysql.jdbc.Driver
  
  //url
  //jdbc:mysql://主机名称:mysql服务端口号/数据库名称?参数=值&参数=值
  
  
  //对于高版本MySQL需要指定useSSL=false,或者为true并提供安全证书
  //否则会报警告
  jdbc:mysql://120.79.246.19:3306/test?useSSL=false
  
  //程序与服务器端的字符集不一致，会导致乱码，指定服务器端的字符
  useUnicode=true&characterEncoding=utf8
  ```

- Oracle

  ```java
  //驱动
  oracle.jdbc.OracleDriver
  
  //url
  //jdbc:oracle:thin:@主机名称:oracle服务端口号:数据库名称
  jdbc:oracle:thin:@192.168.2.58:1521:orcl
  ```

- SQLServer

  ```java
  //驱动
  oracle.jdbc.OracleDriver
  //url
  //jdbc:sqlserver://主机名称:sqlserver端口号:DatabaseName=数据库名称
  jdbc:oracle:thin:@192.168.2.58:1521:orcl
  ```


### 2.3 连接方式

- 方式一

  **直接使用第三方数据库的API**  

  获取Driver对象，并通过Driver对象获取连接(需要传入Properties对象)

  ```java
  //1、直接使用第三方数据库的API,获取数据库Driver对象
  Driver driver = new com.mysql.jdbc.Driver();
  
  //2、提供url，指明具体操作的数据
  String url = "jdbc:mysql://120.79.246.19:3306/test?useSSL=false";
  
  //3、创建Properties的对象，指明用户名和密码
  Properties info = new Properties();
  info.setProperty("user", "root");
  info.setProperty("password", "yunzk123");
  
  //4、直接使用driver的connect()，获取连接
  Connection conn = driver.connect(url, info);
  ```

- 方式二

  在方式一的基础上，**使用反射实例化Driver**  

  不在代码中体现第三方数据库的API，体现了面向接口编程思想

  ```java
  //1、使用反射，获取数据库Driver对象
  Class clazz = Class.forName("com.mysql.jdbc.Driver");
  Driver driver = (Driver) clazz.newInstance();
  
  //2、提供url，指明具体操作的数据
  String url = "jdbc:mysql://120.79.246.19:3306/test?useSSL=false";
  
  //3、创建Properties的对象，指明用户名和密码
  Properties info = new Properties();
  info.setProperty("user", "root");
  info.setProperty("password", "yunzk123");
  
  //4、直接使用driver的connect()，获取连接
  Connection conn = driver.connect(url, info);
  ```

- 方式三

  **使用反射实例化Driver且使用java.sql.DriverManager注册驱动并获取数据库的连接**，不需要创建Properties对象。

  ```java
  //1、提供数据库连接四要素
  String url = "jdbc:mysql://120.79.246.19:3306/test?useSSL=false";
  String user = "root";
  String password = "yunzk123";
  String driverName = "com.mysql.jdbc.Driver";
  
  //2、使用反射，获取数据库Driver对象
  Class clazz = Class.forName(driverName);
  Driver driver = (Driver) clazz.newInstance();
  
  //3、使用java.sql.DriverManager注册驱动
  DriverManager.registerDriver(driver);
  
  //4、使用java.sql.DriverManager获取连接
  Connection conn = DriverManager.getConnection(url, user, password);
  ```

- 方式四

  提供数据库连接四要素

  **通过反射加载Driver类，自动实例化并注册驱动**

  ```java
  //1、提供数据库连接四要素
  String url = "jdbc:mysql://120.79.246.19:3306/test?useSSL=false";
  String user = "root";
  String password = "yunzk123";
  String driverName = "com.mysql.jdbc.Driver";
  
  //2、加载驱动
  Class.forName(driverName);
  /*在mysql的Driver类中声明有以下代码，只要加载Driver类，就自动实例化并注册了Driver
  static {
      try {
          DriverManager.registerDriver(new Driver());
      } catch (SQLException var1) {
          throw new RuntimeException("Can't register driver!");
      }
  }*/
  
  //3、获取连接
  Connection conn = DriverManager.getConnection(url, user, password);
  ```

- 方式五

  通过配置文件指定数据连接四要素

  ```java
  /**
   * 连接数据库
   */
  
  //1、加载配置文件获取数据库连接四要素
  InputStream is = ConnTest.class.getClassLoader().getResourceAsStream("jdbc.properties");
  Properties prop = new Properties();
  prop.load(is);
  
  String url = prop.getProperty("url");
  String user = prop.getProperty("user");
  String password = prop.getProperty("password");
  String driverName = prop.getProperty("driverName");
  
  //2、加载驱动
  Class.forName(driverName);
  
  //3、获取连接
  Connection conn = DriverManager.getConnection(url, user, password);
  ```

  ```java
  /** * 数据库配置文件：jdbc.properties */ user=rootpassword=yunzk123url=jdbc:mysql://120.79.246.19:3306/test?useSSL=falsedriverName=com.mysql.jdbc.Driver
  ```



## 3、通用操作

### 3.1 通用的增删改

```java
/**
 * 通用的 增删改操作
 *
 * @param sql
 * @param args
 */
public void update(String sql, Object... args) {
    Connection conn = null;
    PreparedStatement ps = null;
    try {
        //1、获取数据库连接
        conn = JDBCUtils.getConnection();
        //2、预编译SQL语句，返回PrepareStatement的实例
        ps = conn.prepareStatement(sql);
        //3、填充占位符
        for (int i = 0; i < args.length; i++) {
            ps.setObject(i + 1, args[i]);
        }
        //4、执行操作
        ps.execute();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        //5、关闭资源
        JDBCUtils.closeResource(conn, ps);
    }
}
```



### 3.2 通用的查询

```java
/**
* 通用的 查询操作 返回指定对象
* @param clazz
* @param sql
* @param args
* @param <T>
* @return T
*/
public <T> T getInstance(Class<T> clazz, String sql, Object... args) {
Connection conn = null;
PreparedStatement ps = null;
ResultSet res = null;
try {
    //1、获取连接
    conn = JDBCUtils.getConnection();
    //2、预编译SQL语句，获取PrepareStatement实例
    ps = conn.prepareStatement(sql);
    //3、填充占位符
    for (int i = 0; i < args.length; i++) {
        ps.setObject(i + 1, args[i]);
    }
    //4、执行操作,获取结果集
    res = ps.executeQuery();

    //5、处理结果集
    ResultSetMetaData rsmd = res.getMetaData();//获取结果集的元数据
    int columnCount = rsmd.getColumnCount();//列数

    if (res.next()) {
        T t = clazz.newInstance();
        for (int i = 0; i < columnCount; i++) {//遍历每个列
            //获取列值
            Object columnVal = res.getObject(i + 1);
            //获取列名
            String columnLabel = rsmd.getColumnLabel(i + 1);

            //使用反射给对象的相应属性赋值
            Field field = clazz.getDeclaredField(columnLabel);
            field.setAccessible(true);
            field.set(t,columnVal);
        }
        return t;
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    JDBCUtils.closeResource(conn,ps,res);
}
return null;
```



## 4、操作 BLOB

### 4.1 概述

#### 1、 Java与SQL对应数据类型转换表

| Java类型           | SQL类型                  |
| ------------------ | ------------------------ |
| boolean            | BIT                      |
| byte               | TINYINT                  |
| short              | SMALLINT                 |
| int                | INTEGER                  |
| long               | BIGINT                   |
| String             | CHAR,VARCHAR,LONGVARCHAR |
| byte   array       | BINARY  ,    VAR BINARY  |
| java.sql.Date      | DATE                     |
| java.sql.Time      | TIME                     |
| java.sql.Timestamp | TIMESTAMP                |

#### 2、BLOB类型

- MySQL中，BLOB是一个二进制大型对象，是一个可以存储大量数据的容器，它能容纳不同大小的数据。

- 插入BLOB类型的数据必须使用PreparedStatement，因为BLOB类型的数据无法使用字符串拼接写的。

- MySQL的四种BLOB类型(除了在存储的最大信息量上不同外，他们是等同的)

  | 类型       | 大小（单位：字节） |
  | ---------- | ------------------ |
  | TinyBlob   | 最大 255           |
  | Blob       | 最大 65K           |
  | MediumBlob | 最大 16M           |
  | LongBlob   | 最大 4G            |

- 实际使用中根据需要存入的数据大小定义不同的BLOB类型。

- 需要注意的是：如果存储的文件过大，数据库的性能会下降。

- 如果在指定了相关的Blob类型以后，还报错：xxx too large，那么在mysql的安装目录下，找my.ini文件加上如下的配置参数： **max_allowed_packet=16M**。同时注意：修改了my.ini文件之后，需要重新启动mysql服务。

### 4.2 操作BLOB

- 插入、修改

  ```java
  /**
   * 插入、修改Blob数据
   */
  @Test
  public void insertBlob() {
      Connection conn = null;
      PreparedStatement ps = null;
      FileInputStream fis = null;
      try {
          //1、获取连接
          conn = JDBCUtils.getConnection();
          //2、预编译SQL并获取PrepareStatement对象
          String sql = "insert into customers(name,email,birth,photo)values(?,?,?,?)";
          ps = conn.prepareStatement(sql);
          //3、填充占位符
          ps.setString(1, "梅长苏");
          ps.setString(2, "meichangsu@126.com");
          ps.setDate(3, new Date(new java.util.Date().getTime()));
          // 获取存储Blob的流，并使用setBlob方法填充占位符
          File file=new File("123.jpg");
          System.out.println(file.getAbsolutePath());
          System.out.println(System.getProperty("user.dir"));
  
          fis = new FileInputStream("123.jpg");
          ps.setBlob(4, fis);
          //4、执行
          ps.execute();
      } catch (Exception e) {
          e.printStackTrace();
      } finally {//5、释放资源
          try {
              if (fis != null) {
                  fis.close();
              }
          } catch (IOException e) {
              e.printStackTrace();
          }
          JDBCUtils.closeResource(conn, ps);
      }
  }
  ```

- 查询

  ```java
  /**
   * 查询Blob数据
   */
  @Test
  public void queryBlob() {
      Connection conn = null;
      PreparedStatement ps = null;
      ResultSet res = null;
      InputStream is = null;
      OutputStream os = null;
      try {
          //1、获取连接
          conn = JDBCUtils.getConnection();
          //2、预编译SQL并获取PrepareStatement对象
          String sql = "SELECT * from customers where id = ?";
          ps = conn.prepareStatement(sql);
          //3、填充占位符
          ps.setInt(1, 16);
          //4、执行
          res = ps.executeQuery();
          if (res.next()) {
              Integer id = res.getInt(1);
              String name = res.getString(2);
              String email = res.getString(3);
              Date birth = res.getDate(4);
              Customers cust = new Customers(id, name, email, birth);
              System.out.println(cust);
  
              //读取Blob类型的字段
              Blob photo = res.getBlob(5);
              is = photo.getBinaryStream();
              os = new FileOutputStream("c.jpg");
              byte[] buffer = new byte[1024];
              int len = 0;
              while ((len = is.read(buffer)) != -1) {
                  os.write(buffer, 0, len);
              }
          }
      } catch (Exception e) {
          e.printStackTrace();
      } finally {
          try {
              if (os != null) {
                  os.close();
              }
          } catch (IOException e) {
              e.printStackTrace();
          }
          try {
              if (is != null) {
                  is.close();
              }
          } catch (IOException e) {
              e.printStackTrace();
          }
          JDBCUtils.closeResource(conn, ps, res);
      }
  }
  ```

  

## 5、批量插入

### 5.1 概述

- 批量插入

  当需要成批插入或者更新记录时，可以采用Java的批量**更新机制**，这一机制允许多条语句一次性提交给数据库批量处理。通常情况下比单独提交处理更有效率。

- JDBC批量处理语句

  ```java
  addBatch(String);     //添加需要批量处理的SQL语句或是参数
  executeBatch();       //执行批量处理语句
  clearBatch();         //清空缓存的数据
  ```

- 批量执行SQL的两种方式

  ① 多条SQL语句的批量处理；

  ② 一个SQL语句的批量传参；

- 实现测试表

  ```sql
  CREATE TABLE goods(
      id INT PRIMARY KEY AUTO_INCREMENT,
      NAME VARCHAR(20)
  );
  ```

### 5.2 实现

- 方式一：使用Statement

  ```java
  Connection conn = JDBCUtils.getConnection();
  Statement stmt = conn.createStatement();
  
  for (int i = 0; i < 20000; i++) {
      String name = "name" + i;
      String sql = "insert into goods(NAME) values('" + name + "')";
      stmt.executeUpdate(sql);
  }
  JDBCUtils.closeResource(conn, stmt);
  ```

- 方式二：使用PreparedStatement

  ```java
  long startTime = System.currentTimeMillis();
  
  Connection conn = JDBCUtils.getConnection();
  String sql = "insert into goods(name) values(?)";
  PreparedStatement ps = conn.prepareStatement(sql);
  for (int i = 0; i < 20000; i++) {
      ps.setString(1, "name_" + i);
      ps.executeUpdate();
  }
  
  long endTime = System.currentTimeMillis();
  System.out.println("花费的时间为：" + (endTime - startTime));//82340
  
  JDBCUtils.closeResource(conn, ps);
  ```

- 方式三

  ```java
  /**
   * mysql服务器默认是关闭批处理的，需要设置参数开启批处理的支持。
   * ?rewriteBatchedStatements=true 写在配置文件的url后面 
   * 版本太低的jdbc驱动不支持批处理
   */
  long startTime = System.currentTimeMillis();
  
  Connection conn = JDBCUtils.getConnection();
  String sql = "insert into goods(name) values(?)";
  PreparedStatement ps = conn.prepareStatement(sql);
  for (int i = 0; i < 1000000; i++) {
      ps.setString(1, "name_" + i);
      //1、添加到批处理
      ps.addBatch();
      if (i % 500 == 0) {
          //2、执行批处理
          ps.executeBatch();
          //3、清空批处理
          ps.clearBatch();
      }
  }
  //执行未满一整批的批处理
  ps.executeBatch();
  //清空批处理
  ps.clearBatch();
  
  long endTime = System.currentTimeMillis();
  //20000条数据：1760,1000000条数据：57822
  System.out.println("花费的时间为：" + (endTime - startTime));
  JDBCUtils.closeResource(conn, ps);
  ```

- 方式四：

  ```java
  /**
   * 在方式三的基础上，优化提交
   */
  long startTime = System.currentTimeMillis();
  
  Connection conn = JDBCUtils.getConnection();
  //设置禁止自动提交
  conn.setAutoCommit(false);
  
  String sql = "insert into goods(name) values(?)";
  PreparedStatement ps = conn.prepareStatement(sql);
  for (int i = 0; i < 1000000; i++) {
      ps.setString(1, "name_" + i);
      //1、添加到批处理
      ps.addBatch();
      if (i % 500 == 0) {
          //2、执行批处理
          ps.executeBatch();
          //3、清空批处理
          ps.clearBatch();
      }
  }
  //执行未满一整批的批处理
  ps.executeBatch();
  //清空批处理
  ps.clearBatch();
  
  //一次性提交数据
  conn.commit();
  
  long endTime = System.currentTimeMillis();
  //1000000条数据：50190
  System.out.println("花费的时间为：" + (endTime - startTime));
  JDBCUtils.closeResource(conn, ps);
  ```

## 6、数据库事务

### 6.1 概述

- 事务

  一组逻辑操作单元，使数据从一种状态变换到另一种状态。

- 事务处理（事务操作）

  **保证所有事务都作为一个工作单元来执行，即使出现了故障，都不能改变这种执行方式。当在一个事务中执行多个操作时，要么所有的操作都被提交(commit)**，那么这些修改就永久地保存下来；要么数据库管理系统将放弃所作的所有修改，整个事务**回滚(rollback)**到最初状态。

- 为确保数据库中数据的**一致性**，数据的操纵应当是离散的成组的逻辑单元：当它全部完成时，数据的一致性可以保持，而当这个单元中的一部分操作失败，整个事务应全部视为错误，所有从起始点以后的操作应全部回退到开始状态。

### 6.2 数据库事务

#### 1、事务的ACID属性

- 原子性（Atomicity）

  原子性是指事务是一个不可分割的工作单位，事务中的操作要么都发生，要么都不发生。

- 一致性（Consistency）

  事务必须是数据库从一个一致性状态变换到另一个一致性状态。

- 隔离性（Isolation）

  事务的隔离性是指一个事务的执行不能被其他事务干扰，即一个事务内部操作及使用的数据对并发的其他事务是隔离的，并发执行的各个事务之间不能互相干扰。

- 持久性（Durability）

  一个事务一旦被提交，它对数据库中的数据的改变就是永久性的，接下来的其他操作和数据库故障不应该对其有任何影响。

#### 2、数据库的并发问题

对于同时运行的多个事务, 当这些事务访问数据库中相同的数据时, 如果没有采取必要的隔离机制, 就会导致各种并发问题

- **脏读**：对于两个事务T1，T2。T1**读取了已经**被T2**更新但还没有被提交**的字段。之后，若T2回滚，T1读取的内容就是临时且无效的。**即事务读取其他事务更新而未提交的数据。**

- **不可重复读**：对于两个事务T1，T2。T1读取了一个字段，然后T2更新了该字段。之后，T1再次读取同一个字段，值就不同了。**即事务在其他事务更新数据（针对字段值）前后读取被更新的数据的值不同。**

- **幻读**：对于两个事务T1，T2。T1从一个表中读取数据，然后T2在该表中插入了新的行。之后，如果T1再次读取同一个表，就会多出几行。**即事务在其他事务更新数据行数（针对数据表的行）前后读取该表数据获取到的行数不同。**

#### 3、四种隔离级别

| 隔离级别                         | 描述                                                         |
| -------------------------------- | ------------------------------------------------------------ |
| READ UNCOMMITTED（读未提交数据） | 允许事务读取为被其他事务提交的变更，脏读、不可重复读、幻读的问题都会出现 |
| READ COMMITTED（读已提交数据）   | 只允许事务读已经被其他事务提交的变更，可以避免脏读，但不可重复读和幻读问题仍可能出现。 |
| REPEATABLE READ（可重复读）      | 确保事务可以多次从一个字段读取相同的值。在这个事务持续期间，禁止其他事务对这个字段进行更新。可以避免脏读和不可重复读，但幻读问题仍然存在。 |
| SERIALLZABLE（串行化）           | 确保事务可以从一个表中读取相同的行。在这个事务持续期间，禁止其他事务对该表执行插入、更新和删除操作。所有并发问题都可以避免，但性能十分低下。 |

- Oracle支持的2种事务隔离级别：READ COMMITTED（默认）、SERIALLZABLE

- MySQL支持所有四种隔离级别：默认为REPEATABLE READ

#### 4、MySQL中事务隔离级别设置

- 每启动一个mysql程序，就会获得一个单独的数据库连接。每个数据库连接都有一个全局的变量@@tx_isolation，表示当前的事务隔离级别。

- 查看当前的隔离级别

  ```sql
  SELECT @@tx_isolation;
  ```

- 设置当前mysql连接的隔离级别

  ```sql
  set global transaction isolation level read committed;
  ```

- 数据库用户操作

  ```sql
  create user tom identified by 'abc123';
  ```

- 用户权限操作

  ```sql
  #授予通过网络方式登录的tom用户，对所有库所有表的全部权限，密码设为abc123.
  grant all privileges on *.* to tom@'%' identified by 'abc123';
   
  #给tom用户使用本地命令行方式，授予atguigudb这个库下的所有表的插删改查的权限。
  grant select,insert,delete,update on atguigudb.* to tom@localhost identified by 'abc123';
  ```

#### 5、JDBC中事务操作





## 7、数据库连接池



## 8、JDBC 进阶

### 8.1 PreparedStatement对象

PreaparedStatement对象继承自Statement对象，功能更加强大。

1.  Statement对象编译SQL语句时，如果SQL语句有变量，就需要使用分隔符来隔开，如果变量非常多，就会使SQL变得非常复杂。**PreparedStatement可以使用占位符，简化sql的编写**

2.  Statement会频繁编译SQL。**PreparedStatement可对SQL进行预编译，提高效率，预编译的SQL存储在PreparedStatement对象中**

3.  **PreparedStatement防止SQL注入**。【Statement通过分隔符'++',编写永等式，可以不需要密码就进入数据库】

```java
//模拟查询id为2的信息
String id = "2";

Connection connection = UtilsDemo.getConnection();

String sql = "SELECT * FROM users WHERE id = ?";
PreparedStatement preparedStatement = connection.preparedStatement(sql);

//第一个参数表示第几个占位符【也就是?号】，第二个参数表示值是多少
preparedStatement.setString(1,id);

ResultSet resultSet = preparedStatement.executeQuery();

if (resultSet.next()) {
    System.out.println(resultSet.getString("name"));
}

//释放资源
UtilsDemo.release(connection, preparedStatement, resultSet);
```

### 8.2 批处理

当需要向数据库发送一批SQL语句执行时，应避免向数据库一条条发送执行，**采用批处理以提升执行效率**

批处理有两种方式：

1.  Statement

2.  PreparedStatement

**通过executeBath()方法批量处理执行SQL语句，返回一个int[]数组，该数组代表各句SQL的返回值**

以下代码是以Statement方式实现批处理

```java
/*
* Statement执行批处理
*
* 优点：
*       可以向数据库发送不同的SQL语句
* 缺点：
*       SQL没有预编译
*       仅参数不同的SQL，需要重复写多条SQL
* */
Connection connection = UtilsDemo.getConnection();

Statement statement = connection.createStatement();
String sql1 = "UPDATE users SET name='zhongfucheng' WHERE id='3'";
String sql2 = "INSERT INTO users (id, name, password, email, birthday)" +
        " VALUES('5','nihao','123','ss@qq.com','1995-12-1')";

//将sql添加到批处理
statement.addBatch(sql1);
statement.addBatch(sql2);

//执行批处理
statement.executeBatch();

//清空批处理的sql
statement.clearBatch();

UtilsDemo.release(connection, statement, null);
```

以下方式以PreparedStatement方式实现批处理

```java
/*
* PreparedStatement批处理
*   优点：
*       SQL语句预编译了
*       对于同一种类型的SQL语句，不用编写很多条
*   缺点：
*       不能发送不同类型的SQL语句
*
* */
Connection connection = UtilsDemo.getConnection();

String sql = "INSERT INTO test(id,name) VALUES (?,?)";
PreparedStatement preparedStatement = connection.prepareStatement(sql);

for (int i = 1; i <= 205; i++) {
    preparedStatement.setInt(1, i);
    preparedStatement.setString(2, (i + "zhongfucheng"));

    //添加到批处理中
    preparedStatement.addBatch();

    if (i %2 ==100) {

        //执行批处理
        preparedStatement.executeBatch();

        //清空批处理【如果数据量太大，所有数据存入批处理，内存肯定溢出】
        preparedStatement.clearBatch();
    }

}
//不是所有的%2==100，剩下的再执行一次批处理
preparedStatement.executeBatch();

//再清空
preparedStatement.clearBatch();

UtilsDemo.release(connection, preparedStatement, null);
```

### 8.3 处理大文本和二进制数据

**clob和blob**

-   clob用于存储大文本

-   blob用于存储二进制数据

#### MySQL

**MySQL存储大文本是用Text【代替clob】**，Test又分为4类

-   TINYTEXT

-   TEXT

-   MEDIUMTEXT

-   LONGTEXT

**同理blob也有这4类**

下面用JDBC连接MySQL数据库去操作大文本数据和二进制数据

```java
/*
*用JDBC操作MySQL数据库去操作大文本数据
*
*setCharacterStream(int parameterIndex,java.io.Reader reader,long length)
*第二个参数接收的是一个流对象，因为大文本不应该用String来接收，String太大会导致内存溢出
*第三个参数接收的是文件的大小
*
* */
public class Demo5 {

    @Test
    public void add() {

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = JdbcUtils.getConnection();
            String sql = "INSERT INTO test2 (bigTest) VALUES(?) ";
            preparedStatement = connection.prepareStatement(sql);

            //获取到文件的路径
            String path = Demo5.class.getClassLoader().getResource("BigTest").getPath();
            File file = new File(path);
            FileReader fileReader = new FileReader(file);

            //第三个参数，由于测试的Mysql版本过低，所以只能用int类型的。高版本的不需要进行强转
            preparedStatement.setCharacterStream(1, fileReader, (int) file.length());

            if (preparedStatement.executeUpdate() > 0) {
                System.out.println("插入成功");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(connection, preparedStatement, null);
        }


    }

    /*
    * 读取大文本数据，通过ResultSet中的getCharacterStream()获取流对象数据
    * 
    * */
    @Test
    public void read() {

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = JdbcUtils.getConnection();
            String sql = "SELECT * FROM test2";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {

                Reader reader = resultSet.getCharacterStream("bigTest");

                FileWriter fileWriter = new FileWriter("d:\\abc.txt");
                char[] chars = new char[1024];
                int len = 0;
                while ((len = reader.read(chars)) != -1) {
                    fileWriter.write(chars, 0, len);
                    fileWriter.flush();
                }
                fileWriter.close();
                reader.close();

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(connection, preparedStatement, resultSet);
        }

    }
```

```java
/*
* 使用JDBC连接MYsql数据库操作二进制数据
* 如果我们要用数据库存储一个大视频的时候，数据库是存储不到的。
* 需要设置max_allowed_packet，一般我们不使用数据库去存储一个视频
* */
public class Demo6 {

    @Test
    public void add() {


        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;


        try {
            connection = JdbcUtils.getConnection();
            String sql = "INSERT INTO test3 (blobtest) VALUES(?)";
            preparedStatement = connection.prepareStatement(sql);

            //获取文件的路径和文件对象
            String path = Demo6.class.getClassLoader().getResource("1.wmv").getPath();
            File file = new File(path);

            //调用方法
            preparedStatement.setBinaryStream(1, new FileInputStream(path), (int)file.length());

            if (preparedStatement.executeUpdate() > 0) {

                System.out.println("添加成功");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(connection, preparedStatement, null);
        }

    }

    @Test
    public void read() {


        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;


        try {
            connection = JdbcUtils.getConnection();
            String sql = "SELECT * FROM test3";
            preparedStatement = connection.prepareStatement(sql);

            resultSet = preparedStatement.executeQuery();


            //如果读取到数据，就把数据写到磁盘下
            if (resultSet.next()) {
                InputStream inputStream = resultSet.getBinaryStream("blobtest");
                FileOutputStream fileOutputStream = new FileOutputStream("d:\\aa.jpg");

                int len = 0;
                byte[] bytes = new byte[1024];
                while ((len = inputStream.read(bytes)) > 0) {

                    fileOutputStream.write(bytes, 0, len);

                }
                fileOutputStream.close();
                inputStream.close();

            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(connection, preparedStatement, null);
        }

    }
```

Oracle

下面用JDBC连接Oracle数据库去操作大文本数据和二进制数据

```java
//使用JDBC连接Oracle数据库操作二进制数据

/*
* 对于Oracle数据库和Mysql数据库是有所不同的。
* 1.Oracle定义了BLOB字段，但是这个字段不是真正地存储二进制数据
* 2.向这个字段存一个BLOB指针，获取到Oracle的BLOB对象,把二进制数据放到这个指针里面,指针指向BLOB字段
* 3.需要事务支持
*
* */
public class Demo7 {
    @Test
    public void add() {


        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = UtilsDemo.getConnection();

            //开启事务
            connection.setAutoCommit(false);

            //插入一个BLOB指针
            String sql = "insert into test4(id,image) values(?,empty_blob())";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, 1);
            preparedStatement.executeUpdate();

            //把BLOB指针查询出来,得到BLOB对象
            String sql2 = "select image from test4 where id= ? for update";
            preparedStatement = connection.prepareStatement(sql2);
            preparedStatement.setInt(1, 1);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                //得到Blob对象--当成是Oracle的Blob,不是JDBC的,所以要强转[导的是oracle.sql.BLOB包]
                BLOB  blob = (BLOB) resultSet.getBlob("image");

                //写入二进制数据
                OutputStream outputStream = blob.getBinaryOutputStream();

                //获取到读取文件读入流
                InputStream inputStream = Demo7.class.getClassLoader().getResourceAsStream("01.jpg");

                int len=0;
                byte[] bytes = new byte[1024];
                while ((len = inputStream.read(bytes)) > 0) {

                    outputStream.write(bytes, 0, len);
                }
                outputStream.close();
                inputStream.close();
                connection.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            UtilsDemo.release(connection, preparedStatement, null);
        }

    }

    @Test
    public void find() {

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = UtilsDemo.getConnection();
            String sql = "SELECT * FROM test4 WHERE id=1";

            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {

                //获取到BLOB对象
                BLOB blob = (BLOB) resultSet.getBlob("image");

                //将数据读取到磁盘上
                InputStream inputStream = blob.getBinaryStream();
                FileOutputStream fileOutputStream = new FileOutputStream("d:\\zhongfucheng.jpg");
                int len=0;
                byte[] bytes = new byte[1024];

                while ((len = inputStream.read(bytes)) > 0) {

                    fileOutputStream.write(bytes, 0, len);
                }

                inputStream.close();
                fileOutputStream.close();

            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            UtilsDemo.release(connection, preparedStatement, null);
        }
    }
}
```

### 8.4 获取数据库自动主键列







