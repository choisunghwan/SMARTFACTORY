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

Object objComboaccountTp = request.getAttribute("accountTp");

//그리드 콤보관련 데이터 변경 
String comboaccountString = CommonUtils.JqgridComboString1(objComboaccountTp, "CD_V", "CD_NM");

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
		fn_search("/PSMES/PSMES_UI510_search.do", "grid",setColumn,"80%");
	});
	/*선택 추가*/
	$('#btnSelect').click(function () {
		//그리드에서 선택된 Row값 확인
		var rowindexes = $('#grid').jqxGrid('getselectedrowindexes');
		
		var rows = "";
		var cdtpCnt = 0;
		var cdNmCnt = 0;
		
		for(var i=0;i<rowindexes.length;i++)
		{

			var customName = $('#grid').jqxGrid('getcellvalue', rowindexes[i], "CUSTOMER_NAME");
			var customPk = $('#grid').jqxGrid('getcellvalue', rowindexes[i], "CUSTOMER_PK");
			//rows += $("#grid").jqxGrid('getrowdata', i);
		}
		
		if(rowindexes.length==0 )
		{
			alert("선택된 항목이 없습니다.");
			return;
		}
		

	  //로딩이미지 오픈
		$('#jqxLoader').jqxLoader('open');
	  
		var rows = $('#grid').jqxGrid('getrows');
	  //부모창으로 값 전달
		$("#pCompanyName", opener.document).val(customName);
		$("#pCompanyCode", opener.document).val(customPk);
		window.close();
	});
	
	
	
	
	
	/*버튼 이벤트 끝*/
	
	/*그리드 초기화*/
	setGrid("grid", "",setColumn,"80%");
	/*그리드 초기화 끝*/
	/*그리드 이벤트*/
	$('#grid').on('cellclick', function (event) {
		var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = args.rowindex;
	    
	    if(args.datafield == "CD_NM")
		{
			var value = $('#grid').jqxGrid('getcellvalue', rowBoundIndex, "CD_V");
			
			if(value != null && value !="")
			{
				$("#pCdTp").val("");
				$("#pCdTp").val(value);
				
				
				//사용일자 클릭 시 원료사용 상세정보로 이동
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

//그리드 콤보관련 시작                    
var accountTp1 = <%=comboaccountString%>;

var accountTpSource =
{
     datatype: "array",
     datafields: [
    	 { name: 'CD_V', type: 'string' },
         { name: 'CD_NM', type: 'string' }
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
	{ text: '구분'			, columntype: 'combobox', datafield: 'CUSTOMER_GUBUN', displayfield: 'CUSTOMER_GUBUN_NM'		, cellsalign: 'center', align: 'center', width: '8%' ,
		createeditor: function (row, value, editor) {
            editor.jqxComboBox({ source: accountTpAdapter, displayMember: 'CD_NM', valueMember: 'CD_V' });
       }
	}, 
	{ text: '거래처명'			, columntype: 'textbox', datafield: 'CUSTOMER_NAME'	, cellsalign: 'center', align: 'center',  width: '25%' },
	{ text: '사업자번호'		, columntype: 'textbox', datafield: 'REG_NO'		, cellsalign: 'center', align: 'center',  width: '15%' },
	{ text: '대표자명'			, columntype: 'textbox', datafield: 'CEO_NAME'		, cellsalign: 'center', align: 'center',  width: '8%' },
	{ text: '주소'			, columntype: 'textbox', datafield: 'ADDRESS'		, cellsalign: 'center', align: 'center'},
	{ text: 'CUSTOMER_PK'	, columntype: 'textbox', datafield: 'CUSTOMER_PK'	, hidden: true },
	{ text: 'CHK'	, columntype: 'textbox', datafield: 'CHK'	, hidden: true }
];
  

/*그리드 설정 끝*/
 


/*사용자 함수 */


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
						<a href="#n" class="btn1" id="btnSelect" style="display: inline-block;">선택</a>
						
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
									<label for="">분류</label>
									<select class="form-control"  name = "pCustomerGubun" id = "pCustomerGubun">
										<option value="" selected>전체</option>
										<c:forEach items="${accountTp}" var="accountTp">
										<option value="${accountTp.CD_V}">${accountTp.CD_NM}</option>
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
					<div id="inner_grid" class="con_list mtable" style="height:85%">		
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
