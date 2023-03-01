<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head lang="en">
  <meta charset="UTF-8">
  <title>KyleJmi|酒店管理系统用户中心</title>
  <meta name="Author" content="KyleJmi">
  <meta name="Keywords" content="KyleJmi酒店管理系统">
  <meta name="Description" content="KyleJmi酒店管理系统">
  <link rel="stylesheet" href="../../resources/home/css/index.css"/>
  <link rel="stylesheet" href="../../resources/home/css/mySpace.css"/>

</head>
<body>
    <!--头部-->
    <header>
    <div>
      <a href=""><img src="../../resources/home/images/logo2.png" alt=""></a> 
      &nbsp;&nbsp;&nbsp;
	 <span>&nbsp;会员中心</span>
    </div>
  </header>
    <!--主体-->
    <div id="contain">
        <!--tab选项卡-->
      <ul class="tabs">
       	<li><a href="../index">首页</a></li>
        <li><a href="#order">我的订单</a></li>
        <li><a href="#info">我的资料</a></li>
        <li><a href="#pwd">修改密码</a></li>

      </ul>

      <div class="content">
        
        <div class="order" style="display: block;">
          <table>
            <thead>
            <tr>
              <th>房型图片</th>
              <th>房型</th>
              <th>入住人</th>
              <th>预留手机号</th>
              <th>身份证号</th>
              <th>状态</th>
              <th>下单时间</th>
            </thead>
            <tbody>
               <c:forEach items="${bookOrderList }" var="bookOrder">
               <tr>
					<c:forEach items="${roomTypeList }" var="roomType">
						<c:if test="${roomType.id == bookOrder.roomTypeId }">
							<td><img src="${roomType.photo }" width="100px"></td>
							<td>${roomType.name }</td>
						</c:if>
					</c:forEach>
					<td>${bookOrder.name }</td>
					<td>${bookOrder.mobile }</td>
					<td>${bookOrder.idCard }</td>
					<td>
						<c:if test="${bookOrder.status == 0 }">
			          		<font color="red">预定中</font>
			          	</c:if>
			          	<c:if test="${bookOrder.status == 1 }">
			          		已入住
			          	</c:if>
			          	<c:if test="${bookOrder.status == 2 }">
			          		已结算离店
			          	</c:if>
					</td>
					<td><fmt:formatDate value="${bookOrder.createTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
               </tr>
               </c:forEach>
            </tbody>
          </table>
          
        </div>
        <div class="info" >
          <form id="update-info-form">
          <table style="border:0px;cellspacing:0px;margin-left:50px">
            <tbody >
               <tr>
					<td style="border:0px;">用户名：</td><td style="float:left;width:400px;max-width: 420px;border:0px;"><input class="form-control" type="text" value="${account.name}" name="name" /></td>
               </tr>
			   <tr style="border:0px;">
					<td style="border:0px;">真实姓名：</td><td style="float:left;width:400px;max-width: 820px;border:0px;"><input class="form-control" type="text" value="${account.realName}" name="realName" /></td>
               </tr>
			   <tr>
					<td style="border:0px;">身份证号：</td><td style="float:left;width:400px;max-width: 820px;border:0px;"><input class="form-control" type="text" value="${account.idCard}" name="idCard" /></td>
               </tr>
			   <tr>
					<td style="border:0px;">手机号码：</td><td style="float:left;width:400px;max-width: 820px;border:0px;"><input class="form-control" type="text" value="${account.mobile}" name="mobile" /></td>
               </tr>
			   <tr>
					<td style="border:0px;">联系地址：</td><td style="float:left;width:400px;max-width: 820px;border:0px;"><input class="form-control" type="text" value="${account.address}" name="address" /></td>
               </tr>
            </tbody>
          </table>
          <button type="button" id="update-info-btn" class="btn btn-success" style="width:100px;">提交</button>
          </form>
        </div>
		<div class="pwd" >
          <table style="border:0px;cellspacing:0px;">
            <tbody>
               <tr>
					<td style="border:0px;">原密码：</td><td style="float:left;width:200px;max-width: 420px;border:0px;"><input class="form-control" type="password" id="old-password" /></td>
               </tr>
			   <tr style="border:0px;">
					<td style="border:0px;">新密码：</td><td style="float:left;width:300px;max-width: 420px;border:0px;"><input class="form-control" type="password" id="new-password" /></td>
               </tr>
			   <tr>
					<td style="border:0px;">重复密码：</td><td style="float:left;width:300px;max-width: 420px;border:0px;"><input class="form-control" type="password" id="renew-password" /></td>
               </tr>
			   
			   <tr>
					<td style="border:0px;"></td><td style="float:left;margin-top:15px;width:400px;max-width: 820px;border:0px;"><button type="button" class="btn btn-success" id="update-password-btn" style="width:100px;">提交</button></td>
               </tr>
            </tbody>
          </table>
          
        </div>
      </div>

    </div>
    <!--底部-->
    <div id="c_footer"></div>
    <script src="../../resources/home/js/jquery-1.11.3.js"></script>
 <script>
	$(".tabs").on("click","li a",function(){
    $(this).addClass("active").parents().siblings().children(".active").removeClass("active");
    var href=$(this).attr("href");
    href=href.slice(1);
    var $div=$("div.content>div."+href);
     $div.show().siblings().hide();
    //修改个人信息
     $("#update-info-btn").click(function(){
    	$.ajax({
    		url:'update_info',
    		type:'post',
    		dataType:'json',
    		data:$("#update-info-form").serialize(),
    		success:function(data){
    			alert(data.msg);
    		}
    	});
    });
    //修改密码
    $("#update-password-btn").click(function(){
    	var oldPassword = $("#old-password").val();
    	var newPassword = $("#new-password").val();
    	var renewPassword = $("#renew-password").val();
    	if(oldPassword == ''){
    		alert('请填写原密码！');
    		return;
    	}
    	if(newPassword == ''){
    		alert('请填写新密码！');
    		return;
    	}
    	if(newPassword != renewPassword){
    		alert('两次密码不一致！');
    		return;
    	}
    	$.ajax({
    		url:'update_pwd',
    		type:'post',
    		dataType:'json',
    		data:{oldPassword:oldPassword,newPassword:newPassword},
    		success:function(data){
    			alert(data.msg)
    		}
    	});
    });
});
	
</script>
    
</body>
</html>