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
    #newApprnav{background:rgb(20,70,104)!important; color: white!important;}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	
   	 <section>
        <div class="outer" align="center">    
            <p class="pageTitle">  approval <b> 전자결재</b></p>
            <jsp:include page="apprSidebar.jsp"/>
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
                <form action="main.appr" method="post">
                    <div class="w3-row-padding">
                        <div class="w3-third">&nbsp;</div>
                        <div class="w3-twothird">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">검색분류</span>
                                </div>
                                <select class="form-control" name="category">
                                    <option>전체</option>
                                    <option>일반</option>
                                    <option>비용</option>
                                    <option selected>총무</option>
                                    <option>인사</option>
                                </select>
                                <input type="text" name="docName" class="form-control" placeholder="검색할 제목을 입력하세요" style="width:200px">
                                <div class="input-group-append">
                                    <button type="submit" class="btn btn-primary btn-sm" style="width: 100px">&nbsp;조회&nbsp;</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                
                <!-- 안읽은 문서 건수 안내 끝 -->
                <!-- 문서리스트 -->

                
                 <c:forEach var="a" items="${ list }">
	                  <div class="d-flex mb-4 shadow newDocu">
	                    <div class="p-2 newDocuCate"><b class="text-primary">
                            <c:choose>
                                <c:when test="${a.category eq '인사'}">
                                    <i class="fas fa-user-alt docMenu"></i>
                                </c:when>
                                <c:when test="${a.category eq '비용'}">
                                    <i class="fas fa-coins docMenu"></i>
                                </c:when>
                                <c:when test="${a.category eq '총무'}">
                                    <i class="fas fa-box-open docMenu"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="far fa-file docMenu"></i>
                                </c:otherwise>
                            </c:choose>
                           
                             ${ a.category }</b> <br>${ a.formName }</div>
	                    <div class="p-4 flex-grow-1">${ a.formInfo } </div>
	                    <div class="p-4"><button type="button"  onclick="location.href='enrollForm.appr?ano=${ a.formNo }'" class="btn btn-primary">작성</button></div>
	                 </div>
                 </c:forEach>
            

                <br><br>
               <!--페이징 처리 시작-->
                 <div id="pagingArea">
					<ul class="pagination">
                        <c:if test="${ pi.currentPage ne 1 }">
                            <li class="page-item"><a class="page-link" href="approvalNew?currentPage=${ pi.currentPage-1 }">이전</a></li>
                        </c:if>
                        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
							<c:choose>
								<c:when test="${ pi.currentPage eq p }">
									<li class="page-item">
                                        <a class="page-link" style="background-color: lightsteelblue" href="approvalNew?currentPage=${ p }">${ p }</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item">
                                        <a class="page-link"  href="approvalNew?currentPage=${ p }">${ p }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${ pi.currentPage ne pi.maxPage and pi.maxPage ne '0'}">
                            <li class="page-item">
                                <a class="page-link" href="approvalNew?currentPage=${ pi.currentPage+1 }">다음</a>
                            </li>
                        </c:if>
					</ul>
           		 </div>
				<!--페이징 처리 끝-->
            </div>
    	</div>
    </section>

  
 	
</body>
</html>