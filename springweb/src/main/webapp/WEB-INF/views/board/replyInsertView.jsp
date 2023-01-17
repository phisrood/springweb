<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글답변 창</title>
</head>

<body>
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script>
	$(document).ready(function(){
		var form = $("#infoForm");	
		
		$('.update_btn').on("click", function(){
			console.log(1111);
			var rWriter = $("#rWriter").val() ;
			var rContent = $("#rContent").val();
			var bno = $("#bno").val();
			var rno = $("#rno").val();
			
			var depth = $("#rDepth").val();
			var rDepth = Number(depth);
			
			if((rWriter == null || rWriter == '')||(rContent == null || rContent == '')){
				alert("입력해줘");
				return false;
			}
			
			var data = {
					 rWriter  : rWriter
					,rContent : rContent
					,bno      : bno
					,rno      : rno
					,rDepth   : rDepth
			}
			
			$.ajax({
				 data : data
				,type : 'POST'
				,url : '/board/reReplyInsert' 
				,success : function(result){
					alert('답변성공');
					//팝업창 닫으면서 부모창 새로고침
					opener.parent.location.reload(); 
					window.close();
				}
			})
			
		});
	});	
	
	
	
		
	</script>


	<form name="infoForm" action="/board/reReplyInsert" method="post">
		<input type="hidden" name="bno"    id="bno"     value='<c:out value="${replyList.bno}" />' />
		<input type="hidden" name="rno"    id="rno"     value='<c:out value="${replyList.rno}" />' />
		<input type="hidden" name="rDepth" id="rDepth"  value='1' />	
		<div>							
			<label for="rWriter">댓글작성자</label>						
			<input type="text" name="rWriter" id="rWriter"/>
			<label for="rContent">댓글내용</label>
			<input type="text" name="rContent" id="rContent"/>
		</div> 
	</form>

	<div>
		<button type="button" class="update_btn">등록</button>
		<button type="button" class="cancel_btn">취소</button>
	</div>

</body>
</html>