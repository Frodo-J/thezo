<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 추가</title>
</head>
<body>
	<form action="insert.sc" method="post">
		<!-- The Modal -->
		<input type="hidden" name="scWriter" value="${ loginUser.memNo }"> <!-- 현재 로그인한 유저 아이디 전달 -->
		<div class="modal" id="insertSc">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">일정 추가</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
			    <table align="center">
			        <tr>
			            <th width="120px">일정 제목</th>
			            <td colspan="2">
			            	<input type="text" name="title" style="width: 350px;" placeholder="일정 제목을 입력해주세요">
			            	<select name="scType" id="scType">
			                    <option value="개인">개인</option>
			                    <option value="부서">부서</option>
			                    <option value="회사">회사</option>
			                </select>
			            </td>
			            <td>
			                
			            </td>
			        </tr>
			        
			        <tr>
			            <th>시작일</th>
			            <td width="350px">
			            	<input type="date" name="start" id="startDate"> 
			            	<input type="time" name="start" id="startTime" hidden>
			            </td>
			            <td rowspan="2">
							<input type="checkbox" id="timeCheck">
							<input type="hidden" id="allDay" name="allday">
							<label for="timeCheck">시간설정</label>
						</td>
			            <!-- 시간설정 체크 해제시 시간 input 사라지게 / 기본값: 체크설정-->
			        </tr>
			        
			        <tr>
			            <th>종료일</th>
			            <td>
				            <input type="date" name="end" id="endDate"> 
				            <input type="time" name="end" id="endTime" hidden>
			            </td>
			        </tr>
			        <tr>
			            <th>내용</th>
			            <td colspan="2">
			            	<textarea name="scContent" cols="45" rows="10" style="resize: none;" placeholder="내용을 입력해주세요" required></textarea>
			            </td>
			        </tr>
			
			    </table>
			    
		      </div>
				<script>
			        	// 시간설정 -> 기본을 체크로 두고, 체크해제시 시간설정 input을 hidden처리하고 입력받지않는다.
			        	// 시간 input의 value값을 지우는 설정도 해야될듯 안그러면 값입력하고 hidden 처리시 값이 넘어오니까
			        	// => 체크해제시 하루종일 'Y'로 되게
					$(function(){
						$("#timeCheck").change(function(){
							if($(this).is(":checked")){ // 시간설정 체크시 => 하루종일 일정이 아님
								$("input[type=time]").removeAttr("hidden");
								$("input[type=time]").attr("required", true);
								$("#allday").val('N');
							}else{
								$("input[type=time]").attr("hidden", true);
								$("input[type=time]").removeAttr("required");
								$("input[type=time]").val("");
								$("#allday").val('Y');
							}
						})
					})
		        </script>
		      <!-- Modal footer -->
		      <div class="modal-footer center">
			      <div class="button-area" align="right">
				        <button class="btn btn-secondary" data-dismiss="modal">취소</button>
				        <button class="btn btn-primary" type="submit">저장</button>
				  </div>
		      </div>
		
		    </div>
		  </div>
		</div>
	</form>
</body>
</html>