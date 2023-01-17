<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<style type="text/css">
	.btn_wrap{
		padding-left : -2px;
		margin-top : 20px;
	} 
</style>  

</head>
<body>
	<div class="container">
		<h1>상세조회</h1>
		
		<section id="container">
			<div class="form-group">
				<label for="bno" class="col-sm2 control-label" >게시판 번호</label>
				<input class="form-control" name="bno" readonly="readonly" value='<c:out value="${pageInfo.bno }"/>' />
			</div>
			<div class="form-group">
				<label for="title" class="col-sm2 control-label">게시판 제목</label>
				<input class="form-control" name="title" readonly="readonly" value='<c:out value="${pageInfo.title }" />' />
			</div>
			<div class="form-group">
				<label for="content" class="col-sm2 control-label">게시판 내용</label>
				<textarea class="form-control" rows="10" name="content" readonly="readonly"><c:out value="${pageInfo.content }" /></textarea>
			</div>
			<div class="form-group">
				<label for="writer" class="col-sm2 control-label">작성자</label>
				<input class="form-control" name="writer" readonly="readonly" value='<c:out value="${pageInfo.writer}" />' />
			</div>
			<div class="form-group">
				<label for="regdate" class="col-sm2 control-label">등록일</label>
				<input class="form-control" name="regdate" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${pageInfo.regdate}"/>' />
			</div>
			<div class="form-group">
				<label for="updateDate" class="col-sm2 control-label">수정일</label>
				<input class="form-control" name="updateDate" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${pageInfo.updateDate}"/>' />
			</div>
			<div class="form-group">
				<label>첨부파일</label>
				<c:forEach var="file" items="${file }">
					<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
				</c:forEach>
			</div>
			<div class="btn_wrap">
				<a class="btn btn-secondary" id="list_btn">목록</a>
				<a class="btn btn-warning" id="modify_btn">수정하기</a>
			</div>
			
			<hr/>
			
			<!-- 댓글 -->
			<form name="replyForm" method="post" class="form-horizontal">
				<input type="hidden" id="bno"     name="bno" value='<c:out value="${pageInfo.bno }"/>' />
				<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum}"/>' />
				<input type="hidden" id="amount"  name="amount" value='<c:out value="${cri.amount}"/>' />
				
				<input type="hidden" id="rDepth" name="rDepth" value='0' />
				
				
				<div class="form-group">
					<label for="rWriter" class="col-sm-2 control-label">댓글 작성자</label>
					<div class="col-sm-2">				
						<input class="form-control" type="text" id="rWriter" name="rWriter" />
					</div>
				</div>	
				<div class="form-group">
					<label for="rContent" class="col-sm-2 control-label">댓글 내용</label>
					<div class="col-sm-10">				
						<input class="form-control" type="text" id="rContent" name="rContent"/>
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="button" class="btn btn-success" id="replyWriteBtn">댓글작성</button>
					</div>			
				</div>
			</form>
		
			<!-- 댓글 목록 -->
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
								<button type="button" class="replyUpdateBtn btn btn-warning" data-rno="${replyList.rno }">수정</button>
								<button type="button" class="replyDeleteBtn btn btn-danger" data-rno="${replyList.rno }">삭제</button>
								<button type="button" class="replyInsertBtn btn btn-primary" data-rno="${replyList.rno }">답글</button>
							</div>
						</li>
						<div id="reReplyList" ></div>
					</c:forEach>
				</ol>
			</div>
			
	
			<form id="infoForm" action="/board/modify" method="get">
				<input type="hidden" id="bno" name="bno" value='<c:out value="${pageInfo.bno }"/>'/>
				<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>' />
				<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>' />		
				<input type="hidden" id="FILE_NO" name="FILE_NO" value="" />
			</form>
		</section>
	</div>
	
	

	
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
	$("#replyWriteBtn").on("click", function(){
		/* var formReply = $("form[name='replyForm']");
		formReply.attr("action","/board/writeReply");
		formReply.submit(); */
		var bno = $("#bno").val() ;
		var rWriter = $("#rWriter").val() ; 
		var rContent = $("#rContent").val() ;
		
		var depth = $("#rDepth").val() ;
		var rDepth = Number(depth);

		var data = {
				 bno : bno
				,rWriter : rWriter	
				,rContent : rContent
				,rDepth : rDepth
		}
		
		$.ajax({
			 data : data
			,type : 'POST'
			,url  : '/board/writeReply'
			,success : function(result){
				var replyHtml = "";
			}	
		});
		
		
		
	});
	
	/* 댓글 수정 view 이동 버튼 */
	$(".replyUpdateBtn").on("click", function(){
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
	

	
	/* 답글달기 버튼 */
	$(".replyInsertBtn").on("click", function(){
		var popUrl = "/board/reReplyInsertView?bno=${pageInfo.bno}&rno="+$(this).attr("data-rno");
		var popOption = "width=490px, height=490px, top=300px, left=300px, scrollbars=yes";
		
		window.open(popUrl, "답글달기", popOption);
	});
	
</script>
</body>
</html>