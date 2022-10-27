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

//String pSearchStaDt = CommonUtils.diffDate(7);
String pNowDt = CommonUtils.currenDate();
%>
 
<!DOCTYPE HTML>
<html lang="ko">  
<head>
<meta charset="utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta http-equive="Content-Style-Type" content="text/css"/>
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>DCU CP</title>

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
	
	$('#mainSplitter').jqxSplitter({ width: 'calc(100% - 2px)', height: 'calc(100% - 170px)',  panels: [{ size: 500}] });
	
	/*=========== 달력설정 ============= */
	$('#pInstallDate').datepicker({
		duration: 0,
		dateFormat: "yy-mm-dd",
		firstDay: 1,
		showOtherMonths: true,
		selectOtherMonths: true,
		//changeYear:true,
		//changeMonth:true,
		prevText:"이전달",
		nextText:"다음달",
		currentText:"오늘",
		monthNames:["01","02","03","04","05","06","07","08","09","10","11","12"],
		dayNamesMin:["일","월","화","수","목","금","토"],
		showMonthAfterYear:!0,
		yearSuffix:".",
	});
	$("#pInstallDate").val('<%=pNowDt%>');
	
	$('#pSupplyDate').datepicker({
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
	$("#pSupplyDate").val('<%=pNowDt%>');
	
	//로딩이미지 문구 처리
	$("#jqxLoader").jqxLoader({ width: 100, height: 60, imagePosition: 'top', text: "Loading"  });
	
	//달력 이미지 클릭 시 처리
	$('#fa-calendar1').click(function() {
	    $("#pInstallDate").focus();
	});
	
	$('#fa-calendar2').click(function() {
	    $("#pSupplyDate").focus();
	});
	
	/*버튼 이벤트*/
	//조회버튼
	$('#btnSearch').click(function () {
		fn_search("/CPMES/CPMES_UI430_main_search.do", "grid", setColumn, "100%");
		//setGrid("grid2", "",setColumn2, "100%");
	});
	
	//저장
	$('#btnSave').click(function () {
		fn_save();
	});
	
	//신규
	$('#btnNew').click(function () {
		fn_new();
	});
	
	
	//삭제
	$('#btnDelete').click(function () {
		fn_del("grid");
	});
	
	//삭제2
	$('#btnDelRow2').click(function () {
		fn_del2("grid2");
	});
	
	
	//행추가
	$('#btnAddRow').click(function () {
		//var datarow = generaterow();
	    //var commit = $("#grid").jqxGrid('addrow', null, datarow);
	    
	});
	
	//행추가
	$('#btnAddRow2').click(function () {
		
		if($('#pEquipmentPk').val() == ""){
			alert("설비를 선택해주세요");
			return;
		}
		
		var datarow = generaterow2();
	    var commit = $("#grid2").jqxGrid('addrow', null, datarow);
	    
	});
	
	/*버튼 이벤트 끝*/
	
	/*그리드 초기화*/
	setGrid("grid", "",setColumn, "100%");
	setGrid("grid2", "",setColumn2, "100%");
	/*그리드 초기화 끝*/
	
	/*그리드 이벤트*/
	$('#grid').on('cellclick', function (event) {
		var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = args.rowindex;
	    
	    var cv_EQUIPMENT_PK = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "EQUIPMENT_PK_CP");
	    var cv_EQUIP_CODE = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "EQUIP_CODE_CP");
	    var cv_EQUIP_NAME = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "EQUIP_NAME_CP");
	    var cv_MAKER = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "MAKER_CP");
	    var cv_SUPPLIER = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "SUPPLIER_CP");
	    var cv_SUPPLY_DATE = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "SUPPLY_DATE_CP");
	    var cv_INSTALL_DATE = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "INSTALL_DATE_CP");
	    var cv_MANAGER = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "MANAGER_CP");
	    var cv_EQUIP_AMOUNT = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "EQUIP_AMOUNT_CP");
	    var cv_CALIBARTION_YN = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "CALIBARTION_YN_CP");
	    var cv_USE_YN = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "USE_YN_CP");
	    var cv_NOTE = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "NOTE_CP");
	    
	    $('#pEquipmentPk').val(cv_EQUIPMENT_PK);	// 설비코드PK
		$('#pEquipCode').val(cv_EQUIP_CODE);		// 설비코드
		$('#pEquipName').val(cv_EQUIP_NAME);		// 설비명
		$('#pMaker').val(cv_MAKER);					// 제조사
		$('#pSupplier').val(cv_SUPPLIER);			// 납품사
		$('#pSupplyDate').val(cv_SUPPLY_DATE);		// 납품일
		$('#pInstallDate').val(cv_INSTALL_DATE);	// 설치일
		$('#pManager').val(cv_MANAGER);				// 관리자
		$('#pEquipAccount').val(cv_EQUIP_AMOUNT);	// 설비금액
		
		var bChk1 = true;
		if(cv_CALIBARTION_YN != "Y") bChk = false
		$("input:checkbox[id='pCalibartionYn']").prop("checked", bChk1);

		var bChk2 = true;
		if(cv_USE_YN != "Y") bChk2 = false
		$("input:checkbox[id='pUseYn']").prop("checked", bChk2);
		
		$('#pNote').val(cv_NOTE);					// 비고
	    
		// 관리이력 조회
		fn_search("/CPMES/CPMES_UI430_detail_search.do", "grid2", setColumn2, "100%");
		
	    
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
	
	fn_search("/CPMES/CPMES_UI430_main_search.do", "grid", setColumn, "100%");
	 
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
	{
	     text: '순번', sortable: false, filterable: false, editable: false, align: 'center', cellsalign: 'center',
	     groupable: false, draggable: false, resizable: false,
	     datafield: '', columntype: 'number', width: 50,
	     cellsrenderer: function (row, column, value) {
	         return "<div style='margin:7px;text-align:center'>" + (value + 1) + "</div>";
	     }
 	},
	{ text: '설비코드'	, columntype: 'textbox', datafield: 'EQUIP_CODE_CP', cellsalign: 'center', align: 'center',  width: 120, editable: false },
	{ text: '설비명'	, columntype: 'textbox', datafield: 'EQUIP_NAME_CP', cellsalign: 'center', align: 'center', editable: false },
	{ text: '설비PK'	, columntype: 'textbox', datafield: 'EQUIPMENT_PK_CP',		hidden: true },
	{ text: '제조사'	, columntype: 'textbox', datafield: 'MAKER_CP', 			hidden: true },
	{ text: '납품사'	, columntype: 'textbox', datafield: 'SUPPLIER_CP', 		hidden: true },
	{ text: '납품일'	, columntype: 'textbox', datafield: 'SUPPLY_DATE_CP', 		hidden: true },
	{ text: '설치일'	, columntype: 'textbox', datafield: 'INSTALL_DATE_CP', 	hidden: true },
	{ text: '관리자'	, columntype: 'textbox', datafield: 'MANAGER_CP', 			hidden: true },
	{ text: '구입금액'	, columntype: 'textbox', datafield: 'EQUIP_AMOUNT_CP', 	hidden: true },
	{ text: '검정여부'	, columntype: 'textbox', datafield: 'CALIBARTION_YN_CP', 	hidden: true },
	{ text: '사용유무'	, columntype: 'textbox', datafield: 'USE_YN_CP', 			hidden: true },
	{ text: '비고'	, columntype: 'textbox', datafield: 'NOTE_CP', 			hidden: true },
	{ text: 'CHK'	, columntype: 'textbox', datafield: 'CHK'	, hidden: true }
];
  
