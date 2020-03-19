### 1.PreparedStatement对象

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

### 2.批处理

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

### 3.处理大文本和二进制数据

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

#### 4.获取数据库自动主键列