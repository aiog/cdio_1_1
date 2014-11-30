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
String userName = "sa";  //用户的数据库账号
String userPwd = "052590"; //用户密码
Connection dbConn = null; //连接
Statement stmt = null ;
ResultSet rs = null; //结果集
ResultSet rs2 = null; //结果集
%>
<% 
class subject
{
String stuid;
String name;
Integer score;
Integer avgscore;
public subject(String a,String b,Integer c){
this.stuid =  a;
this.name = b;
this.score = c;
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
String grade = (String)request.getParameter("enter");
String year = (String)request.getParameter("year");
/**String ma = request.getParameter("major");
String major = new String(ma.getBytes("ISO-8859-1"),"utf-8");
String cl = request.getParameter("class");
String classname = new String(cl.getBytes("ISO-8859-1"),"utf-8");
**/
String Term =request.getParameter("term");
String week =request.getParameter("week");
 String sql = "select Score.StudentID,Student.StudentName,Score.Score from Student,Score,TestPlan,Class where Student.ClassID=Class.ClassID and Student.StudentID=Score.StudentID and Score.TestID=TestPlan.TestID  and TestPlan.Term="+Term+" and TestPlan.TestTimes="+week+" and CourseName='语文' and TestPlan.year='"+year+"' and Class.Grade="+grade+" and Class.ClassName = '一班' order by Student.StudentID";
 String sqll ="select AVG(Score.Score) from Student,Score,TestPlan,Class where Student.ClassID=Class.ClassID and Student.StudentID=Score.StudentID and Score.TestID=TestPlan.TestID  and TestPlan.Term="+Term+" and TestPlan.TestTimes="+week+" and CourseName='语文' and TestPlan.year='"+year+"' and Class.Grade='"+grade+"' and Class.ClassName = '一班'" ;
 rs = stmt.executeQuery(sql);
 List<subject> lst = new ArrayList<subject>();
 if(rs.next()){
 subject sb  = new subject(rs.getString(1),rs.getString(2),rs.getInt(3));
 lst.add(sb);
 while(rs.next()){
 sb  = new subject(rs.getString(1),rs.getString(2),rs.getInt(3));
 lst.add(sb);
 }
 }
 else
 {
 out.println("<SCRIPT language=javascript>alert('数据库没有记录，请重新输入!');</script>");
 
 }
   rs2 = stmt.executeQuery(sqll);
  String avg = new String();
   if(rs2.next()){
   avg = rs2.getString(1);
}
  Iterator<subject> itr=lst.iterator();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  	<link rel="stylesheet" type="text/css" href="../../CSS/StudentResultInquiry.css">
	 <script charset="UTF-8" src="../../JS/TeacherResultInquiry.js"></script>
  </head>
  
  <body>
  <div>
  <form name = "teacherSearchForm" id="teacherSearchForm" action="TeacherResultInquiry.jsp" method="post">
  <span style="font-size:20px">入学时间</span>
<select name="enter" id="enter">
<option value="2012" selected="selected">2012</option>
</select>
<span style="font-size:20px">班级</span>
<select name="class" id="class">
<option value="一班" selected="selected">一班</option>
<option value="二班">二班</option>
<option value="三班">三班</option>
<option value="四班">四班</option>
</select>
<span style="font-size:20px">学年</span>
<select name="year" id="year">
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
<option value="1" selected="selected">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
</select>
<span style="font-size:20px">科目</span>
<select name="major" id="major">
<option value="语文" selected="selected">语文</option>
<option value="数学">数学</option>
<option value="英语">英语</option>
<option value="物理">物理</option>
<option value="化学">化学</option>
</select>
<input type="submit" > 
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
tabstr+="<th><b>学号</b></th><th><b>姓名</b></th><th><b>分数</b></th><th><b>班级平均分</b></th>"; 
tabstr+="</tr>";
<% while(itr.hasNext()){ subject sub = itr.next();%>
tabstr+="<tr>";
tabstr+="<td align= 'center' valign='top'><%=(String)sub.stuid %></td>"; 
tabstr+="<td align= 'center' valign='top'><%=sub.name%></td>"; 
tabstr+="<td align= 'center' valign='top'><%=sub.score%></td>"; 
tabstr+="<td align= 'center' valign='top'><%=(String)avg%></td>"; 
tabstr+="</tr>";
<%}%>
 tabstr+="</table>";  
 table.innerHTML=tabstr;
}         
</script>  
  </body>
</html>