//행추가 ROW 설정
var generaterow = function (i) {  
    var row = {};
    row["CD_V_CP"] = ""; 
    row["CD_NM_CP"] = "";
    row["CD_TP_CP"] = "TOP";
    
    return row;
}

//그리드 컬럼 셋팅
var setColumn2 = [
	{
	     text: '순번', sortable: false, filterable: false, editable: false, align: 'center', cellsalign: 'center',
	     groupable: false, draggable: false, resizable: false,
	     datafield: '', columntype: 'number', width: 50,
	     cellsrenderer: function (row, column, value) {
	         return "<div style='margin:7px;text-align:center'>" + (value + 1) + "</div>";
	     }
	},
 	{ 
		text: '일자', datafield: 'HISTORY_DATE_CP', columntype: 'datetimeinput',  align: 'center', cellsalign: 'center', width: 150, cellsformat: 'yyyy-MM-dd',
	  	validation: function (cell, value) {
			if (value == "")
				return true; 
			var year = value.getFullYear();
			return true;
		}
	},
 	{ text: '관리이력'	, columntype: 'textbox', datafield: 'REMARKS_CP'	, cellsalign: 'left', align: 'center'},
 	{ text: '설비관리PK', columntype: 'textbox', datafield: 'EQUIPMENT_DETAIL_PK_CP',		hidden: true },
	{ text: 'CHK'	, columntype: 'textbox', datafield: 'CHK'	, hidden: true }
];

