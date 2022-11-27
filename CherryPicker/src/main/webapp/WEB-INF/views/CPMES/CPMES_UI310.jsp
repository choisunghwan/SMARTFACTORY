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

String programId = request.getParameter("programId");

if(programId ==null) programId ="";

%>

<!DOCTYPE HTML>
<html lang="ko">  
<head>
<meta charset="utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta http-equive="Content-Style-Type" content="text/css"/>
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>DCU CherryPicker</title>

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
	$('#P_ORDER_DATE_CP').datepicker({
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
	
	$('#FIXED_DATE_CP').datepicker({
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
	
	$('#STOCK_DATE_CP').datepicker({
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
	    $("#P_ORDER_DATE_CP").focus();
	});
	
	$('#fa-calendar1').click(function() {
	    $("#FIXED_DATE_CP").focus();
	});
	
	$('#fa-calendar2').click(function() {
	    $("#STOCK_DATE_CP").focus();
	});
	
	/*버튼 이벤트*/
	//조회버튼
	$('#btnSearch').click(function () {
		if($("#P_ORDER_PK_CP").val() == ""){
			$("#btnReload").show();
			alert("신규등록 및 발주목록에서 선택후 조회 해주세요.");
			return;
		}
		fn_searchMas ();
	});
	
	//저장
	$('#btnSave').click(function () {
		fn_save();
	});
	
	//신규
	$('#btnReload').click(function () {
		 
		$("#P_ORDER_NO_CP").val("");
        $("#P_ORDER_PK_CP").val("");
        $("#P_ORDER_NAME_CP").val("");
        $("#COMPANY_CODE_NM_CP").val("");
        $("#COMPANY_CODE_CP").val("");
        $("#P_ORDER_DATE_CP").val("");
        $("#FIXED_DATE_CP").val("");
        $("#STOCK_DATE_CP").val("");
        $("#STAND_YN_CP").val("");
        $("#ESTIMATED_COST_CP").val("");
        $("#FINAL_COST_CP").val("");
        $("#R_ORDER_NO_CP").val("");
        $("#FINAL_COST_CP").val("");
        $("#R_ORDER_NAME_CP").val("");
        $("#REMARKS_CP").val("");
		
		$('#grid').jqxGrid('clearselection');
      
		setGrid("grid", "",setColumn,"100%");
		
		//location.reload();
	});
	
	//삭제
	$('#btnDelRow').click(function () {
		fn_rowdel("grid");
	});
	
	$('#btnBalju').click(function () {
		fn_reportView();
	});
	
	
	//삭제
	$('#btnDel').click(function () {
		fn_del("grid");
	});
	
	
	//행추가
	$('#btnAddRow').click(function () {
		var datarow = generaterow();
	    var commit = $("#grid").jqxGrid('addrow', null, datarow);
	    
	});
	
	//행추가
	$('#fa-calendar3').click(function () {
		var url = '/CPMES/CPMES_UI511.do';
		
		showPopup(url, 'CPMES_UI511', 1240, 700, /*center*/ 1, '', '', /*status*/ 0, /*scroll*/ 0, /*resize*/ 0, /*menubar*/ 0, /*toolbar*/ 0, /*locat*/ 0, /*fullscreen*/ 0);
	    
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
	    
	    if(args.datafield == "CD_NM_CP")
		{
			var value = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "CD_V_CP");
			
			if(value != null && value !="")
			{
				$("#pCdTp").val("");
				$("#pCdTp").val(value);
				
				$('#grid2').jqxGrid('clearselection');
				
				//사용일자 클릭 시 원료사용 상세정보로 이동
				fn_search("/CPMES/CPMES_UI530_searchDet.do", "grid2",setColumn2,"100%");	
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
	    	
	    	if(!isEmpty($("#grid").jqxGrid('getcellvalue', rowBoundIndex, "UNIT_COST_CP")))
	    	{
	    		unitCost = $("#grid").jqxGrid('getcellvalue', rowBoundIndex, "UNIT_COST_CP");  
	    	}
	    	   
	    	$("#grid").jqxGrid('setcellvalue', rowBoundIndex, "SUM_COST_CP", Number(unitCost) * Number(amount));
	    	
	    	$("#grid").jqxGrid('endcelledit', rowBoundIndex, "SUM_COST_CP", true);
	    	
	    	fn_estimateSet();
	    }
	    
	});
	  
	
	/*발주목록에서 넘어오면 조회*/
	if($("#programId").val() !="" && ($("#programId").val() == "CPMES_UI320" || $("#programId").val() == "CPMES_UI330"))
	{
		var param1 = $('#param1', parent.document).val();	// 수주PK
		//var param1 = $('#param1').val();
		$('#P_ORDER_PK_CP').val(param1);
		
		fn_searchMas();
		if(!isEmpty($("#P_ORDER_PK_CP").val()))
		{
			$("#btnReload").show();
		}	
	}	
	
	if(!isEmpty($("#programId").val()) !="" && $("#programId").val() == "CPMES_UI210")
	{
		$('#grid').jqxGrid('clearselection');
		
		//main 에서 gridData 정보 가져옴
		var rows = $('#gridData', parent.document).val();
		
		var param1 = $('#param1', parent.document).val();	// 수주PK
		var param2 = $('#param2', parent.document).val();	// 수주No
		var param3 = $('#param3', parent.document).val();	// 수주명
		
		var prows = JSON.parse(rows);
		
		var gridArray = new Array();
		
		for(var i=0;i< prows.length;i++)
		{
			if(prows[i].CHK == "1")
			{  
				var rowsdata = new Object();
				
				rowsdata.P_PRODUCT_NO_CP =  prows[i].PRODUCT_NO_CP;
				rowsdata.P_PRODUCT_NAME_CP =  prows[i].PRODUCT_NAME_CP;
				rowsdata.P_STANDARD_CP =  prows[i].R_STANDARD_CP;
				rowsdata.UNIT_COST_CP =  prows[i].UNIT_COST_CP;
				rowsdata.AMOUNT_CP =  prows[i].AMOUNT_CP;
				rowsdata.SUM_COST_CP =  prows[i].SUM_COST_CP;
				rowsdata.R_ORDER_DETAIL_PK_CP =  prows[i].R_ORDER_DETAIL_PK_CP;
				//rowsdata.R_ORDER_DETAIL_PK_CP =  prows[i].R_ORDER_DETAIL_PK_CP;
				
				gridArray.push(rowsdata);
			}	
			   
		}
		
		rows = JSON.stringify(gridArray);
		
		setGrid("grid",  rows,setColumn,"100%");
		
		var rowCount = $('#grid').jqxGrid('getrows').length;
		
		$("#grid").jqxGrid('beginupdate');
		for(var i=0;i<rowCount;i++)
		{
			$("#grid").jqxGrid('selectrow', i);
		} 
		$("#grid").jqxGrid('endupdate');
		
		fn_estimateSet();
		
// 		var param1 = $('#param1').val();
// 		var param2 = $('#param2').val();
// 		var param3 = $('#param3').val();
		
		$('#R_ORDER_PK_CP').val(param1);
		$('#R_ORDER_NO_CP').val(param2);
		$('#R_ORDER_NAME_CP').val(param3);
		
		
		
	}
	//
	
// 	$('#FINAL_COST_CP').keyup(function () {

// 		var finalcost = $(this).val();

// 		$("#FINAL_COST_CP").val(addComma(finalcost));
// 	});
	
});



$( window ).resize( function() {
	
} );

//메인 SEARCH
function fn_searchMas() {
	
	//로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	//여기서 조회 이벤트 발생 
	url = "/CPMES/CPMES_UI310_searchMas.do";
	
	$.ajax({
        url: url ,
        dataType: 'json',
        data : $("#form1").serialize(),
		//data : param,
        type : 'POST',
        async: false,
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
            //setGrid(pGrid_id, data.response, pSetColumn, pHeight);
            $("#P_ORDER_NO_CP").val(data.response[0].P_ORDER_NO_CP);
            $("#P_ORDER_PK_CP").val(data.response[0].P_ORDER_PK_CP);
            $("#P_ORDER_NAME_CP").val(data.response[0].P_ORDER_NAME_CP);
            $("#COMPANY_CODE_NM_CP").val(data.response[0].COMPANY_CODE_NM_CP);
            $("#COMPANY_CODE_CP").val(data.response[0].COMPANY_CODE_CP);
            $("#P_ORDER_DATE_CP").val(data.response[0].P_ORDER_DATE_CP);
            $("#FIXED_DATE_CP").val(data.response[0].FIXED_DATE_CP);
            $("#STOCK_DATE_CP").val(data.response[0].STOCK_DATE_CP);
            $("#STAND_YN_CP").val(data.response[0].STAND_YN_CP);
            $("#ESTIMATED_COST_CP").val(data.response[0].ESTIMATED_COST_CP);
            $("#FINAL_COST_CP").val(data.response[0].FINAL_COST_CP);
            $("#R_ORDER_NO_CP").val(data.response[0].R_ORDER_NO_CP);
            $("#FINAL_COST_CP").val(data.response[0].FINAL_COST_CP);
            $("#R_ORDER_NAME_CP").val(data.response[0].R_ORDER_NAME_CP);
            $("#REMARKS_CP").val(data.response[0].REMARKS_CP);
            
            $('#jqxLoader').jqxLoader('close');
            
            $("#ESTIMATED_COST_CP").val(addComma($("#ESTIMATED_COST_CP").val()));
            $("#FINAL_COST_CP").val(addComma($("#FINAL_COST_CP").val()));
            
            $("#R_ORDER_NO_CP").val(data.response[0].R_ORDER_NO_CP);
            $("#R_ORDER_NAME_CP").val(data.response[0].R_ORDER_NAME_CP);
            
            
            fn_search("/CPMES/CPMES_UI310_searchDet.do", "grid",setColumn,"100%");
            
		}
	});
}; 


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
 	
 		$("#ESTIMATED_COST_CP").val(addComma(sumCost));
 	}
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
	     datafield: '', columntype: 'number', width: 50,
	     cellsrenderer: function (row, column, value) {
	         return "<div style='margin:7px;text-align:center'>" + (value + 1) + "</div>";
	     }
 	}, 
	{ text: '품번'		, columntype: 'textbox'		, datafield: 'P_PRODUCT_NO_CP'		, cellsalign: 'center', align: 'center',  width: '100' },
	{ text: '품명'		, columntype: 'textbox'		, datafield: 'P_PRODUCT_NAME_CP'	, cellsalign: 'left', align: 'center',  width: '200' },
	{ text: '규격'		, columntype: 'textbox'		, datafield: 'P_STANDARD_CP'		, cellsalign: 'left', align: 'center',  width: '200' },
	{ text: '단가'		, columntype: 'numberinput'		, datafield: 'UNIT_COST_CP'	, cellsalign: 'right' , align: 'center',  width: '150', cellsformat: 'D'
		, createeditor: function (row, cellvalue, editor) {
            editor.jqxNumberInput({min: 0, decimalDigits: 0, digits: 10 });
        }	
	},
	{ text: '수량'		, columntype: 'numberinput'		, datafield: 'AMOUNT_CP'	, cellsalign: 'right' , align: 'center',  width: '150', cellsformat: 'D'
		, createeditor: function (row, cellvalue, editor) {
            editor.jqxNumberInput({min: 0, decimalDigits: 0, digits: 10 });
        }	
	},
	{ text: '공급가액'		, columntype: 'numberinput'		, datafield: 'SUM_COST_CP'	, cellsalign: 'right' , align: 'center',  width: '150', cellsformat: 'D', editable:false
		, createeditor: function (row, cellvalue, editor) {
            editor.jqxNumberInput({min: 0, decimalDigits: 0, digits: 10 });
        }	
	},

	{ text: '비고'		, columntype: 'textbox'		, datafield: 'NOTE_CP'				, cellsalign: 'left', align: 'center' },
	{ text: '발주PK'		, columntype: 'textbox'		, datafield: 'P_ORDER_PK_CP'	, hidden: true},
	{ text: '발주상세PK'	, columntype: 'textbox'		, datafield: 'P_ORDER_DETAIL_PK_CP', hidden: true},
	{ text: '수주상세PK'	, columntype: 'textbox'		, datafield: 'R_ORDER_DETAIL_PK_CP', hidden: true},
	{ text: 'CHK'		, columntype: 'textbox'		, datafield: 'CHK' , hidden: true}
	  
];
    
