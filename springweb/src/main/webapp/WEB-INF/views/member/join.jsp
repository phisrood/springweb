<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<style type="text/css">
	*{
		margin: 0;
		padding:0;
	}
	
	/* 화면 전체 렙 */
	.wrapper{
		width: 100%;	
	}
	
	/* content 랩 */
	.wrap{
		width : 800px;
		margin: auto;
	}
	/* 페이지 제목 */
	.subjecet{
		width: 100%;
	    height: 120px;
	    background-color: #8EC0E4;
	}
	.subjecet span{
		margin-left: 231px;
	    font-size: 74px;
	    font-weight: 900;
	    color: white;
	}
	
	/* 아이디 영역 */
	.id_wrap{
		width: 100%;
	    margin-top: 20px;
	}
	.id_name{
		font-size: 25px;
	    font-weight: bold;
	}
	.id_input_box{
		border: 1px solid black;
		/* height:31px; */
		padding: 10px 14px;	
		
	}
	.id_input{
		width:100%;
		height:100%;
		border:none;
		font-size:28px;
	}
	
	/* 비밀번호 영역 */
	.pw_wrap{
		width: 100%;
	    margin-top: 20px;
	}
	.pw_name{
		font-size: 25px;
	    font-weight: bold;
	}
	.pw_input_box{
		border: 1px solid black;
		/* height:31px; */
		padding: 10px 14px;	
		
	}
	.pw_input{
		width:100%;
		height:100%;
		border:none;
		font-size:28px;
	}
	
	/* 비밀번호 확인 영역 */
	.pwck_wrap{
		width: 100%;
	    margin-top: 20px;
	}
	.pwck_name{
		font-size: 25px;
	    font-weight: bold;
	}
	.pwck_input_box{
		border: 1px solid black;
		/* height:31px; */
		padding: 10px 14px;	
		
	}
	.pwck_input{
		width:100%;
		height:100%;
		border:none;
		font-size:28px;
	}
	
	/* 이름 영역 */
	.user_wrap{
		width: 100%;
	    margin-top: 20px;
	}
	.user_name{
		font-size: 25px;
	    font-weight: bold;
	}
	.user_input_box{
		border: 1px solid black;
		/* height:31px; */
		padding: 10px 14px;	
		
	}
	.user_input{
		width:100%;
		height:100%;
		border:none;
		font-size:28px;
	}
	

	

	
	/* 가입하기 버튼 */
	 .join_button_wrap{
		margin-top: 40px;
		text-align: center;
	}
	.join_button{
		width: 100%;
	    height: 80px;
	    background-color: #6AAFE6;
	    font-size: 40px;
	    font-weight: 900;
	    color: white;
	} 

	
	/* float 속성 해제 */
	.clearfix{
		clear: both;
	}
	
	/* 중복아이디 존재하지 않는경우 */
	.id_input_re_1{
		color : green;
		display : none;
	}
	/* 중복아이디 존재하는 경우 */
	.id_input_re_2{
		color : red;
		display : none;
	}
	
	/* 유효성 검사 문구 */
	.final_id_ck{
	    display: none;
	}
	.final_pw_ck{
	    display: none;
	}
	.final_pwck_ck{
	    display: none;
	}
	.final_name_ck{
	    display: none;
	}
	.final_mail_ck{
	    display: none;
	}
	.final_addr_ck{
	    display: none;
	}


	/* 비밀번호 확인 일치 유효성검사 */
	.pwck_input_re_1{
	        color : green;
	        display : none;    
	}
	.pwck_input_re_2{
	        color : red;
	        display : none;    
	} 

</style>


</head>
<body>
<div class="wrapper">
	<form id="join_form" method="post">
		<div class="wrap">
			<div class="subjecet">
				<span>회원가입</span>
			</div>
			<div class="id_wrap">
				<div class="id_name">아이디</div>
				<div class="id_input_box">
					<input class="id_input" name="user_id">
				</div>
				<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
				<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
				<span class="final_id_ck">아이디를 입력해주세요.</span>
			</div>
			<div class="user_wrap">
				<div class="user_name">이름</div>
				<div class="user_input_box">
					<input class="user_input" name="user_nm">
				</div>
				<span class="final_name_ck">이름을 입력해주세요.</span>
			</div>
			<div class="pw_wrap">
				<div class="pw_name">비밀번호</div>
				<div class="pw_input_box">
					<input class="pw_input" name="user_pw">
				</div>
				<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
			</div>
			<div class="pwck_wrap">
				<div class="pwck_name">비밀번호 확인</div>
				<div class="pwck_input_box">
					<input class="pwck_input" >
				</div>
				<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
				<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
                <span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
			</div>
			<div class="join_button_wrap">
				<input type="button" id="joinBtn" class="btn btn-info join_button" value="가입하기">
			</div>
		</div>
	</form>
