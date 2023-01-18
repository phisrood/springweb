<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
        
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
			<form id="modifyForm" action="/board/modify" method="post">
				<div class="form-group">
					<label for="bno" class="col-sm2 control-label">게시판 번호</label>
					<input class="form-control" name="bno" readonly value='<c:out value="${pageInfo.bno }"/>' />
				</div>
				<div class="form-group">
					<label for="title" class="col-sm2 control-label">게시판 제목</label>
					<input class="form-control" name="title" value='<c:out value="${pageInfo.title }" />' />
				</div>
				<div class="form-group">
					<label for="content" class="col-sm2 control-label">게시판 내용</label>
					<textarea class="form-control" rows="3" name="content" ><c:out value="${pageInfo.content }" /></textarea>
				</div>
			</form>
			<div class="form-group">
				<label for="writer" class="col-sm2 control-label">작성자</label>
				<input class="form-control" name="writer" readonly="readonly" value='<c:out value="${pageInfo.writer}" />' />
			</div>
			<div class="form-group">
				<label for="regdate" class="col-sm2 control-label">등록일</label>
				<input class="form-control" name="regdate" readonly value='<fmt:formatDate pattern="yyyy-MM-dd" value="${pageInfo.regdate}"/>' />
			</div>
			<div class="form-group">
				<label for="updateDate" class="col-sm2 control-label">수정일</label>      
				<input class="form-control" name="updateDate" readonly value='<fmt:formatDate pattern="yyyy-MM-dd" value="${pageInfo.updateDate}"/>' />
			</div>
			<div class="btn_wrap">
				<a class="btn btn-secondary" id="list_btn">목록</a>
				<a class="btn btn-warning" id="modify_btn">수정하기</a>
				<a class="btn btn-danger" id="delete_btn">삭제하기</a>
				<a class="btn btn-primary" id="cancel_btn">수정취소</a>
			</div>
		
		
			
			<form id="infoForm" action="/board/modify" method="get">
				<input type="hidden" id="bno" name="bno" value='<c:out value="${pageInfo.bno }"/>'/>
				<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>' />
				<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>' />
			</form>
		</section>
		
	</div>
	
	
	
<script>
	var form  = $("#infoForm");
	var mForm = $("#modifyForm"); 
	
	//목록 페이지 이동버튼
	$("#list_btn").on("click", function(e){
		form.find("#bno").remove();
		form.attr("action", "/board/list");
		form.submit();
	});
	
	//수정하기 버튼
	$("#modify_btn").on("click", function(e){
		mForm.submit();
	});
	
	//수정취소 버튼
	$("#cancel_btn").on("click", function(e){
		form.attr("action", "/board/get");
		form.submit();
	});
	
	//삭제하기 버튼
	$("#delete_btn").on("click", function(e){
		form.attr("action", "/board/delete");
		form.attr("method", "post");
		form.submit();
	});
	
</script>
</body>
</html>