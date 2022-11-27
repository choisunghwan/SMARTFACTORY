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

//String programId = request.getParameter("programId");

//if(programId ==null) programId ="";

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
	
	//조회버튼
	$('#btnSearch').click(function () {
		fn_search("/CPMES/CPMES_UI730_search.do", "grid",setColumn,"100%");
		//setGrid("grid2", "",setColumn2,"100%");
	});
	
	// 파일 다운로드 링크.
	$("#btnDownload").click(function(){
		var popup = window.open('https://drive.google.com/file/d/1N_nlE-I67kOudovNRZmHgY9Zad-3lXMy/view?usp=share_link', '팝업', 'width=700px,height=800px,scrollbars=yes');
		
		return;
	});
	
	/*그리드 초기화*/
	setGrid("grid", "",setColumn,"100%");
	/*그리드 초기화 끝*/
	
	/*그리드 이벤트 끝*/
	 
	 
});

$( window ).resize( function() {
	
} );



/*그리드 설정 */
function setGrid (pGrid_id, pResponse, pSetColumn, pHeight, pSumChk)
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
    
    var bsumChk = false;
    if(pSumChk) bsumChk = true;
    
    
    $("#" + pGrid_id).jqxGrid(
	{
		width: '100%',
        height: pHeight,
		source: gridDataAdapter,   
		editable: true,
		selectionmode: 'singlecell',
        editmode: 'click',
//	 		selectionmode: 'singlecell',
//  		pageable: true,
// 			pagesize:15,
 		theme: 'energyblue',
//  		pagerbuttonscount: 10,
 		
//	 		pagesizeoptions:['15', '20', '50'],
	     	pagermode: 'simple',
//	     	pagesize:totalpage,
//			pagermode: 'material',
//		selectionmode: 'checkbox',
		
// 		pagerheight: 50,
		columnsresize: true,
		showrowlines:true,
		showcolumnlines: true,
		showcolumnheaderlines: true,	
		showstatusbar:bsumChk,
		statusbarheight:30,
		showaggregates:bsumChk,
		
 		columns: pSetColumn
		
	});
    
}
//그리드 링크 항목 처리

 
//그리드 콤보관련 끝 

//그리드 컬럼 셋팅
var setColumn = [
	{
	     text: '순번', sortable: false, filterable: false, editable: false, align: 'center', cellsalign: 'center',
	     groupable: false, draggable: false, resizable: false,
	     datafield: '', columntype: 'number', width: 80,
	     cellsrenderer: function (row, column, value) {
	         return "<div style='margin:7px;text-align:center'>" + (value + 1) + "</div>";
	     }
	},
	{ text: '시간'		, columntype: 'textbox', datafield: 'LOG_FIREDETECTTIME_CP'		, cellsalign: 'center', align: 'center',  width: 400, editable: false  },
	{ text: '장소'		, columntype: 'textbox', datafield: 'LOG_FIREDETECT_CONTENT_CP'		, cellsalign: 'center', align: 'center',  width: 300, editable: false  },
	/* { text: '총 수'		, columntype: 'textbox', datafield: 'LOG_FIREDETECT_COUNT_CP'		, cellsalign: 'center', align: 'center', editable: false  },
	{ text: 'CHK'		, columntype: 'textbox', datafield: 'CHK'	, hidden: true } */ 
];
 




</script>

<body>
<form id="form1" name="form1" style="height: 100%;">

<!-- #wrap -->
<div id="wrap" >

		<div id="content" style="height:100%" id ="content">			
			<div class="content-inner hid" style="height:100%">
				<div class="inner_top">
					<h3 class="tit">화재감지 로그</h3>
						<div class="top_btn">
							<a href="#n" class="btn1" id="btnDownload" style="display: inline-block;">다운로드</a>
							<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
						</div>
				</div>
				
				
				<div class="inner p_10" style="height:100%">		
					<section class="section-search">	
						<form1>
							<div class="form-row">
								<div class="col">
									<label for="">로그 확인 날짜</label>
									<input type="text" name="pSearchStaDt" id="pSearchStaDt"  value="<%=pSearchStaDt %>" class="form-control" style="width:120px;" >
									<button type="button" class="date_ico" id ="fa-calendar" >달력</button>
								</div>	
								<div class="col">
									<div class="divider">~ &nbsp;&nbsp; </div>
									<input type="text" name="pSearchEndDt"  id="pSearchEndDt" value="<%=pSearchEndDt %>" class="form-control" style="width:120px;" >
									<button type="button" class="date_ico" id ="fa-calendar1">달력</button>	
								</div>  
							</div>
						</form1>
					</section>
					
					
            		<div style="height:5px;"></div>
					<div id="inner_grid" class="con_list mtable" style="height:calc(100% - 170px);">		
			           	<div id="grid"></div>
			     	</div>           	
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
