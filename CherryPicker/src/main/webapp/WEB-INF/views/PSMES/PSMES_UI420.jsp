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
	
	$('#mainSplitter').jqxSplitter({ width: 'calc(100% - 2px)', height: 'calc(100% - 170px)',  panels: [{ size: 650}] });
	
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
		fn_search_n("/PSMES/PSMES_UI420_main_search.do", "grid",setColumn,"100%");
		setGrid("grid2", "",setColumn2,"100%");
	});
	
	//저장
	$('#btnSave').click(function () {
		fn_save();
	});
	
	//삭제
	$('#btnDelRow').click(function () {
		fn_del("grid");
	});
	
	//삭제2
	$('#btnDelRow2').click(function () {
		fn_del("grid2");
	});
	
	
	//행추가
	$('#btnAddRow').click(function () {
		var datarow = generaterow();
	    var commit = $("#grid").jqxGrid('addrow', null, datarow);
	    
	});
	
	//행추가
	$('#btnAddRow2').click(function () {
		if($("#pCdTp").val() == "")
		{
			alert( "좌측 코드를 먼저 선택하여 주십시요.");
			return;
		}	
		
		var datarow = generaterow2();
	    var commit = $("#grid2").jqxGrid('addrow', null, datarow);
	    
	});
	
	/*버튼 이벤트 끝*/
	
	/*그리드 초기화*/
	setGrid_n("grid", "",setColumn,"100%");
	
	
	setGridGroup("grid2", "",setColumn2, columngroups,"100%");
	//$("#grid2").jqxGrid({shrinkToFit:false});
	//$("#grid2").jqGrid( 'setFrozenColumns' );
	
	/*그리드 초기화 끝*/
	
	/*그리드 이벤트*/
	$('#grid').on('cellclick', function (event) {
		var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = args.rowindex;
	    
	    var cv_R_ORDER_PK = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "R_ORDER_PK");
	    
	    $('#pROrderPk').val(cv_R_ORDER_PK);	// 수주번호PK
	    
	    fn_search("/PSMES/PSMES_UI420_detail_search.do", "grid2", setColumn2, "100%");
	    
// 	    if(args.datafield == "CD_NM")
// 		{
// 			var value = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "CD_V");
			
// 			if(value != null && value !="")
// 			{
// 				$("#pCdTp").val("");
// 				$("#pCdTp").val(value);
				
// 				$('#grid2').jqxGrid('clearselection');
				
// 				//사용일자 클릭 시 원료사용 상세정보로 이동
// 				fn_search("/PSMES/PSMES_UI530_searchDet.do", "grid2",setColumn2,"100%");	
// 			}
			
// 		}
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
	
	//그리드2 값 변경 이벤트
	$("#grid2").on('cellendedit', function (event) 
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

	    if(oldvalue != value)  $("#grid2").jqxGrid('selectrow', rowBoundIndex);	
	    
	    
	});
	
	/*그리드 이벤트 끝*/
	 
	 
});

$( window ).resize( function() {
	
} );

function fn_search_n (pUrl, pGrid_id, pSetColumn, pHeight, pSumChk ) {
	
	//로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	
	url = pUrl;
	
	$.ajax({
        url: pUrl ,
        dataType: 'json',
        data : $("#form1").serialize(),
		//data : param,
        type : 'POST',
        async : false,
        beforeSend: function (request) {
//         	xmlHttpRequest.setRequestHeader("AJAX", "true");
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
            setGrid_n(pGrid_id, data.response, pSetColumn, pHeight, pSumChk);
            
            $('#jqxLoader').jqxLoader('close');
            
		}
	});
};

