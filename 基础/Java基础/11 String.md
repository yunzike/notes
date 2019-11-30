""表示空字符串，双引号中没有任何内容，空字符串不是null，空字符串分配了内存空间，而null是没有分配内存空间。

Java SE提供了三个字符串类：String、
StringBuffer和StringBuilder。String是不可变字
符串，StringBuffer和StringBuilder是可变字符
串。
StringBuffer是线程安全的，它的方法是支持线程同步
8，线程同步会操作串行顺序执行，在单线程环境下会影响效率。StringBuilder是StringBuffer单线程版本，Java 5之后发布的，它不是线程安全的，但它的执行效率很高。


字符串池
创建字符串有两种方式：两种内存区域（pool,heap）
String str="abc"，会先去“字符数据池”搜索是否有“abc”这个字符串，如果有则将该字符串的首地址赋值给str，如果没有则生成一个新的字符串“abc”并且将首地址赋值给str；

String str=new String("abc")，这种方式不会考虑时候已经存在了“abc”这个字符串，而
是直接生成一个新的字符串“abc”并将首地址赋值给str，注意“abc”并不放在“字符数据池”中；
 
注意：
String str1=”java”;    //指向字符串池
String str2=”blog”;   //指向字符串池

String s=str1+str2;   //s是指向堆中值为"javablog"的对象，从字符串池中复制这两个值，然后在堆中创建两个对象，然后再建立对象s,然后将"javablog"的堆地址赋给s.  System.out.println(s==”javablog”);   //结果是false。
String s="java" + "blog"; //直接将"javablog"放入字符串池中，System.out.println(s==”javablog”); 的结果为true
String s=str1+ "blog"; //不放入字符串池，而是在堆中分配,System.out.println(s==”javablog”); 的结果为False


StringBuffer和StringBuilder
在对字符串进行增删改插等操作不会产生新的对象


不同点：
StringBuffer         线程安全，支持多线程同步，单线程下会影响效率。
StringBuilder       线程不安全，是前者的单线程版，执行效率高。

相同点：
完全相同的API，即相同的4个构造方法
StringBuilder()：创建空字符串，capacity默认为16。
StringBuilder(int capacity) : 指定capacity值；
StringBuilder(String str):由字符串创建，capacity为16+str.length();
StringBuilder(CharSequence seq):可以是String、StringBuffer、StringBuilder等。





长度和容量

length：长度，str.length()返回字符串当前实际长度。
capacity:容量，str.capacity()返回字符串容量。

对于可变字符串
创建时如不指定容量大小，则capacity默认的值是16.
如StringBuilder sBuilder = new SrtingBuilder();
length=0；

指定了值，就把这个值赋给capacity.
如StringBuilder sBuilder = new SrtingBuilder(10);
则capacity为10，length=0；

传字符串，capacity的值就是字符串的长度+16.
如StringBuilder sBuilder = new SrtingBuilder(“1234”);
则capacity为20，length=4；

如果当前length值加上要增加的字符串长度大于默认capacity值16而无法容纳，
如果将capacity扩大为现有容量的2倍+2能容纳则扩容为2倍+2；
不能容纳则扩容为刚好能容纳的容量。