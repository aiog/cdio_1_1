 /*@author 张燕清  2014-11-26
  * 对用户登录页面输入的账号、密码进行判断如果用户输入的表单信息不合法。例如账号、密码为空或者不合法
  * 如果判断用户提交的表单信息不合法那么不提交到服务器直接报错，只有提交的表单信息全部合法且格式正确才提交用户表单
  * 
  * */
function validate(f){

       if(f.userid.value==""){

           alert("用户ID不能为空!") ;

           f.userid.focus() ;

           return false ;

       }

       if(f.password.value==""){

           alert("密码不能为空!") ;

           f.password.focus() ;

           return false ;

       }

       return true ;

    }