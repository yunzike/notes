#### 一、概述

#### 1、 Java与SQL对应数据类型转换表

| Java类型             | SQL类型                    |
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

  | 类型         | 大小（单位：字节） |
  | ---------- | --------- |
  | TinyBlob   | 最大 255    |
  | Blob       | 最大 65K    |
  | MediumBlob | 最大 16M    |
  | LongBlob   | 最大 4G     |

- 实际使用中根据需要存入的数据大小定义不同的BLOB类型。

- 需要注意的是：如果存储的文件过大，数据库的性能会下降。

- 如果在指定了相关的Blob类型以后，还报错：xxx too large，那么在mysql的安装目录下，找my.ini文件加上如下的配置参数： **max_allowed_packet=16M**。同时注意：修改了my.ini文件之后，需要重新启动mysql服务。

## 二、操作BLOB

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

  