//행추가 ROW 설정
var generaterow = function (i) {    
    var row = {};
    row["P_ORDER_PK_CP"] = $("#P_ORDER_PK_CP").val(); 
    row["P_PRODUCT_NO_CP"] = "";
    row["P_PRODUCT_NAME_CP"] = "";
    row["UNIT_COST_CP"] = "0";
    row["AMOUNT_CP"] = "0";
    row["SUM_COST_CP"] = "0";
    row["NOTE_CP"] = "";
    row["P_ORDER_DETAIL_PK_CP"] = "";
    row["R_ORDER_DETAIL_PK_CP"] = ""; 
    
    return row;
}

/*그리드 설정 끝*/
/*사용자 함수 */
var fn_save = function () {
  //저장 전 체크 
	var rowindexes = $('#grid').jqxGrid('getselectedrowindexes');
	
	var rows = "";
	
	for(var i=0;i<rowindexes.length;i++)
	{
		$("#grid").jqxGrid('setcellvalue', rowindexes[i], "CHK", "1");
	}
	
	if(isEmpty($("#P_ORDER_NO_CP").val()))
	{
		alert("발주번호를 입력하여 주십시요.");
		return;
	}	
	
	
	if(!confirm("저장하시겠습니까?")) return;
  
	if(!isEmpty($("#STOCK_DATE_CP").val()))
	{
		$("#ORDER_TP_CP").val("O02");
	}
	else
	{
		$("#ORDER_TP_CP").val("O01");
	}	
		
  	//로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	
  	var rows = $('#grid').jqxGrid('getrows');
	
	$("#gridData").val(JSON.stringify(rows));
		
	$.ajax({
      url: "/CPMES/CPMES_UI310_save.do",
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
          
			fn_searchMas();
			
			if(!isEmpty($("#P_ORDER_PK_CP").val()))
			{
				$("#btnReload").show();
			}
			
			
		}
	});
};


