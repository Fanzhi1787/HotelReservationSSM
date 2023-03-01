<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>欢迎页面</title>
</head>
<body>
<div title="欢迎使用" style="padding:40px;
	  overflow:hidden; 
	  color: white;
	  font-size:20px;		
	  text-align:center;
	  background: url(../resources/home/images/indeximg/2.jpg) no-repeat;
	  background-size:contain;">
	 <p style="font-size: 70px; line-height: 30px; height: 30px;">欢迎使用基于SSM的酒店管理系统</p>
	<p style="font-size: 50px; line-height: 60px; height: 60px;">当前用户：${admin.username}</p>
  	<p>开发人员：信息工程学院-软件技术191301-张政</p>
  	<p>开发周期：2021/12/2 至 2022/4/30</p>
  	<p>系统环境：Windows 10</p>
	<p>开发工具：Eclipse</p>
	<p>Java版本：JDK 11</p>
	<p>服务器：tomcat 9.0</p>
	<p>数据库：MySQL 8.0</p>
	<p>系统采用技术： spring+springMVC+mybaits+EasyUI+jQuery+Ajax+面向接口编程</p>
</div>
</body>
</html>
<script>

	$(document).ready(function() {
		checkOldPassword();
	})
	function checkOldPassword() {
		//给原密码输入框添加失去焦点事件
		$("#oldPwd").blur(function() {
			var oldPassword = $("#oldPwd").val();
			if (oldPassword == null || oldPassword === '') {
				alert("原密码不能为空！");
				return;
			}
			//发送ajax请求
			$.post("/user/checkOldPassword", {
				"oldPassword" : oldPassword
			}, function(data) {
				if (data.state == 1) {
					$("#sp1").html(data.message);
					$("#sp1").css("color", "green");
				} else {
					$("#sp1").html(data.message);
					$("#sp1").css("color", "red");
				}
			}, "json");
		});
	}
</script>