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
	<link rel="stylesheet" hre3f="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
	<style type="text/css">
		.modalContent{
			display: inline-block;
			background-color:aliceblue;
			width:39%;
		}
		
		@media (min-width:1100px){
			.modalContent{
				width:100%;
			}		
		}
	</style>
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

		<div style="width:inherit; height:250px; display:inline-flex; margin-top: 24px;">
		 	<img alt="" src="/resources/img/bear.PNG" style="border-radius:70%;">
		 	
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
		
		<!-- 게시물 -->
		<div class="pictureDiv ">
			<ul style="margin-top: 16px;">
				<th><a href="#myModal" data-toggle="modal" class="pictureTh"><img alt="" src="/resources/img/koala.jpg" style="width:30%;margin-bottom: 8px;"></a></th>
				<th><img alt="" src="/resources/img/koala.jpg" style="width:30%;margin-bottom: 8px;"></th>
				<th><img alt="" src="/resources/img/koala.jpg" style="width:30%;margin-bottom: 8px;"></th>
				<th><img alt="" src="/resources/img/koala.jpg" style="width:30%;margin-bottom: 8px;"></th>
				<th><img alt="" src="/resources/img/koala.jpg" style="width:30%;margin-bottom: 8px;"></th>
				<th><img alt="" src="/resources/img/koala.jpg" style="width:30%;margin-bottom: 8px;"></th>
			</ul>
		</div>
		
		<!-- 동영상 -->
		<div class="videoDiv" >
			<ul style="margin-top: 16px;">
				<th>안녕안뇽</th>
				<th>안녕안뇽</th>
				<th>안녕안뇽</th>
			</ul>			
		</div>

		<!-- 게시물 모달 -->
		<div class="modal fade" id="myModal" data-backdrop="static" data-keyboard="false">
		    <div class="modal-dialog modal-xl modal-dialog-centered" >
		      <div class="modal-content" style="height: 912px;">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title"></h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        
		        <!-- Modal body -->
		        <div class="modal-body test" style="overflow:scroll;" >
		        	<div style="display: inline-flex;">
		            	<img class="card-img-top rounded img-fluid" src="/resources/img/koala.jpg" >		        	
		        	</div>
		        	<div class="modalContent" >
		        		<div style="height:500px; overflow:scroll;">
			        		<ul style="padding-left:15px;width:100%;">
		        				<span><img alt="" src="/resources/img/bear.PNG" style="width:60px;border-radius:70%;"></span>
		        				<span style="font-weight:bold;">닉네임자리</span><div>내용부분내용부분내용부분내용부분내용부분내용부분내용부분내용부분</div>
			        		</ul>
			        		<ul style="padding-left:15px;width:100%;">
		        				<span><img alt="" src="/resources/img/bear.PNG" style="width:60px;border-radius:70%;"></span>
		        				<span style="font-weight:bold;">닉네임자리</span><div>내용부분내용부분내용부분내용부분내용부분내용부분내용부분내용부분</div>
			        		</ul>
			        		<ul style="padding-left:15px;width:100%;">
		        				<span><img alt="" src="/resources/img/bear.PNG" style="width:60px;border-radius:70%;"></span>
		        				<span style="font-weight:bold;">닉네임자리</span><div>내용부분내용부분내용부분내용부분내용부분내용부분내용부분내용부분</div>
			        		</ul>
			        		<ul style="padding-left:15px;width:100%;">
		        				<span><img alt="" src="/resources/img/bear.PNG" style="width:60px;border-radius:70%;"></span>
		        				<span style="font-weight:bold;">닉네임자리</span><div>내용부분내용부분내용부분내용부분내용부분내용부분내용부분내용부분</div>
			        		</ul>
			        		<ul style="padding-left:15px;width:100%;">
		        				<span><img alt="" src="/resources/img/bear.PNG" style="width:60px;border-radius:70%;"></span>
		        				<span style="font-weight:bold;">닉네임자리</span><div>내용부분내용부분내용부분내용부분내용부분내용부분내용부분내용부분</div>
			        		</ul>
		        		</div> 
		        		
		        	</div>
		        	
		        	
		        </div>
		        
		        
		        <!-- Modal footer -->
		        <div class="modal-footer">
		          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        </div>
		        
		      </div>
		    </div>
		</div>



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
		
		$("#test1").click(function(){
			document.getElementById('videoDiv').style.display = 'none';
		})
		$("#test2").click(function(){

		})
		
		/* 게시물 사진 클릭 */
		$(".pictureTh").click(function(){
			$("#myModal").modal("show");
		})
		
	</script>
</body>
</html>