//그리드 데이터 출력
function setGrid_n (pGrid_id, pResponse, pSetColumn, pHeight)
{
	//grid_id = "";
	//setColumn = "";
	var gridData = null;
	
	if(pResponse != "")
	{
		gridData = pResponse;
	}
	
	var gridSource =
    {
        localdata: gridData,
        datatype: 'json',
       	root: "entry",
       	//pager: function (pagenum, pagesize, oldpagenum) {
       	pager: function (pagenum, pagesize, oldpagenum) {	
         // callback called when a page or page size is changed.
 		}
    };
    
    var gridDataAdapter = new $.jqx.dataAdapter(gridSource);
    
    $("#" + pGrid_id).jqxGrid(
	{
		width: '100%',
        height: pHeight,
		source: gridDataAdapter,   
		editable: true,
		selectionmode: 'singlerow',
        editmode: 'click',
 		theme: 'energyblue',
	    pagermode: 'simple',
		columnsresize: true,
		showrowlines:true,
		showcolumnlines: true,
 		columns: pSetColumn
		
	});
    
}


/*그리드 설정 */
//그리드 링크 항목 처리
var cellsrenderer = function (row, columnfield, value, defaulthtml, columnproperties) {

	var formattedValue = value;

	var scan = "<div class='jqx-grid-cell-middle-align' style='margin-top:9px;color:blue;cursor:pointer;text-decoration:underline;'>" + formattedValue + " </div>";
                         
 	return scan;
}


//그리드 컬럼 셋팅
var setColumn = [
	{
	     text: '순번', sortable: false, filterable: false, editable: false, align: 'center', cellsalign: 'center',
	     groupable: false, draggable: false, resizable: false,
	     datafield: '', columntype: 'number', width: 40,
	     cellsrenderer: function (row, column, value) {
	         return "<div style='margin:7px;text-align:center'>" + (value + 1) + "</div>";
	     }
 	},
 	{ text: '수주상태'		, columntype: 'textbox', datafield: 'SALES_NM'		, cellsalign: 'center', align: 'center',  width: 80, editable: false },
 	{ text: '수주번호'		, columntype: 'textbox', datafield: 'R_ORDER_NO'	, cellsalign: 'center', align: 'center',  width: 100, editable: false },
	{ text: '수주명'		, columntype: 'textbox', datafield: 'R_ORDER_NAME'	, cellsalign: 'left'  , align: 'center', editable: false },
	{ text: '수주일자'		, columntype: 'textbox', datafield: 'R_ORDER_DATE_V', cellsalign: 'center', align: 'center',  width: 100, editable: false },
	{ text: '납기일'		, columntype: 'textbox', datafield: 'FIXED_DATE'	, cellsalign: 'center', align: 'center',  width: 100, editable: false },
	{ text: '작업'		, columntype: 'textbox', datafield: 'WORK_CONFIRM'	, cellsalign: 'center', align: 'center',  width: 40, editable: false },
	{ text: '수주PK'		, columntype: 'textbox', datafield: 'R_ORDER_PK'	, hidden: true },
	{ text: 'CHK'		, columntype: 'textbox', datafield: 'CHK'			, hidden: true },
	{ text: 'SALES_TP'	, columntype: 'textbox', datafield: 'SALES_TP'		, hidden: true }
];
  
//행추가 ROW 설정
var generaterow = function (i) {  
    var row = {};
    row["CD_V"] = ""; 
    row["CD_NM"] = "";
    row["CD_TP"] = "TOP";
    
    return row;
}

