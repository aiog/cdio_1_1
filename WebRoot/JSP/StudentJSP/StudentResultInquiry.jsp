<%-- 
@author 张燕清 2014-11-27
本文件属于服务器脚本，主要是实现学生对成绩的分析根据学生ID以及相应的选项生成不同的动态网页
以表格的形式显示学生成绩的查询结果
--%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.ParseException"%>
<%!
String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";   
//加载JDBC驱动
String dbURL = "jdbc:sqlserver://localhost:1433;DatabaseName=cdio_1_1_DB";  //连接服务器和数据库
String userName = "sa";  
String userPwd = "052590"; 
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
String stuid=(String)request.getSession().getAttribute("userid");
String year = (String)request.getParameter("grade");
String term =request.getParameter("term");
String week = request.getParameter("week");


 String sql = " select Score.CourseName,Score.Score from Score,TestPlan where StudentID='"+stuid+"' and Score.TestID=TestPlan.TestID and TestPlan.year='"+year+"' and Term="+term+" and TestTimes="+week+"" ;
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
	<link rel="stylesheet" type="text/css" href="../../CSS/StudentResultInquiry.css">
	 <script charset="UTF-8" src="../../JS/StudentResultInquiry.js"></script>

  </head>
  
 <body>
   <div>
<form  name = "Myform" id = "Myform" action="StudentResultInquiry.jsp" method="post">
<span style="font-size:20px">学年</span>
<select name="grade" id="grade">
<option value="2012-2013" selected="selected">2012-2013</option>
<option value="2013-2014">2013-2014</option>
</select>
<span style="font-size:20px">学期</span>
<select name="term" id="term">
<option value="1" selected="selected">1</option>
<option value="2">2</option>
</select>
<span style="font-size:20px">考试</span>
<select name="week" id="week">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
</select>
<input type="submit"> 
</form>
</div>
<div>
<input type="button" onclick="search()" value="成绩查询"> 
<input type="button" onclick="back()" value="返回上级菜单"> 
<input type="button" onclick="logout()" value="退出">
</div>
<div id="table">
</div>
	<script LANGUAGE="JavaScript">
function search(){
var table=document.getElementById("table");  
var tabstr =" ";
tabstr+="<table border=2><tr>";
tabstr+="<th><b>科目</b></th><th><b>分数</b></th>"; 
tabstr+="</tr>";
<% while(itr.hasNext()){ subject sub = itr.next();%>
tabstr+="<tr>";
tabstr+="<td align= 'center' valign='top'><%=(String)sub.name %></td>"; 
tabstr+="<td align= 'center' valign='top'><%=sub.score%></td>"; 
tabstr+="</tr>";
<%}%>
 tabstr+="</table>";  
 table.innerHTML=tabstr;
}         
</script>  
  </body>
</html>
