##  一、容器

#### IOC容器

IOC容器也就是spring容器。是具有依赖注入功能的容器，负责**对象的实例化、对象的初始化，对象和对象之间依赖关系配置、对象的销毁、对外提供对象的查找**等操作，对象的整个生命周期都是由容器来控制。我们需要使用的对象都由ioc容器进行管理，不需要我们再去手动通过new的方式去创建对象，由ioc容器直接帮我们组装好，当我们需要使用的时候直接从ioc容器中直接获取就可以了。

首先需要我们给ioc容器提供一个配置清单，这个配置**支持xml格式**和**java注解的方式**，在配置文件中列出需要让ioc容器管理的对象，以及可以指定让ioc容器如何构建这些对象，当spring容器启动的时候，就会去加载这个配置文件，然后将这些对象给组装好以供外部访问者使用。

#### 容器接口

- **BeanFactory**

  ```java
  /**
   * org.springframework.beans.factory.BeanFactory
   * BeanFactory是spring容器的顶层接口，提供了容器最基本的功能
   */
  
  //按bean的id或者别名查找容器中的bean
  Object getBean(String name) throws BeansException
  
  //这个是一个泛型方法，按照bean的id或者别名查找指定类型的bean，返回指定类型的bean对象
  <T> T getBean(String name, Class<T> requiredType) throws BeansException;
  
  //返回容器中指定类型的bean对象
  <T> T getBean(Class<T> requiredType) throws BeansException;
  
  //获取指定类型bean对象的获取器
  <T> ObjectProvider<T> getBeanProvider(Class<T> requiredType);
  ```

- **ApplicationContext** 

  org.springframework.context.ApplicationContext

  这个接口继承了BeanFactory接口，所以内部包含了BeanFactory所有的功能，并且在其上进行了扩展，增加了很多企业级功能，比如AOP、国际化、事件支持等等。

#### 实现类

- **ClassPathXmlApplicationContext**

  org.springframework.context.support.ClassPathXmlApplicationContext

  这个类实现了ApplicationContext接口，注意一下这个类名称包含了ClassPath Xml，说明这个容器类可以从classpath中加载bean xml配置文件，只需要给定bean的配置文件并正确配置 CLASSPATH 环境变量，容器就会从 CLASSPATH 中搜索 bean 配置文件，然后创建xml中配置的bean对象。
  
  ```java
  //通过bean名称获取bean
  getBean()
  //通过bean名称获取这个bean的所有别名
  getAliases()
  //返回spring容器中定义的所有bean的名称
  getBeanDefinitionNames()
  ```
  
- **FileSystemXmlApplicationContext**
  
  实现了ApplicationContext接口，需要提供XML 文件的完整路径。
  
- **WebXmlApplicationContext**

  会在一个 web 应用程序的范围内加载在 XML 文件中已被定义的 bean。

- **AnnotationConfigApplicationContext**

  org.springframework.context.annotation.AnnotationConfigApplicationContext
  
  这个类也实现了ApplicationContext接口，注意其类名包含了Annotation和config两个单词，使用注解的方式定义bean的时候，就需要用到这个容器来装载了，这个容器内部会解析注解来构建构建和管理需要的bean。

## 二、Bean

#### Bean的定义

由spring容器管理的对象统称为Bean对象。Bean就是普通的java对象，和我们自己new的对象其实是一样的，只是这些对象是由spring去创建和管理的，我们需要在配置文件中告诉spring容器需要创建哪些bean对象，所以需要先在配置文件中定义好需要创建的bean对象，这些配置统称为bean定义配置元数据信息，spring容器通过读取这些bean配置元数据信息来构建和组装我们需要的对象。

#### 在XML中配置Bean

