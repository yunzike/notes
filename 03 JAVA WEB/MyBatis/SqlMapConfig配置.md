

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
#### mappers（映射器）
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
