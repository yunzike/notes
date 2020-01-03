#### 1.创建Maven项目

idea设置自动导入依赖
#### 2.导入Spring Boot依赖



#### 3.编写主程序
```
//src/main/java/com.yunzike.HelloWorldApplication
@SpringBootApplication//标注主程序类，说明是一个springBoot应用
public class HelloWorldMainApplication {
    public static void main(String[] args) {
        //传入主程序类，启动SpringBoot应用
        SpringApplication.run(HelloWorldMainApplication.class,args);
    }
}
```
#### 4.编写相关的Controller和Service等  
```
//设置类为控制层
@Controller
public class HelloController {
    //将方法返回内容写到浏览器
    @ResponseBody
    //将浏览器hello请求映射到hello方法
    @RequestMapping("/hello")
    public String hello(){
        return  "hello world!";
    }
}
```
#### 5.运行主程序测试


#### 6.简化部署

```
 <!--  这个插件，可以将应用打包成一个可执行的jar包  -->
<build>
    <plugins>
        <plugin>
           <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
    </plugins>
</build>
```
使用Maven将应用打包成jar包，可以直接用java -jar的命令运行应用


