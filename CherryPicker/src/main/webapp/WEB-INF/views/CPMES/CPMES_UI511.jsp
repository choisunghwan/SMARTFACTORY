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

Object objComboaccountTp = request.getAttribute("accountTp");

//그리드 콤보관련 데이터 변경 
String comboaccountString = CommonUtils.JqgridComboString1(objComboaccountTp, "CD_V_CP", "CD_NM_CP");

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
	
	
	/*버튼 이벤트*/
	//조회버튼
	$('#btnSearch').click(function () {
		fn_search("/CPMES/CPMES_UI510_search.do", "grid",setColumn,"100%");
	});
	
	//저장
	$('#btnSel').click(function () {
		returnData();
	});
	
	/*버튼 이벤트 끝*/
	
	/*그리드 초기화*/
	setGrid("grid", "",setColumn,"100%");
	/*그리드 초기화 끝*/
	/*그리드 이벤트*/
	
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

//그리드 콤보관련 시작                    
var accountTp1 = <%=comboaccountString%>;

var accountTpSource =
{
     datatype: "array",
     datafields: [
    	 { name: 'CD_V_CP', type: 'string' },
         { name: 'CD_NM_CP', type: 'string' }
     ],
     localdata: accountTp1
}; 
var accountTpAdapter = new $.jqx.dataAdapter(accountTpSource, {
    autoBind: true
});
 
//그리드 콤보관련 끝 

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
	{ text: '구분'			, columntype: 'combobox', datafield: 'CUSTOMER_GUBUN_CP', displayfield: 'CUSTOMER_GUBUN_NM_CP', cellsalign: 'center', align: 'center', width: 60 , editable:false}, 
	{ text: '거래처명'			, columntype: 'textbox', datafield: 'CUSTOMER_NAME_CP'	, cellsalign: 'left',   align: 'center',  width: 230 , editable:false},
	{ text: '사업자번호'		, columntype: 'textbox', datafield: 'REG_NO_CP'		, cellsalign: 'center', align: 'center',  width: 180 , editable:false},
	{ text: '대표자명'			, columntype: 'textbox', datafield: 'CEO_NAME_CP'		, cellsalign: 'center', align: 'center',  width: 80 , editable:false},
	{ text: 'TEL'			, columntype: 'textbox', datafield: 'TEL_NO_CP'		, cellsalign: 'center', align: 'center',  width: 120 , editable:false},
	{ text: 'HP'			, columntype: 'textbox', datafield: 'FAX_NO_CP'		, cellsalign: 'center', align: 'center',  width: 120 , editable:false},
	{ text: '주소'			, columntype: 'textbox', datafield: 'ADDRESS_CP'		, cellsalign: 'left',   align: 'center',  editable:false},
	{ text: 'CUSTOMER_PK_CP'	, columntype: 'textbox', datafield: 'CUSTOMER_PK_CP'	, hidden: true },
	{ text: 'CHK'	, columntype: 'textbox', datafield: 'CHK'	, hidden: true }
];
  
/*그리드 설정 끝*/

function returnData(){
	
	var rowindexes = $('#grid').jqxGrid('getselectedrowindexes');
	
	var rows = "";
	var cdtpCnt = 0;
	var cdNmCnt = 0;
	
	if(rowindexes.length>1)
	{
		alert("한 업체만 선택하여 주십시요.");
		return;
	}	
	
	var pArr = new Array();
	
	pArr[0] = $("#grid").jqxGrid('getcellvalue', rowindexes[0], "CUSTOMER_PK_CP");
	pArr[1] = $("#grid").jqxGrid('getcellvalue', rowindexes[0], "CUSTOMER_NAME_CP");;
	
	if(window.opener.returnValue)
		window.opener.returnValue(pArr);
		
	window.close();
	
}

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
					<h3 class="tit">거래처관리</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
						<a href="#n" class="btn1" id="btnSel" style="display: inline-block;">선택</a>
					</div>
				</div>
				
				<div class="inner p_10" style="height:100%">		
					<section class="section-search">
						<form1>
							<div class="form-row">
								<div class="col">
									<label for="">분류</label>
									<select class="form-control"  name = "pCustomerGubun" id = "pCustomerGubun">
										<option value="" selected>전체</option>
										<c:forEach items="${accountTp}" var="accountTp">
										<option value="${accountTp.CD_V_CP}">${accountTp.CD_NM_CP}</option>
										</c:forEach>
									</select>
								</div>
								
								<div class="col">
									<label for="">거래처명</label>
									<input type="text" id="pCustomerName" name="pCustomerName" value="" class="form-control" style="width:120px;"> 
								</div>
								
							</div>
						</form1>
					</section>
            		<div style="height:5px;"></div>
					<div id="inner_grid" class="con_list mtable" style="height:calc(100% - 140px);">		
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
