<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!-- @Author Jaewon.s -->   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="author" content="Jaewon.s">
<title>Insert title here</title>
<style>
    #message-outer{width: 300px; height: 470px; padding: 5px 0px; margin: auto; background-color: white;}
    #message-navarea{width: 100%; height: 36px; display: flex; justify-content: space-around;}
    #message-navarea>div{width: 31%; height: 100%; color: rgb(51,51,51); font-size: 15px; font-weight: bold; font-family:'Noto Sans KR', sans-serif; text-align: center; line-height: 36px; border-radius: 2px; background-color: rgb(224,224,224);}
    #message-navarea>div:hover{color: rgb(20,70,104); cursor: pointer; transform: scale(1.03); background-color: lightblue;}
    #receive-message-page, #sent-message-page, #recycle-bin-page{width: 100%; height:424px; padding: 0px 4px 0px 4px; overflow-y: scroll; position: relative;}
    #receive-message-page::-webkit-scrollbar, #sent-message-page::-webkit-scrollbar, #recycle-bin-page::-webkit-scrollbar {width: 10px; display: block;}
    #receive-message-page::-webkit-scrollbar-thumb, #sent-message-page::-webkit-scrollbar-thumb, #recycle-bin-page::-webkit-scrollbar-thumb {border: 2px solid transparent; border-radius: 5px; background-clip: padding-box; background-color: rgb(41,128,185);}
    #receive-message-page::-webkit-scrollbar-track, #sent-message-page::-webkit-scrollbar-track, #recycle-bin-page::-webkit-scrollbar-track {border-radius: 5px; box-shadow: inset 0px 0px 5px white; background-color: rgb(215, 238, 247);}
