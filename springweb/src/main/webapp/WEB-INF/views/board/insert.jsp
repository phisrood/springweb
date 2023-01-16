<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.btn_wrap{
		padding-left : -2px;
		margin-top : 20px;
	} 
</style>

</head>
<body>
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			
			/* 등록버튼 체크*/
			$("#insert_btn").on("click", function(e){
				var title      = $('#title').val();
				var content    = $('#content').val();
				var writer     = $('#writer').val(); 
				var uploadFile = $('#uploadFile').val();
				if((title == "" || title == null) || (content == "" || content == null) || (writer == "" || writer == null)){
					alert('입력해줘');
					return false;
				}
			}); 
			
			/* 목록버튼 클릭 */
			$("#list_btn").on("click", function(e){
				location.href="/board/list"
			});
		});
	</script>
	
	<div class="container">
		<h1>게시판 등록</h1>
		<section id="container">
			<form id="infoForm" action="/board/insert" method="post" enctype="multipart/form-data">			
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<input class="form-control" name="title" id="title"/>
				</div>
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<textarea class="form-control" rows="3" name="content" id="content"></textarea>
				</div>
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
					<input class="form-control" name="writer" id="writer"/>
				</div>
				<div class="form-group">
					<label for="uploadFile" class="col-sm-2 control-label">업로드</label>
					<input class="form-control" type="file" name="uploadFile" id="uploadFile"/>
				</div>
				<div class="form-group">
					<div class="btn_wrap">
						<button class="btn btn-secondary" id="list_btn">목록</button>
						<button class="btn btn-primary" id="insert_btn">등록</button>
					</div>
				</div>
			</form>
			
		</section>
	</div>
	
	
	
</body>
</html>