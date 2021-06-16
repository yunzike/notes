## 1、介绍



### 1.2 优点





## 2、规范

### 2.1 动作





### 2.2 路径（接口命名）

- 路径设计

  

- controller 实践

  ```java
  @GetMapping( "/users")
  public String findAll(SalesRequestDTO userName){
      return "所有用户";
  }
  
  @GetMapping("/users/{id}")
  public String findById(@PathVariable String id){
      return "id为{id}的用户";
  }
  
  @PostMapping("/users")
  public String addUser(@RequestBody Map<String,Object> userInfo){
      return "新增用户";
  }
  
  @PutMapping("/users")
  public String updateUser(@RequestBody Map<String,Object> userInfo){
      return "修改用户";
  }
  
  @DeleteMapping( "/users/{id}")
  public String deleteUser(@PathVariable String id){
      return "删除用户";
  }
  ```

### 2.3 版本





### 2.4 过滤





### 2.5 状态码



### 2.6 版本