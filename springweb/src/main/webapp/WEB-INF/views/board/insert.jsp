<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	/* ckeditor 높이 */
	.ck-content {height: 300px;}
</style>

</head>
<body>
	<script src="https://cdn.ckeditor.com/ckeditor5/36.0.0/classic/ckeditor.js"></script>
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
	var geditor;
		$(document).ready(function(){
			
			/* 등록버튼 체크*/
			$("#insert_btn").on("click", function(e){
				console.log( geditor.getData());
				
				var form = $("#infoForm") ; 

				var title      = $('#title').val();
				var content    = $('#content').val(geditor.getData());
				var writer     = $('#writer').val(); 
				var uploadFile = $('#uploadFile').val();
				if((title == "" || title == null) || (content == "" || content == null) || (writer == "" || writer == null)){
					console.log('content: ',content);
					console.log('title: ',title);
					console.log('writer: ',writer);
					alert('입력해줘');
					return false;
				}
				
				form.find("textarea[name='content']").val(geditor.getData());
				form.submit();
			}); 

			/* 목록버튼 클릭 */
			$("#list_btn").on("click", function(e){
				location.href="/board/list" ;
			});
			
			
			$("#uploadFile").change(function(){
				   if(this.files && this.files[0]) {
				    var reader = new FileReader;
				    reader.onload = function(data) {
				     	$(".select_img img").attr("src", data.target.result).width(500);        
				    }
				    reader.readAsDataURL(this.files[0]);
				   }
			});

			fn_addFile();
			
			ClassicEditor
				.create(document.querySelector('#content'),{
					  toolbar: [ 'heading', 'bold', 'italic', 'insertTable','undo', 'redo', 'numberedList', 'bulletedList']
				})
				.then(editor => {
					geditor = editor;
				})
				.catch(error=>{
					console.error(error);
				}); 
				


		});
		
		
		
		function fn_addFile(){
			var fileIndex = 1;
			$(".fileAdd_btn").on("click", function(){
				var fileHtml = "";
				
				fileHtml += "<div style='display:flex; margin:7px 0px'>";
				fileHtml += "	<input class='form-control' type='file' style='width:auto; margin-right:3px;' name='file_"+(fileIndex++)+"'>";
				fileHtml += "	<button type='button' class='btn btn-outline-secondary' id='fileDelBtn'>삭제</button>";		
				fileHtml += "</div>";
				
				$("#fileIndex").append(fileHtml);
			});
			
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
			});
			
		}
		

		
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
					<textarea class="form-control" name="content" id="content" ></textarea>
				</div>
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
					<input class="form-control" name="writer" id="writer" value="${member.user_nm }" readonly="readonly"/>
				</div>
				<div class="form-group" style="padding-top:14px;">
					<div >
						<div id="fileIndex"></div>
					</div>
				</div>
				
			</form>
			<div class="form-group">
				<div class="btn_wrap">
					<button class="btn btn-secondary" id="list_btn">목록</button>
					<button class="btn btn-primary" id="insert_btn">등록</button>
					<button class="btn btn-success  fileAdd_btn" type="button" >파일추가</button>	
				</div>
			</div>
		</section>
	</div>
	
	
	
</body>
</html>