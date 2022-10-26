<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page session="false" %> --%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ page import = "com.hubizict.web.common.util.CommonUtils" %>
<%@ page import="com.hubizict.web.comm.UserVO" %>
<%@ page import="java.util.*" %>
<%

UserVO user = (UserVO)session.getAttribute("UserInfo");

%>

<!DOCTYPE HTML>
<html lang="ko">  
<head>
<meta charset="utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta http-equive="Content-Style-Type" content="text/css"/>
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>휴비즈ICT</title>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />	
	
<%@ include file="/resources/js/include-header.jspf" %>	

<%-- <link rel="stylesheet" href="<c:url value='/resources/jqwidgets/styles/jqx.base.css'/>" type="text/css" /> --%>
<%-- <link rel="stylesheet" href="<c:url value='/resources/jqwidgets/styles/jqx.black.css'/>" type="text/css" /> --%>
	
<style>
	
      


.jqx-icon-arrow-left jqx-icon-arrow-left-ui-overcast
{
    margin-left: 6px;
    margin-top: 5px;
    width: 15px;
    height: 15px;
}
</style>   

<script type="text/javascript">

$(document).ready(function() {
	/*=========== 달력설정 ============= */
	
	
	/*버튼 이벤트*/
	//조회버튼
	$('#btnSearch').click(function () {
		fn_search("/PSMES/PSMES_UI920_search_param.do", "grid",setColumn,"100%");
	});
	
	
	
	//신규
	$('#btnInsert').click(function () {
		fn_save("INSERT");
	});
	
	//수정
	$('#btnSave').click(function () {
		fn_save("UPDATE");
	});
	
	
	//행추가
	$('#btnAddRow').click(function () {
		var datarow = generaterow();
		     
		var commit = $("#grid").jqxGrid('addrow', null, datarow);
		
		var rows = $('#grid').jqxGrid('getrows');
		
		$('#grid').jqxGrid('ensurerowvisible', rows.length-1);
		 
	});  
	
	//삭제
	$('#btnDelRow').click(function () {
		fn_save("DELETE");
	});
	
	/*버튼 이벤트 끝*/
	
	/*그리드 초기화*/
	setGrid("grid", "",setColumn,"100%");
	/*그리드 초기화 끝*/
	
	/*그리드 이벤트 끝*/
	//그리드 값 변경 이벤트
	$("#grid").on('cellendedit', function (event) 
	{
	    // event arguments.
	    var args = event.args;
	    // column data field.
	    var dataField = event.args.datafield;
	    // row's bound index.
	    var rowBoundIndex = event.args.rowindex;
	    // cell value
	    var value = args.value;
	    // cell old value.
	    var oldvalue = args.oldvalue;
	    // row's data.
	    var rowData = args.row;
	    
	    if(oldvalue == null) oldvalue ="";
	    
	    if(oldvalue != value)  $("#grid").jqxGrid('selectrow', rowBoundIndex);
	    
	}); 
	 
});

$( window ).resize( function() {
	
} );



/*그리드 설정 */
//그리드 링크 항목 처리

 
//그리드 콤보관련 끝 

//그리드 컬럼 셋팅
var setColumn = [
	
	{ text: '항목1'		, columntype: 'textbox', datafield: 'AAA'		, cellsalign: 'center', align: 'center',  width: 150 },
	{ text: '항목2'		, columntype: 'textbox', datafield: 'BBB'		, cellsalign: 'center', align: 'center',  width: 150 },
	{ text: '항목3'		, columntype: 'textbox', datafield: 'CCC'		, cellsalign: 'center', align: 'center',  width: 150 },
	{ text: '항목4'		, columntype: 'textbox', datafield: 'DDD'		, cellsalign: 'center', align: 'center',  width: 150 },
	{ text: '항목5'		, columntype: 'textbox', datafield: 'EEE'		, cellsalign: 'center', align: 'center' },
	{ text: 'CHK'		, columntype: 'textbox', datafield: 'CHK'	, hidden: true }
];
  
//행추가 ROW 설정
var generaterow = function (i) {  
    var row = {};
    row["AAA"] = ""; 
    row["BBB"] = "";
    row["CCC"] = "";
    row["DDD"] = "";
    row["EEE"] = "";
    
    return row;
}

