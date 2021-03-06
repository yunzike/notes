### 1、提高代码性能

#### 1.1 需要Map的主键和取值时，应该迭代entrySet( )

当循环中只需要Map的主键时，迭代keySet( )是正确的。但是，当需要主键和取值时，迭代entrySet( ) 会比先迭代keySet( ) 后再用get取值性能更高。

```java
//反例
Map map = ...;
for(String key : map.keySet()){
    String value = map.get(key);
    ...
}

//正例
Map map = ...;
for(Map.Entry entry : map.entrySet()){
    String key = entry.getKey();
    String value = entry.getValue();
    ...
}
```

#### 1.2.应该使用 Collection.isEmpty() 检测空

使用 Collection.size() 来检测空逻辑上没有问题，但是使用 Collection.isEmpty() 使得代码更易读，并且可以获得更好的性能。任何 Collection.isEmpty() 实现的时间复杂度都是 O(1) ，但是某些 Collection.size() 实现的时间复杂度可能是O(n)。

```java
//反例：
if(collection.size() == 0){
    ...
}

正例：
if(collection.isEmpty()){
    ...
}
```

如果还需要检测null，可以采用：

-   CollectionUtils.isEmpty ( collection )
    
-   CollectionUtils.isNotEmpty ( collection )
    

#### 1.3.不要把集合对象传给自己

将集合作为参数传递给集合自己的方法要么是一个错误，要么是无意义的代码。

此外，由于某些方法要求参数在执行期间保持不变，因此将集合传递给自身可能会导致异常行为。

```java
//反例：
List list = new ArrayList<>();
list.add("hello");
list.add("world");
if(list.containsAll(list)){//无意义，总是返回true
    ...
}
list.removeAll(list);//性能差，应该直接使用clear()
```

#### 1.4.集合初始化尽量指定大小

java 的集合类用起来十分方便，但是看源码可知，集合也是有大小限制的。每次扩容的时间复杂度很有可能是 O(n) ，所以尽量指定可预知的集合大小，能减少集合的扩容次数。

```java
//反例：
int[] arr = new int[]{1,2,3};
List list = new ArrayList<>();
for(int i : arr){
    list.add(i);
}

//正例：
int[] arr = new int[]{1,2,3};
List list = new ArrayList<>(arr.length);
for(int i : arr){
 list.add(i);
}
```

#### 1.5.字符串拼接使用 StringBuilder

一般的字符串拼接在编译期 java 会进行优化，但是在循环中字符串拼接，java 编译期无法做到优化，所以需要使用 StringBuilder 进行替换。

```java
//反例：
String s = "";
for(int i = 0; i < 10; i++){
    s += i;
}

//正例：
String a = "a";
String b = "b";
String c = "c";
String s = a + b + c; //没问题，编译器会优化

StringBuilder sb = new StringBuilder();
for(int i = 0; i < 10; i++){
    sb.append(i); //循环中，java编译器无法进行优化，所以要手动使用StringBuilder
}
```

#### 1.6.List的随机访问

大家都知道数组和链表的区别：数组的随机访问效率更高。当调用方法获取到 List 后，如果想随机访问其中的数据，并不知道该数组内部实现是链表还是数组，怎么办呢？可以判断它是否实现 RandomAccess 接口。

```java
List list = otherService.getList();
if(list instanceof RandomAccess){
    //内部数组实现，可以随机访问
    System.out.print(list.get(list.size()-1));
}esle{
    //内部可能是链表实现，随机访问效率低
}
```

#### 1.7.频繁调用 Collection.contains 方法请使用 Set

在 java 集合类库中，List 的 contains 方法普遍时间复杂度是 O(n) ，如果在代码中需要频繁调用 contains 方法查找数据，可以先将 list 转换成 HashSet 实现，将 O(n) 的时间复杂度降为 O(1) 。

```java
//反例：
ArrayList list = otherService.getList();
for(int i = 0; i <= Integer.MAX_VALUE; i++){
    //时间复杂度o(n)
    if(list.contains(i)){
        ...
    }
}

//正例：
ArrayList list = otherService.getList();
Set set = new HashSet(list);
for(int i = 0; i <= Integer.MAX_VALUE; i++){
 //时间复杂度o(1)
 if(set.contains(i)){
 ...
 }
}
```

### 2.让代码更优雅

#### 2.1.长整型常量后添加大写 L

在使用长整型常量值时，后面需要添加 L ，必须是大写的 L ，不能是小写的 l ，小写 l 容易跟数字 1 混淆而造成误解。

```java
//反例：
long value = 1l;
long max = Math.max(1L,5);

//正例：
long value = 1L;
long max = Math.max(1L,5L);
```

###

#### 2.2.不要使用魔法值

当你编写一段代码时，使用魔法值可能看起来很明确，但在调试时它们却不显得那么明确了。这就是为什么需要把魔法值定义为可读取常量的原因。但是，-1、0 和 1 不被视为魔法值。

```java
//反例：
for(int i = 0; i < 100; i++){
    ...
}
if(count == 100){
    ...
}

//正例：
private static final int MAX_COUNT = 100;
for(int i = 0; i < MAX_COUNT; i++){
    ...
}
if(count == MAX_COUNT){
    ...
}
```

#### 2.3.不要使用集合实现来赋值静态成员变量

对于集合类型的静态成员变量，不要使用集合实现来赋值，应该使用静态代码块赋值。

```java
//反例：
private static Map map = new HashMap(){
    {
        put("a",1);
        put("b",2);
    }
}
private static List list = new ArrayList(){
    {
        add("a");
        add("b");
    }
}

//正例：
private static Map map = new HashMap<>();
static{
    map.put("a",1);
    map.put("b",2);
}

private static List list = new ArrayList<>();
static{
    list.add("a");
    list.add("b");
}
```

#### 2.4.建议使用 try-with-resources 语句

Java 7 中引入了 try-with-resources 语句，该语句能保证将相关资源关闭，优于原来的 try-catch-finally 语句，并且使程序代码更安全更简洁。

```java
//反例：
private void handle(String fileName){
    BufferedReader reader = null;
    try{
        String line;
        reader = new BufferedReader(new FileReader(fileName));
        while((line = reader.readLine()) != null){
            ...
        }
    } catch (Exception e){
        ...        
    } finally{
        if(reader != null){
            try{
                reader.close();
            } catch(IOException e){
                ...
            }
        }
    }
}

//正例：
private void handle(String fileName){
    try(Buffered reader = new BufferedReader(new FileReader(fileName))){
        String line;
        while((line = reader.readLine()) != null){
            ...
        }
    } catch(Exception e){
        ...
    }
}
```

#### 2.5.删除未使用的私有方法和字段

删除未使用的私有方法和字段，使代码更简洁更易维护。若有需要再使用，可以从历史提交中找回。

#### 2.6.删除表达式的多余括号、未使用的局部变量和方法参数

#### 2.7.工具类应该屏蔽构造函数

工具类是一堆静态字段和函数的集合，不应该被实例化。但是， Java 为每个没有明确定义构造函数的类添加了一个隐式公有构造函数。所以，为了避免 java "小白"使用有误，应该显式定义私有构造函数来屏蔽这个隐式公有构造函数。

```java
public class MathUtils{
    public static final double PI = 3.1415926D;
    private MathUtils(){}//屏蔽构造函数
    public static int sum(int a,int b){
        return a + b;
    }
}
```

#### 2.8.删除多余的异常捕获并抛出

用catch语句捕获异常后，什么也不进行处理，就让异常重新抛出，这跟不捕获异常的效果一样，可以删除这块代码( 保留try )或添加别的处理。