</style>
</head>
<body>
    <div id="message-outer">
        <div id="message-navarea">
            <div class="receive-message" onclick="moveToReceive();">
                받은쪽지함
            </div>
            <div class="sent-message" onclick="moveToSent();">
                보낸쪽지함
            </div>
            <div class="recycle-bin" onclick="moveToRecycleBin()">
                휴지통
            </div>            
        </div>  

        <!-- 보여질 영역 -->
        <div id="receive-message-page" class="w3-animate-opacity">
            <jsp:include page="../message/userReceiveMessage.jsp"/>
        </div>
        <div id="sent-message-page" class="w3-animate-opacity" style="display: none;">
            <jsp:include page="../message/userSentMessage.jsp"/>
        </div>
        <div id="recycle-bin-page" class="w3-animate-opacity" style="display: none;">
            <jsp:include page="../message/userMSGRecycleBin.jsp"/>
        </div>
    </div>
	
    <!-- 각각의 스크립트에서 ! 일단 값을 뽑아서 !!! 값들 뿌려주고 호출이다!  -->
    <script>
        function moveToReceive(){
           	var restrictDate = new Date("${loginUser.msgRestrict}");
           	var now = new Date();           	
        	if(${loginUser.msgRestrict != null} && now.getTime() < restrictDate.getTime()){ // 신고처리를 당하고 현재 날짜가 쪽지기능제한 시간 범위안에 있을때      		
            	showRcMsg();                        
                $("#receive-message-page").show();
                $("#sent-message-page").hide();
                $("#recycle-bin-page").hide();
                $(".receive-message").css("color","rgb(41,128,185)").css("background","rgb(250,215,160)");
                $(".sent-message").css("color","rgb(51,51,51)").css("background","rgb(224,224,224)");
                $(".recycle-bin").css("color","rgb(51,51,51)").css("background","rgb(224,224,224)");            
				$(".receive-del").prop("disabled", true);
				$(".receive-del").css("background","darkgray");
				$(".receive-report").prop("disabled", true);
				$(".receive-report").css("background","darkgray");
				$(".sendign-MSG").prop("disabled", true);
				$(".sendign-MSG").css("background","darkgray");
				$("#reply-btn").prop("disabled", true);
				$("#reply-btn").css("background","darkgray");
        	}else{// 신고 당하지 않았거나 현재 날짜가 쪽지기능제한 시간을 넘겼을때 
            	showRcMsg();                        
                $("#receive-message-page").show();
                $("#sent-message-page").hide();
                $("#recycle-bin-page").hide();
                $(".receive-message").css("color","rgb(41,128,185)").css("background","rgb(250,215,160)");
                $(".sent-message").css("color","rgb(51,51,51)").css("background","rgb(224,224,224)");
                $(".recycle-bin").css("color","rgb(51,51,51)").css("background","rgb(224,224,224)");                    	
				$(".receive-del").prop("disabled", false);
				$(".receive-del").css("background","rgb(236,112,99)");
				$(".receive-report").prop("disabled", false);
				$(".receive-report").css("background","rgb(188,144,206)");
				$(".sendign-MSG").prop("disabled", false);
				$(".sendign-MSG").css("background","rgb(95,160,203)");
				$("#reply-btn").prop("disabled", false);
				$("#reply-btn").css("background","rgb(52,152,219)");
        	}
        }

        function moveToSent(){ // 신고처리를 당하고 현재 날짜가 쪽지기능제한 시간 범위안에 있을때
           	var restrictDate = new Date("${loginUser.msgRestrict}");
           	var now = new Date();
        	if(${loginUser.msgRestrict != null} && now.getTime() < restrictDate.getTime() ){        		
            	var gap = parseInt((restrictDate.getTime() - now.getTime())/1000/60);
            	var restrictTimeText = "쪽지기능제한 해제까지 " + (parseInt(gap/60/24) + "일 ") + (parseInt(gap/60%24) + "시간 ") + ((gap%60) + "분 남았습니다.")
            	alert("${loginUser.memName}" + "님은 쪽지 신고조치로 인하여\n" 
            			+ "오직 받은쪽지만 확인 가능합니다.\n" + restrictTimeText);
        	}else{// 신고 당하지 않았거나 현재 날짜가 쪽지기능제한 시간을 넘겼을때 
	        	showStMsg();
	            $("#receive-message-page").hide();
	            $("#sent-message-page").show();
	            $("#recycle-bin-page").hide();
	            $(".sent-message").css("color","rgb(41,128,185)").css("background","rgb(250,215,160)");
	            $(".receive-message").css("color","rgb(51,51,51)").css("background","rgb(224,224,224)");
	            $(".recycle-bin").css("color","rgb(51,51,51)").css("background","rgb(224,224,224)");            
        	};
        }

        function moveToRecycleBin(){// 신고처리를 당하고 현재 날짜가 쪽지기능제한 시간 범위안에 있을때
           	var restrictDate = new Date("${loginUser.msgRestrict}");
           	var now = new Date();
        	if(${loginUser.msgRestrict != null} && now.getTime() < restrictDate.getTime()){
            	var gap = parseInt((restrictDate.getTime() - now.getTime())/1000/60);
            	var restrictTimeText = "쪽지기능제한 해제까지 " + (parseInt(gap/60/24) + "일 ") + (parseInt(gap/60%24) + "시간 ") + ((gap%60) + "분 남았습니다.")
            	alert("${loginUser.memName}" + "님은 쪽지 신고조치로 인하여\n" 
            			+ "오직 받은쪽지만 확인 가능합니다.\n" + restrictTimeText);
        	}else{// 신고 당하지 않았거나 현재 날짜가 쪽지기능제한 시간을 넘겼을때 
    			showRcRecycleBin();
    			showStRecycleBin();
                reloadReportList();
                movebackToRecycleBin();
                $("#receive-message-page").hide();
                $("#sent-message-page").hide();
                $("#recycle-bin-page").show();
                $(".recycle-bin").css("color","rgb(41,128,185)").css("background","rgb(250,215,160)");
                $(".receive-message").css("color","rgb(51,51,51)").css("background","rgb(224,224,224)");
                $(".sent-message").css("color","rgb(51,51,51)").css("background","rgb(224,224,224)");  
        	};
        }

        // 쪽지 상세 보기 쪽인데 !!! 여기서 ajax로 값 뿌려주면서 만들어줘야한다
        function openDetailMSG(msgNo,checkMsgType){
            if(checkMsgType == 'r'){//받은 쪽지 (보낸 사람, 받은 시간을 표기)
            	//console.log("받은 쪽지 함수열림");
            	ajaxCommonDetailMsg();
            	$("#receiverType").hide();
                $("#sendTime").hide();
                $("#reply-btn").show();
                $("#senderType").show();
                $("#receiveTime").show();
                $("#messageDetail").modal();

            }else if(checkMsgType =='s'){//보낸 쪽지 (받는사람, 보낸시간을 표기)    
            	//console.log("보낸 쪽지 함수열림");
            	ajaxCommonDetailMsg();
                $("#reply-btn").hide();
                $("#senderType").hide();
                $("#receiveTime").hide();
                $("#receiverType").show();
                $("#sendTime").show();
                $("#messageDetail").modal();

            }else if(checkMsgType =='srb'){// 휴지통에 있는 보낸 쪽지 ( 받는사람, 보낸시간을 표기)
            	//console.log("휴지통 보낸 쪽지 함수열림");
            	ajaxCommonDetailMsg();
                $("#reply-btn").hide();
                $("#senderType").hide();
                $("#receiveTime").hide();
                $("#receiverType").show();
                $("#sendTime").show();
                $("#messageDetail").modal();
            
            }else{// 휴지통에 있는 받은 쪽지 (보낸 사람, 받은 시간을 표기)  checkMsgType이 rrb로 넘어온다.
            	//console.log("휴지통 받은 쪽지 함수열림");
            	ajaxCommonDetailMsg();
            	$("#receiverType").hide();
                $("#sendTime").hide();
                $("#reply-btn").hide();
                $("#senderType").show();
                $("#receiveTime").show();
                $("#messageDetail").modal();
            }
            
            function ajaxCommonDetailMsg(){
    		 	$.ajax({
    		 		url: "Detail.msg",
    		 		data:{msgNo: msgNo
    		 			, memNo: "${sessionScope.loginUser.memNo}"
    		 			, msgType :checkMsgType 
    		 		},
    		 		success:function(msgDetail){
    		 			//console.log(msgDetail);
    		 			$("#toFromPerson").html(msgDetail.recipientNameAndRank);
    		 			$("#detailMsgStatus").html(msgDetail.msgStatus);
    		 			$("#msgDetailTime").html(msgDetail.createDate);
    		 			$("#detailMsgContentMsg").html(msgDetail.contentStatus);
    		 			$(".detail-modal-content pre").html(msgDetail.msgContent);
    					showRcMsg();
    					ajaxBringUnreadedMsgCount();
    					$("#reply-btn").attr("onclick", "openReplyAndSendMsg(" + msgNo + ");");

    		 		},error:function(){
    		 			console.log("ajax통신 실패");
    		 		}    		 		
    		 	})
            }
        }
    </script>  

</body>
</html>