/*그리드 설정 끝*/
 


/*사용자 함수 */
var fn_save = function (cmd) {
  //저장 전 체크 
	var rowindexes = $('#grid').jqxGrid('getselectedrowindexes');

	var rows = "";
	
	for(var i=0;i<rowindexes.length;i++)
	{
		$("#grid").jqxGrid('setcellvalue', rowindexes[i], "CHK", "1");
	}
	
	
	if(rowindexes.length==0 )
	{
		alert("처리 할 항목이 없습니다.");
		return;
	}
	
	if(cmd == "INSERT")
	{
		if(!confirm("저장하시겠습니까?")) return;	
	}
	else if(cmd == "UPDATE")
	{
		if(!confirm("저장하시겠습니까?")) return;	
	}
	else if(cmd == "DELETE")
	{
		if(!confirm("삭제하시겠습니까?")) return;	
	}
	
	$("#pCmd").val(cmd);
  
  //로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	
  	var rows = $('#grid').jqxGrid('getrows');
	
	$("#gridData").val(JSON.stringify(rows));
		
	$.ajax({
      url: "/PSMES/PSMES_UI930_save.do",
      dataType: 'json',
      data : $("#form1").serialize(),
		//data : param,
      type : 'POST',
      beforeSend: function (request) {
//       	xmlHttpRequest.setRequestHeader("AJAX", "true");
      	$("jqxgrid").html('');
          request.setRequestHeader("AJAX", "true");
      },
      error: function (json, textStatus, errorThrown) {
          if(json.status == "403")
          {
          	alert("세션이 만료되어 로그인 화면으로 이동합니다.");
              window.parent.location.href="/login.do";
          }
          else
          {
          	alert(' Error :' + errorThrown + "  " + textStatus + "  " + json);	
          }
      	
      },
      success: function (data) {
			// initailize grid
			$('#jqxLoader').jqxLoader('close');
			
			alert("처리 완료 하였습니다.");
			
          
			$('#grid').jqxGrid('clearselection');
          
			fn_search("/PSMES/PSMES_UI910_search.do", "grid",setColumn,"100%");
          
			
		}
	});
};


 
	
 

</script>

<body>
<form id="form1" name="form1" style="height: 100%;">
<input type="hidden" id="pCmd" name="pCmd">
<input type="hidden" name="gridData" id="gridData" value="">


<!-- #wrap -->
<div id="wrap" >

	<!-- #container -->
<!-- 	<div id="container">	 -->
		<!-- #side -->
		<!-- #content -->
		<div id="content" style="height:100%" id ="content">			
			<div class="content-inner hid" style="height:100%">
				<div class="inner_top">
					<h3 class="tit">거래처관리</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
						<a href="#n" class="btn1" id="btnAddRow" style="display: inline-block;">행추가</a>
						<a href="#n" class="btn1" id="btnInsert" style="display: inline-block;">신규</a>
						<a href="#n" class="btn1" id="btnSave" style="display: inline-block;">수정</a>
						<a href="#n" class="btn1" id="btnDelRow" style="display: inline-block;">삭제</a>
					</div>
				</div>
				
				<div class="inner p_10" style="height:100%">		
					<section class="section-search">
						<form1>
							<div class="form-row">

								<div class="col">
									<label for="">항목1</label>
									<input type="text" id="param1" name="param1" value="" class="form-control" style="width:120px;"> 
								</div>
								
							</div>
		
							
						</form1>
					</section>
            		<div style="height:5px;"></div>
					<div id="inner_grid" class="con_list mtable" style="height:calc(100% - 170px);">		
			           	<div id="grid"></div>
			     	</div>
         			
<!-- 					<div class="scroll_x">좌우로 스크롤하시면 볼 수 있습니다.</div> -->
				</div>
			</div>
		</div>
		<div id="jqxLoader">
    	</div>
		

	
	 
	</div>   <!--#wrap-->
	</form>    	
	
</body>


	<div id='jqxwindow' style="display:none;">
        <div id='content' style="text-align:center;">
        </div>
    </div>
</html>
