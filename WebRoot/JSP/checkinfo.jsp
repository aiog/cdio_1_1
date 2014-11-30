<!-- 
@author 张燕清  2014-11-26
本文件是服务端脚本，主要是接受用户提交的表单，根据执行结果返回一个网页。如果用户账号密码都正确那么登录系统成功，页面跳转到对应用户类别的主功能界面
如果登录失败那么提示错误并且重新返回登录页面
-->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@page contentType="text/html;charset=GB2312"%>
<%@page import="java.sql.*"%>
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
String userid = (String)request.getParameter("userid") ; // 接收表单参数
 request.getSession().setAttribute("userid", userid);//设置全局变量
String password = request.getParameter("password") ; // 接受表单参数
String usertype =  request.getParameter("type");
request.getSession().setAttribute("usertype", usertype);
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
if(usertype.equals("student")){
 String sql = "SELECT StudentID,StudentName FROM Student WHERE (StudentID='"+userid+"' AND  Password='"+password+"')" ;
 rs = stmt.executeQuery(sql);
 if(rs.next()){
 response.sendRedirect("StudentJSP/StudentOperation.jsp");
 
}
else
{
out.println("<SCRIPT language=javascript>alert('用户名或密码不正确，请重新输入!'); window.location='../Login.html';</script>");
}}
else if(usertype.equals("teacher")){
String sql = "SELECT TeacherID,TeacherName FROM Teacher WHERE (TeacherID='"+userid+"' AND  Password='"+password+"')" ;
 rs = stmt.executeQuery(sql);
 if(rs.next()){
 response.sendRedirect("TeacherJSP/TeacherOperation.jsp");
 
}
else
{
out.println("<SCRIPT language=javascript>alert('用户名或密码不正确，请重新输入!'); window.location='../Login.html';</script>");
}

}
else{

String sql = "SELECT StudentID,StudentName FROM Student WHERE (StudentID='"+userid+"' AND  Password='"+password+"')" ;
 rs = stmt.executeQuery(sql);
 if(rs.next()){
 response.sendRedirect("../index.jsp");
 
}
else
{
out.println("<SCRIPT language=javascript>alert('用户名或密码不正确，请重新输入!'); window.location='../Login.html';</script>");
}


}

%>




