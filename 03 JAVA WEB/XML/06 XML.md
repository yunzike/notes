XML：W3C发布的可扩展标记语言，是一种标记语言，很类似于HTML  
但它用于传输数据，而不是显示数据，而且需要自行定义标签。  

规范：  
最简单的声明：<?xml version="1.0" encoding="UTF-8"?>  
树结构：必须具有一个且只有一个根元素，每个元素都允许有多个子元素。  
大小写敏感  
所有XML元素都必须有关闭标签，不能像HTML一样省略。  
属性值要加引号  
XML中空格会保留，而HTML中多个空格会合并成一个  
注释（和HTML一样）：<!-- This is a comment -->不能写在声明之前  
实体引用（预定义了5个）  
```
 原符号 |   替换符号
--------|------------
    <   |   &lt;
    <=  |   &lt;=
    >   |   &gt;
    >=  |   &gt;=
    &   |   &amp;
    '   |   &apos;
    "   |   &quot;
```
注释：在XML中，只有字符"<"和"&"确实是非法的，">"是合法的，但用实体引用来代替它是一个好习惯。


PCDATA：被解析的字符数据，元素内的都是PCDATA。  
CDATA：如果要指定数据不被解析，则要放入CDATA区  
<?[CDATA[   
XXXXX  
]]>  

XML文档可以用CSS或XSLT来指定样式  
<?xml-stylesheet type="text/css" href="xxx.css"?>  
<?xml-stylesheet type="text/xsl" href="xxx.css"?>  


XML验证约束  
DTD（Document Type Definition）文档类型定义或者XML Schema  
XML引入：<!DOCTYPE 文档根节点 SYSTEM "xxx.dtd">  
也可以在文档内写  
<!DOTYPE 文档根节点[  
DTD内容  
]>  
当引用的DTD是一个公共的文档时，引用格式为：  
<!DOCTYPE 文档根节点 PUBLIC  "DTD名称" "DTD的URL">  
校验XML是否符合DTD约束，浏览器无法校验，一般使用eclipse来校验  

DTD语法：  
```
<!ELEMENT 元素名称  （包含的内容)或类型>   
```
类型：ENPTY、ANY  
元素内容可以使用以下符号修饰：  
| ：或  
+：1次或多次  
?：0次或1次  
*：0次或多次  
```
<!ATTLIST 元素名称  
属性名1	属性值类型	设置说明	    ["默认值"]  
属性名2	属性值类型	设置说明  
......  
>  
```
属性值类型：  
CDATA			普通字符串  
ENUMERETED	枚举	eg：(a|b|c）  
ID				唯一ID，且只能以字母或者下划线开头，不能包含空格  
ENTITY			实体：为某一段内容创建一个别名，通过使用别名即可引用，分为引用实体和参数实体  
引用实体  
<!ENTITY 实体名称 "内容">  
引用方式：&实体名称;  
参数实体  
<!ENTITY  %  实体名称 "参数1|参数2|...">  
引用方式：%实体名称；  

设置说明：  
#REQUIRED	必须的  
#IMPLIED	可选的  
#FLEXD "xxx"	固定的，固定为xxx  

<!ELEMENT 根元素  (子元素1,子元素2,...)>  
<!ELEMENT 子元素1  （#PCDATA）>  
<!ELEMENT 子元素2  （#PCDATA）>  
<!ELEMENT 子元素...  （#PCDATA）>   


XML文档解析  
方式1：Dom   
优点：CRUD方便  
缺点：一次加载全部文档，转成Dom对象，内存占用比较大  
方式2：sax  
只适合文档读取，解析速度快，占用内存少  


- DOM解析  
```
读取  


添加  


删除  


修改  
```



