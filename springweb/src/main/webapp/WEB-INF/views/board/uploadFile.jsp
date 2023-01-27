<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.uploadResult{
		width: 100%;
		background-color: gray;
	}
	.uploadResult ul{
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	.uploadResult ul li{
		list-style: none;
		padding: 10px;
	}
	.uploadResult ul li img{
		width: 20px;
	}
	.uploadResult ul li #img{
		width: 100%;
	}

</style>

</head>
<body>
	<h2>첨부파일 테스트</h2>
	<br/>
	<h3>form방식</h3>
	<form action="/board/uploadFormAction" method="post" enctype="multipart/form-data">
		<input type="file" name="uploadFile" mutiple />
		<button>업로드</button>
	</form>
	
	<hr/>
	
	<h3>ajax방식</h3>
	<div class="uploadDiv">
		<input type="file" name="uploadFile1" multiple />
	</div>
	<div class="uploadResult">
		<ul>
		
		</ul>
	</div>
	
	<button id="uploadBtn">업로드</button>
	
	
	<script type="text/javascript">
	$(document).ready(function(){
		
		//첨부파일 이름을 목록으로 처리
		var uploadResult = $(".uploadResult ul");
		
		function showUploadedFile(uploadResultArr){

			var str = "";
			
			$(uploadResultArr).each(function(i, obj){
				console.log('obj==========: ',obj);
				
				if(!obj.image){
					str += "<li><img src='/resources/img/attach.png'> "+ obj.fileName +"</li>";
				}else{
					//str += "<li>" + obj.fileName + "</li>";
					var fileCallPath = encodeURIComponent(obj.uploadPath+ "/s_" +obj.uuid+ "_" +obj.fileName);
					str += "<li><img id='img' src='/board/display?fileName="+fileCallPath+"'></li>";
				}
				
			});
			uploadResult.append(str);
		}
		
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;  //5MB
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
			 	return false; 
			}
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		var cloneObj = $(".uploadDiv").clone();
		
		$("#uploadBtn").on("click", function(){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile1']");
			var files = inputFile[0].files;
			console.log('files',files);
			
			//add filedate to formdata
			for(var i=0; i<files.length; i++){
				if(!checkExtension(files[i].name, files[i].size)){
					return false; 
				}
				
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: '/board/uploadFile',
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType: 'json',
				success: function(result){
					alert(result);
					
					showUploadedFile(result);
					$(".uploadDiv").html(cloneObj.html());
				}
			})// $.ajax end
		});
	});
	
	
	</script>
</body>
</html>