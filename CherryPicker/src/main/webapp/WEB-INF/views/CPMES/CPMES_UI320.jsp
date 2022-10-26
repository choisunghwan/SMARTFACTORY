<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page session="false" %> --%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ page import = "com.CherryPicker.web.common.util.CommonUtils" %>
<%@ page import="com.CherryPicker.web.comm.UserVO" %>
<%@ page import="java.util.*" %>
<%

UserVO user = (UserVO)session.getAttribute("UserInfo");

String pSearchStaDt = CommonUtils.diffDate(7);
String pSearchEndDt = CommonUtils.currenDate();
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
	$('#pSearchStaDt').datepicker({
		duration: 0,
		dateFormat: "yy-mm-dd",
		firstDay: 1,
		showOtherMonths: true,
		selectOtherMonths: true,
		prevText:"이전달",
		nextText:"다음달",
		currentText:"오늘",
		monthNames:["01","02","03","04","05","06","07","08","09","10","11","12"],
		dayNamesMin:["일","월","화","수","목","금","토"],
		showMonthAfterYear:!0,
		yearSuffix:".",
	});
	
	$('#pSearchEndDt').datepicker({
		duration: 0,
		dateFormat: "yy-mm-dd",
		firstDay: 1,
		showOtherMonths: true,
		selectOtherMonths: true,
		prevText:"이전달",
		nextText:"다음달",
		currentText:"오늘",
		monthNames:["01","02","03","04","05","06","07","08","09","10","11","12"],
		dayNamesMin:["일","월","화","수","목","금","토"],
		showMonthAfterYear:!0,
		yearSuffix:".",
	});
	
	//로딩이미지 문구 처리
	$("#jqxLoader").jqxLoader({ width: 100, height: 60, imagePosition: 'top', text: "Loading"  });
	
	//달력 이미지 클릭 시 처리
	$('#fa-calendar').click(function() {
	    $("#pSearchStaDt").focus();
	});
	
	$('#fa-calendar1').click(function() {
	    $("#pSearchEndDt").focus();
	});
	
	/*버튼 이벤트*/
	//조회버튼
	$('#btnSearch').click(function () {
		fn_search("/CPMES/CPMES_UI320_searchMas.do", "grid",setColumn, "100%", true);
// 		setGrid("grid2", "",setColumn2,"100%");
	});
	
	$('#btnCustomerOpen').click(function () {
		var url = '/CPMES/CPMES_UI511.do';
		
		showPopup(url, 'CPMES_UI511', 1240, 700, /*center*/ 1, '', '', /*status*/ 0, /*scroll*/ 0, /*resize*/ 0, /*menubar*/ 0, /*toolbar*/ 0, /*locat*/ 0, /*fullscreen*/ 0);
	    
	});
	
	//엑셀
	$('#btnExcel').click(function () {
		$("#grid").jqxGrid('exportdata', 'xlsx', '발주목록');
	});
	
	/*버튼 이벤트 끝*/
	
	/*그리드 초기화*/
	setGrid("grid", "",setColumn, "100%", true);
	/*그리드 초기화 끝*/
	
	/*그리드 이벤트*/
	$('#grid').on('cellclick', function (event) {
		var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = args.rowindex;
	    
	    if(args.datafield == "P_ORDER_NO_CP")
		{
			var value = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "P_ORDER_PK_CP");
			
			if(value != null && value !="")
			{
				//사용일자 클릭 시 원료사용 상세정보로 이동
				window.parent.addTabNewLoad('/CPMES/CPMES_UI310.do?programId=CPMES_UI320', '발주 등록 및 조회', "", value, '','','','','');
				//fn_search("/CPMES/CPMES_UI310.do", "grid2",setColumn2,"100%");	
			}
			
		}
	});
	
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
	
	
	/*그리드 이벤트 끝*/
	 
	 
});

$( window ).resize( function() {
	
} );



/*그리드 설정 */
//그리드 링크 항목 처리
var cellsrenderer = function (row, columnfield, value, defaulthtml, columnproperties) {

	var formattedValue = value;

	var scan = "<div class='jqx-grid-cell-middle-align' style='margin-top:9px;color:blue;cursor:pointer;text-decoration:underline;'>" + formattedValue + " </div>";
                         
 	return scan;
}