//그리드 컬럼 셋팅
var setColumn2 = [
	{ text: '품번'	, columntype: 'textbox', datafield: 'PRODUCT_NO'		, cellsalign: 'center', align: 'center', width: 80, pinned: true, editable: false},
	{ text: '품명'	, columntype: 'textbox', datafield: 'PRODUCT_NAME'		, cellsalign: 'left'  , align: 'center', width: 150, pinned: true, editable: false },
	{ text: '작업'	, columntype: 'textbox', datafield: 'WORK_CONFIRM'		, cellsalign: 'center', align: 'center', width: 40 , pinned: true, editable: false },
 	{ text: '계획일'	, columntype: 'textbox', datafield: 'P1_PLAN_DATE'		, cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails1'},
	{ text: '작업자'	, columntype: 'textbox', datafield: 'P1_WORKER'			, cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails1'},
	{ text: '작업시작'	, columntype: 'textbox', datafield: 'P1_WORK_START_DATE', cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails1'},
	{ text: '작업완료'	, columntype: 'textbox', datafield: 'P1_WORK_END_DATE'	, cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails1'},
	{ text: '계획일'	, columntype: 'textbox', datafield: 'P2_PLAN_DATE'		, cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails2'},
	{ text: '작업자'	, columntype: 'textbox', datafield: 'P2_WORKER'			, cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails2'},
	{ text: '작업시작'	, columntype: 'textbox', datafield: 'P2_WORK_START_DATE', cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails2'},
	{ text: '작업완료'	, columntype: 'textbox', datafield: 'P2_WORK_END_DATE'	, cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails2'},
	{ text: '계획일'	, columntype: 'textbox', datafield: 'P3_PLAN_DATE'		, cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails3'},
	{ text: '작업자'	, columntype: 'textbox', datafield: 'P3_WORKER'			, cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails3'},
	{ text: '작업시작'	, columntype: 'textbox', datafield: 'P3_WORK_START_DATE', cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails3'},
	{ text: '작업완료'	, columntype: 'textbox', datafield: 'P3_WORK_END_DATE'	, cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails3'},
	{ text: '계획일'	, columntype: 'textbox', datafield: 'P4_PLAN_DATE'		, cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails4'},
	{ text: '작업자'	, columntype: 'textbox', datafield: 'P4_WORKER'			, cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails4'},
	{ text: '작업시작'	, columntype: 'textbox', datafield: 'P4_WORK_START_DATE', cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails4'},
	{ text: '작업완료'	, columntype: 'textbox', datafield: 'P4_WORK_END_DATE'	, cellsalign: 'center', align: 'center', width: 100, editable: false, columngroup: 'ProductDetails4'},
	{ text: 'R_ORDER_PK'	    , columntype: 'textbox', datafield: 'R_ORDER_PK'		, hidden: true },
	{ text: 'R_ORDER_DETAIL_PK'	, columntype: 'textbox', datafield: 'R_ORDER_DETAIL_PK'	, hidden: true },
	{ text: 'CHK'			    , columntype: 'textbox', datafield: 'CHK'				, hidden: true }
];

var columngroups = 
	[
	  { text: '제관', align: 'center', name: 'ProductDetails1' },
	  { text: '용접', align: 'center', name: 'ProductDetails2' },
	  { text: '가공', align: 'center', name: 'ProductDetails3' },
	  { text: '조립', align: 'center', name: 'ProductDetails4' }
	];
	

//행추가 ROW 설정
var generaterow2 = function (i) {  
    var row = {};
    row["CD_V"] = ""; 
    row["CD_NM"] = "";
    row["CD_TP"] = $("#pCdTp").val();
    row["ATTR1"] = "";
    row["ATTR2"] = "";
    row["ATTR3"] = "";
    row["ATTR4"] = "";
    
    return row;
}

/*그리드 설정 끝*/
 


/*사용자 함수 */
var fn_save = function () {
  //저장 전 체크 
	var rowindexes = $('#grid').jqxGrid('getselectedrowindexes');
	
	var rowindexes2 = $('#grid2').jqxGrid('getselectedrowindexes');
	
	var rows = "";
	var cdtpCnt = 0;
	var cdNmCnt = 0;
	var cdtpCnt2 = 0;
	var cdNmCnt2 = 0;
	
	var vOrderNo = "";
	var vWorkConfirm = "";
	var vSalestp = "";
	for(var i=0;i<rowindexes.length;i++)
	{
		$("#grid").jqxGrid('setcellvalue', rowindexes[i], "CHK", "1");
		
		vOrderNo = $("#grid").jqxGrid('getcellvalue', rowindexes[i], "R_ORDER_NO");
		vWorkConfirm = $("#grid").jqxGrid('getcellvalue', rowindexes[i], "WORK_CONFIRM");
		vSalestp =  $("#grid").jqxGrid('getcellvalue', rowindexes[i], "SALES_TP"); 
	}
	
	if(vSalestp == "S04"){
		alert("수주번호["+vOrderNo+"] 작업이 완료된 상태입니다.");
		return;
	}else if(vSalestp == "S05"){
		alert("수주번호["+vOrderNo+"] 출고된 상태입니다.");
		return;
	} 
	
	
	if(rowindexes.length==0)
	{
		alert("우측그리드의 수주번호를 선택해주세요.");
		return;
	}
	
	var msg = "수주번호["+vOrderNo+"] 작업완료하시겠습니까?";
	if(vWorkConfirm != "Y"){
		msg = "수주번호["+vOrderNo+"] 상세작업이 완료되지 않았습니다.\n작업완료하시겠습니까?";
	}
	
	if(!confirm(msg)) return;
  
  //로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	
  	var rows = $('#grid').jqxGrid('getrows');
	var rows2 = $('#grid2').jqxGrid('getrows');
	
	$("#gridData").val(JSON.stringify(rows));
	$("#gridData2").val(JSON.stringify(rows2));
		
	$.ajax({
      url: "/PSMES/PSMES_UI420_save.do",
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
			$('#grid2').jqxGrid('clearselection');
          
			fn_search_n("/PSMES/PSMES_UI420_main_search.do", "grid",setColumn,"100%");
          
          	fn_search("/PSMES/PSMES_UI420_detail_search.do", "grid2", setColumn2, "100%");
			
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
	var cdtpCnt2 = 0;
	var cdNmCnt2 = 0;
	
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
      url: "/PSMES/PSMES_UI530_del.do",
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
          $('#grid2').jqxGrid('clearselection');
          
          fn_search_n("/PSMES/PSMES_UI420_searchMas.do", "grid",setColumn,"100%");
          
		  //fn_search("/PSMES/PSMES_UI420_detail_search.do", "grid2", setColumn2, "100%");
			
		}
	});
	
	
};

</script>

<body>
<form id="form1" name="form1" style="height: 100%;">
<input type="hidden" id="pCdTp" name="pCdTp">
<input type="hidden" name="gridData" id="gridData" value="">
<input type="hidden" name="gridData2" id="gridData2" value="">
<input type="hidden" name="pROrderPk" id="pROrderPk" value=""> 
 
<!-- #wrap -->
<div id="wrap" >

	<!-- #container -->
<!-- 	<div id="container">	 -->
		<!-- #side -->
		<!-- #content -->
		<div id="content" style="height:100%" id ="content">			
			<div class="content-inner hid" style="height:100%">
				<div class="inner_top">
					<h3 class="tit">생산실적조회</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnSave" style="display: inline-block;">작업완료</a>
						<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
					</div>
				</div>
				
				<div class="inner p_10" style="height:100%">		
					<section class="section-search">
						<form1>
							<div class="form-row">
								<div class="col">
									<label for="">작업상태</label>
									<select class="form-control"  name = "pPstatus" id = "pPstatus">
										<option value="">전체</option>
										<option value="S03">작업지시</option>
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
								
							</div>
		
							
						</form1>
					</section>
					
					<div style="height:5px;"></div>
					
					<div id="mainSplitter">
		                <div class="splitter-panel">
		                	<!-- left -->
		                	<div id="inner_grid" class="con_list mtable" style="height:100%;">		
					           	<div id="grid"></div>
					     	</div>
		                </div>
		                <div class="splitter-panel">
		                	<div id="inner_grid" class="con_list mtable" style="height:100%;">		
					           	<div id="grid2"></div>
					     	</div>
		                </div>
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
