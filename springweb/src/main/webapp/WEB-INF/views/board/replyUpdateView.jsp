<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>게시판</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			/* 취소버튼 클릭 */
			$(".cancel_btn").on("click", function(){
				//location.href = "/board/readView?bno=${replyUpdate.bno}";
				window.close();
			})
			
			
			/* 수정버튼 클릭*/
			$(".update_btn").on("click", function(e){
				var data ={
						rContent : $("#content").val(),
						bno : $("#bno").val(),
						rno : $("#rno").val()
				}

				$.ajax({
					data : data,
					type : 'POST',
					url  : '/board/replyUpdate',
					success : function(result){
						//팝업창 닫으면서 부모창 새로고침
						opener.location.reload();
						//document.location.reload();
						alert("수정되었습니다."); 
						
						window.close();
					}
				})
			});
		})
		
 		
		
	</script>
	<body>
		<div id="root">
			<header>
				<h1>댓글 수정</h1>
			</header>
			<hr />
			<section id="container">
				<form name="updateForm" role="form" method="post" action="/board/replyUpdate">
					<input type="hidden" id="bno" name="bno" value="${replyUpdate.bno}" readonly="readonly"/>
					<input type="hidden" id="rno" name="rno" value="${replyUpdate.rno}" />
					<table>
						<tbody>
							<tr>
								<td>
									<label for="content">댓글 내용</label>
									<input type="text" id="content" name="rContent" value="${replyUpdate.rContent}"/>
								</td>
							</tr>	
						</tbody>			
					</table>
					<div>
						<button type="button" class="update_btn">저장</button>
						<button type="button" class="cancel_btn">취소</button>
					</div>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>