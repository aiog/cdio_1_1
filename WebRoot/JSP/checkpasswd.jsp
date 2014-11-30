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
Connection dbConn; 
Statement stmt = null ;
ResultSet rs; 
%>
<%
String oldpasswd = request.getParameter("oldpwd") ; // 接收表单参数
String newpasswd = request.getParameter("newpwd") ; // 接受表单参数
String userid = (String)request.getSession().getAttribute("userid");
String usertype = (String)request.getSession().getAttribute("usertype");
Class.forName(driverName); 
dbConn = DriverManager.getConnection(dbURL, userName, userPwd);  
stmt=dbConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY); 
if(usertype.equals("student")){ 
 String sql1 = "SELECT StudentID,StudentName FROM Student  WHERE (StudentID='"+userid+"' AND Password='"+oldpasswd+"')" ;
 String sql2 = "update Student set Password = '"+newpasswd+"' WHERE (StudentID='"+userid+"')" ;
 rs = stmt.executeQuery(sql1);
 if(rs.next()){
 stmt.executeUpdate(sql2);
out.println("<script language=javascript>alert('密码修改成功!请重新登录'); window.location='../Login.html';</script>");
// response.sendRedirect("StudentMenu.jsp");
}
else
{
out.println("<SCRIPT language=javascript>alert('用户名或密码不正确，请重新修改密码!'); window.location='passwdchange.jsp';</script>");
}
}
else if(usertype.equals("teacher"))
{
 String sql1 = "SELECT StudentID,StudentName FROM Student  WHERE (TeacherID='"+userid+"' AND Password='"+oldpasswd+"')" ;
 String sql2 = "update Student set Password = '"+newpasswd+"' WHERE (StudentID='"+userid+"')" ;
 rs = stmt.executeQuery(sql1);
 if(rs.next()){
 stmt.executeUpdate(sql2);
out.println("<script language=javascript>alert('密码修改成功!请重新登录'); window.location='../Login.html';</script>");
// response.sendRedirect("StudentMenu.jsp");
}
else
{
out.println("<SCRIPT language=javascript>alert('用户名或密码不正确，请重新修改密码!'); window.location='passwdchange.jsp';</script>");
}

}
else{


}

%>




