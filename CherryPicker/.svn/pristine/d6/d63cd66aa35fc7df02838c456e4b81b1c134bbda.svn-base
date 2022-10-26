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

String pSearchStaDt = CommonUtils.currenDate();
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
	
	$('#mainSplitter').jqxSplitter({ width: 'calc(100% - 2px)', height: 'calc(100% - 170px)',  panels: [{ size: 230}] });
	
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
		fn_search("/PSMES/PSMES_UI620_searchuser.do", "grid",setColumn,"100%");
		setGrid("grid2", "",setColumn2,"100%");
	});
	
	
	/*버튼 이벤트 끝*/
	
	/*그리드 초기화*/
	setGrid("grid", "",setColumn,"100%");
	setGrid("grid2", "",setColumn2,"100%");
	/*그리드 초기화 끝*/
	
	/*그리드 이벤트*/
	$('#grid').on('cellclick', function (event) {
		var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = args.rowindex;
	    
	    
	    if(args.datafield == "USER_NAME")
		{
			var value = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "USER_ID");
			
			if(value != null && value !="")
			{
				$("#pUserId").val("");
				$("#pUserId").val(value);
				
				$('#grid2').jqxGrid('clearselection');
				
				//사용일자 클릭 시 원료사용 상세정보로 이동
				fn_search("/PSMES/PSMES_UI620_searchList.do", "grid2",setColumn2,"100%");	
			}
			
		}
	});
	
	
	/*그리드 이벤트 끝*/
	
	$('#btnSearch').click();
	 
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
	{ text: '작업자명'	, columntype: 'textbox', datafield: 'USER_NAME'	, cellsalign: 'center', align: 'center',  width: 150 ,  cellsrenderer: cellsrenderer, editable: false },
// 	{ text: '명칭'	, columntype: 'textbox', datafield: 'CD_NM'	, cellsalign: 'center', align: 'center',  cellsrenderer: cellsrenderer},
	{ text: 'USER_ID'	, columntype: 'textbox', datafield: 'USER_ID'	, hidden: true },
	{ text: 'CHK'	, columntype: 'textbox', datafield: 'CHK'	, hidden: true }
];
  


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
 	{ text: '수주번호'	, columntype: 'textbox', datafield: 'R_ORDER_NO'		, cellsalign: 'center', align: 'center', width: 150, editable: false },	
 	{ text: '수주명'	, columntype: 'textbox', datafield: 'R_ORDER_NAME'		, cellsalign: 'center', align: 'center', editable: false },
	{ text: '품번'	, columntype: 'textbox', datafield: 'PRODUCT_NO'		, cellsalign: 'center', align: 'center', width: 120, editable: false },
	{ text: '품명'	, columntype: 'textbox', datafield: 'PRODUCT_NAME'		, cellsalign: 'center', align: 'center', width: 120, editable: false },
	{ text: '작업구분'	, columntype: 'textbox', datafield: 'WORK_STATUS'		, cellsalign: 'center', align: 'center', width: 120, editable: false },
	{ text: '계획일자'	, columntype: 'textbox', datafield: 'P1_PLAN_DATE'		, cellsalign: 'center', align: 'center', width: 100, editable: false },
	{ text: '시작일자'	, columntype: 'textbox', datafield: 'P1_WORK_START_DATE', cellsalign: 'center', align: 'center', width: 100, editable: false },
	{ text: '완료일자'	, columntype: 'textbox', datafield: 'P1_WORK_END_DATE'	, cellsalign: 'center', align: 'center', width: 100, editable: false },
	{ text: 'CHK'	, columntype: 'textbox', datafield: 'CHK'	, hidden: true }
];
 

</script>

<body>
<form id="form1" name="form1" style="height: 100%;">
<input type="hidden" id="pUserId" name="pUserId">
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
					<h3 class="tit">생산계획대비실적</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
					</div>
				</div>
				
				<div class="inner p_10" style="height:100%">		
					<section class="section-search">
						<form1>
							<div class="form-row">

								<div class="col">
									<label for="">완료일자</label>
									<input type="text" name="pSearchStaDt" id="pSearchStaDt"  value="<%=pSearchStaDt %>" class="form-control" style="width:120px;" >
									<button type="button" class="date_ico" id ="fa-calendar" >달력</button>
								</div>
								
								
							</div>
		
							
						</form1>
					</section>
            		<div style="height:5px;"></div>
            		
            		<div id="mainSplitter">
		                <div class="splitter-panel">
		                	<!-- left -->
		                	<div id="inner_grid" class="con_list mtable" style="height:calc(100% - 5px);">		
					           	<div id="grid"></div>
					     	</div>
		                </div>
		                <div class="splitter-panel">
		                	
							<div id="inner_grid" class="con_list mtable" style="height:calc(100% - 5px);">		
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
