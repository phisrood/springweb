<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" 
			crossorigin="anonymous"></script>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

	<style>
	</style>
</head>
<body>
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
		<h1>게시판 목록</h1>
		<hr/>
		
		<div style="display: inline-flex;">
			<div>		
				<a id="insertBtn" type="button" class="btn btn-primary btn-sm">게시글 등록</a>
			</div>
			
	        <div class="search_area" style="position: relative;left: 7px;">
	        	<select style="height:30px;text-align:center;" >
				  <option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>=전체=</option>
				  <option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
				  <option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
				  <option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
				  <option value="TW" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목+내용</option>
				</select>
	            <input style="height:30px;" type="text" name="keyword" value="${pageMaker.cri.keyword }">
	            <button style="height:30px;height:30px;border:1px solid gray;">검색</button>
	        </div>
	        
    	</div>
		
		<section id="container">
			<table class="table table-hover">
				<thead>
					<tr>
						<th style="width:5%;text-align:center;">번호</th>
						<th style="width:1%;text-align:center;">☆</th>
						<th>제목</th>
						<th style="width:9%;">작성자</th>
						<th style="width:9%;text-align:center;">작성일</th>
						<th style="width:9%;text-align:center;">수정일</th>
					</tr>
				</thead>
				<c:if test="${listTotal ne 0}">
						<c:forEach items="${list}" var="list" >
							<tr>
								<td style="text-align:center;"><c:out value="${list.num}" /></td>
								<c:url var="imageUrl" value="/board/listImage">
									<c:param name="bno" value="${list.bno}" />
								</c:url>
								<c:if test="${list.ATTACH_PATH ne null}">
									<td><img alt="없음" src="${imageUrl }" width="80" height="80"></td>
								</c:if>
								<c:if test="${list.ATTACH_PATH eq null}">
									<td></td>
								</c:if>
								<td>
									<a class="move" href='<c:out value="${list.bno}" />'>
										<c:out value="${list.title}"/>
										<c:if test="${list.repCount ne 0}">
											<small>
												<b style="color: #B40431;">[&nbsp;<c:out value="${list.repCount}"/>&nbsp;]</b>
											</small>
										</c:if>
									</a>					
								</td>
								<td><c:out value="${list.writer}"/></td>				
								<td style="text-align:center;"><fmt:formatDate pattern="yyyy-MM-dd" value="${list.regdate}"/></td>
								<td style="text-align:center;"><fmt:formatDate pattern="yyyy-MM-dd" value="${list.updateDate}"/></td>				
							</tr>
						</c:forEach>
				</c:if>
				<c:if test="${listTotal == 0}">
					<tr><td colspan="5" style="text-align: center;">등록된 글이 없습니다.</td></tr>
				</c:if>
				
			</table>
		
		<div class="col-md-offset-3">
			<div class="pageInfo_area">
				<ul id="pageInfo" class="pagination">		
					<!-- 이전페이지 버튼 -->
					<c:if test="${pageMaker.prev}">
						<li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
					</c:if>
					
					<!-- 각 번호 페이지 버튼 -->
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class='pageInfo_btn ${pageMaker.cri.pageNum==num?"active":""} '><a href="${num}">${num}</a></li>
					</c:forEach>
					
					<!-- 다음페이지 버튼 -->
					<c:if test="${pageMaker.next}">
						<li class="pageInfo_btn next"><a href="${pageMaker.endPage+1}">Next</a></li>
					</c:if>
				</ul>
			</div>
		</div>
		
		<form id="moveForm" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">	
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
			<input type="hidden" name="type" value="${pageMaker.cri.type}">
		</form>
		
		<form id="insertForm" method="get">
			<input type="hidden" name="bno" value="">					
			
			<c:if test="${member != null }">			
				<input type="hidden" name="user_id" value="${member.user_id}">			
				<input type="hidden" name="user_nm" value="${member.user_nm}">			
			</c:if>
			<c:if test="${member == null }">
				<input type="hidden" name="user_id" value="">	
			</c:if>		
		</form>
		</section>
		
	</div>

	
	
	
	
	<script>
		$(document).ready(function(){
			var result = '<c:out value="${result}" />';
			
			checkAlert(result);
			
			function checkAlert(result){
				if(result === ''){
					return ;
				}
				if(result === 'insert success'){
					alert("등록이 완료되었습니다.");	
					location.replace("/board/list");
				}
				if(result === 'modify success'){
					alert("수정이 완료되었습니다.");
					location.replace("/board/list");
				}
				if(result === 'delete success'){
					alert("삭제가 완료되었습니다.");
					location.replace("/board/list");
				}
			}
			
			/* 검색버튼 엔터 누를시 */
			$(".search_area input").keydown(function(keyNum){
				if(keyNum.keyCode == 13){ 
					//searchChk();
					var searchVal = $(".search_area input[name='keyword']").val();
					var searchType = $(".search_area select").val();
					
					moveForm.find("input[name='keyword']").val(searchVal);
					moveForm.find("input[name='type']").val(searchType);
					moveForm.find("input[name='pageNum']").val(1);
					moveForm.submit();
				}
			})
		});
		
		
		function searchChk(){
			var type = $(".search_area select").val();
			var keyword = $(".search_area input[name='keyword']").val();
			
			if(!type){
				alert("검색 종류를 선택하세요");
				return false;
			};
			if(!keyword){
				alert("키워드를 입력하세요");
				return false;
			};
		};
		
		
		var moveForm = $("#moveForm");
		var form = $("#insertForm");
		
		/* 검색버튼 */
		$(".search_area button").on("click", function(e){
			e.preventDefault();
			//searchChk();
			var searchVal = $(".search_area input[name='keyword']").val();
			var searchType = $(".search_area select").val();
			
			moveForm.find("input[name='keyword']").val(searchVal);
			moveForm.find("input[name='type']").val(searchType);
			moveForm.find("input[name='pageNum']").val(1);
			moveForm.submit();
		})
		
		/* 상세조회 */
		$(".move").on("click", function(e){
			e.preventDefault();
			form.find("input[name=bno]").remove();
			form.append("<input type='hidden' name='bno' value='"+ $(this).attr("href") +"'>");
			form.attr("action", "/board/get");
			form.submit();
		});
		
		/* 게시글 등록 */
		$("#insertBtn").click(function(){
			if(${member != null }){
				form.attr("action", "/board/insert");
				form.submit();
			}else{
				alert("게시글 등록은 로그인한 상태에서만 가능합니다.");
				return false;
			}	
		});
		
		/* 페이지네이션 */
		$("#pageInfo a").on("click", function(e){
			e.preventDefault(); //a태그 동작 멈춤
			
			moveForm.find("input[name='pageNum']").val($(this).attr("href")); //<form>태그 내부 pageNum과 관련된 <input>태그의 value속성값을 클릭한 <a>태그의 페이지 번호 찾아줘
			moveForm.attr("action", "/board/list") //<form>태그 action 속성 추가 및 '/board/list'을 속성값으로 추가
			moveForm.submit(); //<form>태그 서버 전송
		});
		
		/* 로그아웃 버튼 클릭 */
		$("#logoutBtn").click(function(){
			$.ajax({
				type: 'POST',
				url: "/member/logout",
				success: function(data){
					alert("로그아웃 성공");
					document.location.reload();
				}
			})
		});

	</script>
</body>
</html>