- 基本格式

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <beans xmlns="http://www.springframework.org/schema/beans"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
      <import resource="引入其他bean xml配置文件" />  
     
      <bean id="bean标识" class="全限定类名">
          <property name="name" value="hello,Spring!"/>
          <property name="age" value="4"/>
      </bean>
  
      <alias name="bean标识" alias="别名" />
  </beans>
  ```

  id：bean的标识，在IOC容器中必须唯一，且不能以数字、符号开头，不能有空格。
  class：用来指定这个bean的完整类名。
  name：bean名称
  factory-bean：工厂bean名称 
  factory-method：工厂方法

- **bean名称别名定义规则**

  名称和别名可以通过bean元素中的id和name来定义，具体定义规则如下：：

  1. 当id存在的时候，不管name有没有，取id为bean的名称
  2. 当id不存在，此时需要看name，name的值可以通过`,;或者空格`分割，最后会按照分隔符得到一个String数组，数组的第一个元素作为bean的名称，其他的作为bean的别名
  3. 当id和name都存在的时候，id为bean名称，name用来定义多个别名
  4. 当id和name都不指定的时候，bean名称由spring自动生成，bean名称为：**bean的class的完整类名#编号**，编号是从0开始的，同种类型的没有指定名称的依次递增，**只有第一个也就是编号为0的bean会有别名，别名为完整的类名**。

- **alias元素**

  ```xml
  <!-- 可以用来给某个bean定义别名 -->
  <alias name="需要定义别名的bean的名称" alias="别名" />
  ```

- **import元素**

  ```xml
  <!-- 当我们的系统比较大的时候，会分成很多模块，每个模块会对应一个bean xml文件，我们可以在一个总的bean xml中对其他bean xml进行汇总，相当于把多个bean xml的内容合并到一个里面了，可以通过import元素引入其他bean配置文件。 -->
  <import resource="其他配置文件的位置" />
  ```

  注解的方式相对于xml方式更方便一些，是比较推荐的方式。


#### 作用域（scope）

| **作用域**     | **描述**                                                     |
| -------------- | ------------------------------------------------------------ |
| singleton      | 在spring IoC容器仅存在一个Bean实例，Bean以单例方式存在，默认值 |
| prototype      | 每次从容器中调用Bean时，都返回一个新的实例，即每次调用getBean()时，相当于执行newXxxBean() |
| request        | 每次HTTP请求都会创建一个新的Bean，该作用域仅适用于WebApplicationContext环境 |
| session        | 同一个HTTP Session共享一个Bean，不同Session使用不同的Bean，仅适用于WebApplicationContext环境 |
| global-session | 一般用于Portlet应用环境，该运用域仅适用于WebApplicationContext环境 |

**自定义作用域**



#### 生命周期

  

#### 后置处理器

  

#### 定义继承



#### 创建bean实例

- 方式一：通过反射调用构造方法创建bean对象

  ```xml
  <!-- 通过无参构造方法创建bean实例,创建bean的类必须存在无参构造方法 -->
  <bean id="createBeanByConstructor1" class="com.yunzike.bean.Person"/>
  
  <!-- 
  通过有参构造方法创建bean实例,创建bean的类必须存在参数个数和类型相对应的有参构造方法 
  constructor-arg用于指定构造方法参数的值
  index：构造方法中参数的位置，从0开始，依次递增
  value：指定参数的值
  ref：当插入的值为容器内其他bean的时候，这个值为容器中对应bean的名称 
  -->
  <bean id="createBeanByConstructor2" class="com.yunzike.bean.Person">
          <constructor-arg index="0" value="我是通过有参构造方法创建的对象！"/>
          <constructor-arg index="1" value="10"/>
  </bean>
  ```

- 方式二：通过静态工厂方法创建bean对象

  创建静态工厂，内部提供一些静态方法来生成所需要的对象，spring容器会自动调用静态工厂的静态方法获取指定的对象，将其放在容器中以供使用。

  ①定义静态工厂

  ```java
  /** 
   * 静态工厂类
   */
  package com.yunzike.factory;
  
  import com.yunzike.bean.Person;
  
  public class PersonStaticFactory {
      /**
       * 使用无参构造方法创建Person
       *
       * @return Person
       */
      public static Person buildPerson1() {
          System.out.println(PersonStaticFactory.class + ".buildPerson1()");
          Person person = new Person();
          person.setName("我是静态工厂使用无参构造方法创建的！");
          return person;
      }
  
      /**
       * 使用有参构造方法创建Person
       *
       * @param name
       * @param age
       * @return Person
       */
      public static Person buildPerson2(String name, Integer age) {
          System.out.println(PersonStaticFactory.class + ".buildPerson2()");
          Person person = new Person(name, age);
          return person;
      }
  }
  ```

  ②配置bean

  ```xml
  <!-- 
  bean的xml配置
  class：指定静态工厂完整的类名
  factory-method：静态工厂中的静态方法，返回需要的对象。
  constructor-arg：指定静态方法参数的值
  -->
  
  <!-- 通过静态工厂使用无参构造方法创建bean实例,创建bean的类必须存在无参构造方法 -->
  <bean id="createBeanByStaticFactoryMethod1" class="com.yunzike.factory.PersonStaticFactory" factory-method="buildPerson1"/>
  
  <!-- 通过静态工厂使用有参构造方法创建bean实例 -->
  <bean id="createBeanByStaticFactoryMethod2" class="com.yunzike.factory.PersonStaticFactory" factory-method="buildPerson2">
          <constructor-arg index="0" value="通过工厂静态有参方法创建UerModel实例对象"/>
          <constructor-arg index="1" value="30"/>
  </bean>
  ```

- 方式三：通过实例工厂方法创建bean对象

  ①创建实例工厂类

  ```java
  /** 
   * 实例工厂类
   */
  package com.yunzike.factory;
  
  import com.yunzike.bean.Person;
  
  public class PersonFactory {
  
      /**
       * 实例工厂使用无参构造函数创建bean
       *
       * @return Person
       */
      public Person buildPerson1() {
          System.out.println("----------------------1");
          Person person = new Person();
          person.setName("通过bean实例无参方法创建UserModel实例对象!");
          return person;
      }
  
      /**
       * 实例工厂使用有参构造函数创建bean
       *
       * @param name
       * @param age
       * @return Person
       */
      public Person buildPerson2(String name, Integer age) {
          System.out.println("----------------------2");
          Person person = new Person();
          person.setName(name);
          person.setAge(age);
          return person;
      }
  }
  ```

  ②配置bean

  ```xml
  <!-- 
  bean的xml配置,首先定义一个工厂的bean实例,然后使用它的方法实例bean
  factory-bean：指定实例工厂的免称
  factory-method：实例工厂中的方法，返回需要的对象。
  constructor-arg：指定实例工厂中方法参数的值
  -->
  
  <bean id="personFactory" class="com.yunzike.factory.PersonFactory"/>
  
  <bean id="createBeanByFactoryMethod1" factory-bean="personFactory" factory-method="buildPerson1"/>
  
  <bean id="createBeanByFactoryMethod2" factory-bean="personFactory" factory-method="buildPerson2">
          <constructor-arg index="0" value="通过bean实例有参方法创建UserModel实例对象"/>
          <constructor-arg index="1" value="30"/>
  </bean>
  ```

- 方式四：通过FactoryBean创建bean对象

  FactoryBean接口中有3个方法，前面2个方法需要我们去实现，getObject方法内部由开发者自己去实现对象的创建，然后将创建好的对象返回给Spring容器，getObjectType需要指定我们创建的bean的类型；isSingleton表示通过这个接口创建的对象是否是单例的，如果返回false，那么每次从容器中获取对象的时候都会调用这个接口的getObject() 去生成bean对象，返回true则是单例的。
  
  ```java
  /**
   * FactoryBean接口
   */
  public interface FactoryBean<T> {
      /**
       * 返回创建好的对象
       */
      @Nullable
      T getObject() throws Exception;
  
      /**
       * 返回需要创建的对象的类型
       */
      @Nullable
      Class<?> getObjectType();
  
      /**
      * bean是否是单例的
      **/
      default boolean isSingleton() {
          return true;
      }
  }
  ```
  
  ①创建一个FactoryBean实现类
  
  ```java
  /**
   * FactoryBean的实现类
   */
  package com.yunzike.factory;
  
  import com.yunzike.bean.Person;
  import org.springframework.beans.factory.FactoryBean;
  
  public class PersonFactoryBean implements FactoryBean {
  
      int count = 0;
  
      @Override
      public Person getObject() throws Exception {
          Person person = new Person();
          person.setName("我是通过FactoryBean创建的第" + count++ + "对象");
          return person;
      }
  
      @Override
      public Class<?> getObjectType() {
          return Person.class;
      }
      
      
      @Override
      public boolean isSingleton() {
          return true;
      }
  }
  ```
  
  ②配置bean
  
  ```xml
  <bean id="createByFactoryBean" class="com.yunzike.factory.PersonFactoryBean"/>
  ```
#### 依赖注入

- 构造器注入

  根据构造器参数索引注入

  根据构造器参数类型注入

  根据构造器参数名称注入

- setter注入

- 注入容器中的其他bean

  ref属性方式

  内置bean的方式

- 其他常见类型注入

#### 自动注入

- 手动注入的不足
- 按名称自动注入
- 按类型自动注入
- 按构造器进行自动注入
- 按类型自动注入某种类型的所有bean给List和Map（重点）



## 三、

  
