//삭제 

//삭제
var fn_del = function(grid_id)
{
	
	if(!confirm("삭제하시겠습니까?")) return;
	  
    //로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	
	var rows = $('#' + grid_id).jqxGrid('getrows');
	
	$("#gridData").val(JSON.stringify(rows));
		
	$.ajax({
      url: "/CPMES/CPMES_UI310_delete.do",
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
          
			setGrid("grid", "",setColumn,"100%");
			
			location.reload();
			
// 			$("#P_ORDER_NO_CP").val("");
//             $("#P_ORDER_PK_CP").val("");
//             $("#P_ORDER_NAME_CP").val("");
//             $("#COMPANY_CODE_NM_CP").val("");
//             $("#COMPANY_CODE_CP").val("");
//             $("#P_ORDER_DATE_CP").val("");
//             $("#FIXED_DATE_CP").val("");
//             $("#STOCK_DATE_CP").val("");
//             $("#STAND_YN_CP").val("");
//             $("#ESTIMATED_COST_CP").val("");
//             $("#FINAL_COST_CP").val("");
//             $("#R_ORDER_NO_CP").val("");
//             $("#FINAL_COST_CP").val("");
//             $("#R_ORDER_NAME_CP").val("");
//             $("#REMARKS_CP").val("");
            
			
			
			//fn_search("/CPMES/CPMES_UI310_searchDet.do", "grid",setColumn,"100%");
			
		}
	});
	
};