//그리드 컬럼 셋팅
var setColumn = [
	{ text: '순번'	, columntype: 'textbox', datafield: 'ROWNUM'		, cellsalign: 'center'	, align: 'center',  width: 50, editable:false},
 	{ text: '발주상태'	, columntype: 'textbox', datafield: 'ORDER_TP_NM_CP'	, cellsalign: 'center'	, align: 'center',  width: 80, editable:false},
 	{ text: '발주번호'	, columntype: 'textbox', datafield: 'P_ORDER_NO_CP'	, cellsalign: 'center'	, align: 'center',  width: 150 , editable:false,  cellsrenderer: cellsrenderer},
	{ text: '발주명'	, columntype: 'textbox', datafield: 'P_ORDER_NAME_CP'	, cellsalign: 'left'	, align: 'center', editable:false},
	{ text: '업체명'	, columntype: 'textbox', datafield: 'CUSTOMER_NAME_CP'	, cellsalign: 'left'	, align: 'center',  width: 300 , editable:false},
	{ text: '발주일자'	, columntype: 'textbox', datafield: 'P_ORDER_DATE_CP'	, cellsalign: 'center'	, align: 'center',  width: 150 , editable:false},
	{ text: '납기일자'	, columntype: 'textbox', datafield: 'FIXED_DATE_CP'	, cellsalign: 'center'	, align: 'center',  width: 150 , editable:false},
	{ text: '견적가'	, columntype: 'numberinput', datafield: 'ESTIMATED_COST_CP', cellsalign: 'right'	, align: 'center',  width: 150 , editable:false, cellsformat: 'D', 
		aggregates: ["sum"],
		aggregatesrenderer: function (aggregates) {  
			var vSum = aggregates.sum;
		    if(vSum == undefined) vSum = "";
			var renderstring = '<div style="float: right; margin: 4px;">'+vSum+'</div>'; 
		    return renderstring;  
		}  
	},
	{ text: '결정가'	, columntype: 'numberinput', datafield: 'FINAL_COST_CP'	, cellsalign: 'right'	, align: 'center',  width: 150 , editable:false, cellsformat: 'D',
		aggregates: ["sum"],
		aggregatesrenderer: function (aggregates) {  
			var vSum = aggregates.sum;
		    if(vSum == undefined) vSum = "";
			var renderstring = '<div style="float: right; margin: 4px;">'+vSum+'</div>'; 
		    return renderstring;  
		}  	
	},
	{ text: 'P_ORDER_PK_CP'	, columntype: 'textbox', datafield: 'P_ORDER_PK_CP'	, hidden: true }
];
  
//행추가 ROW 설정
var generaterow = function (i) {  
    var row = {};
    row["CD_V_CP"] = ""; 
    row["CD_NM_CP"] = "";
    row["CD_TP_CP"] = "TOP";
    
    return row;
}

/*그리드 설정 끝*/
 


/*사용자 함수 */
var fn_save = function () {
  //저장 전 체크 
	var rowindexes = $('#grid').jqxGrid('getselectedrowindexes');
	
	var rows = "";
	var cdtpCnt = 0;
	var cdNmCnt = 0;
	
	for(var i=0;i<rowindexes.length;i++)
	{
		
		$("#grid").jqxGrid('setcellvalue', rowindexes[i], "CHK", "1");
		
		if($("#grid").jqxGrid('getcellvalue', rowindexes[i], "CD_V_CP") == "")
		{
			cdtpCnt++;	
		}
		
		if($("#grid").jqxGrid('getcellvalue', rowindexes[i], "CD_NM_CP") == "")
		{
			cdNmCnt++;	
		}
		
		//rows += $("#grid").jqxGrid('getrowdata', i);
	}
	
	
	if(rowindexes.length==0 )
	{
		alert("저장 할 항목이 없습니다.");
		return;
	}
	
	if(cdtpCnt>0 )
	{
		alert("코드분류를 입력하여 주십시요.");
		return;
	}
	
	if(cdtpCnt2>0)
	{
		alert("코드종류를 입력하여 주십시요.");
		return;
	}
	
	if(cdNmCnt>0)
	{
		alert("코드명칭을 입력하여 주십시요.");
		return;
	}
	
	if(!confirm("저장하시겠습니까?")) return;
  
  //로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	
  	var rows = $('#grid').jqxGrid('getrows');
	
	$("#gridData").val(JSON.stringify(rows));
		
	$.ajax({
      url: "/CPMES/CPMES_UI530_save.do",
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
          
			alert("저장 하였습니다.");
          
			$('#grid').jqxGrid('clearselection');
          
			fn_search("/CPMES/CPMES_UI530_searchMas.do", "grid",setColumn,"100%");
          
			$("#pCdTp").val("");
			
		}
	});
};


//삭제 

//삭제
var fn_del = function(grid_id)
{
	
	//저장 전 체크 
	var rowindexes = $('#' + grid_id).jqxGrid('getselectedrowindexes');
	
	var rows = "";
	var cdtpCnt = 0;
	var cdNmCnt = 0;
	
	for(var i=0;i<rowindexes.length;i++)
	{
		
		$('#' + grid_id).jqxGrid('setcellvalue', rowindexes[i], "CHK", "1");
		//rows += $("#grid").jqxGrid('getrowdata', i);
	}
	
	if(rowindexes.length==0 )
	{
		alert("삭제 할 항목이 없습니다.");
		return;
	}
	
	if(!confirm("삭제하시겠습니까?")) return;
  
  //로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	
	var rows = $('#' + grid_id).jqxGrid('getrows');
	
	$("#gridData").val(JSON.stringify(rows));
		
	$.ajax({
      url: "/CPMES/CPMES_UI530_del.do",
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
          
			alert("삭제 하였습니다.");
          
			$('#grid').jqxGrid('clearselection');
          
			fn_search("/CPMES/CPMES_UI530_searchMas.do", "grid",setColumn,"100%");
          
			$("#pCdTp").val("");
			
		}
	});
	
	
};
	
