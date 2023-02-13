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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

</head>
<body>
	<div class="container">
		<div class="container">
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
			<h1>메인화면</h1>
			<div></div>
			
	</div>
	
	<script type="text/javascript">
		$(function(){
			  
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
	</script>
</body>
</html>