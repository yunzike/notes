#### 1、Action

- 实现(三种方式)
  
  ① 普通Java类
  
  
  
  ② 继承Action接口
  
  
  
  ③ 继承ActionSupport
  
  

- 配置
  
  

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
