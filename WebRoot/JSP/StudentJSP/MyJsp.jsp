<%-- 
@author 张燕清 2014-11-27
本文件属于服务器脚本，主要是实现学生对成绩的分析根据学生ID以及相应的选项生成不同的动态网页
以表格的形式显示学生成绩的查询结果
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@page contentType="text/html;charset=GB2312"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.*"%>
<%!
String driverName = "com.mysql.jdbc.Driver";   
//加载JDBC驱动
String dbURL = "jdbc:mysql://121.41.51.176:3306/cdio_1_1_DB";  //连接服务器和数据库
String userName = "cdio_1_1";  
String userPwd = "cdio_1_1"; 
Connection dbConn = null; 
Statement stmt = null ;
ResultSet rs = null; 
%>
<% 
class subject
{
String name;
Integer score;
public subject(String a,Integer b){
this.name =  a;
this.score = b;
}
public subject()
{
}
}

%>
<%
try{
Class.forName(driverName); 
dbConn = DriverManager.getConnection(dbURL, userName, userPwd);  
stmt=dbConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
}
catch(ClassNotFoundException e)
{
e.printStackTrace();

}
catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
}  
 String sql = " select Score.CourseName,Score.Score from Score,TestPlan where StudentID='123012012001' and Score.TestID=TestPlan.TestID and TestPlan.year='2012-2013' and Term=1 and TestTimes=1" ;
 rs = stmt.executeQuery(sql);
 List<subject> lst = new ArrayList<subject>();
 if(rs.next()){
 subject sb  = new subject(rs.getString(1),rs.getInt(2));
 lst.add(sb);
 while(rs.next()){
 sb  = new subject(rs.getString(1),rs.getInt(2));
 lst.add(sb);
 }
 
 }
 else
 {
 out.println("<SCRIPT language=javascript>alert('数据库没有记录，请重新输入!');</script>");
 
 }
 Iterator<subject> itr=lst.iterator();
 

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'StudentManager.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="../../CSS/StudentResultInquiry.css">
	<script LANGUAGE="JavaScript" charset="UTF-8">
function search(){
var table=document.getElementById("table");  
var tabstr =" ";
tabstr+="<table border=2><tr>";
tabstr+="<th><b>科目</b></th><th><b>分数</b></th>"; 
tabstr+="</tr>";
<% while(itr.hasNext()){ subject sub = itr.next();%>
tabstr+="<tr>";
var str = "<%=(String)sub.name %>";
tabstr+="<td align= 'center' valign='top'><%=(String)sub.name %></td>"; 
tabstr+="<td align= 'center' valign='top'><%=sub.score%></td>"; 
tabstr+="</tr>";
<%}%>
 tabstr+="</table>";  
 table.innerHTML=tabstr;
}         
</script>  

  </head>
  
 <body>
   <div>
<span style="font-size:20px">学年</span>
<select name="year" id="year">
<option value="grade1"></option>
<option value="grade2"></option>
<option value="grade3"></option>
</select>
<span style="font-size:20px">学期</span>
<select name="term" id="term">
<option value="1">1</option>
<option value="2">2</option>
</select>
<span style="font-size:20px">周考</span>
<select name="week" id="term">
<option value="1">1</option>
<option value="2">2</option>
<option value="1">3</option>
<option value="2">4</option>
<option value="1">5</option>
<option value="2">6</option>
</select>
</div>
<div>
<input type="button" onclick="search()" value="成绩查询">
<input type="button" onclick="back()" value="返回上级菜单"> 
<input type="button" onclick="logout()" value="退出">
</div>
<div id="table">
</div>
  </body>
</html>