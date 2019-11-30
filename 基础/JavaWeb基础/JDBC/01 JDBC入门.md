## 一、概述

- JDBC
  
  Java提供的支持数据库应用开发的一组API。提供多种关系数据库统一访问接口，屏蔽了底层技术细节，使得开发者不用关心数据库具体实现和不同数据库的差异。

## 二、实现

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

## 三、常用接口和对象

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
