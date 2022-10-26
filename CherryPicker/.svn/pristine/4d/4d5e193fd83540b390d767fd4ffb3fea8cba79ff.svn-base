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
		fn_search("/CPMES/CPMES_UI230_searchMas.do", "grid",setColumn,"100%");
		setGrid("grid2", "",setColumn2,"100%");
	});
	
	//출고
	$('#btnRelease').click(function () {
		fn_save();
	});
	
	//삭제
	$('#btnDelRow').click(function () {
		fn_del("grid");
	});
	
	
	//행추가
	$('#btnAddRow').click(function () {
		var datarow = generaterow();
	    var commit = $("#grid").jqxGrid('addrow', null, datarow);
	    
	});
	
	$('#btnExcel').click(function () {
		$("#grid").jqxGrid('exportdata', 'xlsx', '제품출고관리');
	});
	
	
	/*버튼 이벤트 끝*/
	
	/*그리드 초기화*/
	setGrid("grid", "",setColumn,"100%");
	/*그리드 초기화 끝*/
	
	/*그리드 이벤트*/
	$('#grid').on('cellclick', function (event) {
		var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = args.rowindex;
	    
	    if(args.datafield == "R_ORDER_NO_CP")
		{
			var value = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "R_ORDER_PK_CP");
			
			if(value != null && value !="")
			{
				//사용일자 클릭 시 원료사용 상세정보로 이동
				window.parent.addTabNewLoad('/CPMES/CPMES_UI210.do?programId=CPMES_UI220', '수주 등록 및 조회', "", value, '','','','','');
				//fn_search("/PSMES/PSMES_UI310.do", "grid2",setColumn2,"100%");	
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
	{ text: '순번'		, columntype: 'textbox', datafield: 'ROWNUM'			, cellsalign: 'center', align: 'center',  width: 50,  editable:false},
 	{ text: '상태'		, columntype: 'textbox', datafield: 'SALES_TP_CP'			, cellsalign: 'center', align: 'center',  width: 100, editable:false},
	{ text: '수주번호'		, columntype: 'textbox', datafield: 'R_ORDER_NO_CP'		, cellsalign: 'center', align: 'center',  width: 180, editable:false, cellsrenderer: cellsrenderer },
	{ text: '수주명'		, columntype: 'textbox', datafield: 'R_ORDER_NAME_CP'		, cellsalign: 'left'  , align: 'center', editable:false},
	{ text: '업체명'		, columntype: 'textbox', datafield: 'COMPANY_NAME_CP'		, cellsalign: 'left'  , align: 'center',  width: 300, editable:false},
	{ text: '수주일자'		, columntype: 'textbox', datafield: 'R_ORDER_DATE_CP'		, cellsalign: 'center', align: 'center',  width: 120, editable:false },
	{ text: '납기일자'		, columntype: 'textbox', datafield: 'FIXED_DATE_CP'		, cellsalign: 'center', align: 'center',  width: 120, editable:false },
	{ text: '작업시작일자'	, columntype: 'textbox', datafield: 'P_WORK_START_DATE_CP'	, cellsalign: 'center', align: 'center',  width: 120, editable:false },
	{ text: '작업완료일자'	, columntype: 'textbox', datafield: 'P_WORK_END_DATE_CP'	, cellsalign: 'center', align: 'center',  width: 120, editable:false },
	{ text: '출고일자'		, columntype: 'textbox', datafield: 'SHIPPING_DATE_CP'		, cellsalign: 'center', align: 'center',  width: 120, editable:false },
	{ text: 'R_ORDER_PK_CP', columntype: 'textbox', datafield: 'R_ORDER_PK_CP' 		, hidden: true },
	{ text: 'CHK'		, columntype: 'textbox', datafield: 'CHK'			    , hidden: true }
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
	}
	
	if(rowindexes.length==0 )
	{
		alert("출고할 수주번호를 선택해주세요.");
		return;
	}
	
	if(!confirm("출고처리 하시겠습니까?")) return;
  
  	//로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	
  	var rows = $('#grid').jqxGrid('getrows');
	
	$("#gridData").val(JSON.stringify(rows));
		
	$.ajax({
      url: "/CPMES/CPMES_UI230_save.do",
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
          
			fn_search("/CPMES/CPMES_UI230_searchMas.do", "grid",setColumn,"100%");
			
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
	


//팝업 강제로 닫기 버튼
//	$('#btn_search').click(function () {
// 	$('#jqxwindow').jqxWindow('close');
//	});
 
 // 원료사용실적 등록 팝업 오픈
//  var fn_showPop = function(num, IsNew){
// 	$("#jqxwindow").jqxWindow({ height: 380, width: 920, theme: 'summer'});
	
// 	var url ="/PSMES/PSMES_TD1_032.do?num="+num + "&IsNew=" + IsNew;
	
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
					<h3 class="tit">제품출고관리</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnRelease" style="display: inline-block;">출고</a>
						<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
						<a href="#n" class="btn1" id="btnExcel" style="display: inline-block;">엑셀</a>
					</div>
				</div>
				
				<div class="inner p_10" style="height:100%">		
					<section class="section-search">
						<form1>
							<div class="form-row">

								<div class="col">  
									<label for="">수주상태</label> 
									<select class="form-control"  name = "pSalesTp" id = "pSalesTp">
										<option value="">전체</option>
										<option value="S04">작업완료</option>
										<option value="S05">출고</option>
									</select>
								</div>
								
								<div class="col">
									<label for="">납기일자</label>
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
