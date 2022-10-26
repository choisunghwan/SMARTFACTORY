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
		fn_search("/CPMES/CPMES_UI510_search.do", "grid",setColumn,"100%");
	});
	
	$('#btntest').click(function () {
		var rows = $('#grid').jqxGrid('getrows');
		
		$("#gridData").val(JSON.stringify(rows));
		
		window.parent.addTabNewLoad('/CPMES/CPMES_UI520.do', '사원정보관리', $("#gridData").val());
		
	});
	
	
	
	//저장
	$('#btnSave').click(function () {
		fn_save();
	});
	
	//신규
	$('#btnAddRow').click(function () {
		var datarow = generaterow();
		     
		var commit = $("#grid").jqxGrid('addrow', null, datarow);
		
		var rows = $('#grid').jqxGrid('getrows');
		
		$('#grid').jqxGrid('ensurerowvisible', rows.length-1);
		 
	});  
	
	//삭제
	$('#btnDelRow').click(function () {
		fn_del("grid");
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
	{ text: '구분'			, columntype: 'combobox', datafield: 'CUSTOMER_GUBUN_CP', displayfield: 'CUSTOMER_GUBUN_NM_CP'		, cellsalign: 'center', align: 'center', width: 70 ,
		createeditor: function (row, value, editor) {
            editor.jqxComboBox({ source: accountTpAdapter, displayMember: 'CD_NM_CP', valueMember: 'CD_V_CP' });
       }
	}, 
	{ text: '거래처명'			, columntype: 'textbox', datafield: 'CUSTOMER_NAME_CP'	, cellsalign: 'left'  , align: 'center',  width: 300 },
	{ text: '사업자번호'		, columntype: 'textbox', datafield: 'REG_NO_CP'		, cellsalign: 'center', align: 'center',  width: 150 },
	{ text: '대표자명'			, columntype: 'textbox', datafield: 'CEO_NAME_CP'		, cellsalign: 'center', align: 'center',  width: 120 },
	{ text: 'TEL'			, columntype: 'textbox', datafield: 'TEL_NO_CP'		, cellsalign: 'center', align: 'center',  width: 130 },
	{ text: 'HP'			, columntype: 'textbox', datafield: 'FAX_NO_CP'		, cellsalign: 'center', align: 'center',  width: 130 },
	{ text: '주소'			, columntype: 'textbox', datafield: 'ADDRESS_CP'		, cellsalign: 'center', align: 'center',  width: 300 },
	{ text: '비고'			, columntype: 'textbox', datafield: 'REMARKS_CP'		, cellsalign: 'left', align: 'center' },
	{ text: 'CUSTOMER_PK_CP'	, columntype: 'textbox', datafield: 'CUSTOMER_PK_CP'	, hidden: true },
	{ text: 'CHK'	, columntype: 'textbox', datafield: 'CHK'	, hidden: true }
];
  


//행추가 ROW 설정
var generaterow = function (i) {  
    var row = {};
    row["CUSTOMER_GUBUN_CP"] = ""; 
    row["CUSTOMER_NAME_CP"] = "";
    row["REG_NO_CP"] = "";
    row["CEO_NAME_CP"] = "";
    row["TEL_NO_CP"] = "";
    row["FAX_NO_CP"] = "";
    row["ADDRESS_CP"] = "";
    row["REMARKS_CP"] = "";
    
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
	
// 	if(cdtpCnt>0 )
// 	{
// 		alert("코드분류를 입력하여 주십시요.");
// 		return;
// 	}
	
// 	if(cdtpCnt2>0)
// 	{
// 		alert("코드종류를 입력하여 주십시요.");
// 		return;
// 	}
	
// 	if(cdNmCnt>0)
// 	{
// 		alert("코드명칭을 입력하여 주십시요.");
// 		return;
// 	}
	
	if(!confirm("저장하시겠습니까?")) return;
  
  //로딩이미지 오픈
	$('#jqxLoader').jqxLoader('open');
	
  	var rows = $('#grid').jqxGrid('getrows');
	
	$("#gridData").val(JSON.stringify(rows));
		
	$.ajax({
      url: "/CPMES/CPMES_UI510_save.do",
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
          
			fn_search("/CPMES/CPMES_UI510_search.do", "grid",setColumn,"100%");
          
			
		}
	});
};


 

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
      url: "/CPMES/CPMES_UI510_del.do",
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
          
			fn_search("/CPMES/CPMES_UI510_search.do", "grid",setColumn,"80%");
          
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
					<h3 class="tit">거래처관리</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
<!-- 						<a href="#n" class="btn1" id="btntest" style="display: inline-block;">test</a> -->
						<a href="#n" class="btn1" id="btnAddRow" style="display: inline-block;">신규</a>
						<a href="#n" class="btn1" id="btnSave" style="display: inline-block;">저장</a>
						<a href="#n" class="btn1" id="btnDelRow" style="display: inline-block;">삭제</a>
						
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
