### 常用函数
#### trunc：截取date或数值类型
TRUNC（number,num_digits）
Number 需要截尾取整的数字。
Num_digits 用于指定取整精度的数字。Num_digits 的默认值为 0。如果Num_digits为正数，则截取小数点后Num_digits位；如果为负数，则先保留整数部分，然后从个位开始向前数，并将遇到的数字都变为0。
TRUNC()函数在截取时不进行四舍五入，直接截取
````
针对数字的案例，如：
trunc(123.458) --123
trunc(123.458,0) --123
trunc(123.458,1) --123.4
trunc(123.458,-1) --120
trunc(123.458,-4)  --0
trunc(123.458,4)  --123.458
trunc(123) --123
trunc(123,1)  --123
trunc(123,-1) --120
 
针对日期的案例，如：
trunc(sysdate)  --2017/6/13  返回当天的日期
trunc(sysdate,'yyyy') --2017/1/1  返回当年第一天.
trunc(sysdate,'mm')  --2017/6/1  返回当月第一天.
trunc(sysdate,'d')   --2017/6/11 返回当前星期的第一天(以周日为第一天).
trunc(sysdate,'dd')  --2017/6/13  返回当前年月日
trunc(sysdate,'hh')  --2017/6/13 13:00:00  返回当前小时
trunc(sysdate,'mi')  --2017/6/13 13:06:00  返回当前分钟
````
#### Concat/|：连接两个不同的列，concat只能接受两个参数
concat()


#### Greatest：返回列表中最大值


#### listagg：多行合并成一行  
```
-- 查询部门为20的员工列表
SELECT t.DEPTNO,t.ENAME FROM SCOTT.EMP t where t.DEPTNO = '20' ;

SELECT
	T .DEPTNO,
	listagg (T .ENAME, ',') WITHIN GROUP (ORDER BY T .ENAME) names
FROM
	SCOTT.EMP T
WHERE
	T .DEPTNO = '20'
GROUP BY
	T .DEPTNO
```
#### nvl/nvl2/decode/case when
能用NVL就不用NVL2，能用NVL2就不用DECODE，能用DECODE就不用CASE WHEN
```
//判exp1是否为空，不为空返回exp1，否则返回exp2
nvl(exp1,exp2)

//判exp1是否为空，不为空返回exp2，否则返回exp3
nvl2(exp1,exp2,exp3)

//判断exp的值，返回与之相等的条件所对应的结果，无法匹配则返回默认值（默认值也可不写，则返回null）
decode(exp，条件1，结果1，条件2，结果2，.....，默认值X)

//复杂条件判断
case 
    when exp = 1 then 
        '上午'
    when exp = 2 then 
        '下午'
    else 
        '晚上'
end
```
#### row_number/rank/dense_rank：将查询结果以department分区后按id排序添加序号
row_number:按顺序排序生成序号（eg:1、2、1、2、3、4、5）  
rank:并列跳跃排序，排序值相同则序号相同，然后序号跳跃（eg:1、2、1、2、2、4、5）  
dense_rank：并列连续排序，排序值相同则序号相同，然后序号连续（eg:1、2、1、2、2、3、4）  
不写partition by t.department则排序整个结果集  
```
row_number() over(partition by t.department order by t.id  )as bz
```


#### with as：
```
with temp as (

)
select temp.* from temp
```
#### connect by：递归层级


#### rownum：获取第1条数据或前n条数据
只支持使用<和<=或者=1
```
//获取第一条数据
select * from(
    ......
) where rownum = 1

//获取前n条数据
select * from(
    ......
) where rownum <= n 

select * from(
    ......
) where rownum < n+1
```

## Oracle数据库插入日期处理

````
'1996-12-03' 改为 to_date('1996-12-03','yyyy-mm-dd')  
'1970-12-12' 改为 to_date('1970-12-12','yyyy-mm-dd')  
'19-Dec-00' 改为 to_date('19-Dec-00','dd-mon-yy')  
'19-Oct-75' 改为 to_date('19-Oct-75','dd-mon-yy')  
````