//행삭제
var fn_rowdel = function(grid_id)
{
	
	
	//저장 전 체크 
	var rowindexes = $('#' + grid_id).jqxGrid('getselectedrowindexes');
	
	var rows = "";
	var delCnt = 0;
	var nonedelCnt = 0;
	var delrows = [];
	if(rowindexes.length==0 )
	{
		alert("삭제 할 항목이 없습니다.");
		return;
	}
	
	for(var i=0;i<rowindexes.length;i++)
	{
		$('#grid').jqxGrid('setcellvalue', rowindexes[i], "CHK", "1");
		
		
		if($('#grid').jqxGrid('getcellvalue', rowindexes[i], "P_ORDER_DETAIL_PK_CP") == "")
		{
			delrows[i] = rowindexes[i];
			nonedelCnt++;
		}
		else if($('#grid').jqxGrid('getcellvalue', rowindexes[i], "P_ORDER_DETAIL_PK_CP") != "")
		{
			delCnt++;  
		}	
	}
	
	for(var j=0;j<delrows.length;j++)
	{
		$('#grid').jqxGrid('deleterow', delrows[i]);
	}
	
	if(nonedelCnt>0 && delCnt ==0)
	{
		alert("삭제 하였습니다.");
		return;
	}	
	else if(delCnt >0) 
	{
		if(!confirm("삭제하시겠습니까?")) return;
		  
	    //로딩이미지 오픈
		$('#jqxLoader').jqxLoader('open');
		
		var rows = $('#' + grid_id).jqxGrid('getrows');
		
		$("#gridData").val(JSON.stringify(rows));
			
		$.ajax({
	      url: "/CPMES/CPMES_UI310_row_del.do",
	      dataType: 'json',
	      data : $("#form1").serialize(),
			//data : param,
	      type : 'POST',
	      beforeSend: function (request) {
//	       	xmlHttpRequest.setRequestHeader("AJAX", "true");
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
	          
				fn_search("/CPMES/CPMES_UI310_searchDet.do", "grid",setColumn,"100%");
				
			}
		});
	}	
	
	
	
	
};
	
