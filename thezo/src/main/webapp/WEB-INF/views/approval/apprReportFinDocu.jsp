<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>The Zo</title>

<style>
    .fa-file-alt{font-size:50pt;}

</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	
   	 <section>
        <div class="outer" align="center">    
            <jsp:include page="apprSidebar.jsp"/>
            <br><br>
            <div class="sideOuter">
                
                <!-- 카테고리 area -->
                <div class="card-deck" style="width:70%">
                    
                    <div class="card category shadow">
                        <div class="card-body text-center">
                            <p class="card-text"><i class="far fa-file-alt"></i></p>
                            <h5 class="card-text">일반</h5>
                        </div>
                    </div>
                    <div class="card category shadow">
                        <div class="card-body text-center">
                            <p class="card-text"><i class="far fa-file-alt"></i></p>
                            <h5 class="card-text">비용</h5>
                        </div>
                    </div>
                    <div class="card category shadow">
                        <div class="card-body text-center">
                            <p class="card-text"><i class="far fa-file-alt"></i></p>
                            <h5 class="card-text">총무</h5>
                        </div>
                    </div>
                    <div class="card category shadow">
                        <div class="card-body text-center">
                            <p class="card-text"><i class="far fa-file-alt"></i></p>
                            <h5 class="card-text">인사</h5>
                        </div>
                    </div>
                </div>
                <br>
                <h6>결재양식을 선택 해 주세요</h6>
                <hr>
                <br>
                <!-- 안읽은 문서 건수 안내 끝 -->
                <!-- 문서리스트 -->
                <div class="d-flex mb-2 newDocu">
                    <div class="p-2 newDocuCate"><b class="text-primary"> 일반</b> <br>일반기안서</div>
                    <div class="p-3 flex-grow-1">별도의 양식이 없는 경우 사용하는 문서입니다 </div>
                    <div class="p-3"><button type="button"  onclick="location.href='enrollForm.appr'" class="btn btn-primary">작성</button></div>
                </div>
                <div class="d-flex mb-2 newDocu">
                    <div class="p-2 newDocuCate"><b class="text-primary"> 일반</b> <br>일반기안서</div>
                    <div class="p-3 flex-grow-1">별도의 양식이 없는 경우 사용하는 문서입니다 </div>
                    <div class="p-3"><button type="button" class="btn btn-primary">작성</button></div>
                </div>
                <div class="d-flex mb-2 newDocu">
                    <div class="p-2 newDocuCate"><b class="text-primary"> 일반</b> <br>일반기안서</div>
                    <div class="p-3 flex-grow-1">별도의 양식이 없는 경우 사용하는 문서입니다 </div>
                    <div class="p-3"><button type="button" class="btn btn-primary">작성</button></div>
                </div>
                <div class="d-flex mb-2 newDocu">
                    <div class="p-2 newDocuCate"><b class="text-primary"> 일반</b> <br>일반기안서</div>
                    <div class="p-3 flex-grow-1">별도의 양식이 없는 경우 사용하는 문서입니다 </div>
                    <div class="p-3"><button type="button" class="btn btn-primary">작성</button></div>
                </div>
                <div class="d-flex mb-2 newDocu">
                    <div class="p-2 newDocuCate"><b class="text-primary"> 일반</b> <br>일반기안서</div>
                    <div class="p-3 flex-grow-1">별도의 양식이 없는 경우 사용하는 문서입니다 </div>
                    <div class="p-3"><button type="button" class="btn btn-primary">작성</button></div>
                </div>
                

                <br><br>
                <ul class="pagination justify-content-center">
                    <li class="page-item"><a class="page-link" href="#">이전</a></li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item active"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">다음</a></li>
                  </ul>
            </div>
    	</div>
    </section>

  
 	
</body>
</html>