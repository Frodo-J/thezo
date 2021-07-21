<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 에디터 api 다시 수정하기  -->
<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<style>
    #enrollForm>table{width:80%;}
    #enrollForm>table *{ margin:5px;}
    
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	
    <div class="outer">
        <br>
        <h1><b>공지사항</b></h1>
        <br><br>

        <form id="enrollForm" method="post" action="" enctype="">
            <table align="center">
                <tr>
                    <th><label for="title">제목</label></th>
                    <td><input type="text" id="title" class="form-control" value="공지사항입니다" name="" required></td>
                </tr>
                <tr>
                    <th><label for="writer">작성자</label></th>
                    <td><input type="text" id="writer" class="form-control" value="user01" name="" readonly></td>
                </tr>
                <tr height="500px;"><!--에디터 api 적용하자-->
                    <th><label for="content">내용</label></th>
                    <th><div id="summernote"></div> </th>



                    <!--일단 남겨두기-->
                    <th><textarea class="form-control" value="공지사항입" required name="" id="content" rows="10" style="resize:none;"></textarea></th>
                </tr>
                <tr>
                    <th><label for="upfile">첨부파일</label></th>
                    <td>
                        <input type="file" id="upfile" class="form-control-file border" name="">
                        현재 업로드된 파일 : 
                        <a href="" download="">flower.png</a>
                    </td>
                </tr>

            </table>
            <br>

        <br>

        <div align="center">
            <!-- 수정하기, 삭제하기 버튼은 이글이 본인글일 경우만 보여져야됨 -->
            <button type="submit" class="btn btn-secondary">수정</button>
            <button type="button" class="btn btn-secondary" onclick="javascript:history.go(-1);">이전</button>
        </div><br><br>


        <script>
            $(document).ready(function() {
                    $('#summernote').summernote({
                        lang: 'ko-KR',
                        height: 300,
                    });
                    
            });
        </script>

    </div>
  
	


</body>
</html>