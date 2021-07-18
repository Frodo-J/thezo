<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href='${pageContext.request.contextPath}/resources/fullcalendar-5.8.0/lib/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/resources/fullcalendar-5.8.0/lib/main.js'></script>
<script>

  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    
    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
          left: 'prevYear,prev,next,nextYear today',
          center: 'title',
          right: 'dayGridMonth,dayGridWeek,dayGridDay'
        },
        initialDate: '2021-07-13',
        navLinks: true, // can click day/week names to navigate views
        editable: true,
        dayMaxEvents: true, // allow "more" link when too many events
        lang: 'ko', // 한국어 설정
        themeSystem: 'bootstrap',
        events: [
          {
            title: 'All Day Event',
            start: '2021-07-01'
          },
          {
            title: 'Long Event',
            start: '2021-07-07',
            end: '2021-07-10'
          },
          {
            groupId: 999,
            title: 'Repeating Event',
            start: '2021-07-11T16:00:00'
          },
          {
            groupId: 999,
            title: 'Repeating Event',
            start: '2021-07-16T16:00:00'
          },
          {
            title: 'Conference',
            start: '2021-07-11',
            end: '2021-07-13'
          },
          {
            title: 'Meeting',
            start: '2021-07-12T10:30:00',
            end: '2021-07-12T12:30:00'
          },
          {
            title: 'Lunch',
            start: '2021-07-12T12:00:00'
          },
          {
            title: 'Meeting',
            start: '2021-07-12T14:30:00'
          },
          {
            title: 'Happy Hour',
            start: '2021-07-12T17:30:00'
          },
          {
            title: 'Dinner',
            start: '2021-07-12T20:00:00'
          },
          {
            title: 'Birthday Party',
            start: '2021-07-13T07:00:00'
          },
          {
            title: 'Click for Google',
            url: 'http://google.com/',
            start: '2021-07-28'
          }
        ]
      });
    
    calendar.render();
  });

</script>
<style>
	#calendar{
    	width: 70%;
    	margin-right:75px;
    	float:right;
    }
</style>
</head>
<body>
	<br>
	<div id="calendar" align="center"></div>
</body>
</html>