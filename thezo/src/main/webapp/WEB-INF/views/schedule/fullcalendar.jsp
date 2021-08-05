<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
    <!-- 풀캘린더  -->
	<link href='${pageContext.request.contextPath}/resources/fullcalendar-5.8.0/lib/main.css' rel='stylesheet' />
	<script src='${pageContext.request.contextPath}/resources/fullcalendar-5.8.0/lib/main.js'></script>
	<!-- 한국어설정 -->
	<script src='${pageContext.request.contextPath}/resources/fullcalendar-5.8.0/lib/locales/ko.js'></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    
	    var calendar = new FullCalendar.Calendar(calendarEl, {
    	
	    	dateClick: function(date) { 
	    		// 날짜셀 클릭했을 시 이벤트 설정하면됨! 
	    		// => 일정추가 모달창 뜨게 설정
	    		//console.log(date.dateStr);
	    		$('#startDate').val(date.dateStr);
	    		$('#endDate').val(date.dateStr);
	    		$('#insertSc').modal();
	    	},
	    	
	      	headerToolbar: { // 헤더설정
				left: 'prevYear,prev,next,nextYear today',
				center: 'title',
				right: 'dayGridMonth,dayGridWeek,dayGridDay'
	        },
	        navLinks: true, // can click day/week names to navigate views
	       	editable: true, // 편집가능
	        dayMaxEvents: true, // allow "more" link when too many events
	        locale: 'ko', // 한국어 설정
	        themeSystem: 'bootstrap', // 테마 설정
	        eventSources:[
	        	{
        		 events: [ // ajax로 일정 불러오기
     	        	// 1. 개인 일정
     				$.ajax({
     					url :'list.sc',
     					data : {scType: "개인"},
     					cache: false,
     					success:function(list){
     						var scList = Object.values(JSON.parse(list));
     						for(var i=0; i<scList.length; i++){
     							calendar.addEvent(scList[i]); // DB에 있는 이벤트 캘린더에 추가
     						}
     					},error: function(){
     						console.log("일정 조회용 ajax 통신 실패");
     					}
     				})
				],
     	        events: [
     	        	// 2. 회사 일정
     	        	$.ajax({
     	        		url :'list.sc',
	     				data : {scType: "회사"},
	     				cache: false,
	     				success:function(list){
	     					var scList = Object.values(JSON.parse(list));
	     					for(var i=0; i<scList.length; i++){
	     						scList[i].color = '#378006';
	     						calendar.addEvent(scList[i]); // DB에 있는 이벤트 캘린더에 추가
	     					}
	     				},error: function(){
	     					console.log("일정 조회용 ajax 통신 실패");
	     				},
     	        	})
     	        ], 
     	        events: [
     	        	// 3. 부서 일정
     	        	$.ajax({
     	        		url :'list.sc',
	     				data : {scType: "부서"},
	     				cache: false,
	     				success:function(list){
	     					var scList = Object.values(JSON.parse(list));
	     					for(var i=0; i<scList.length; i++){
	     						scList[i].color = '#7B68EE';
	     						calendar.addEvent(scList[i]); // DB에 있는 이벤트 캘린더에 추가
	     					}
	     				},error: function(){
	     					console.log("일정 조회용 ajax 통신 실패");
	     				}
     	        	})
     	        ], color: '#378006'
	        }],
	        
	        eventClick: function(info) {
	        	// 이벤트 클릭했을 시 기능 설정
	        	// 일정 내용과 보고서가 보여져야 함!!
	        	var scNo = info.event._def.extendedProps.scNo;
	        	var option = "width = 680, height = 530, top = 100, left = 200, location = no";
				window.open("detail.sc?scNo=" + scNo, "일정상세정보", option);
	        }
		});
	    calendar.render();
	});
		
</script>

<style>
	#calendar{
    	width: 100%;
    	padding: 20px;
    }
	.fc-event{
	    cursor: pointer;
		
	}
	.fc-event:hover{
		opacity: 0.7;
	}
</style>
</head>
<body>
	<div id="calendar"></div>
	<!-- 일정추가 모달창 -->
	<jsp:include page="scheduleInsertView.jsp"/>
</body>
</html>