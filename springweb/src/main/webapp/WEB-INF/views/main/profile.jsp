<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YOUN★STAR</title>
	<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" hre
	3f="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
</head>
<body>
	<div class="container" >
		<!-- 로그인정보 : start -->
		<div class="login_area">
			<!-- 로그인하지 않은 상태  -->
			<c:if test="${member == null }">
				<div class="login_button">
					<a href="/member/login">로그인</a>
					<span><a href="/member/join">회원가입</a></span>
				</div>
			</c:if>	
			<!-- 로그인한 상태 -->
			<c:if test="${member != null }">
				<div class="login_success_area">
					<span>반갑습니다 ${member.user_nm}님♥</span>
					<a id="logoutBtn" class='btn btn-link'>로그아웃</a>
				</div>
			</c:if>
		</div>
		<!-- 로그인정보 : end -->
		
		<div style="height:250px; display: inline-flex; margin-top: 24px;">
		 	<div style="width:277px;border-radius:70%;overflow:hidden;">
		 		<img alt="" src="/resources/img/bear.PNG">
		 	</div>
		 	<div style="width:863px;margin-left: 57px;">
		 		<div style="margin-top:38px;">
		 			${member.user_nm} 
		 			<a style="margin-left:17px;margin-bottom: 2px;" class="btn btn-outline-secondary">프로필 편집</a>
		 			<a style="margin-left:3px;margin-bottom: 2px;" class="btn btn-outline-secondary">게시물 등록</a>
		 		</div>
		 		<div style="margin-top:38px;">게시물</div>	 		
		 	</div>
		</div>
		<hr>
		<ul class="nav justify-content-center">
		  	<li class="nav-item">
		    	<a id="test1" class="nav-link active" aria-current="page" href="javascript:void(0);" style="color:darkgreen;"><img alt="" src="/resources/img/picture.png" style="width:20px;"> 게시물</a>
		  	</li>
		  	<li class="nav-item">
		    	<a id="test2" class="nav-link" href="javascript:void(0);" style="color:darkgreen;"><img alt="" src="/resources/img/video.png" style="width:20px;"> Link</a>
		  	</li>
		</ul>
		
		<div class="pictureDiv">
			<ul style="margin-top: 16px;">
				<th><img alt="" src="/resources/img/koala.jpg" style="width:30%;margin-bottom: 8px;"></th>
				<th><img alt="" src="/resources/img/koala.jpg" style="width:30%;margin-bottom: 8px;"></th>
				<th><img alt="" src="/resources/img/koala.jpg" style="width:30%;margin-bottom: 8px;"></th>
				<th><img alt="" src="/resources/img/koala.jpg" style="width:30%;margin-bottom: 8px;"></th>
				<th><img alt="" src="/resources/img/koala.jpg" style="width:30%;margin-bottom: 8px;"></th>
				<th><img alt="" src="/resources/img/koala.jpg" style="width:30%;margin-bottom: 8px;"></th>
			</ul>
			<ul>
				
			</ul>
		</div>
		<div class="videoDiv" >
			<ul style="margin-top: 16px;">
				<th>안녕안뇽</th>
				<th>안녕안뇽</th>
				<th>안녕안뇽</th>
			</ul>			
		</div>



	</div>
	
	<script type="text/javascript">
		$(function(){
			 $('#videoDiv').css('display', 'none');
		});
		
		/* 로그아웃 버튼 클릭 */
		$("#logoutBtn").click(function(){
			$.ajax({
				type: 'POST',
				url: "/member/logout",
				success: function(data){
					alert("로그아웃 성공");
					location.href = "/main/yunHome";
				}
			})
		});
		
		$("#test1").click(function(){
			$("#videoDiv").css("display", "none");
		})
		$("#test2").click(function(){

		})
		
	</script>
</body>
</html>