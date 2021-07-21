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
            <p class="pageTitle">  관리자모드 <b> 전자결재</b></p>
            <jsp:include page="apprAdminSidebar.jsp"/>
            <div class="sideOuter">
                <!-- 검색 area -->
                <form action="" method="post">
                    <div class="input-group mb-3" style="width:50%">                        
                            <select class="form-control" id="sel1">
                              <option>전체</option>
                              <option>일반</option>
                              <option>비용</option>
                              <option>인사</option>
                            </select>
                        <input type="text" class="form-control" placeholder="검색어를 입력하세요" style="height:36px;">
                        <div class="input-group-append">
                            <button type="submit" id="" class="btn btn-primary btn-sm">&nbsp;조회&nbsp;</button>
                        </div>
                        
                    </div>
                 </form>
                
                <br>
                <!-- 안읽은 문서 건수 안내 끝 -->
                <!-- 문서리스트 -->
                <div class="d-flex mb-2 newDocu">
                    <div class="p-2 newDocuCate"><b class="text-primary"> 일반</b> <br>일반기안서</div>
                    <div class="p-3 flex-grow-1">별도의 양식이 없는 경우 사용하는 문서입니다 </div>
                    <div class="pr-3" align="center">
                        <h5><span class="badge badge-pill badge-warning">사용중</span></h5>
                        <button type="button"  onclick="location.href='enrollForm.appr'" class="btn btn-sm btn-secondary">수정</button>
                        <button type="button"  onclick="location.href='enrollForm.appr'" class="btn btn-sm btn-secondary">삭제</button>
                    </div>
                </div>
                <div class="d-flex mb-2 newDocu">
                    <div class="p-2 newDocuCate"><b class="text-primary"> 일반</b> <br>일반기안서</div>
                    <div class="p-3 flex-grow-1">별도의 양식이 없는 경우 사용하는 문서입니다 </div>
                    <div class="pr-3" align="center">
                        <h5><span class="badge badge-pill badge-warning">사용중</span></h5>
                        <button type="button"  onclick="location.href='enrollForm.appr'" class="btn btn-sm btn-secondary">수정</button>
                        <button type="button"  onclick="location.href='enrollForm.appr'" class="btn btn-sm btn-secondary">삭제</button>
                    </div>
                </div>
                <div class="d-flex mb-2 newDocu">
                    <div class="p-2 newDocuCate"><b class="text-primary"> 일반</b> <br>일반기안서</div>
                    <div class="p-3 flex-grow-1">별도의 양식이 없는 경우 사용하는 문서입니다 </div>
                    <div class="pr-3" align="center">
                        <h5><span class="badge badge-pill badge-warning">사용중</span></h5>
                        <button type="button"  onclick="location.href='enrollForm.appr'" class="btn btn-sm btn-secondary">수정</button>
                        <button type="button"  onclick="location.href='enrollForm.appr'" class="btn btn-sm btn-secondary">삭제</button>
                    </div>
                </div>
                <div class="d-flex mb-2 newDocu">
                    <div class="p-2 newDocuCate"><b class="text-primary"> 일반</b> <br>일반기안서</div>
                    <div class="p-3 flex-grow-1">별도의 양식이 없는 경우 사용하는 문서입니다 </div>
                    <div class="pr-3" align="center">
                        <h5><span class="badge badge-pill badge-warning">사용중</span></h5>
                        <button type="button"  onclick="location.href='enrollForm.appr'" class="btn btn-sm btn-secondary">수정</button>
                        <button type="button"  onclick="location.href='enrollForm.appr'" class="btn btn-sm btn-secondary">삭제</button>
                    </div>
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