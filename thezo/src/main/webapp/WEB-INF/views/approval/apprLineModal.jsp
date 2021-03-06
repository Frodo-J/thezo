<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8">
      <title>The Zo</title>
      <style>
        .note-modal-content,
        .note-modal-content:before,
        .note-modal-content:after {
          box-sizing: unset !important;
        }

        .note-modal-footer,
        .note-modal-footer:before,
        .note-modal-footer:after {
          box-sizing: unset !important;
        }

        .input-group-text {
          width: 80px
        }

        ul,
        #apprOrgTree {
          list-style-type: none;
        }

        #apprOrgTree {
          margin: 0;
          padding: 0;
          line-height: 2em;
        }

        .box {
          cursor: pointer;
          -webkit-user-select: none;
          /* Safari 3.1+ */
          -moz-user-select: none;
          /* Firefox 2+ */
          -ms-user-select: none;
          /* IE 10+ */
          user-select: none;
        }

        .box::before {
          content: "\25B6";
          color: rgb(121, 121, 121);
          display: inline-block;
          margin-right: 6px;
        }

        .line::before {
          content: "\268A";
          color: lightgray;
          display: inline-block;
          margin-right: 6px;
        }

        .check-box::before {
          -ms-transform: rotate(90deg);
          /* IE 9 */
          -webkit-transform: rotate(90deg);
          /* Safari */
          transform: rotate(90deg);
        }

        .nested {
          display: none;
        }

        .active {
          display: block;
        }

       

        label {
          margin-bottom: 0rem !important;
        }

        .eachPerson:hover {
          cursor: pointer !important;
          background-color: lightgray;
        }

        .eachPerson label:hover {
          cursor: pointer !important;
        }

        #currentLine tr:hover {
          cursor: pointer;
          background-color: lightgray;
        }
      </style>
    </head>

    <body>

      <!-- ????????? ?????? ?????? -->
      <div class="modal" id="apprLineModal">
        <div class="modal-dialog modal-xl">
          <div class="modal-content">

            <div class="modal-header">
              <h4 class="modal-title">????????? ??????</h4>
              <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!--?????? ??? area?????? -->
            <div class="modal-body row pl-3 justify-content-center">
              <div class="input-group mb-3">
                <input type="text" class="form-control" id="myInput" placeholder="???????????? ???????????????">
              </div>
              <div>
                <h5>?????????</h5>
                <div class="p-3" style="border:1px solid lightgrey; width:400px; min-height: 500px;">

                  <ul id="apprOrgTree">
                    <li class="eachPerson" id="ceoCheck"></li>
                    <ul>
                      <li class="departmentLevel">
                        <span class="box">??????????????????</span>
                        <ul class="nested">
                          <li>
                            <span class="box">?????????</span>
                            <ul class="nested">
                              <li></li>
                            </ul>
                          </li>
                          <li>
                            <span class="box">?????????</span>
                            <ul class="nested">
                              <li></li>
                            </ul>
                          </li>
                          <li>
                            <span class="box">?????????</span>
                            <ul class="nested">
                              <li></li>
                            </ul>
                          </li>
                        </ul>
                      </li>
                      <li class="departmentLevel">
                        <span class="box">????????????</span>
                        <ul class="nested">
                          <li>
                            <span class="box">??????1???</span>
                            <ul class="nested">
                              <li></li>
                            </ul>
                          </li>
                          <li>
                            <span class="box">??????2???</span>
                            <ul class="nested">
                              <li></li>
                            </ul>
                          </li>
                          <li>
                            <span class="box">????????????</span>
                            <ul class="nested">
                              <li></li>
                            </ul>
                          </li>
                        </ul>
                      </li>
                      <li class="departmentLevel">
                        <span class="box">????????????</span>
                        <ul class="nested">
                          <li>
                            <span class="box">?????????</span>
                            <ul class="nested">
                              <li></li>
                            </ul>
                          </li>
                          <li>
                            <span class="box">?????????</span>
                            <ul class="nested">
                              <li></li>
                            </ul>
                          </li>
                          <li>
                            <span class="box">?????????</span>
                            <ul class="nested">
                              <li></li>
                            </ul>
                          </li>
                        </ul>
                      </li>
                    </ul>
                  </ul>
                </div>
              </div>
              <div class="p-2 align-self-center">
                <button type="button" class="btn btn-sm btn-outline-secondary" id="addAppr">??????</button><br>
                <button type="button" class="btn btn-sm mt-2 btn-outline-secondary" id="deleteAppr">??????</button>
              </div>
              <div>
                <h5>???????????? <b class="text-primary" id="countApprPpl">0</b>???</h5>
                <div class="p-3" style="width:600px;">

                  <table class="table text-center">
                    <thead>
                      <tr>
                        <th style="width:40%">?????????</th>
                        <th>??????</th>
                        <th>??????/??????</th>
                        <th>??????</th>
                      </tr>
                    </thead>
                    <tbody id="currentLine">

                    </tbody>
                  </table>
                </div>
              </div>
            </div>
            <!--?????? ??? area ??? -->
            <div class="modal-footer">
              <button type="button" class="btn btn-primary" id="enrollApprLineBtn">??????</button>
              <button type="button" class="btn btn-secondary" data-dismiss="modal" id="claseApprLineModal">??????</button>
            </div>

          </div>
        </div>
      </div>
      <!-- ????????? ?????? ??? -->


      <script>
        // ?????? ???????????? ????????? ?????? ?????? ??????
        var toggler = document.getElementsByClassName("box");
        var i;
        for (i = 0; i < toggler.length; i++) {
          toggler[i].addEventListener("click", function () {
            this.parentElement.querySelector(".nested").classList.toggle("active");
            this.classList.toggle("check-box");
          });
        }

        // ????????? ??????
        $(document).ready(function () {
            $("#myInput").on("keyup", function () {
              console.log($("#myInput").val().length == 0);
              if ($("#myInput").val().length == 0) {
                $(".nested").removeClass("active");
                $(".box").removeClass("check-box");
              } else {
                $(".nested").addClass("active");
                $(".box").addClass("check-box");
                var value = $(this).val().toLowerCase();
                $(".eachPerson").filter(function () {
                  $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
              }
            });
          });


        // ???????????? ??? ?????? ?????????
        $(function () {
            $("#apprOrgTree").find(".box").each(function (index, el) {
              <c:forEach var="p" items="${ empList }" varStatus="status">
                if("????????????"=="${p.department}"){
                  var ceoInfo="<label><input type='checkbox' style='display:none' value='${p.memNo}' class='apprLineCheck' /> ${p.memName} ????????????</label>";
                  $("#ceoCheck").html(ceoInfo);
                }
                if($(this).text()=="${p.department}"){                  
                  if($(this).text().includes("??????")){
                    var temp=$(this).next();
                    $("<li class='eachPerson'><label><input type='checkbox' class='apprLineCheck' value='${p.memNo}' style='display:none' /> ${p.memName} ${p.rank} <c:if test='${!empty p.job }'>(${p.job})</c:if> </label></li>").prependTo(temp);
                  } else {
                    var temp=$(this).parent().find("ul");
                      $("<li class='eachPerson'><label><input type='checkbox' class='apprLineCheck' value='${p.memNo}' style='display:none' /> ${p.memName} ${p.rank} <c:if test='${!empty p.job }'>(${p.job})</c:if> </label></li>").appendTo(temp);
                  }                    
                }
              </c:forEach>
            })
        })


        // ???????????? ????????? ????????? ?????????????????? ?????? ???
        $("#addAppr").click(function () {
          
          if ($("#ceoCheck").find(":checkbox").prop("checked")) {
            var tempLine = "<tr><td class='text-left pl-5'>" + $("#ceoCheck").children().html()
              + "</td><td>????????????</td><td><select class='selectBoxCustom'><option>??????</option>"
              + "<option>??????</option></select></td><td class='upDown'><button type='button'  class='btn btn-sm btn-outline-dark' onclick='moveUp(this)'>&#8743;</button><button type='button' class='btn-outline-dark btn btn-sm' onclick='moveDown(this)'>&#8744;</button></td></tr>"
            $($("#currentLine")).append(tempLine);
          }
          $(".apprLineCheck").each(function (index, el) {

            if ($(this).prop("checked")) {
              //??????????????? ?????? ????????????
              var inputValue = $(this).val();
              var removeTr = $("#currentLine input[value=" + inputValue + "]").parent().parent();
              if (removeTr != null) {
                removeTr.remove();
              }
              //??????????????? ?????? ???????????? ???
              var tempLine = "<tr><td class='text-left pl-5'>" + $(this).parent().html()
                + "</td><td>" + $(this).parent().parent().parent().parent().children("span").text()
                + "</td><td><select class='selectBoxCustom'><option>??????</option>"
                + "<option>??????</option></select></td><td class='upDown'><button type='button' class='btn-outline-dark btn btn-sm' onclick='moveUp(this)'>&#8743;</button><button type='button' class='btn-outline-dark btn btn-sm' onclick='moveDown(this)'>&#8744;</button></td></tr>"
              $($("#currentLine")).append(tempLine);
            }
          })
          $("#countApprPpl").text($("#currentLine tr").length);
        })

        // ???????????? ????????? ????????? ??????????????? ?????? ???
        $("#deleteAppr").click(function () {
          $("#currentLine tr").each(function (index, el) {
            if ($(this).children().eq(0).children().prop("checked")) {
              $(this).remove();
            }
          })
          $("#countApprPpl").text($("#currentLine tr").length);
        })


        // ?????? ????????? ????????? ?????? ??? ???????????? ?????? 
        $(function () {
          $("#currentLine").on("click", "tr:not(.upDown)", function () {
            if ($(this).find(":checkbox").prop("checked")) {
              $(this).css("backgroundColor", "");
              $(this).children().eq(0).children().attr("checked", false);
            } else {
              $(this).css("backgroundColor", "lightblue");
              $(this).children().eq(0).children().attr("checked", true);
            }
          })

          $(".nested").on("click", "label", function () {
            if ($(this).find(":checkbox").prop("checked")) {
              $(this).parent().css("backgroundColor", "lightblue");
            } else {
              $(this).parent().css("backgroundColor", "");
            }
          })

          $("#ceoCheck").on("click", function () {
            if ($(this).find(":checkbox").prop("checked")) {
              $(this).css("backgroundColor", "lightblue");
            } else {
              $(this).css("backgroundColor", "");
            }
          })
        })
        // ?????? ????????? ????????? ?????? ??? ???????????? ?????? ???


        // ?????? ??? ????????? ????????? ?????? ??? ??????
        function moveUp(el) {
          var $tr = $(el).parent().parent();
          $tr.prev().before($tr);
        }

        function moveDown(el) {
          var $tr = $(el).parent().parent();
          $tr.next().after($tr);
        }
      // ?????? ??? ????????? ????????? ?????? ??? ?????? ???



      // ????????? ????????? ?????? ????????? ????????? ????????? ?????? 
      $(function(){
       
          $("#enrollApprLineBtn").click(function () {
            if ($("#currentLine tr").length == 0) {
              alert("???????????? ?????? 1????????? ?????????????????????");
            } else {
                var confirmedLine = [];
                $("#currentLine tr").each(function (index, el) { //currentLine tr
                  var tempLine = [];
                  console.log($(this).html());
                  tempLine.push($(this).children().eq(0).text());  // 0 ?????? ??? ??????
                  tempLine.push($(this).children().eq(0).children().val()); //1 ??????
                  tempLine.push($(this).children().eq(1).text()); //2 ??????
                  tempLine.push($(this).children().eq(2).children().val()); // 3 ????????????
                  confirmedLine.push(tempLine);
                })
                $("#selectedLine div").remove();
                for( var i =0 ; i< confirmedLine.length;i++){
                  console.log("confirmedlineLength"+confirmedLine.length);
                  var addLine= '<div class="mb-2 p-2 shadow-sm">'
                        +'<div class="d-flex">'
                              +'<div class="p-2 text-primary"><b>'+confirmedLine[i][0]+'</b></div>'
                        +'</div>'
                        +'<div class="d-flex flex-row mb-3">'
                              +'<div class="pl-2" style="width:75%">'+confirmedLine[i][2]+'</div>'
                              +'<div><span class="btn-sm btn-secondary">'+confirmedLine[i][3]+'</span></div>'
                        +'</div>'
                        +'<input type="hidden" name="apAccept['+i+'].memNo" value="'+confirmedLine[i][1]+'">'
                        +'<input type="hidden" name="apAccept['+i+'].type" value="'+confirmedLine[i][3]+'">'
                        +'<input type="hidden" name="apAccept['+i+'].apprLevel" value="'+(i+1)+'">'
                  +'</div>'
                  
                  $("#selectedLine").append(addLine);
              }
            
              alert("???????????? ?????????????????????");
              $("#claseApprLineModal").click();
        
            }
          })
      })
      // ????????? ????????? ?????? ????????? ????????? ????????? ?????? ???
      </script>



    </body>

    </html>