//업체정보 팝업 return 값
function returnValue(arr){
	$("#COMPANY_CODE_CP").val(arr[0]);
	$("#COMPANY_CODE_NM_CP").val(arr[1]);
} 
 
 
//report
function fn_reportView(){
	
	var loading = $('<div id="loading" class="loading"></div><img id="loading-image" alt="loading" src="/resources/image/ajax-loader.gif" />').appendTo(document.body).hide();
	
	loading.show();
	// PO_NO Check
	$.ajax({
		url : '/CPMES/CPMES_UI310_Report.do',
		type : 'post',
		data : {P_ORDER_PK_CP : $("#P_ORDER_PK_CP").val()},
		dataType : 'json',
		beforeSend :function(xmlHttpRequest){xmlHttpRequest.setRequestHeader("AJAX","true");},
		async: true,
		success : function(data) {
			
			if(data.pdfFileName != ""){
				loading.hide();
				windowOpen("/pdf/web/viewer.jsp?file=" + "/output/"+data.pdfFileName, "popup1", 1100, 700, "no");
			}
	  	},
	  	error : function(xhr, msg, statusMsg){
		  	loading.hide();
		  	if(xhr.status == "400")
	  		{
	  			
				alert("세션이 만료되었습니다. 현재창을 닫습니다. 다시 로그인 하여 주십시요. ");
	  			window.close();
	  		}
	  		else
	  		{
	  			alert(statusMsg);	
	  		}
 		}
	});
}

function windowOpen(url, wname, w, h, scrollbars){
	
	var agt = navigator.userAgent.toLowerCase();
	var left = 0;
	var top = 0;
	
	if (agt.indexOf("chrome") != -1){
		var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
	    var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
	 
	    var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
	    var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;
	 
	    left = ((width/2)-(w/2)) + dualScreenLeft;
	    top = ((height/2)-(h/2)) + dualScreenTop;

	}else{
		
		var sw=screen.availWidth;
		var sh=screen.availHeight;
		
		left=(sw-w)/2;
		top=(sh-h)/2;
	}
	
	var option = 'left='+left+',top='+top+',width='+w+',height='+h+',scrollbars='+scrollbars;
	
	window.open(url, wname, option);

}
 




</script>

<body>
<form id="form1" name="form1" style="height: 100%;">
<input type="hidden" id="pCdTp" name="pCdTp">
<input type="hidden" name="gridData" id="gridData" value="">
<input type="hidden" name="gridData2" id="gridData2" value="">
<input type="hidden" name="programId" id="programId" value="<%=programId%>">
<input type="hidden" name="ORDER_TP_CP" id="ORDER_TP_CP" value="">
<input type="hidden" name="R_ORDER_PK_CP" id="R_ORDER_PK_CP" value="">

<!-- #wrap -->
<div id="wrap" >

	<!-- #container -->