//행추가 ROW 설정
var generaterow2 = function (i) {  
    var row = {};
    row["CD_V_CP"] = ""; 
    row["CD_NM_CP"] = "";
    row["CD_TP_CP"] = $("#pCdTp").val();
    row["ATTR1_CP"] = "";
    row["ATTR2_CP"] = "";
    row["ATTR3_CP"] = "";
    row["ATTR4_CP"] = "";
    
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
	
	if($("#pEquipCode").val() == ""){
		alert("설비코드를 입력하세요.");
		$("#pEquipCode").focus();
		return;
	}
	
	if($("#pEquipName").val() == ""){
		alert("설비명를 입력하세요.");
		$("#pEquipName").focus();
		return;
	}
	
	if($("#pEquipName").val() == ""){
		alert("설비명를 입력하세요.");
		$("#pEquipName").focus();
		return;
	}

	
	if(!confirm("저장하시겠습니까?")) return;
  
  	//로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	
  
	for(var i=0;i<rowindexes2.length;i++)
	{
		$('#grid2').jqxGrid('setcellvalue', rowindexes2[i], "CHK", "1");
	}
  	
  	var rows = $('#grid').jqxGrid('getrows');
	var rows2 = $('#grid2').jqxGrid('getrows');
	
	$("#gridData").val(JSON.stringify(rows));
	$("#gridData2").val(JSON.stringify(rows2));
	
	$.ajax({
      url: "/CPMES/CPMES_UI430_save.do",
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
          
			fn_search("/CPMES/CPMES_UI430_main_search.do", "grid", setColumn, "100%");
          	
			fn_search("/CPMES/CPMES_UI430_detail_search.do", "grid2", setColumn2,"100%");
			
			// 신규입력이면 설비코드가 존재하지 않으므로 grid에서 비교해서 넣어준다.
			if($('#pEquipmentPk').val() == "")
			{
				var gridrows = $('#grid').jqxGrid('getrows');
				
				for(i=0; i<gridrows.length; i++){
					
					var EQUIPMENT_PK = $('#grid').jqxGrid('getcellvalue', i, "EQUIPMENT_PK_CP");
				    var EQUIP_CODE = $('#grid').jqxGrid('getcellvalue', i, "EQUIP_CODE_CP");
				    var EQUIP_NAME = $('#grid').jqxGrid('getcellvalue', i, "EQUIP_NAME_CP");
					
				    var txtEquipCode = $('#pEquipCode').val();
				    var txtEquipName = $('#pEquipName').val();
				    
				    if(EQUIP_CODE == txtEquipCode && EQUIP_NAME == txtEquipName){
				    	$('#pEquipmentPk').val(EQUIPMENT_PK_CP);
				    	break;
				    }
					
				}
				
			}
			
		}
	});
};


//신규
var fn_new = function()
{
	// 설비정보 리셋
	$('#pEquipmentPk').val("");	// 설비코드PK
	$('#pEquipCode').val("");	// 설비코드
	$('#pInstallDate').val("<%=pNowDt%>");	// 설치일
	$('#pEquipName').val("");	// 설비명
	$('#pManager').val("");	// 관리자
	$('#pMaker').val("");	// 제조사
	$('#pEquipAccount').val("");	// 설비금액
	$('#pSupplier').val("");	// 납품사
	$('#pCalibartionYn').val("");	// 검교정여부
	$('#pSupplyDate').val("<%=pNowDt%>");	// 납품일
	$('#pUseYn').val("");	// 사용여부
	$('#pNote').val("");	// 비고
	$("input:checkbox[id='pCalibartionYn']").prop("checked", true);
	$("input:checkbox[id='pUseYn']").prop("checked", true);
	
	// 설비이력 리셋
	setGrid("grid2", "",setColumn2, "100%");
};

// 메인삭제
var fn_del = function(grid_id)
{
	//저장 전 체크 
	if($('#pEquipmentPk').val() == ""){
		alert("설비를 선택해주세요");
		return;
	}
	
	if(!confirm("삭제하시겠습니까?")) return;
  
  	//로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
		
	$.ajax({
      url: "/CPMES/CPMES_UI430_main_delete.do",
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
          
          fn_new();
          
          $('#grid').jqxGrid('clearselection');
          $('#grid2').jqxGrid('clearselection');
          
          fn_search("/CPMES/CPMES_UI430_main_search.do", "grid", setColumn, "100%");
        	
		  fn_search("/CPMES/CPMES_UI430_detail_search.do", "grid2", setColumn2,"100%");
          
          
		}
	});
	
	
};

