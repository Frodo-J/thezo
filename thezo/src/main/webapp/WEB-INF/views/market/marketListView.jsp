<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    #searchForm{
        width:40%;
    }
    #searchForm>*{
         float:left;
        margin:5px;
    }
    .select{width:20%;}
    .text{width:53%;}
    .searchBtn{Width:20%;}
    #pagingArea{width:fit-content;margin:auto;}
    .list-area{
        width:760px;
        margin:auto;
    }
    .thumbnail{
        border:1px solid lightgray;
        width:220px;
        display:inline-block;
        margin:14px;
    }
    .thumbnail:hover{
        cursor:pointer;
        opacity:0.7;
    }
    .innerOuter{
        width: 1000px;
        margin:auto;
        padding:5% 5%;
        background:white;
    }

</style>
</head>
<body>
	
	<!--  .innerOuter 넣어서 크기 조절하기  -->
	<!-- 찜하기, 판매내역 수정하기 -->
	<jsp:include page="../common/header.jsp"/>
	
	
    <div class="outer">
        <br>
        <h1><b>더조마켓</b></h1>
        <!-- a태그 넣어야하는데...? 어라랏-->
        <br>

        <div id="search-area" align="center">
        	<!-- 여기 부분 수정 (디자인적으로 별로...)   -->
            <a href="">찜하기</a>
            <a href="">판매내역</a>
            <form id="searchForm" action="" method="Get">
                <div class="select">
                    <select class="custom-select" name="condition">
                        <option value="writer">품명</option>
                        <option value="title">작성자</option>
                    </select>
                </div>
                <div class="text">
                    <input type="text" class="form-control" name="keyword">
                </div>
                <button type="submit" class="searchBtn btn btn-secondary">검색</button>
            </form>
        </div>

        <br><br><br>
            
        <div class="list-area">
	            <div class="thumbnail" align="center">
	            	<input type="hidden" value="${ b.boardNo }">
                    <br>
	                <img src="${ b.titleImg }" width="200" height="150">
	                <p>
	                    <b>머그컵</b><br>
                        15000 원<br>
                        판매중<br>
	                </p>
                    <p align="left">
                        &nbsp;user01<br>
                        &nbsp;2021-08-01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <img src="https://image.flaticon.com/icons/png/128/709/709612.png alt="">
                        5&nbsp;&nbsp;
                    </p>
	            </div>
                <div class="thumbnail" align="center">
	            	<input type="hidden" value="${ b.boardNo }">
                    <br>
	                <img src="${ b.titleImg }" width="200" height="150">
	                <p>
	                    <b>머그컵</b><br>
                        15000 원<br>
                        판매중<br>
	                </p>
                    <p align="left">
                        user01<br>
                        2021-08-01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        조회수 5
                    </p>
	            </div>
                <div class="thumbnail" align="center">
	            	<input type="hidden" value="${ b.boardNo }">
                    <br>
	                <img src="${ b.titleImg }" width="200" height="150">
	                <p>
	                    <b>머그컵</b><br>
                        15000 원<br>
                        판매중<br>
	                </p>
                    <p align="left">
                        user01<br>
                        2021-08-01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        조회수 5
                    </p>
	            </div>
                <br>
                <div class="thumbnail" align="center">
	            	<input type="hidden" value="${ b.boardNo }">
                    <br>
	                <img src="${ b.titleImg }" width="200" height="150">
	                <p>
	                    <b>머그컵</b><br>
                        15000 원<br>
                        판매중<br>
	                </p>
                    <p align="left">
                        user01<br>
                        2021-08-01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        조회수 5
                    </p>
	            </div>
                <div class="thumbnail" align="center">
	            	<input type="hidden" value="${ b.boardNo }">
                    <br>
	                <img src="${ b.titleImg }" width="200" height="150">
	                <p>
	                    <b>머그컵</b><br>
                        15000 원<br>
                        판매중<br>
	                </p>
                    <p align="left">
                        user01<br>
                        2021-08-01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        조회수 5
                    </p>
	            </div>
                <div class="thumbnail" align="center">
	            	<input type="hidden" value="${ b.boardNo }">
                    <br>
	                <img src="${ b.titleImg }" width="200" height="150">
	                <p>
	                    <b>머그컵</b><br>
                        15000 원<br>
                        판매중<br>
	                </p>
                    <p align="left">
                        user01<br>
                        2021-08-01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        조회수 5
                    </p>
	            </div>
        </div>
        
        
        <div  align="center"> 
            <br>
            <a class="btn btn-secondary"  href="marketEnrollForm.bo">글쓰기</a>&nbsp;&nbsp;
        </div>
            <br><br>
            <div id="pagingArea">
                <ul class="pagination">
                    <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">4</a></li>
                    <li class="page-item"><a class="page-link" href="#">5</a></li>
                    <li class="page-item"><a class="page-link" href="#">Next</a></li>
                </ul>
            </div>
           
            <br clear="both"><br>

    </div>
  
	
</body>
</html>