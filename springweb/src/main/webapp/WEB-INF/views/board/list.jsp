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
	  /* a{text-decoration : none;}
	  table{
	 		border-collapse: collapse;
	 		width: 1000px;    
	 		margin-top : 20px;
	 		text-align: center;
	  }
	  td, th{
	  		border : 1px solid black;
	  		height: 50px;
	  }
	  th{font-size : 17px;}
	  thead{font-weight: 700;}
	  .table_wrap{margin : 50px 0 0 50px;}
	  .bno_width{width: 12%;}
	  .writer_width{width: 20%;}
	  .regdate_width{width: 15%;}
	  .updatedate_width{width: 15%;}
	  .top_btn{
	  		font-size: 20px;
	    	padding: 6px 12px;
	   	 	background-color: #fff;
	    	border: 1px solid #ddd;
	    	font-weight: 600;
	  }
	  
	  .pageInfo{
	    	list-style : none;
	    	display: inline-block;
	  		margin: 50px 0 0 100px;      
	  }
	  .pageInfo li{
	      	float: left;
	    	font-size: 20px;
	    	margin-left: 18px;
	    	padding: 7px;
	    	font-weight: 500;
	  }
	  a:link {color:black; text-decoration: none;}
	  a:visited {color:black; text-decoration: none;}
	  a:hover {color:black; text-decoration: underline;}
	  
	  .active{background-color:#cdd5ec;} */
	</style>
</head>
<body>
	<div class="container">
		<h1>게시판 목록</h1>
		<hr/>
		<a href='/board/insert' class="btn_primary">게시판 등록</a>
		
		<section id="container">
			<table class="table table-hover">
				<thead>
					<tr>
						<th class="bno_width">번호</th>
						<th class="title_width">제목</th>
						<th class="writer_width">작성자</th>
						<th class="regdate_width">작성일</th>
						<th class="updatedate_width">수정일</th>
					</tr>
				</thead>
			<c:forEach items="${list}" var="list">
				<tr>
					<td><c:out value="${list.rownum}"/></td>
					<td>
						<a class="move" href='<c:out value="${list.bno}"/>'>
							<c:out value="${list.title}"/>
							<c:if test="${list.repCount ne 0}">
								<small>
									<b style="color: #B40431;">[&nbsp;<c:out value="${list.repCount}"/>&nbsp;]</b>
								</small>
							</c:if>
						</a>					
					</td>
					<td><c:out value="${list.writer}"/></td>				
					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.regdate}"/></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.updateDate}"/></td>				
				</tr>
			</c:forEach>
		</table>
		
		<div class="col-md-offset-3">
			<div class="pageInfo_area">
				<ul id="pageInfo" class="pagination">		
					<!-- 이전페이지 버튼 -->
					<c:if test="${pageMaker.prev}">
						<li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1 }">Previous</a></li>
					</c:if>
					
					<!-- 각 번호 페이지 버튼 -->
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class='pageInfo_btn ${pageMaker.cri.pageNum==num?"active":"" } '><a href="${num}">${num}</a></li>
					</c:forEach>
					
					<!-- 다음페이지 버튼 -->
					<c:if test="${pageMaker.next}">
						<li class="pageInfo_btn next"><a href="${pageMaker.endPage+1 }">Next</a></li>
					</c:if>
				</ul>
			</div>
		</div>
		
		<form id="moveForm" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">	
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
		});
		
		var moveForm = $("#moveForm");
		
		$(".move").on("click", function(e){
			e.preventDefault();
			moveForm.append("<input type='hidden' name='bno' value='"+ $(this).attr("href") +"'>");
			moveForm.attr("action", "/board/get");
			moveForm.submit();
		});
		
		$("#pageInfo a").on("click", function(e){
			e.preventDefault(); //a태그 동작 멈춤
			moveForm.find("input[name='pageNum']").val($(this).attr("href")); //<form>태그 내부 pageNum과 관련된 <input>태그의 value속성값을 클릭한 <a>태그의 페이지 번호 찾아줘
			moveForm.attr("action", "/board/list") //<form>태그 action 속성 추가 및 '/board/list'을 속성값으로 추가
			moveForm.submit(); //<form>태그 서버 전송
		});

	</script>
</body>
</html>