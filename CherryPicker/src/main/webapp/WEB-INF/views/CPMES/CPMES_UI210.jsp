<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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

String param1 = request.getParameter("param1");	
String programId = request.getParameter("programId");

if(programId ==null) programId ="";
if(param1 ==null) param1 ="";
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

<!-- 화면별 공통 사항 include -->	
<%@ include file="/resources/js/include-header.jspf" %>	

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
	$('#pROrderDate').datepicker({
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
	
	$('#pFixedDate').datepicker({
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
	
	$('#pShippingDate').datepicker({
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
	    $("#pROrderDate").focus();
	});
	
	$('#fa-calendar1').click(function() {
	    $("#pFixedDate").focus();
	});
	
	$('#fa-calendar2').click(function() {
	    $("#pShippingDate").focus();
	});
	//달력 이미지 클릭 시 처리 완료
	
	/*버튼 이벤트*/
	//조회버튼
	$('#btnSearch').click(function () {
		
		if($('#pROrderPk').val() == ""){
			console.log("무선택 조회");
			alert("신규등록 및 수주목록에서 선택후 조회 해주세요.");
			return;
		}
		//메인화면 조회
		fn_main_search();
	});
	
	//저장버튼 이벤트
	$('#btnSave').click(function () {
		fn_Main_save();
	});

	//삭제버튼 이벤트
	$('#btnDel').click(function () {
		fn_del("grid");
	});
	
	//신규버튼 이벤트
	$('#btnReload').click(function () {
		
		$("#pROrderPk").val("");
    	$("#pROrderNo").val("");
    	$("#pROrderName").val("");
    	$("#pCompanyCode").val("");
    	$("#pCompanyName").val("");
    	$("#pROrderDate").val("");
    	$("#pFixedDate").val("");
    	$("#pShippingDate").val("");
    	$("#pEstimatedCost").val("");
    	$("#pGeneralCost").val("");
    	$("#pFinalCost").val("");
    	$("#pRemarks").val("");
    	$("#pNationTp").val("");
    	$("#pSalesTp").val("");
    	$("#pOutsourcingCost").val("");
		
		$('#grid').jqxGrid('clearselection');
      
		//그리드 설정 초기화 함수 
		//common.js 에 선언 되어 있음
		setGrid("grid", "",setColumn,"100%");
		
	});
	
	//행삭제 버튼 이벤트
	$('#btnDelRow').click(function () {
		fn_delRow("grid");
	});
	
	//엑셀 버튼 이벤트
	$('#btnExcel').click(function () {
		$("#grid").jqxGrid('exportdata', 'xlsx', '견적샘플');
	});
	
	//파일업로드 버튼 이벤트
	$('#btnUpload').click(function () {
		$('#uploadfile').click();
	});
	
	// 파일이 첨부되면 실행됨.
	$("#uploadfile").change(function(){
		const fileInput = $("#uploadfile")[0];
	  	// 파일을 여러개 선택할 수 있으므로 files 라는 객체에 담긴다.
	  	//console.log("uploadfile: ", fileInput.files)

		if(fileInput.files.length === 0){
			alert("파일은 선택해주세요");
		   	return;
		}
	  	
	  	const formData = new FormData();
	  	formData.append("input_file", fileInput.files[0]);

	  	//로딩이미지 오픈
		$('#jqxLoader').jqxLoader('open');
	  	
	  	$.ajax({
	    	type:"POST",
	    	url: "/CPMES/CPMES_UI210_excel_upload.do",
	    	processData: false,
	    	contentType: false,
	    	data: formData,
	    	success: function(data){
	    		$('#jqxLoader').jqxLoader('close');
	    		
	    		setGrid("grid", data.excellist, setColumn,"100%");
	    		
	    		var rowCount = $('#grid').jqxGrid('getrows').length;
	    		
	    		$("#grid").jqxGrid('beginupdate');
	    		for(var i=0;i<rowCount;i++)
	    		{
	    			$("#grid").jqxGrid('selectrow', i);
	    		} 
	    		$("#grid").jqxGrid('endupdate');
	    		
 	      		//console.log("## CPMES_UI210_excel_upload data: ", data)

	    	},
	    	err: function(err){
	    		$('#jqxLoader').jqxLoader('close');
	    		console.log("err:", err)
	    	}
	  	});
	});
	
	
	//행추가
	$('#btnAddRow').click(function () {
		//수주번호가 있거나 수주PK번호가 있을경우에만 행추가
		if($('#pROrderNo').val() == "" && $('#pROrderPk').val() =="" ){
			alert("수주번호가 없습니다.");
			return;
		}
		else{
			var datarow = generaterow();
		    var commit = $("#grid").jqxGrid('addrow', null, datarow);
		}
	    
	});

	//업체 선택
	$('#selectCompanyBtn').click(function () {
		//alert("업체 선택");
		//업체 선택 popup
		//showPopup("/CPMES/CPMES_UI211.do", "selectCompanyPopup", "900", "600", "yes", "", "", "yes", "yes", "yes");
		var url = '/CPMES/CPMES_UI511.do';
		showPopup(url, 'CPMES_UI511', 1240, 700, /*center*/ 1, '', '', /*status*/ 0, /*scroll*/ 0, /*resize*/ 0, /*menubar*/ 0, /*toolbar*/ 0, /*locat*/ 0, /*fullscreen*/ 0);
	});
	
	//업체 선택
	$('#btnAttch').click(function () {
		//alert("업체 선택");
		//업체 선택 popup
		showPopup("/CPMES/CPMES_UI214.do?pROrderPk=" + $("#pROrderPk").val(), "selectAttchFilePopup", "910", "600", "yes", "", "", "yes", "yes", "yes");
	});
	
	
    $('#btnfileUp').click(function (e) {
       // e.preventDefault();
        //$('#input_file').click();

		if($('#pROrderNo').val() == "" && $('#pROrderPk').val() =="" ){
			alert("수주번호가 없습니다.");
			return;
		}
		showPopup("/CPMES/CPMES_UI213.do?pROrderPk="+$('#pROrderPk').val(), "dwgFilePopup", "900", "600", "yes", "", "", "yes", "yes", "yes");
    });

    //외주발주
	$('#btn1').click(function () {
		
		if($("#pROrderPk").val() == ""){
			alert("수주정보를 저장후 외주발주를 진행하세요.");
			retrun;
		}
		
		if($("#pSalesTp").val() == "S01"){
			alert("견적->수주단계로 상태변경 후 진행하세요.");
			retrun;
		}
		
		if($("#pSalesTp").val() == "S03" || $("#pSalesTp").val() == "S04" || $("#pSalesTp").val() == "S05"){
			alert("수주상태가 아닙니다.");
			retrun;
		}
		
		var rowindexes = $('#grid').jqxGrid('getselectedrowindexes');
		var rows = "";
		//detail PK 값이 없으면 넘기면 안됨
		var rpkCnt = "";
		for(var i=0;i<rowindexes.length;i++)
		{
			$("#grid").jqxGrid('setcellvalue', rowindexes[i], "CHK", "1");
			
			if(isEmpty($("#grid").jqxGrid('getcellvalue', i, "R_ORDER_DETAIL_PK_CP")))
			{
				rpkCnt++;
			}
		}  
		
		if(rpkCnt>0)
		{
			alert("저장되지 않은 품번이 있습니다. \n 저장 후 외주 발주하여 주십시요.");
			return;
		}
		
		rows =  $('#grid').jqxGrid('getrows');
		
		var value1 = $("#pROrderPk").val();
		var value2 = $("#pROrderNo").val();
		var value3 = $("#pROrderName").val();
		  
		if(value1 != null && value1 !="")
		{
			window.parent.addTabNewLoad('/CPMES/CPMES_UI310.do?programId=CPMES_UI210', '발주 등록 및 조회', JSON.stringify(rows), value1, value2, value3,'','');
		}
		
	});
	
	//작업지시
	$('#btn2').click(function () {
		
		if($("#pROrderPk").val() == ""){
			alert("수주정보를 저장후 작업지시를 진행하세요.");
			retrun;
		}
		
		if($("#pSalesTp").val() == "S01"){
			alert("견적->수주단계로 상태변경 후 진행하세요.");
			retrun;
		}
		
		var rowindexes = $('#grid').jqxGrid('getselectedrowindexes');
		var rows = "";
		//detail PK 값이 없으면 넘기면 안됨
		var rpkCnt = "";
		for(var i=0;i<rowindexes.length;i++)
		{
			$("#grid").jqxGrid('setcellvalue', rowindexes[i], "CHK", "1");
			
			if(isEmpty($("#grid").jqxGrid('getcellvalue', i, "R_ORDER_DETAIL_PK_CP")))
			{
				rpkCnt++;
			}
		}  
		
		if(rpkCnt>0)
		{
			alert("저장되지 않은 품명이 있습니다. \n 저장 후 작업지시하여 주십시요.");
			return;
		}
		
		rows =  $('#grid').jqxGrid('getrows');
		
		var value1 = $("#pROrderPk").val();
		var value2 = $("#pROrderNo").val();
		var value3 = $("#pROrderName").val();
		var value4 = $("#pROrderDate").val();
		var value5 = $("#pFixedDate").val();
		
		if(value1 != null && value1 !="")
		{
			window.parent.addTabNewLoad('/CPMES/CPMES_UI410.do?programId=CPMES_UI210', '작업지시', JSON.stringify(rows), value1, value2, value3, value4,value5);
		}
		else
		{
			alert("저장 후 작업지시하여 주십시요.");	
		}
		
	});
    
	/*버튼 이벤트 끝*/
	
	/*그리드 초기화*/
	setGrid("grid", "",setColumn,"100%");
	/*그리드 초기화 끝*/
	
	/*그리드 이벤트*/
	$('#grid').on('cellclick', function (event) {
		var args = event.args;
	    var dataField = event.args.datafield;
	    // row's bound index.
	    var rowBoundIndex = args.rowindex;
	    
	    if(dataField == "DRAWING_FILE_CP")
	    {  
	    	if($("#grid").jqxGrid('getcellvalue', rowBoundIndex, "DRAWING_FILE_CP") != "" ){
		    	location.href = "/CPMES/CPMES_UI210_FileDown.do?filePath="+$('#pROrderPk').val()+"&fileName="+$("#grid").jqxGrid('getcellvalue', rowBoundIndex, "DRAWING_FILE_CP");
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
	    
	    var unitCost = 0;
	    var amount = 0;
	    
	    if(dataField == "UNIT_COST_CP")
	    {
	    	unitCost = args.value;
	    	if(!isEmpty($("#grid").jqxGrid('getcellvalue', rowBoundIndex, "AMOUNT_CP")))
	    	{
	    		amount = $("#grid").jqxGrid('getcellvalue', rowBoundIndex, "AMOUNT_CP");
	    	}
	    	
	    	$("#grid").jqxGrid('setcellvalue', rowBoundIndex, "SUM_COST_CP", Number(unitCost) * Number(amount));
	    	
	    	$("#grid").jqxGrid('endcelledit', rowBoundIndex, "SUM_COST_CP", true);
	    	
	    	fn_estimateSet();
	    }	
	    
	    if(dataField == "AMOUNT_CP")
	    {  
	    	amount = args.value;
	    	
	    	if(!isEmpty($("#grid").jqxGrid('getcellvalue', rowBoundIndex, "UNIT_COST_CP_CP")))
	    	{
	    		unitCost = $("#grid").jqxGrid('getcellvalue', rowBoundIndex, "UNIT_COST_CP_CP");  
	    	}
	    	   
	    	$("#grid").jqxGrid('setcellvalue', rowBoundIndex, "SUM_COST_CP", Number(unitCost) * Number(amount));
	    	
	    	$("#grid").jqxGrid('endcelledit', rowBoundIndex, "SUM_COST_CP", true);
	    	
	    	fn_estimateSet();
	    }

	});
	
	// 그리드 cell change 이벤트
	$('#grid').on('cellvaluechanged', function (event) {
		var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = args.rowindex;
	    if(args.datafield == "UNIT_COST_CP" || args.datafield == "AMOUNT_CP")
		{
			var unitCost = nvl($('#grid').jqxGrid('getcellvalue', rowBoundIndex, "UNIT_COST_CP"),0);
			var amount = nvl($('#grid').jqxGrid('getcellvalue', rowBoundIndex, "AMOUNT_CP"),0);

			$('#grid').jqxGrid('setcellvalue', rowBoundIndex, "SUM_COST_CP", unitCost*amount );
		}else if(args.datafield == "OUT_YN_CP"){
			if($('#grid').jqxGrid('getcellvalue', rowBoundIndex, "OUT_YN_CP") == "Y"){
				$('#grid').jqxGrid('setcellvalue', rowBoundIndex, "SELF_YN_CP", "N" );
			}else{
				$('#grid').jqxGrid('setcellvalue', rowBoundIndex, "SELF_YN_CP", "Y" );
			}
		}else if(args.datafield == "SELF_YN_CP"){
			if($('#grid').jqxGrid('getcellvalue', rowBoundIndex, "SELF_YN_CP") == "Y"){
				$('#grid').jqxGrid('setcellvalue', rowBoundIndex, "OUT_YN_CP", "N" );
			}else{
				$('#grid').jqxGrid('setcellvalue', rowBoundIndex, "OUT_YN_CP", "Y" );
			}
		}
	});
	
	//그리드 값 변경 완료 시 이벤트
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

	/*발주목록에서 넘어오면 조회*/
	if(!isEmpty($("#programId").val()))
	{
		fn_main_search();
	}
	    
	
});



/*그리드 설정 */
//그리드 링크 항목 처리
var cellsrenderer = function (row, columnfield, value, defaulthtml, columnproperties) {

	var formattedValue = value;

	var scan = "<div class='jqx-grid-cell-middle-align' style='margin-top:9px;color:blue;cursor:pointer;text-decoration:underline;'>" + formattedValue + " </div>";
                         
 	return scan;
}



//그리드 콤보관련 시작                    
var outYn = [{CD_V_CP:"Y",CD_NM_CP:"Y"},{CD_V_CP:"N",CD_NM_CP:"N"}];

var outYnSource =
{
   datatype: "array",
   datafields: [
  	 { name: 'CD_V_CP', type: 'string' },
       { name: 'CD_NM_CP', type: 'string' }
   ],
   localdata: outYn
}; 
var outYnAdapter = new $.jqx.dataAdapter(outYnSource, {
  autoBind: true
});

var selfYn = [{CD_V_CP:"Y",CD_NM_CP:"Y"},{CD_V_CP:"N",CD_NM_CP:"N"}];

var selfYnSource =
{
   datatype: "array",
   datafields: [
  	 { name: 'CD_V_CP', type: 'string' },
       { name: 'CD_NM_CP', type: 'string' }
   ],
   localdata: selfYn
}; 
var selfYnAdapter = new $.jqx.dataAdapter(selfYnSource, {
  autoBind: true
});
//그리드 컬럼 셋팅
var setColumn = [
	{
	     text: '순번', sortable: false, filterable: false, editable: false, align: 'center', cellsalign: 'center', exportable: true, 
	     groupable: false, draggable: false, resizable: false,
	     datafield: '', columntype: 'number', width: 50,
	     cellsrenderer: function (row, column, value) {
	         return "<div style='margin:7px;text-align:center'>" + (value + 1) + "</div>";
	     }
 	},
	{ text: '품번'	, columntype: 'textbox'		, datafield: 'PRODUCT_NO_CP'	, cellsalign: 'center', align: 'center',  width: 100, exportable: true },
	{ text: '품명'	, columntype: 'textbox'		, datafield: 'PRODUCT_NAME_CP'	, cellsalign: 'left', align: 'center',  width: 200, exportable: true },
	{ text: '규격'	, columntype: 'textbox'		, datafield: 'R_STANDARD_CP'	, cellsalign: 'left', align: 'center',  width: 200, exportable: true },
	{ text: '단가'	, columntype: 'numberinput'	, datafield: 'UNIT_COST_CP'	, cellsalign: 'right', align: 'center',  width: 150, cellsformat: 'D', exportable: true,
		createeditor: function (row, cellvalue, editor) {
            editor.jqxNumberInput({min: 0, decimalDigits: 0, digits: 10 });
        }	 },
	{ text: '수량'	, columntype: 'numberinput'	, datafield: 'AMOUNT_CP'	, cellsalign: 'center', align: 'center',  width: 80, cellsformat: 'D', exportable: true,
		createeditor: function (row, cellvalue, editor) {
            editor.jqxNumberInput({min: 0, decimalDigits: 0, digits: 10 });
        }	 },
	{ text: '금액'	, columntype: 'numberinput'	, datafield: 'SUM_COST_CP'	, cellsalign: 'right', align: 'center',  width: 150, cellsformat: 'D',editable: false , exportable: true},
	{ text: '외주'	, columntype: 'textbox'	, datafield: 'OUT_YN_CP}'	, cellsalign: 'center', align: 'center',  width: 200, editable: false, exportable: false },
// 	{ text: '외주'	, columntype: 'combobox'	, datafield: 'OUT_YN'	, cellsalign: 'center', align: 'center', width: 100,
// 		createeditor: function (row, value, editor) {
//             editor.jqxComboBox({ source: outYnAdapter, displayMember: 'CD_NM', valueMember: 'CD_V', promptText: "선택"});
//        }
// 	}, 
	{ text: '자체제작'	, columntype: 'combobox'	, datafield: 'SELF_YN_CP', displayfield: 'SELF_YN_CP'		, cellsalign: 'center', align: 'center', width: 100, exportable: false, hidden: true,
		createeditor: function (row, value, editor) {
            editor.jqxComboBox({ source: selfYnAdapter, displayMember: 'CD_NM_CP', valueMember: 'CD_V_CP', promptText: "선택"});
       }
	}, 
	{ text: '도면'	, columntype: 'textbox'		, datafield: 'DRAWING_FILE_CP'	, cellsalign: 'center', align: 'center',  width: 200, editable:false,  cellsrenderer: cellsrenderer, exportable: false },
	{ text: '비고'	, columntype: 'textbox'		, datafield: 'NOTE_CP'	, cellsalign: 'left', align: 'center', exportable: true },
	{ text: 'R_ORDER_DETAIL_PK_CP'	, columntype: 'textbox', datafield: 'R_ORDER_DETAIL_PK_CP'	, hidden: true, exportable: false },
	{ text: 'CHK'	, columntype: 'textbox'		, datafield: 'CHK'	, hidden: true, exportable: false }
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


var fn_estimateSet = function()
{
	var rows = $('#grid').jqxGrid('getrows');
     
 	if(rows.length>0)
 	{ 
 		var sumCost =0;  
 	
 		
 		for(var i=0;i<rows.length;i++)  
	    {  
 			if(!isEmpty($("#grid").jqxGrid('getcellvalue', i, "SUM_COST_CP")))
 			{
 				sumCost += $("#grid").jqxGrid('getcellvalue', i, "SUM_COST_CP");	  
 			}
 			   
	    }	   
  		$("#pEstimatedCost").val(addComma(sumCost));
 	}
}


var fn_Main_save = function () {
  
	//저장 전 체크 
	if($("#pROrderNo").val() == ""){
		alert("수주번호를 입력하세요.");
		$("#pROrderNo").focus();
		return;
	}
	
	if($("#pROrderName").val() == ""){
		alert("수주명을 입력하세요.");
		$("#pROrderName").focus();
		return;
	}
    	
	var rowindexes = $('#grid').jqxGrid('getselectedrowindexes');

	for(var i=0;i<rowindexes.length;i++)
	{
		$("#grid").jqxGrid('setcellvalue', rowindexes[i], "CHK", "1");
	}
	var rows = "";
  //로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');

	
  	var rows = $('#grid').jqxGrid('getrows');

	$("#gridData").val(JSON.stringify(rows));
	
	if(!confirm("저장하시겠습니까?")) return;
	$.ajax({
      url: "/CPMES/CPMES_UI210_Main_save.do",
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

			$('#pROrderPk').val(data.sROrderPk);  
			
			$('#grid').jqxGrid('clearselection');
          
			//재조회
			alert("저장 하였습니다.");

			fn_main_search();
		}
	});
};


//삭제
var fn_del = function()
{
	//PK가 존재하지 않으면 reload
	if($('#pROrderPk').val() == ""){
		location.reload();
		return;
	}
	if(!confirm("삭제하시겠습니까?")) return;

	//로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');

	$.ajax({
    url: "/CPMES/CPMES_UI210_delete.do",
    dataType: 'json',
    data : $("#form1").serialize(),
		//data : param,
    type : 'POST',
    beforeSend: function (request) {
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

			location.reload();
			$('#grid').jqxGrid('clearselection');
			
		}
	});
};


//삭제
var fn_delRow = function(grid_id)
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
      url: "/CPMES/CPMES_UI210_delRow.do",
      dataType: 'json',
      data : $("#form1").serialize(),
		//data : param,
      type : 'POST',
      beforeSend: function (request) {
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
          
			fn_main_search();
          
			$("#pCdTp").val("");
			
		}
	});
	
	
};
	
//마스터 정보 조회
function fn_main_search () {
	
	//로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	
	pUrl = "/CPMES/CPMES_UI210_searchMas.do";
	
	$.ajax({
        url: pUrl ,
        dataType: 'json',
        data : $("#form1").serialize(),
		//data : param,
        type : 'POST',
        beforeSend: function (request) {
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
        	$("#pROrderPk").val(data.MastInfo.R_ORDER_PK_CP);
        	$("#pROrderNo").val(data.MastInfo.R_ORDER_NO_CP);
        	$("#pROrderName").val(data.MastInfo.R_ORDER_NAME_CP);
        	$("#pCompanyCode").val(data.MastInfo.COMPANY_CODE_CP);
        	$("#pCompanyName").val(data.MastInfo.COMPANY_NAME_CP);
        	$("#pROrderDate").val(data.MastInfo.R_ORDER_DATE_CP);
        	$("#pFixedDate").val(data.MastInfo.FIXED_DATE_CP);
        	$("#pShippingDate").val(data.MastInfo.SHIPPING_DATE_CP);
        	$("#pEstimatedCost").val(data.MastInfo.ESTIMATED_COST_CP);
        	$("#pGeneralCost").val(data.MastInfo.GENERAL_COST_CP);
        	$("#pFinalCost").val(data.MastInfo.FINAL_COST_CP);
        	$("#pRemarks").val(data.MastInfo.REMARKS_CP);
        	$("#pNationTp").val(data.MastInfo.NATION_TP_CP);
        	$("#pSalesTp").val(data.MastInfo.SALES_TP_CP);
        	$("#pOutsourcingCost").val(data.MastInfo.OUTSOURCING_COST_CP);
        	
            setGrid("grid", data.DetailList, setColumn,"100%");
        	
			$('#jqxLoader').jqxLoader('close');
		}
	});
};   


//상세 정보 조회
function fn_detail_search () {
	//로딩이미지 오픈   
	$('#jqxLoader').jqxLoader('open');
	
	pUrl = "/CPMES/CPMES_UI210_searchDet.do";
	
	$.ajax({
        url: pUrl ,
        dataType: 'json',
        data : $("#form1").serialize(),
		//data : param,
        type : 'POST',
        beforeSend: function (request) {
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
            
            setGrid("grid", data.DetailList, setColumn,"100%");
        	
			$('#jqxLoader').jqxLoader('close');
		}
	});
};

//업체정보 팝업 return 값
function returnValue(arr){
	$("#pCompanyCode").val(arr[0]);
	$("#pCompanyName").val(arr[1]);
} 

</script>

<body>
<form id="form1" name="form1" style="height: 100%;">
<input type="hidden" id="pCdTp" name="pCdTp">
<input type="hidden" name="gridData" id="gridData" value="">
<input type="hidden" name="gridData2" id="gridData2" value="">
<input type="hidden" name="pROrderPk" id="pROrderPk" value="<%=param1%>">
<input type="hidden" name="programId" id="programId" value="<%=programId%>">
<!-- #wrap -->
<div id="wrap" >

	<!-- #container -->
		<!-- #side -->
		<!-- #content -->
		<div id="content" style="height:100%" id ="content">			
			<div class="content-inner hid" style="height:100%">
				<div class="inner_top">
					<h3 class="tit">수주등록및조회</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btn1" style="display: inline-block;">외주발주</a>
						<a href="#n" class="btn1" id="btn2" style="display: inline-block;">작업지시</a>
						<a href="#n" class="btn1" id="btnfileUp" style="display: inline-block;">도면등록</a>
						<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
						<a href="#n" class="btn1" id="btnReload" style="display: inline-block;">신규</a>
						<a href="#n" class="btn1" id="btnSave" style="display: inline-block;">저장</a>
						<a href="#n" class="btn1" id="btnDel" style="display: inline-block;">삭제</a>
					</div>
				</div>
				
				<div class="inner p_10" style="height:100%">		
					<section class="section-search">
						<form1>
							<div class="form-row">

								<table class="type-a" id="table">
									<colgroup>
										<col style="width:10%;">
										<col style="width:15%;">
										<col style="width:10%;">
										<col style="width:15%;">
										<col style="width:10%;">
										<col style="width:15%;">
										<col style="width:10%;">
										<col style="width:15%;">
									</colgroup>
									<tbody>
										<tr>
											<th>수주번호</th>
											<td>
												<input type="text" style="width:100%;" class="form-control" id="pROrderNo" name="pROrderNo">
											</td>
											<th>수주명</th>
											<td colspan="3">
												<input type="text" style="width:100%;" class="form-control" id="pROrderName" name="pROrderName">
											</td>
											<th>업체명</th>
											<td>
												<div class="col">	
													<input type="text" name="pCompanyName" id="pCompanyName"  value="" class="form-control" style="width:100%;" >
													<input type="hidden" name="pCompanyCode" id="pCompanyCode"  value="" >
													<button type="button" class="search_ico" id ="selectCompanyBtn" style="text-indent:-99999px; width: 30px;height: 33px;padding: 4px 0 0;position: absolute; right: 22px;top: 15px;cursor: pointer;" >돋보기</button>
												</div>
											</td>
										</tr>
										<tr>
											<th>수주일</th>
											<td>
												<div class="col">	
													<input type="text" name="pROrderDate" id="pROrderDate"  value="<%=pSearchStaDt %>" class="form-control" style="width:120px;" >
													<button type="button" class="date_ico" id ="fa-calendar" >달력</button>
												</div>
											</td>
											<th>납기일</th>
											<td>
												<div class="col">	
													<input type="text" name="pFixedDate" id="pFixedDate"  value="<%=pSearchStaDt %>" class="form-control" style="width:120px;" >
													<button type="button" class="date_ico" id ="fa-calendar1" >달력</button>
												</div>
											</td>
											<th>출하일</th>
											<td>
												<div class="col">	
													<input type="text" name="pShippingDate" id="pShippingDate"  value="" class="form-control" style="width:120px;" >
													<button type="button" class="date_ico" id ="fa-calendar2" >달력</button>
												</div>
											</td>
											<th>국내&수출</th>
											<td>
												<select class="form-control"  name = "pNationTp" id = "pNationTp">
													<c:forEach items="${nationTp}" var="nationTp">
													<option value="${nationTp.CD_V_CP}">${nationTp.CD_NM_CP}</option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th>견적가</th>
											<td>
												<input type="text" style="width:100%;text-align:right;" class="form-control" id="pEstimatedCost" name="pEstimatedCost" readonly="readonly">
											</td>
											<th>외주비용</th>
											<td>
												<input type="text" style="width:100%;text-align:right;" class="form-control" id="pOutsourcingCost" name="pOutsourcingCost" readonly="readonly">
											</td>
											<th>일반관리비</th>
											<td>
												<input type="text" style="width:100%;text-align:right;" class="form-control" id="pGeneralCost" name="pGeneralCost_">
											</td>
											<th>결정가</th>
											<td>
												<input type="text" style="width:100%;text-align:right;" class="form-control" id="pFinalCost" name="pFinalCost">
											</td>
										</tr>
										<tr>
											<th>상태</th>
											<td>
												<select class="form-control"  name = "pSalesTp" id = "pSalesTp">
													<c:forEach items="${salesTp}" var="salesTp">
													<option value="${salesTp.CD_V_CP}">${salesTp.CD_NM_CP}</option>
													</c:forEach>
												</select>
											</td>
											<th>특이사항</th>
											<td colspan="5">
												<input type="text" style="width:100%;" class="form-control" id="pRemarks" name="pRemarks">
											</td>
										</tr>
									</tbody>
								</table>
								
							</div>
		
							
						</form1>
					</section>
					<table style="width:100%">
						<tr>
							<td style="width:50%">
								<div style="text-align: left;padding:5px;">
			            			<a href="#n" class="btn_search" id="btnAttch">첨부파일</a>
								</div>			
							</td> 
							<td style="width:50%">
								<div style="text-align: right;padding:5px;">
            						<input type="file" name="uploadfile" id="uploadfile" accept="xls,xlsx" style="display:none;"/>
									<a href="#n" class="btn_search" id="btnUpload">업로드</a>
									<a href="#n" class="btn_search" id="btnAddRow">행추가</a>
									<a href="#n" class="btn_search" id="btnDelRow">삭제</a>
									<a href="#n" class="btn_search" id="btnExcel">엑셀다운로드</a>
								</div>
											
							</td>
						</tr>
					</table>
					
					
					<div id="inner_grid" class="con_list mtable" style="height:calc(100% - 343px);">		
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
