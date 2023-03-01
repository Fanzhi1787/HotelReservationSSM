<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="Author" content="">
  <meta name="Keywords" content="KyleJmi酒店预约系统">
  <meta name="Description" content="KyleJmi酒店预约系统">
  <link href="../resources/home/css/reservation.css" type="text/css" rel="Stylesheet"/>
  <link href="../resources/home/css/index.css" type="text/css" rel="Stylesheet"/>
  
<title>KyleJmi酒店预约</title>
</head>

<body>
<!--头部-->
<div id="c_header"></div>
<!--主体内容-->
<section>
  <div id="subject">
  <div class="logo"></div>
	<p style="float:right;">
		<c:if test="${account == null }">
			<a href="../home/login"><button class="offset">登录</button></a>
			<a href="../home/reg"><button class="offset">注册</button></a>
			  <a href="../system/login" target="_blank"><button class="offset">管理员登录</button></a>
		</c:if>
		<c:if test="${account != null }">
			<font color="#165A9D;">当前用户：${account.name }&nbsp;&nbsp;&nbsp;&nbsp;</font>
			<a href="account/index"><button class="offset">用户中心</button></a>
			<a href="../home/logout"><button class="offset">注销登录</button></a>
		</c:if>
	</p>
 <div class="box">
        <!-- 图片盒子 -->
        <div class="box_img">
         <img src="../resources/home/images/indeximg/1.jpg" alt="">
        </div>
        <!-- 左按钮 -->
        <div class="box_left" style="writing-mode:vertical-rl;">
            上一张
        </div>
        <!-- 右按钮 -->
        <div class="box_right" style="writing-mode:vertical-rl;">
            下一张
        </div>
        <!-- 底部小按钮 -->
        <div class="box_round">
            <span class="active"></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
        </div>
    </div>
  </div>

  <!---->
  <!---预订菜单--->
  <div id="due_menu">
    <!--关于-->
    
    <!--客房-->
    <div id="guest_rooms">
      <p class="booking_tab"><span></span>客房列表</p>
      <div class="chioce">
        <input type="text" placeholder="关键字" value="${kw }" id="kw"/>
        <input type="button" value="搜索" id="search-btn"/>
      </div>
      <form style="display:none;" action="index" method="get" id="search-form"><input type="hidden" name="name" id="search-name"></form>
      <!--列表-->
      <table id="pro_list" >
        <thead>
          <tr>
            <th >客房</th>
            <th>房型</th>
            <th>床位</th>
            <th>房价</th>
            <th>状态</th>
            <th>预订</th>
          </tr>
        </thead>
        <tbody >
        <c:forEach items="${roomTypeList }" var="roomType">
        <tr>
          <td style="width="480px;"><a href="#"><img src="${roomType.photo }" class="pic"></a>
          </td>
          <td align="center">
            <p style="font-size:20px;font-weight:bold;color:cornflowerblue;">${roomType.name }</p>
            <p class="sub_txt">${roomType.remark }</p>
          </td>
         
          <td>${roomType.bedNum }</td>
          <td>${roomType.price }</td>
          <td>
          	<c:if test="${roomType.status == 0 }">
          		已满房
          	</c:if>
          	<c:if test="${roomType.status == 1 }">
          		可预订
          	</c:if>
          </td>
          <td>
          	<c:if test="${roomType.status == 0 }">
          		<input type="button" class="disable" value="满房" >
          	</c:if>
          	<c:if test="${roomType.status == 1 }">
          		<input type="button" value="预订" onclick="window.location.href='account/book_order?roomTypeId=${roomType.id }'" >
          	</c:if>
          </td>
        </tr>
		</c:forEach>
        </tbody>
      </table>
      
      <div id="pages"></div>
      <!--  -列表菜单 -->
      <div></div>
    </div>
  </div>