<!-- 	<div id="container">	 -->
		<!-- #side -->
		<!-- #content -->
		<div id="content" style="height:100%" id ="content">			
			<div class="content-inner hid" style="height:100%">
				<div class="inner_top">
					<h3 class="tit">발주등록및조회</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnBalju" style="display: inline-block;">발주서생성</a>
						<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
						<a href="#n" class="btn1" id="btnReload" style="display: inline-block;" >신규</a>
						<a href="#n" class="btn1" id="btnSave" style="display: inline-block;">저장</a>
						<a href="#n" class="btn1" id="btnDel" style="display: inline-block;">삭제</a>
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
											<th>발주번호</th>
											<td>
												<input type="text" style="width:100%;" class="form-control" id="P_ORDER_NO_CP" name="P_ORDER_NO_CP" value="">
												<input type="hidden" id="P_ORDER_PK_CP" name="P_ORDER_PK_CP" value="">
											</td> 
											<th>발주명</th>
											<td colspan="3">
												<input type="text" style="width:100%;" class="form-control" id="P_ORDER_NAME_CP" name="P_ORDER_NAME_CP">
											</td>
											<th>업체명</th>  
											<td>
												<div class="col">	
													<input type="text" name="COMPANY_CODE_NM_CP" id="COMPANY_CODE_NM_CP"  value="" class="form-control" style="width:100%;" >													
													<input type="hidden" name="COMPANY_CODE_CP" id="COMPANY_CODE_CP"  value="" class="form-control" style="width:120px;" >
													<button type="button" class="search_ico" id ="fa-calendar3" style="text-indent:-99999px; width: 30px;height: 33px;padding: 4px 0 0;position: absolute; right: 22px;top: 15px;cursor: pointer;" >돋보기</button>

												</div>  
											</td>
										</tr>
										<tr>
											<th>발주일</th>
											<td>
												<div class="col">	
													<input type="text" name="P_ORDER_DATE_CP" id="P_ORDER_DATE_CP"  value="<%=pSearchEndDt %>" class="form-control" style="width:120px;" >
													<button type="button" class="date_ico" id ="fa-calendar" >달력</button>
												</div>
											</td>
											<th>납기일</th>
											<td>
												<div class="col">	
													<input type="text" name="FIXED_DATE_CP" id="FIXED_DATE_CP"  value="" class="form-control" style="width:120px;" >
													<button type="button" class="date_ico" id ="fa-calendar1" >달력</button>
												</div>
											</td>
											<th>입고일</th>
											<td>
												<div class="col">	
													<input type="text" name="STOCK_DATE_CP" id="STOCK_DATE_CP"  value="" class="form-control" style="width:120px;" >
													<button type="button" class="date_ico" id ="fa-calendar2" >달력</button>
												</div>
											</td>
											<th>일반구매</th>
											<td>
												<select class="form-control"  name = "STAND_YN_CP" id = "STAND_YN_CP" style="width:100%;">
													<option value="Y">Y</option>
													<option value="N" selected>N</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>견적가</th>
											<td>
												<input type="text" style="width:100%;" class="form-control" id="ESTIMATED_COST_CP" name="ESTIMATED_COST_CP" readonly>
											</td>
											<th>결정가</th>
											<td>
												<input type="text" style="width:100%;" class="form-control" id="FINAL_COST_CP" name="FINAL_COST_CP">
											</td>
											<th>수주번호</th>
											<td>
												<input type="text" style="width:100%;" class="form-control" id="R_ORDER_NO_CP" name="R_ORDER_NO_CP">
												
											</td>
											<th>수주명</th>
											<td>
												<input type="text" style="width:100%;" class="form-control" id="R_ORDER_NAME_CP" name="R_ORDER_NAME_CP">
											</td>
										</tr>
										<tr>
											<th>특이사항</th>
											<td colspan="7">
												<input type="text" style="width:100%;" class="form-control" id="REMARKS_CP" name="REMARKS_CP">
											</td>
										</tr>
									</tbody>
								</table>
								
							</div>
		
							
						</form1>
					</section>
            		<div style="text-align: right;padding:5px;">
						<a href="#n" class="btn_search" id="btnAddRow">행추가</a>
						<a href="#n" class="btn_search" id="btnDelRow">삭제</a>
					</div>
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
