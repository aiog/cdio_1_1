
<!-- 
@author 张燕清  2014-11-26
本文件是是学生登录成功后跳转的主功能或者说操作页面
-->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<!-- 引用的页面样式文件 -->
<link rel="stylesheet" href="../../CSS/StudentOperation.css" media="screen" type="text/css"/>
<!-- 引用的js文件对用户选择进行处理  -->
<script charset="UTF-8" src="../../JS/stuoperationchoose.js"></script>
</head>
  <body background="../../Img/Login.jpg"><!-- 设置背景 -->
  <div id="logoutdiv">
  <h3>欢迎你亲爱的张同学<p></p><input type="button" name="logout" id="logout" onclick="logout()" style="width:60px;height:30px" value="退出"/><h3>
  
</div>
  <div id="menu">
  <div id="manager">
  <input type="button" name="manager" onclick="manager()" style="width:95px;height:55px" value="用户管理"/>
  </div>
  <div id="search">
    <input type="button" name="search"  onclick="search()" style="width:95px;height:55px" value="成绩查询"/>
  </div>
    <div id="analysis">
    <input type="button" name="analasys"  onclick="analysis()" style="width:95px;height:55px" value="成绩分析"/>
  </div>
  </div>
  </body>
</html>