</section>
<%@include file="../common/footer.jsp"%>
<script src="../resources/home/js/jquery-1.11.3.js"></script>
<script>
//图片悬停放大事件
$(function(){
    $w = $('.pic').width();
    $h = $('.pic').height();
    $w2 = $w + 200;
    $h2 = $h + 200;

    $('.pic').hover(function(){
         $(this).stop().animate({height:$h2,width:$w2,left:"-10px",top:"-10px"},500);
    },function(){
         $(this).stop().animate({height:$h,width:$w,left:"0px",top:"0px"},500);
    });
});

$(document).ready(function(){
	$("#search-btn").click(function(){
		$("#search-name").val($("#kw").val());
		$("#search-form").submit();
	})
});

//获取img
let img =document.querySelector('img');
//获取上一张
let box_left = document.querySelector('.box_left');
//获取下一张
let box_right = document.querySelector('.box_right');
//获取小按钮
let box_round_list = document.querySelectorAll('.box_round>span');
console.log(box_round_list);
 
let box = document.querySelector('.box')
 
let index = 0;
//封装图片修改更迭方法
let changeImg = (index1,index2) => {

	box_round_list[index1].classList.remove('active');
	box_round_list[index2].classList.add('active');
	img.src = '../resources/home/images/indeximg/'+ (index2 + 1 )+'.jpg'
	//切换图片
}

	//下一张点击事件
	box_right.onclick = () => {
		changeImg(index,index = index === 5 ? 0 : ++index)
	}

	//上一张点击事件
	box_left.onclick = () => {
		changeImg(index,index = index === 0 ? 5 : --index)
	}
	
	//小圆点事件
    //循环添加小圆点的点击事件
    for ( let i = 0;i<box_round_list.length;i++){
        box_round_list[i].onclick = () => {
            changeImg(index,index = i)
        }
    }
	
	//自动轮播
	let time = setInterval((O) =>{
	box_right.click();
	},2000);
	
	//设置大盒子鼠标滑入事件
	box.onmouseover = () =>{
		clearInterval(time);
	}
	//设置大盒子鼠标移出事件
	box.onmouseout = () =>{
		time = setInterval((O) =>{
			box_right.click();
		},2000);
	}


</script>

</body>
<style>
  button {
  background: none;
  border: 2px solid;
  line-height: 1;
  margin: 10px;
  padding: 12px;
  width: 120px;
  height: 36px;
  white-space: nowrap;
	}
button {
  color: var(--color);
  transition: 0.4s;
}
button:hover, button:focus {
  border-color: var(--hover);
  color: #fff;
}
.offset {
  box-shadow: 0.3em 0.3em 0 0 var(--color), inset 0.3em 0.3em 0 0 var(--color);
}
.offset:hover, .offset:focus {
  box-shadow: 0 0 0 0 var(--hover), inset 6em 3.5em 0 0 var(--hover);
}
.offset {
  --color: #1973bc;
  --hover: #19bc8b;
}
 .box{
 	margin-top:60px;
    width: 1200px;
    height: 500px;
    border:  1px solid #ccc;
    margin_bottom:20px;
    osition: relative;		
        }
		.box_right{
		    right: 0;
		}
        .box_left,.box_right{
            position: absolute;
            top: 40%;
            width: 30px;
            height: 100px;
         	 background:none;
            margin-top: -40px;
            text-align: center;
          	color: #FFFFFF;
            line-height:30px;
             border:  1px solid #ccc;
   
        }
        .box_left:hover,.box_right:hover{
            color: #000000;
           background-color: rgba(231, 231, 231, 1.0);
        }
        .box_round{
            position: absolute;
            left: 30px;
            display: flex;
            justify-content: space-around;
            bottom:30px;
        }
        .box_round > span{
            width: 20px;
            height: 16px;
            border: 2px solid rgba(173, 173, 173, 0.3);
            border-radius: 15%;
            background-color: rgba(0,0,0,.3);
			position: relative;
			left: 500px;
        }
        .box_round > span.active{
            border: 2px solid whitesmoke;
            background-color: rgba(0,0,0,.3);
        }
	    .box_img,.box_img >img{
	            width: 100%;
	            height: 100%;
	        }
		.logo{
			background-image: url(../resources/home/images/logo2.png);
			background-repeat:no-repeat;
			height:50px;
			width:600px;
			float:left;
		 }
</style>