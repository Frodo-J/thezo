<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<style>
    .outer-wrap{height: 200px;}
    .sub-menu{float: left; width: 30%; height: 100%;}
    #sub-name{
        width: 80%;
        text-align: left;
        margin-top: 10%;
        margin-left: 10%;
        float: left;
        font-weight: bold;
        font-size: 30px;  
    }
    .content{height: 800px;}
    #company-table input{width: 300px;}
    #company-table input[type="date"]{height: 40px;}
    #sub-title{margin-top: 30px; margin-bottom: 10px;}
    #company-table{margin-top: 10px; width: 95%;}
    #company-table textarea{
        width: 390px;
        height: 32px;
        resize: none;
        padding-left: 10px;
    }
    #company-table a{color: gray;}
    #company-table th{height: 50px !important;} 
    #company-btn{
        float: right; width: 100px;
        margin-right: 100px;
    }
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	<script>
		$(function(){
			var adminNav = document.getElementById("admin-header");
			$("section").css("margin-top", (adminNav.style.display != 'none'?"115px":"70px"));
		})
		document.getElementById("admin-header").style.display ="block"; 
        document.getElementById("admin-mode").style.color = "red";
	</script>
    <section>
		<div class="outer" align="center">
            <div class="outer-wrap">
                <div class="sub-menu">
                    <div id="sub-name"><i class="bi bi-building"></i> ??????????????????</div>
                </div>
            </div>
            <div class="content">
                <form action="insert.co" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="companyNo" value="1">
                    <table id="company-table">
                        <tr>
                            <th colspan="4"><h5 style="margin-bottom: 10px;"><i class="fas fa-caret-square-right"></i> ????????????</h5></th>
                        </tr>
                        <tr>
                            <th width="200">?????????</th>
                            <td width="400"><input type="text" name="companyName" class="form-control" placeholder="???????????? ??????????????????" value="${ cInfo.companyName }" required></td>
                            <th width="200">????????????</th>
                            <td><input type="text" name="ceoName" class="form-control" placeholder="??????????????? ??????????????????" value="${ cInfo.ceoName }" required></td>
                        </tr>
                        <tr>
                            <th>?????????????????????</th>
                            <td><input type="text" name="regNo" class="form-control" placeholder="???????????????????????? ??????????????????" value="${ cInfo.regNo }" required></td>
                            <th>?????????</th>
                            <td><input type="text" name="email" class="form-control" placeholder="???????????? ??????????????????" value="${ cInfo.email }" required></td>
                        </tr>
                        <tr>
                            <th>??????</th>
                            <td><input type="text" name="bussStatus" class="form-control" placeholder="????????? ??????????????????" value="${ cInfo.bussStatus }" required></td>
                            <th>??????</th>
                            <td><input type="text" name="bussKind" class="form-control" placeholder="????????? ??????????????????" value="${ cInfo.bussKind }" required></td>
                        </tr>
                        <tr>
                            <th colspan="4"><h5 id="sub-title"><i class="far fa-caret-square-right"></i> ????????????</h5></th>
                        </tr>
                        <tr>
                            <th>????????????</th>
                            <td><input type="text" name="phone" class="form-control" placeholder="????????? ??????????????????" value="${ cInfo.phone }"></td>
                            <th>????????????</th>
                            <td><input type="url" name="homePage" class="form-control" placeholder="??????????????? ??????????????????" value="${ cInfo.homePage }"></td>
                        </tr>
                        <tr>
                            <th>??????????????????</th>
                            <td><input type="text" name="corNo" class="form-control" placeholder="????????????????????? ??????????????????"  value="${ cInfo.corNo }"></td>
                            <th>??????</th>
                            <td><input type="text" name="fax" class="form-control" placeholder="????????? ??????????????????" value="${ cInfo.fax }"></td>
                        </tr>
                        <tr>
                            <th>????????????</th>
                            <td><input type="date" name="estDate" value="${ cInfo.estDate }"></td>
                        </tr>
                        <tr>
                            <th>??????</th>
                            <td><input type="text" name="address" class="form-control" placeholder="????????? ??????????????????" value="${ cInfo.address }"></td>
                            <th>????????????(??????)</th>
                            <td><input type="text" name="ceoEng" class="form-control" placeholder="????????????(??????)??? ??????????????????" value="${ cInfo.ceoEng }"></td>
                        </tr>
                        <tr>
                            <th>?????????(??????)</th>
                            <td><input type="text" name="cnameEng" class="form-control" placeholder="?????????(??????)??? ??????????????????" value="${ cInfo.cnameEng }"></td>
                        </tr>
                        <tr>
                            <th>??????(??????)</th>
                            <td colspan="2"><input type="text" name="addressEng" class="form-control" placeholder="??????(??????)??? ?????????????????? " value="${ cInfo.addressEng }"></td>
                        </tr>
                        <tr>
                            <th>????????????</th>
                            <td>            
                                <div class="input-group mb-3" style="margin-bottom: 0% !important;">
                                    <input type="file" name="upImg" onchange="loadImg(this);" class="form-control" id="inputGroupFile02">
                                    <label class="input-group-text" for="inputGroupFile02">Upload</label>
                                    <img src="${ cInfo.changeName }" id="companyImg" width="60px" height="100px" style="margin-top:10px">
                                    <script>
				                    	$(function(){
				                    		$("#companyImg").click(function(){
				                    			$("#inputGroupFile02").click();
				                    		})
				                    	})
				                    	
				                    	function loadImg(inputFile){
				                    		if(inputFile.files.length == 1){
				                    			var reader = new FileReader();
				                    			
				                    			reader.readAsDataURL(inputFile.files[0]);
				                    			
				                    			reader.onload = function(e){
				                    				 $("#companyImg").attr("src", e.target.result);
				                    				}
				                    			}else{
				                    				$("#companyImg").attr("src", null);
				                    			}
				                    		}
                    				</script>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <button type="submit" id="company-btn" class="btn btn-dark">??????</button>
                    
                </form>
            </div>
        </div>
    </section>
</body>
</html>