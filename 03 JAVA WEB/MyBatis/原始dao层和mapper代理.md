#### SqlSession
SqlSession是一个面向程序员的接口，其中提供了很多操作数据库的方法。比如selectOne()、selectList()、update、delete等。
但是SqlSession是线程不安全的，在SqlSession实现类中除了接口中的方法，还有数据域的属性。因此，SqlSession的最佳使用场合是方法体内，即定义成局部变量使用。

#### 一、原始dao开发方式
##### 0.xml文件

##### 1.dao接口

##### 2.dao实现类

##### 3.dao测试

##### 4.存在的问题
1.dao接口的实现类中存在大量模板代码，如果提取出来，将大大减少工作量；
2.调用sqlsession方法时将statement的id硬编码了；
3.调用sqlsession方法时传入变量，由于sqlsession方法使用泛型接收，即使传入参数类型错误，在编译阶段也无法报错，不利于开发。

#### 二、mapper代理开发
##### 1.mapper.xml
namespace必须为对应的mapper接口地址；
statement的id必须与对应mapper接口中的对应方法名一致；
statement的paremeterType必须与对应mapper接口对应方法的参数一致；
statement的resultType必须与对应mapper接口对应方法的返回值类型一致。
##### 2.mapper接口