//행삭제
var fn_del2 = function(grid_id)
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
	}
	
	if(rowindexes.length==0 )
	{
		alert("삭제 할 항목이 없습니다.");
		return;
	}
	
	if(!confirm("설비이력을 삭제하시겠습니까?")) return;
  
  //로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	
    var rows = $('#' + grid_id).jqxGrid('getrows');
	
	$("#gridData2").val(JSON.stringify(rows));
		
	$.ajax({
      url: "/CPMES/CPMES_UI430_detail_delete.do",
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
          
          //$('#grid').jqxGrid('clearselection');
          $('#grid2').jqxGrid('clearselection');
          
          //fn_search("/CPMES/CPMES_UI430_main_search.do", "grid", setColumn, "100%");
        	
		  fn_search("/CPMES/CPMES_UI430_detail_search.do", "grid2", setColumn2,"100%");
          
          
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
					<h3 class="tit">설비관리</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
						<a href="#n" class="btn1" id="btnNew" style="display: inline-block;">신규</a>
						<a href="#n" class="btn1" id="btnSave" style="display: inline-block;">저장</a>
						<a href="#n" class="btn1" id="btnDelete" style="display: inline-block;">삭제</a>
					</div>
				</div>
				
				<div class="inner p_10" style="height:100%">		
					<section class="section-search">
						<form1>
							<div class="form-row">
								
								<div class="col">
									<label for="">설비명</label>
									<input type="text" id="pSearchEquipName" name="pSearchEquipName" value="" class="form-control" style="width:200px;"> 
								</div>
								
							</div>
		
							
						</form1>
					</section>
            		<div style="height:5px;"></div>
            		
            		<div id="mainSplitter">
		                <div class="splitter-panel">
		                	<!-- left -->
		                	<div id="grid"></div>
		                </div>
		                <div class="splitter-panel">
		                	<!-- right -->
		                	<section class="section-search">
							<form1>
								<div class="form-row">
								<table class="type-a" id="table">
									<colgroup>
										<col style="width:15%;">
										<col style="width:35%;">
										<col style="width:15%;">
										<col style="width:35%;">
									</colgroup>
									<tbody>
										<tr>
											<th>설비코드</th>
											<td>
												<input type="text" style="width:100%;" id="pEquipCode" name="pEquipCode" class="form-control">
												<input type="hidden" id="pEquipmentPk" name="pEquipmentPk">
											</td>
											<th>설치일</th>
											<td>
												<div class="col">	
													<input type="text" name="pInstallDate" id="pInstallDate"  value="" class="form-control" style="width:120px;" >
													<button type="button" class="date_ico" id ="fa-calendar1" >달력</button>
												</div>
											</td>
										</tr>
										<tr>
											<th>설비명</th>
											<td>
												<input type="text" style="width:100%;" id="pEquipName" name="pEquipName" class="form-control">
											</td>
											<th>관리자</th>
											<td>
												<input type="text" style="width:100%;" id="pManager" name="pManager" class="form-control">
											</td>
										</tr>
										<tr>
											<th>제조사</th>
											<td>
												<input type="text" style="width:100%;" id="pMaker" name="pMaker" class="form-control">
											</td>
											<th>설비금액</th>
											<td>
												<input type="text" style="width:100%;" id="pEquipAccount" name="pEquipAccount" class="form-control">
											</td>
										</tr>
										<tr>
											<th>납품사</th>
											<td>
												<input type="text" style="width:100%;" id="pSupplier" name="pSupplier" class="form-control">
											</td>
											<th>검교정여부</th>
											<td>
												<input type="checkbox" id="pCalibartionYn" name="pCalibartionYn" value="Y" >
											</td>
										</tr>
										<tr>
											<th>납품일</th>
											<td>
												<div class="col">	
													<input type="text" name="pSupplyDate" id="pSupplyDate"  value="" class="form-control" style="width:120px;" >
													<button type="button" class="date_ico" id ="fa-calendar2" >달력</button>
												</div>
											</td>
											<th>사용여부</th>
											<td>
												<input type="checkbox" id="pUseYn" name="pUseYn" value="Y" >
											</td>
										</tr>
										<tr>
											<th>비고</th>
											<td colspan="3">
												<input type="text" name="pNote" id="pNote"  value="" class="form-control" style="width:100%;" >
											</td>
										</tr>
									</tbody>
								</table>
								</div>
							</form1>
							</section>
							<div style="text-align: right;padding:5px;">
								<a href="#n" class="btn_search" id="btnAddRow2">행추가</a>
								<a href="#n" class="btn_search" id="btnDelRow2">삭제</a>
							</div>
							<div id="inner_grid" class="con_list mtable" style="height:calc(100% - 317px);">		
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
