<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시판 등록</h1>
	<form action="/board/insert" method="post" enctype="multipart/form-data">
		<div>
			<label>제목</label>
			<input name="title" />
		</div>
		<div>
			<label>내용</label>
			<textarea rows="3" name="content"></textarea>
		</div>
		<div>
			<label>작성자</label>
			<input name="writer"/>
		</div>
		<div>
			<label>업로드</label>
			<input type="file" name="uploadFile"/>
		</div>
		<button>등록</button>
	</form>
</body>
</html>