</div>



<script type="text/javascript">
	/* 유효성 검사 통과유무 변수 */
	var idCheck = false;            // 아이디
	var idckCheck = false;            // 아이디 중복 검사
	var pwCheck = false;            // 비번
	var pwckCheck = false;            // 비번 확인
	var pwckcorCheck = false;        // 비번 확인 일치 확인
	var nameCheck = false;            // 이름

	$(document).ready(function(){
		
		/* 회원가입 버튼 클릭 */
		$("#joinBtn").click(function(){
			/* 입력값 변수 */
	        var id = $('.id_input').val();                 // id 입력란
	        var pw = $('.pw_input').val();                // 비밀번호 입력란
	        var pwck = $('.pwck_input').val();            // 비밀번호 확인 입력란
	        var name = $('.user_input').val();            // 이름 입력란

	        /* 아이디 유효성검사 */
	        if(id == ""){
	            $('.final_id_ck').css('display','block');
	            idCheck = false; 
	        }else{
	            $('.final_id_ck').css('display', 'none');
	            idCheck = true; 
	        }
	        
	        /* 비밀번호 유효성 검사 */
	        if(pw == ""){
	            $('.final_pw_ck').css('display','block');
	            pwCheck = false;
	        }else{
	            $('.final_pw_ck').css('display', 'none');
	            pwCheck = true;
	        }
	        /* 비밀번호 확인 유효성 검사 */
	        if(pwck == ""){
	            $('.final_pwck_ck').css('display','block');
	            pwckCheck = false;
	        }else{
	            $('.final_pwck_ck').css('display', 'none');
	            pwckCheck = true;
	        }
	        
	        /* 이름 유효성 검사 */
	        if(name == ""){
	            $('.final_name_ck').css('display','block');
	            nameCheck = false;
	        }else{
	            $('.final_name_ck').css('display', 'none');
	            nameCheck = true;
	        }
	        
	        /* 최종 유효성 검사 */
	        if(idCheck && idckCheck && pwCheck && pwckCheck && pwckcorCheck && nameCheck){
	        	$("#join_form").attr("action", "/member/join");
				$("#join_form").submit();
	        }  	
	        
	        return false; //정상 종료되지 못할 경우를 대비
		});
		
		
	});
	
	/* 아이디 중복검사 */
	$('.id_input').on("propertychange change keyup paste input", function(){
		var user_id = $('.id_input').val();	// .id_input에 입력되는 값
		var data = {user_id : user_id}		// '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'
		
		$.ajax({
			type : "post",
			url : "/member/memberIdChk",
			data : data,
			success : function(result){
				if(result != 'fail'){
					$('.id_input_re_1').css("display","inline-block");
					$('.id_input_re_2').css("display", "none");	
					idckCheck = true; // 아이디 중복이 없는 경우
				} else {
					$('.id_input_re_2').css("display","inline-block");
					$('.id_input_re_1').css("display", "none");	
					idckCheck = false; // 아이디 중복된 경우
				} 
			}
		}); // ajax 종료
	});
	
	/* 비밀번호 확인 일치 유효성 검사 */
	$('.pwck_input').on("propertychange change keyup paste input", function(){
	 
	    var pw = $('.pw_input').val();
	    var pwck = $('.pwck_input').val();
	    $('.final_pwck_ck').css('display', 'none');
	        
	    if(pw == pwck){
	        $('.pwck_input_re_1').css('display','block');
	        $('.pwck_input_re_2').css('display','none');
	        pwckcorCheck = true;
	    }else{
	        $('.pwck_input_re_1').css('display','none');
	        $('.pwck_input_re_2').css('display','block');
	        pwckcorCheck = false;
	    }        
	    
	});  

	
</script>
</body>
</html>