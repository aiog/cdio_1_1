<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
  <head>
  <script>
  function valipwd(f)
  {
  var v1 = document.getElementById('oldpwd').value;//得到输入框1的值var 
  var v2 = document.getElementById('newpwd').value;//得到输入框2的值
 var v3 = document.getElementById('checknewpwd').value;//得到输入框2的值
    if(v1==""||v2==""||v3==""){

           alert("信息不完整，请前些完整") ;

           f.oldpwd.focus() ;

           return false ;

       }

      else if(v2!=v3){

           alert("两次新密码不相同，请重新填写") ;

           f.oldpwd.focus() ;

           return false ;

       }
       else{

       return true ;
       }

    }

  </script>
 <style>
 #pwdform
 {
 position:absolute;
 left:100px;
 top:80px;
 
 }
 </style>
  </head>
  
  <body>
  <div>
  <form id="pwdform" action="checkpasswd.jsp" method="post" onSubmit="return valipwd(this)">
  <dl><label for="oldpwd">原密码:</label>
  <input type="text" name="oldpwd" id="oldpwd"/>
  </dl>
   <dl><label for="newpwd">新密码:</label>
  <input type="text" name="newpwd" id="newpwd"/>
  </dl>
   <dl><label for="checknewpwd">确认新密码:</label>
  <input type="text" name="checknewpwd" id="checknewpwd"/>
  </dl>
  <dl>
 <input type="submit" value="提交" style="background:blue;width: 85px; height: 30px;" >

 <input type="reset" value="重置" style="background:blue;width: 85px; height: 30px;">
  </dl>
   </form>
   </div>
  </body>
</html>
