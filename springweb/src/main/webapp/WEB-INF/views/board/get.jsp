<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<script src="https://cdn.ckeditor.com/ckeditor5/36.0.0/classic/ckeditor.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<style type="text/css">
	.btn_wrap {
		padding-left: -2px;
		margin-top: 20px;
	}
	/* ckeditor 높이 */
	.ck-content {height: 500px;}
</style>

</head>
<body>
아이디: ${user_id }
이름 : ${user_nm }

	<div class="container">
		<h1>상세조회</h1>
		
		<section id="container">
			<div class="form-group">
				<label for="writer" class="col-sm2 control-label">작성자</label> 
				<input class="form-control" name="writer" readonly="readonly" value='<c:out value="${pageInfo.writer}" />' />
			</div>
			<div class="form-group">
				<label for="regdate" class="col-sm2 control-label">등록일</label> 
				<input class="form-control" name="regdate" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${pageInfo.regdate}"/>' />
			</div>
			<div class="form-group">
				<label for="updateDate" class="col-sm2 control-label">수정일</label> 
				<input class="form-control" name="updateDate" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${pageInfo.updateDate}"/>' />
			</div>
			<div class="form-group">
				<label for="title" class="col-sm2 control-label">게시판 제목</label> 
				<input class="form-control" name="title" readonly="readonly" value='<c:out value="${pageInfo.title }" />' />
			</div>
			<div class="form-group">
				<label for="content" class="col-sm2 control-label">게시판 내용</label>
				<textarea class="form-control" rows="10" id="content" name="content" readonly="readonly"><c:out value="${pageInfo.content }" /></textarea>
			</div>
			
			<div class="form-group">
				<label>첨부파일</label><span style='color: crimson;'>[${fileCnt}]</span>
				<div style='padding:15px 0px 5px 20px;'>
					<c:forEach var="file" items="${file }">
						<c:url var="imageUrl" value="/board/getImage">
							<c:param name="FILE_NO" value="${file.FILE_NO }" />
						</c:url>
						<ul>
							<li>
								<img style='width: 20px;' src='/resources/img/attach.png' >
								<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br/>
								<img alt="" src="${imageUrl}" width="600px;">
							</li>
						</ul>
					</c:forEach>
				</div>
			</div>
			
			<div class="btn_wrap">
				<a class="btn btn-secondary" id="list_btn">목록</a> 
				<c:if test="${user_id != ''}">		
					<c:if test="${user_nm eq pageInfo.writer}">
						<a class="btn btn-warning" id="modify_btn">수정하기</a>
					</c:if>		
				</c:if>
			</div>

			<hr />

			<!-- 댓글 -->
			<form name="replyForm" method="post" class="form-horizontal">
				<input type="hidden" id="bno" name="bno" value='<c:out value="${pageInfo.bno }"/>' /> 
				<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum}"/>' />
				<input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount}"/>' /> 
				<input type="hidden" id="rDepth" name="rDepth" value='0' />
				<c:if test="${user_id != '' }">			
					<input type="hidden" name="user_id" value="${user_id}">			
					<input type="hidden" name="user_nm" value="${user_nm}">			
				</c:if>
				<c:if test="${user_id == null }">
					<input type="hidden" name="user_id" value="">	
					<input type="hidden" name="user_nm" value="">	
				</c:if>

				<!-- 댓글 작성 -->
				<c:if test="${user_id != ''}">
					<div class="form-group">
						<label for="rWriter" class="col-sm-2 control-label">댓글 작성자</label>
						<div class="col-sm-2">
							<input class="form-control" type="text" id="rWriter" name="rWriter" value="${user_nm}" readonly/>
						</div>
					</div>
					<div class="form-group">
						<label for="rContent" class="col-sm-2 control-label">댓글 내용</label>
						<div class="col-sm-10">
							<input class="form-control" type="text" id="rContent" name="rContent" />
						</div>
					</div>
	
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="button" class="btn btn-success" id="replyWriteBtn">댓글작성</button>
						</div>
					</div>
				</c:if>
				<c:if test="${user_id == ''}">
					<div>댓글은 로그인한 상태에서만 가능합니다.<a href='/member/login'>로그인</a></div>
				</c:if>
			</form>

			<!-- 댓글 목록 -->
			<div id="reply">
				<ol class="replyList">
					<c:forEach items="${replyList}" var="replyList" varStatus="status">
					
						<!-- 자식댓글 -->
						<c:if test="${replyList.rDepth > 0 }">
							<hr style='border-block-color: inherit;'>
							<div style='margin-left: 74px;'>
								부모: ${replyList.rGroup} <br /> 
								자식: ${replyList.rno} <br /> 
								작성자: ${replyList.rWriter} <br />
								작성일자: <fmt:formatDate value='${replyList.rRegdate}' pattern='yyyy-MM-dd' />
								<p>${replyList.rContent}</p>
							</div>
							<div style="margin-left: 71px;">
							
								<c:if test="${user_nm eq replyList.rWriter }">								
									<button type="button" class="reReplyUpdateBtn btn btn-warning" data-rno="${replyList.rno }" >답글 수정</button>
									<button type="button" class="reReplyDeleteBtn btn btn-danger"  data-rno="${replyList.rno }" >답글 삭제</button>
								</c:if>
							</div>
						</c:if>
						<!-- 부모댓글 -->
						<c:if test="${replyList.rDepth eq 0 }">
							<li>
								<div style='margin-top: 25px;'>
									댓글번호: ${replyList.rno} <br /> 
									작성자: ${replyList.rWriter}<br />
									작성일자: <fmt:formatDate value="${replyList.rRegdate}" pattern="yyyy-MM-dd" />
									<p>${replyList.rContent}</p>
								</div>
								<div>
									<c:if test="${user_nm eq replyList.rWriter }">
										<button type="button" class="replyUpdateBtn btn btn-warning" data-rno="${replyList.rno }">수정</button>
										<button type="button" class="replyDeleteBtn btn btn-danger"  data-rno="${replyList.rno }">삭제</button>
									</c:if>
									<c:if test="${user_nm != '' }">								
										<button type="button" class="replyInsertBtn btn btn-primary" data-no="${status.count}" data-rno="${replyList.rno}">답글</button>
									</c:if>
								</div>
							</li>
						</c:if>

						<!-- 답글 등록창 부분 : start -->
						<div style="margin: 7px 10px 8px 12px;" class="reReplyList${status.count }" hidden>
							<div style='padding-top: 14px; padding-left: 25px; padding-bottom: 14px; border-right-width: 0px; margin-right: 0px; margin-left: 60px; background-color: aliceblue;'>
								<form name='reReplyForm' action='/board/reReplyInsert' method='post'>
									<div>
										<label for='rWriter'>답글 작성자</label> 
										<input style='width: 100px; margin-left: 10px;' type='text' name='rWriter' id='reWriter${replyList.rno}' value='${user_nm }' readonly/>
									</div>
									<div>
										<label style='margin-left: 12px;' for='rContent'>답글 내용</label>
										<input style='margin-left: 12px; width: 735px;' type='text' name='rContent' id='reContent${replyList.rno}' />
									</div>
									<div style='margin-left: 84px; margin-top: 3px;'>
										<input type='button' class='btn btn-info' value='답글등록' onclick='reReplyInsertFn(${replyList.rno}, ${pageInfo.bno } );' />
									</div>
								</form>
							</div>
						</div>
						<!-- 답글 등록창 부분 : end -->
						
					</c:forEach>
				</ol>
			</div>

			<form id="infoForm" action="/board/modify" method="get">
				<input type="hidden" id="bno" name="bno" value='<c:out value="${pageInfo.bno }"/>' /> 
				<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>' /> 
				<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>' />
				<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>' />
				<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
				<input type="hidden" id="FILE_NO" name="FILE_NO" value="" />
				<input type="hidden" name="fileCnt" value="${fileCnt}" />
			
				<c:if test="${user_id != '' }">			
					<input type="hidden" name="user_id" value="${user_id}">			
					<input type="hidden" name="user_nm" value="${user_nm}">			
				</c:if>
				<c:if test="${user_id == null }">
					<input type="hidden" name="user_id" value="">	
					<input type="hidden" name="user_nm" value="">	
				</c:if>
				
			</form>
			
		</section>
	</div>




	<script>
	$(function(){
		
		ClassicEditor
			.create(document.querySelector('#content'),{
				toolbar:[]
			})
			.then(editor =>{
				editor.enableReadOnlyMode('my-feature-id');
			})
			.catch(error=>{
				console.error(error);
		});
		
		
	});	

	var form = $("#infoForm");
	
	/* 목록버튼 클릭 */
	$("#list_btn").on("click", function(e){
		form.find("#bno").remove();
		form.find("#FILE_NO").remove();
		form.attr("action", "/board/list");
		form.submit();
		location.href="/board/list" ;
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

		var formReply = $("form[name='replyForm']");
		formReply.attr("action","/board/writeReply");
		formReply.submit();
		
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

			formReply.attr("action", "/board/replyDelete");
			formReply.attr("method", "post");
			formReply.submit();
		}
	});
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/* 답글등록 폼 버튼 */
	$(".replyInsertBtn").on("click", function(){		
		console.log('rno: ',$(this).data('rno'));
		console.log($(".reReplyList"+$(this).data('no')));
		
		$(".reReplyList"+$(this).data('no')).prop('hidden',!$(".reReplyList"+$(this).data('no')).prop('hidden'));
		$(".reReplyList"+$(this).data('no')).show();
	});

	/* 답글 등록 */
	function reReplyInsertFn(rno, bno){
		var targetRwriter = "#reWriter" + rno;
		var targetReContent = "#reContent" + rno;
		var user_id = '<c:out value="${user_id}" />'
		var user_nm = '<c:out value="${user_nm}" />'

		console.log(user_id)
		
		var rWriter = $(targetRwriter).val() ;
		var rContent = $(targetReContent).val();

		if((rWriter == null || rWriter == '')||(rContent == null || rContent == '')){
			alert("입력해줘");
			return false;
		}
		
		var data = {
			user_id : user_id,
			user_nm : user_nm,
			rWriter  : rWriter,
			rContent : rContent,
			rno : rno,
			bno : bno,
			rDepth : 1
		}
		
		$.ajax({
			data : data,
			type : 'POST',
			url : '/board/reReplyInsert',
			success : function(){
				//현재 페이지 새로고침
				//window.location.reload(); 
				document.location.reload();
			}
			
		}); 
	}
	
	$(".reReplyUpdateBtn").on("click", function(){
		var popUrl = "/board/replyUpdateView?bno=${pageInfo.bno}&rno="+$(this).attr("data-rno");
		var popOption = "width=490px, height=490px, top=300px, left=300px, scrollbars=yes";
		
		window.open(popUrl, "답글수정", popOption);
	}) 
	
	$(".reReplyDeleteBtn").on("click", function(){
		var a = confirm("작성하신 답글을 삭제하시겠습니까?");
		if(!a){
		}else{
			var data = {
					rno : $(this).attr("data-rno"),
					bno : ${pageInfo.bno }
			};
			
			$.ajax({
				data : data, 
				type : 'POST',
				url : "/board/replyDelete",
				success : function(){
					alert("삭제되었습니다."); 
					//현재 페이지 새로고침
					//window.location.reload(); 
					document.location.reload();
				}
			});
			
		};
	});
	
</script>
</body>
</html>