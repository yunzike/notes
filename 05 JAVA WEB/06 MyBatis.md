## 1、简介

### 1.1 什么是 MyBatis

<img src="../images/image-20210509033733037.png" alt="image-20210509033733037" style="zoom:50%;" />

- MyBatis 是一款优秀的**持久层框架**。
- 它支持自定义 SQL、存储过程以及高级映射。
- MyBatis 免除了几乎所有的 JDBC 代码以及设置参数和获取结果集的工作。
- MyBatis 可以通过简单的 XML 或注解来配置和映射原始类型、接口和 Java POJO（Plain Old Java Objects，普通老式 Java 对象）为数据库中的记录。
- MyBatis 本是apache的一个[开源项目](https://baike.baidu.com/item/开源项目/3406069)iBatis, 2010年这个[项目](https://baike.baidu.com/item/项目/477803)由apache software foundation 迁移到了[google code](https://baike.baidu.com/item/google code/2346604)，并且改名为MyBatis 。
- 2013年11月迁移到[Github](https://baike.baidu.com/item/Github/10145341)。

如何获取 MyBatis ?

- maven 仓库：

  ```xml
  <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
  <dependency>
      <groupId>org.mybatis</groupId>
      <artifactId>mybatis</artifactId>
      <version>3.5.7</version>
  </dependency>
  ```

- Github：https://github.com/mybatis/mybatis-3

- 中文文档：https://mybatis.org/mybatis-3/zh/index.html



### 1.2 持久层

- 持久层：即 Dao（Data Access Object）层，数据访问对象，完成持久化工作的代码块。
- 持久化：将程序中的数据在瞬时状态（在内存中）和持久状态（在数据库中）转化的过程。
- 其他层：Service 层（处理业务逻辑），Controller 层（处理前端请求）等。



### 1.3 为什么要使用 MyBatis



### MyBatis 和 Hibernate 比较

Hibernate:标准的ORM框架。入门门槛比较高，不需要写SQL，SQL语句自动生成，所以对SQL的优化、修改比较困难。适用于需求变化不多的中小型项目，比如后台管理系统，erp，orm，oa。  
MyBatis：专注SQL本身，需要编写SQL，SQL的修改、优化比较方便。MyBatis是一个不完全的ORM，虽然手动编写SQL，但也可以实现映射（输入映射、输出映射）。适用于需求变化比较多的项目。  





## 2、第一个 MyBatis 程序

### 2.1 搭建环境

创建数据库

```sql
CREATE DATABASE `mybatis`;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(30) DEFAULT NULL COMMENT '姓名',
  `password` varchar(30) DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


INSERT INTO `user` VALUES (1, '张三', '123456');
INSERT INTO `user` VALUES (2, '李四', '123');
INSERT INTO `user` VALUES (3, '王五', '888');
```

新建 Maven 项目

1、新建普通的 maven 项目

2、删除 src 目录，将项目作为父工程

3、导入依赖

```xml
<dependencies>
    <!-- mysql 驱动 -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <version>5.1.49</version>
    </dependency>
    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
    <dependency>
        <groupId>org.mybatis</groupId>
        <artifactId>mybatis</artifactId>
        <version>3.5.7</version>
    </dependency>
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.12</version>
    </dependency>
</dependencies>
```

4、创建模块



编写核心配置文件

mybatis-config.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>

    <!-- 数据库环境配置 -->
    <environments default="development">
        <environment id="development">
            <transactionManager type="JDBC"/>
            <dataSource type="POOLED">
                <property name="driver" value="com.mysql.jdbc.Driver"/>
                <property name="url" value="jdbc:mysql://81.68.250.252:3306/mybatis?characterEncoding=utf-8&amp;serverTimezone=UTC&amp;useSSL=false"/>
                <property name="username" value="root"/>
                <property name="password" value="xxxxxx"/>
            </dataSource>
        </environment>
    </environments>


    <!-- 每个 Mapper.xml 都需要在 MyBatis 配置文件中注册 -->
    <mappers>
        <mapper resource="mapper/UserMapper.xml"/>
    </mappers>

</configuration>
```

编写 mybatis 工具类

```java
public class MybatisUtils {

    private static SqlSessionFactory sqlSessionFactory;

    //1、加载配置文件，获取 SqlSessionFactory 对象
    static {
        try {
            String resource = "mybatis-config.xml";
            InputStream inputStream = Resources.getResourceAsStream(resource);
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 2、获取 SqlSession
    public static SqlSession getSqlSession(){
        return sqlSessionFactory.openSession();
    }

}
```

### 2.2 编写代码

- 实体类：User.java

  ```java
  package com.yunzike.entity;
  
  
  public class User {
  
      private Integer id;
      private String name;
      private String password;
  
      public Integer getId() {
          return id;
      }
  
      public void setId(Integer id) {
          this.id = id;
      }
  
      public String getName() {
          return name;
      }
  
      public void setName(String name) {
          this.name = name;
      }
  
      public String getPassword() {
          return password;
      }
  
      public void setPassword(String password) {
          this.password = password;
      }
  
      @Override
      public String toString() {
          return "User{" +
                  "id=" + id +
                  ", name='" + name + '\'' +
                  ", password='" + password + '\'' +
                  '}';
      }
  }
  
  ```

- Mapper 接口：UserMapper.java

  ```java
  package com.yunzike.mapper;
  
  import com.yunzike.entity.User;
  
  import java.util.List;
  
  public interface UserMapper {
  
      List<User> getUserList();
  
  }
  
  ```

- 实现类：UserMapper.xml

  编写 Mapper.xml 后还需要在 MyBatis 配置文件中进行注册

  ```xml
  <?xml version="1.0" encoding="UTF-8" ?>
  <!DOCTYPE mapper
          PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
          "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
  
  <!-- namespace：绑定 Mapper 接口 -->
  <mapper namespace="com.yunzike.mapper.UserMapper">
  
      <!-- id：绑定 Mapper 接口中的方法，来执行指定的 SQL -->
      <select id="getUserList" resultType="com.yunzike.entity.User">
          select * from user;
      </select>
  
  </mapper>
  ```

### 2.3 测试

``` java
package com.yunzike.mapper;

import com.yunzike.entity.User;
import com.yunzike.util.MybatisUtils;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import java.util.List;

public class UserMapperTest {

    @Test
    public void test() {

        //1、获取 SqlSession 对象
        SqlSession sqlSession = MybatisUtils.getSqlSession();

        //2、通过 SqlSession 对象获取 Mapper 接口的实现
        UserMapper mapper = sqlSession.getMapper(UserMapper.class);

        //3、调用 Mapper 接口中的方法执行 SQL
        List<User> userList = mapper.getUserList();
        userList.forEach(System.out::println);

        //4、关闭资源
        sqlSession.close();

    }

}
```



## 3、CRUD

#### 3.1 select

```java
<!-- namespace:命名空间 -->
<mapper namespace="test">
	<!-- id:sql的标识
		会将sql语句封装到mappedStatement对象中，所以将id称为statement的id
	-->
	<select id="findUserbyId" parameterType="int" resultType="com.yunzike.mybatis.po.User">
		select * from user where id = #{id}
	</select>
    
    <!-- 根据name模糊查询 -->
    <select id="findUserbyName" parameterType="String" resultType="com.yunzike.mybatis.po.User">
        select * from user where username like '%${value}%'
    </select>
</mapper> 
```

namespace：命名空间，绑定对应 Mapper 接口，若接口名唯一则可以直接使用接口名，推荐使用接口全限定名。

id：绑定 Mapper 接口中对应的方法

parameterType：指定参数类型

resultType：指定 sql 输出结果中单条输出结果所映射的java对象类型，如果返回结果要用 pojo 来接收，则要建立对应 po 类。

#{}：表示一个占位符，大括号中间为参数，在SQL中会在参数值外面加上单引号‘。接收的参数类型可为简单类型、pojo、hashmap、list。
参数类型为简单类型时，参数名称任意;
参数类型为pojo时，通过OGNL读取对象中属性值，参数名为 po类属性名 或 po对象.属性

${}：也表示一个占位符，大括号中间为参数，在SQL中不会在参数值外添加单引号‘’，有SQL注入的风险，尽量避免使用。接收的参数类型同样可以是简单类型、pojo、hashmap、list。
参数为简单类型，参数名必须为value;
参数为其他类型时，同#{}占位符。

#### 3.2 insert

```java
//mapper.xml
<insert id="insertUser" parameterType="com.yunzike.mybatis.po.UserPO">
	insert into user values (
		#{id},#{username},#{birthday},#{sex},#{address}
	)
</insert>
//插入操作
UserPO user1 = new UserPO();
user1.setId(3);
user1.setUsername("第三者");
user1.setSex("女");
user1.setBirthday(new Date());
user1.setAddress("湖南");

SqlSession.insert("test.insertUser",user1);
```

##### 1 自增主键返回

mysql自增主键，执行insert，提交之前自动生成。可以通过LAST_INSERT_ID()函数获取,然后设置到传入的po对象中。

```
<insert id="insertUser" parameterType="com.yunzike.mybatis.po.UserPO">
    <!-- 将插入的主键返回到UserPO对象中
    select LAST_INSERT_ID():得到刚insert进去记录的主键值，只适用于自增主键
    keyProperty:将查询到的主键值设置到parameterType指定的对象的哪个属性
    resultType:指定返回主键类型
    order:select LAST_INSERT_ID()相对于insert语句的执行顺序
    -->
    <selectKey keyProperty="id" resultType="java.lang.Integer" order="AFTER">
        select LAST_INSERT_ID()
    </selectKey>
    insert into user(username,birthday,sex,address) values (
        #{username},#{birthday},#{sex},#{address}
    )
</insert>
```

##### 2 非自增主键返回

mysql主键类型为字符串时，可以使用uuid()函数生成主键之后再设置到传入的po对象中，再传给insert语句。

```java
<insert id="insertUser" parameterType="com.yunzike.mybatis.po.UserPO">
    <!-- 生成uuid主键并返回到UserPO对象中
    select uuid():生成UUID主键，主键类型必须为字符串，获取并设置到po对象。
    keyProperty:将查询到的主键值设置到parameterType指定的对象的哪个属性
    resultType:指定返回主键类型
    order:select uuid():相对于insert语句的执行顺序
    -->
    <selectKey keyProperty="id" resultType="String" order="BEFORE">
        select uuid()
    </selectKey>
    insert into user values (
        #{id},#{username},#{birthday},#{sex},#{address}
    )
</insert>
```

Oracle通过序列生成组件，方法同上，将uuid()函数改为序列名.nextval()即可。 

#### 3.3 update

```java
<update id="updatebyid" parameterType="com.yunzike.mybatis.po.UserPO">
    update user set username = #{username},birthday=#{birthday},sex=#{sex},address=#{address} where  id = #{id}
</update>
```

#### 3.4 delete

```java
<delete id="deleteuserbyid" parameterType="java.lang.Integer">
    delete from user where  id = #{id}
</delete>
```



## 4、配置解析

### 4.1 核心配置文件



### 4.2 环境配置



### 4.3 属性



### 4.4 类型别名



### 4.5 设置



#### setting设置



#### typeAliases（别名定义）

```java
<!--类型别名定义
定义后可在statement中使用
-->
<typeAliases>
    <!--单别名定义
    type：返回值类型，类完整名
    alias:别名
    -->
    <typeAlias type="com.yunzike.mybatis.po.UserPO" alias="UserPO"/>
    
    <!--批量别名定义
    指定报名，MyBatis自动扫描包中的po类，自动定义别名，别名就是类名且首字母大小写都可以
    -->
    <package name="com.yunzike.mybatis.po"/>
</typeAliases>
```

#### typeHandlers（类型处理器）

MyBatis中通过typeHandlers完成Java类型和jdbc类型的转换。
通常MyBatis提供的类型处理器就能满足日常使用，不需要自定义。

### 4.6 其他设置



### 4.7 映射器

```java
<!-- 加载映射文件 -->
<mappers>
    <!-- 通过resource指定Mapper.xml来单个加载 -->
    <mapper resource="mapper/UserMapper.xml"/>
    
    <!-- 通过class指定Mapper接口来单个加载
    前提条件：使用Mapper代理方式，Mapper接口类名必须和对应的Mapper.xml同目录且同名
    -->
    <mapper class="com.yunzike.mybatis.mapper.UserMapper"/>
    
    <!-- 通过package指定Mapper接口包名来批量加载 
    前提条件：使用Mapper代理方式，Mapper接口类名必须和对应的Mapper.xml同目录且同名
    -->
    <package name="com.yunzike.mybatis.mapper"/>
</mappers>
```



## 5、结果集映射（ResultMap）



## 6、日志



## 7、分页

### 7.1 使用 limit 实现分页



### 7.2 



### 7.3 使用分页插件 





## 8、使用注解开发

### @Param() 注解

- 一个参数时可以可以忽略，但是建议加上
- 多个参数时，必须加上，加上后在 SQL 中引用的就是 @Param() 中设定的属性名

### 映射器属性

| 属性          | 描述                                                         |
| ------------- | ------------------------------------------------------------ |
| id            | 绑定方法名                                                   |
| parameterType | 将会传入这条语句的参数的类全限定名或别名。这个属性是可选的，因为 MyBatis 可以通过类型处理器（TypeHandler）推断出具体传入语句的参数，默认值为未设置（unset）。 |
| resultType    | 期望从这条语句中返回结果的类全限定名或别名。 注意，如果返回的是集合，那应该设置为集合包含的类型，而不是集合本身的类型。 resultType 和 resultMap 之间只能同时使用一个。 |
| resultMap     | 对外部 resultMap 的命名引用。结果映射是 MyBatis 最强大的特性，如果你对其理解透彻，许多复杂的映射问题都能迎刃而解。 resultType 和 resultMap 之间只能同时使用一个。 |





## 9、关联映射

[MyBatis（七）：一对一、一对多、多对多 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/37259714)

### 一对一

学生和身份证

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="one.to.one.mapper.OrdersMapper">
    <!--
    嵌套结果：使用嵌套结果映射来处理重复的联合结果的子集
    封装联表查询的数据(去除重复的数据)
    select * from orders o,user u where o.user_id=u.id and o.id=#{id}
    -->
    <select id="selectOrderAndUserByOrderID" resultMap="getOrderAndUser">
        select *
        from orders o,
             user u
        where o.user_id = u.id
          and o.id = #{id}
    </select>
    <resultMap type="com.ys.po.Orders" id="getOrderAndUser">
        <!--
        id:指定查询列表唯一标识，如果有多个唯一标识，则配置多个id
        column:数据库对应的列
        property:实体类对应的属性名
        -->
        <id column="id" property="id"/>
        <result column="user_id" property="userId"/>
        <result column="number" property="number"/>
        <!--association:用于映射关联查询单个对象的信息
        property:实体类对应的属性名
        javaType:实体类对应的全类名
        -->
        <association property="user" javaType="com.ys.po.User">
            <!--
            id:指定查询列表唯一标识，如果有多个唯一标识，则配置多个id
            column:数据库对应的列
            property:实体类对应的属性名
            -->
            <id column="id" property="id"/>
            <result column="username" property="username"/>
            <result column="sex" property="sex"/>
        </association>
    </resultMap>


    <!--
    方式二：嵌套查询：通过执行另外一个SQL映射语句来返回预期的复杂类型
    select user_id from order WHERE id=1;//得到user_id
    select * from user WHERE id=1  //1 是上一个查询得到的user_id的值
    property:别名(属性名)    column：列名 -->
    <select id="getOrderByOrderId" resultMap="getOrderMap">
        select *
        from order
        where id = #{id}
    </select>
    <resultMap type="com.ys.po.Orders" id="getOrderMap">
        <id column="id" property="id"/>
        <result column="number" property="number"/>
        <association property="userId" column="id" select="getUserByUserId"/>
    </resultMap>
    <select id="getUserByUserId" resultType="com.ys.po.User">
        select *
        from user
        where id = #{id}
    </select>
</mapper> 
```





### 一对多处理

某个课程，有哪些学生选修

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="one.to.many.mapper.UserMapper">
    <!--
    方式一：嵌套结果：使用嵌套结果映射来处理重复的联合结果的子集
    封装联表查询的数据(去除重复的数据)
    select * from user u,orders o where u.id=o.user_id and u.id=#{id}
    -->
    <select id="selectUserAndOrdersByUserId" resultMap="getUserAndOrders">
        select u.*, o.id oid, o.number number
        from user u,
             orders o
        where u.id = o.user_id
          and u.id = #{id}
    </select>
    <resultMap type="com.ys.po.User" id="getUserAndOrders">
        <!--id:指定查询列表唯一标识，如果有多个唯一标识，则配置多个id
        column:数据库对应的列
        property:实体类对应的属性名 -->
        <id column="id" property="id"/>
        <result column="username" property="username"/>
        <result column="sex" property="sex"/>
        <!--
        property:实体类中定义的属性名
        ofType：指定映射到集合中的全类名
        -->
        <collection property="orders" ofType="com.ys.po.Orders">
            <id column="oid" property="id"/>
            <result column="number" property="number"/>
        </collection>
        
        <!--
			如果是 List<String> xxx
			<collection property="clinicList" ofType="string" javaType="list">
            	<result column="clinic_id"/>
        	</collection>
 		-->
    </resultMap>
</mapper> 
```





### 多对一处理

学生和课程





## 12、动态 SQL

### if



### where

*where* 元素只会在子元素返回任何内容的情况下才插入 “WHERE” 子句。而且，若子句的开头为 “AND” 或 “OR”，*where* 元素也会将它们去除。

### foreach

```xml
<select id="selectPostIn" resultType="domain.blog.Post">
  SELECT *
  FROM POST P
  WHERE ID in
  <foreach item="item" index="index" collection="list"
      open="(" separator="," close=")">
        #{item}
  </foreach>
</select>
```



### 其他



## 13、缓存

### 13.1 缓存简介



### 13.2 一级缓存



### 13.3 二级缓存





## 14、懒加载





## 15、Spring 整合 MyBatis