//업체정보 팝업 return 값
function returnValue(arr){
	$("#pCustomerPk").val(arr[0]);
	$("#pCustomerNm").val(arr[1]);
} 

//팝업 강제로 닫기 버튼
//	$('#btn_search').click(function () {
// 	$('#jqxwindow').jqxWindow('close');
//	});
 
 // 원료사용실적 등록 팝업 오픈
//  var fn_showPop = function(num, IsNew){
// 	$("#jqxwindow").jqxWindow({ height: 380, width: 920, theme: 'summer'});
	
// 	var url ="/CPMES/CPMES_TD1_032.do?num="+num + "&IsNew=" + IsNew;
	
// 	//팝업 헤더 안보이게 하는 부분
// //		$('.jqx-window-header').css('display', 'none');
// 	var opened = $("#jqxwindow").jqxWindow('isOpen');
// 	$("#jqxwindow").jqxWindow('setContent', "<iframe src='"+ url +"' width='100%' height='99%' scrolling='auto' frameborder='0' ></iframe>");	
// 	$("#jqxwindow").jqxWindow('setTitle',"원료 정보 관리")
// 	$("#jqxwindow").jqxWindow("open");
//  }
 
 

</script>

<body>
<form id="form1" name="form1" style="height: 100%;">
<input type="hidden" id="pCdTp" name="pCdTp">
<input type="hidden" name="gridData" id="gridData" value="">
<input type="hidden" name="gridData2" id="gridData2" value="">

<!-- #wrap -->
<div id="wrap" >

	<!-- #container -->
<!-- 	<div id="container">	 -->
		<!-- #side -->
		<!-- #content -->
		<div id="content" style="height:100%" id ="content">			
			<div class="content-inner hid" style="height:100%">
				<div class="inner_top">
					<h3 class="tit">발주목록</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
						<a href="#n" class="btn1" id="btnExcel" style="display: inline-block;">엑셀</a>
					</div>
				</div>
				
				<div class="inner p_10" style="height:100%">		
					<section class="section-search">
						<form1>
							<div class="form-row">
<!-- 								<div class="col"> -->
<!-- 									<label for="">계약일자</label> -->
<%-- 									<input type="text" name="pSearchStaDt" id="pSearchStaDt"  value="<%=pSearchStaDt %>" class="form-control" style="width:120px;" > --%>
<!-- 									<button type="button" class="date_ico" id ="fa-calendar" >달력</button> -->
<!-- 								</div>	 -->
<!-- 								<div class="col"> -->
<!-- 									<div class="divider">~</div> -->
<%-- 									<input type="text" name="pSearchEndDt"  id="pSearchEndDt" value="<%=pSearchEndDt %>" class="form-control" style="width:120px;" > --%>
<!-- 									<button type="button" class="date_ico" id ="fa-calendar1">달력</button>	 -->
<!-- 								</div>   -->
								
								
<!-- 								<div class="col"> -->
<!-- 									<label for="">SO_NO</label> -->
<!-- 									<input type="text" id="pSoNo" name="pSoNo" value="" class="form-control" style="width:80px;"> -->
<!-- 								</div> -->
<!-- 								<div class="col"> -->
<!-- 									<label for="">고객사</label> -->
<!-- 									<input type = "text" name = "pVenderNm" id = "pVenderNm" class="form-control" value="" style="width:80px;" onblur="javascript:vendorData()"> -->
<!-- 									<input type = "hidden" name = "pVender" id = "pVender"  value="" readonly> -->
<!-- 									<button type="button" class="search_ico" id ="btnVenderOpen" >검색</button>	 -->
									
<!-- 								</div> -->
								
								<div class="col">
									<label for="">발주일자</label>
									<input type="text" name="pSearchStaDt" id="pSearchStaDt"  value="<%=pSearchStaDt %>" class="form-control" style="width:120px;" >
									<button type="button" class="date_ico" id ="fa-calendar" >달력</button>
								</div>
								<div class="col">
									<div class="divider">~</div>
									<input type="text" name="pSearchEndDt"  id="pSearchEndDt" value="<%=pSearchEndDt %>" class="form-control" style="width:120px;" >
									<button type="button" class="date_ico" id ="fa-calendar1">달력</button>	
								</div>  
								 
								<div class="col">  
									<label for="">거래처명</label> 
									<input type = "text" name = "pCustomerNm" id = "pCustomerNm" class="form-control" value="" style="width:200px;" >
								</div>
								
								<div class="col">
									<label for="">발주상태</label>
									<select class="form-control"  name = "pOrderTp" id = "pOrderTp">
										<option value="" selected>전체</option>
										<c:forEach items="${orderTp}" var="orderTp">
										<option value="${orderTp.CD_V_CP}">${orderTp.CD_NM_CP}</option>
										</c:forEach>
									</select>
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
