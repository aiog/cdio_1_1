<%-- 
@author 张燕清 2014-11-28
本文件属于服务器脚本，主要是实现老师对班级成绩的分析根据分析的类型的不同。例如班级平均分在几次考试的变化情况、班级排名在几次考试的变化情况。生成相应的折线图与柱状图、饼图
通过图的形式显示分析的结果，这样显得更加直观
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
String term  = (String)request.getParameter("term");
String sub = (String)request.getParameter("subject");
String subject = new String(sub.getBytes("ISO-8859-1"),"utf-8");
String sql = "SELECT TestPlan.TestTimes,Score.Score FROM TestPlan,Score  where Score.TestID=TestPlan.TestID and Score.StudentID='123012012001' and TestPlan.Year='"+year+"' and TestPlan.Term='"+term+"' and CourseName='"+subject+"' order by Score.TestID";
 rs = stmt.executeQuery(sql);
 rs.last();
 int num = rs.getRow();
Integer[] data = new Integer[num];
Integer[] month = new Integer[num];
 rs.first();
 int i = 0;
 do{
 month[i] =rs.getInt(1);
 data[i] = rs.getInt(2);
i++;
 }while(rs.next());

%>
<html>
  <head>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
   <link rel="stylesheet" href="../../CSS/Style.css" media="screen" type="text/css"/>
  </head>
  
  <body>
   <div>
   <form  id = "Graphicform" action="StudentResultAnalysis.jsp" method="post">
<span style="font-size:20px">学年</span>
<select name="grade" id="grade">
<option value="2012-2013" selected="selected">2012-2013</option>
<option value="2013-2014" selected="selected">2013-2014</option>
</select>
<span style="font-size:20px">学期</span>
<select name="term" id="term">
<option value="1" selected="selected">1</option>
<option value="2">2</option>
</select>
<span style="font-size:20px">科目</span>
<select name="subject" id="subject">
<option value="语文" selected="selected">语文</option>
<option value="数学">数学</option>
<option value="英语">英语</option>
<option value="物理">物理</option>
<option value="化学">化学</option>
</select>
<input type="submit" value="提交分析信息">
</form>
   </div>
   <div id="container">
   </div>
   <input type="button" onclick="getdiagram()" value="折线图分析">
 <script charset="UTF-8" src="../../JS/d3.v3.js"></script>
<script charset="UTF-8" type="text/javascript">
function getdiagram(){
var data=[];
var Stu=[];
var xmark=[];
var width = 500,
height = 250,
margin={left:50,top:30,right:20,bottom:20},
g_width = width-margin.left-margin.right,
g_height = height-margin.top-margin.bottom;
//svg
getData();
var svg = d3.select("#container")
.append("svg")
//width,height
.attr("width",width)
.attr("height",height);
var g = d3.select("svg")
.append("g")
.attr("transform","translate("+margin.left+","+margin.top+")");
//横坐标的伸缩范围
var scale_x = d3.scale.linear()
.domain([0,data.length-1])
.range([0,g_width]);
//设定纵坐标的伸缩范围
var scale_y = d3.scale.linear()
.domain([0,d3.max(data)])
.range([g_height,0]);
//添加折线
var line_generator = d3.svg.line()
.x(function(d,i){ return scale_x(i);})
.y(function(d){return scale_y(d); })
//.interpolate("cardinal");
//第一条线
d3.select("g")
.append("path")
.attr("d",line_generator(data));
//.interpolate("cardinal");
//第二条线
var x_axis = d3.svg.axis().scale(scale_x).ticks(data.length),
 y_axis = d3.svg.axis().scale(scale_y).orient("left");
g.append("g")
.call(x_axis)
.attr("transform","translate(0,"+g_height+")")
.call(x_axis).selectAll("text").text(function(d){ return xmark[d];})


;
g.append("g")
.call(y_axis)
.append("text")
.text("Price($)")
.attr("transform","rotate(-90)")
.attr("text-anchor","end")
.attr("dy","1em");
//添加系列的小圆点
d3.select("g").selectAll("circle")
	.data(data)
	.enter()
	.append("circle")
	.attr("cx", function(d,i) {
			return scale_x(i);
	})  
	.attr("cy", function(d) {
			return scale_y(d);  
	})  
	.attr("r",5)
	.attr("fill", function(d) {
			return "rgb(" + (d%200) + ",0,0)";  
	});	


//产生随机数据

	function getData()
	{		
		<%for(int j=0;j<data.length;j++){
		%>
		    data.push(<%=data[j]%>);
			xmark.push("考试"+<%=month[j]%>);	
			<%
			}	
			%>
		
	}

}

</script>
  </body>
</html>
