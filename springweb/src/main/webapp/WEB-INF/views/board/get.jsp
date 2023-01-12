<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<style type="text/css">
	.input_wrap{
		padding: 5px 20px;
	}
	label{
	    display: block;
	    margin: 10px 0;
	    font-size: 20px;	
	}
	input{
		padding: 5px;
	    font-size: 17px;
	}
	textarea{
		width: 800px;
	    height: 200px;
	    font-size: 15px;
	    padding: 10px;
	}
	.btn{
	  	display: inline-block;
	    font-size: 22px;
	    padding: 6px 12px;
	    background-color: #fff;
	    border: 1px solid #ddd;
	    font-weight: 600;
	    width: 140px;
	    height: 41px;
	    line-height: 39px;
	    text-align : center;
	    margin-left : 30px;
	    cursor : pointer;
	}
	.btn_wrap{
		padding-left : 80px;
		margin-top : 50px;
	}
</style>  
</head>
<body>
	<h1>상세조회</h1>
	<div class="input_wrap">
		<label>게시판 번호</label>
		<input name="bno" readonly="readonly" value='<c:out value="${pageInfo.bno }"/>' />
	</div>
	<div class="input_wrap">
		<label>게시판 제목</label>
		<input name="title" readonly="readonly" value='<c:out value="${pageInfo.title }" />' />
	</div>
	<div class="input_wrap">
		<label>게시판 내용</label>
		<textarea rows="3" name="content" readonly="readonly"><c:out value="${pageInfo.content }" /></textarea>
	</div>
	<div class="input_wrap">
		<label>작성자</label>
		<input name="writer" readonly="readonly" value='<c:out value="${pageInfo.writer}" />' />
	</div>
	<div class="input_wrap">
		<label>등록일</label>
		<input name="regdate" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${pageInfo.regdate}"/>' />
	</div>
	<div class="input_wrap">
		<label>수정일</label>
		<input name="updateDate" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${pageInfo.updateDate}"/>' />
	</div>
	<div class="input_wrap">
		<label>첨부파일</label>
		<c:forEach var="file" items="${file }">
			<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
		</c:forEach>
	</div>
	<div class="btn_wrap">
		<a class="btn" id="list_btn">목록</a>
		<a class="btn" id="modify_btn">수정하기</a>
	</div>
	
	<hr/>
	
	<form name="replyForm" method="post">
		<input type="hidden" id="bno" name="bno" value='<c:out value="${pageInfo.bno }"/>' />
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>' />
		<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>' />
		<div>
			<label>댓글 작성자</label><input type="text" id="rWriter" name="rWriter" />
			<label>댓글 내용</label><input type="text" id="rContent" name="rContent" />
		</div>
		<button type="button" class="replyWriteBtn">댓글작성</button>
	</form>

	<!-- 댓글 -->
	<div id="reply">
		<ol class="replyList">
			<c:forEach items="${replyList}" var="replyList">
				<li>
					<p>
						작성자: ${replyList.rWriter}<br/>
						작성일자:<fmt:formatDate value="${replyList.rRegdate}" pattern="yyyy-MM-dd"/>
					</p>
					<p>${replyList.rContent}</p>
					<div>
						<button type="button" class="replyUpdateBtn" data-rno="${replyList.rno }">수정</button>
						<button type="button" class="replyDeleteBtn" data-rno="${replyList.rno }">삭제</button>
					</div>
				</li>
			</c:forEach>
		</ol>
	</div>

	<form id="infoForm" action="/board/modify" method="get">
		<input type="hidden" id="bno" name="bno" value='<c:out value="${pageInfo.bno }"/>'/>
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>' />
		<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>' />		
		<input type="hidden" id="FILE_NO" name="FILE_NO" value="" />
	</form>
	

	
<script>
	var form = $("#infoForm");
	
	/* 목록버튼 클릭 */
	$("#list_btn").on("click", function(e){
		form.find("#bno").remove();
		form.attr("action", "/board/list");
		form.submit();
	});
	
	/* 수정하기버튼 클릭 */
	$("#modify_btn").on("click", function(e){
		form.attr("action", "/board/modify");
		form.submit();
	})
	
	/* 첨부파일 다운로드 기능*/
	function fn_fileDown(fileNo){
		$("#FILE_NO").attr("value", fileNo);
		form.attr("action", "/board/fileDown");
		form.submit();
	}
	
	/* 댓글 작성버튼 클릭 */
	$(".replyWriteBtn").on("click", function(){
		var formReply = $("form[name='replyForm']");
		formReply.attr("action","/board/writeReply");
		formReply.submit();
	});
	
	/* 댓글 수정 view 이동 버튼 */
	$(".replyUpdateBtn").on("click", function(){

		//location.href= "/board/replyUpdateView?bno=${pageInfo.bno}&rno="+$(this).attr("data-rno");
		var popUrl = "/board/replyUpdateView?bno=${pageInfo.bno}&rno="+$(this).attr("data-rno");
		var popOption = "width=490px, height=490px, top=300px, left=300px, scrollbars=yes";
		
		window.open(popUrl, "리뷰수정", popOption);
	});
	
	/* 삭제 버튼 */
	$(".replyDeleteBtn").on("click", function(){
		var a = confirm("작성하신 댓글을 삭제하시겠습니까?");
		if(!a){
		}else{
			var formReply = $("form[name='replyForm']");
			
			formReply.append("<input type='hidden' name='rno' value='"+ $(this).attr("data-rno") +"'>");
			//formReply.append("input[name='replyForm']").val($(this).attr("data-rno"));
			
			formReply.attr("action", "/board/replyDelete");
			formReply.attr("method", "post");
			formReply.submit();
		}
		
		
	});
	
</script>
</body>
</html>