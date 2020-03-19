#### 1、Action

- action请求与Action类

  action：代表一个Struts2的请求

  Action类：能够处理Struts2请求的类

  ①属性的名字必须遵守与JavaBeans属性名相同的命名规则。属性的类型可以是任意类型。从字符串到非字符串（基本数据库类型）之间的数据转换可以自动发生

  ②必须有一个不带参的构造器：通过反射创建实例

  ③同一个Action类可以包含多个action方法

  ④Struts2会为每一个HTTP请求创建一个新的Action实例，即Action不是单例的，是线程安全的。

- 实现(三种方式)
  
  ① 普通Java类
  
  
  
  ② 继承Action接口
  
  
  
  ③ 继承ActionSupport
  
  

- 配置



- 访问WEB资源
  
  WEB资源：HttpSeruletRequest，HttpSession，ServletContext等原生的Servlet API
  
  为什么要访问WEB资源：
  
  访问方式：
  
  ①
  
  ②

#### 2、获取表单数据

- 原始方式



- 属性封装

- 

- 模型驱动
  
  ① Action实现接口ModelDriven接口
  
  ② 实现接口里面的方法（getModel方法，返回实体类对象）
  
  ③ 在Action类中创建实体类对象，表单输入项name值要与实体类属性值相同
  
  

- 表达式封装
  
  ① 在Action中声明实体类
  
  ② 生成实体类的get、set方法
  
  ③ 在表单输入项的name属性值里写表达式（实体类.属性名）
