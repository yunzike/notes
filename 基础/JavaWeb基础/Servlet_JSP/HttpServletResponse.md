---
title: HttpServletResponse
date: 2019-01-17 15:15:29
tags:
 - ServleHttpServletResponse
categories: Servlet
---

#### 一、通过字节流输出到浏览器
````
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//通过设置响应头来控制浏览器使用UTF-8编码格式
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		String country = "中国";
		OutputStream out = response.getOutputStream();
		//指定响应内容为UTF-8编码
		out.write(country.getBytes("UTF-8"));
}
````

#### 二、通过字符流输出到浏览器
````
//设置响应内容的编码为UTF-8
response.setCharacterEncoding("UTF-8");
//通过设置响应头来控制浏览器使用UTF-8编码格式
response.setHeader("Content-type", "text/html;charset=UTF-8");
String country = "中国";
PrintWriter out = response.getWriter();
out.write(country);
````