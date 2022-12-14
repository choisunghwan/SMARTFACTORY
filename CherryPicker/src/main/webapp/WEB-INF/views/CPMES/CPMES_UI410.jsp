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
 
String param1 = request.getParameter("param1");
String param2 = request.getParameter("param2");
String param3 = request.getParameter("param3");
String programId = request.getParameter("programId");

if(programId ==null) programId ="";
if(param1 ==null) param1 ="";
if(param2 ==null) param2 ="";
if(param3 ==null) param3 ="";
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
	/*=========== ???????????? ============= */
	
	
	/*?????? ?????????*/
	//????????????
	$('#btnSearch').click(function () {
		//fn_search("/PSMES/PSMES_UI510_searchMas.do", "grid",setColumn,"100%");
	});
	
	//??????
	$('#btnSave').click(function () {
		fn_save();
	});
	
	/*?????? ????????? ???*/
	
	/*????????? ?????????*/
	setGridGroup("grid", "",setColumn, columngroups,"100%");
	/*????????? ????????? ???*/
	/*????????? ?????????*/
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
				
				
				//???????????? ?????? ??? ???????????? ??????????????? ??????
			}
			
		}
	});
	
	//????????? ??? ?????? ?????????
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
	
	/*????????? ????????? ???*/
	
	/*?????????????????? ???????????? ??????*/
	if($("#programId").val() !="" && ($("#programId").val() == "CPMES_UI320" || $("#programId").val() == "CPMES_UI330"))
	{
// 		fn_searchMas();
// 		if(!isEmpty($("#P_ORDER_PK").val()))
// 		{
// 			$("#btnReload").show();
// 		}	
	}
	
	// ???????????? ???????????? ????????? ????????????
	var comWorkDayArray = new Array();
	<c:forEach items="${WorkDayList}" var="WorkDayList">
		var rdata = new Object();	
		rdata.CD_V_CP = "${WorkDayList.CD_V_CP}";
		rdata.ATTR1_CP = "${WorkDayList.ATTR1_CP}";
		rdata.ATTR2_CP = "${WorkDayList.ATTR2_CP}";
		rdata.ATTR3_CP = "${WorkDayList.ATTR3_CP}";
		rdata.ATTR4_CP = "${WorkDayList.ATTR4_CP}";
		comWorkDayArray.push(rdata);
	</c:forEach>
	
	
	/*?????????????????? ???????????? ??????  */
	if(!isEmpty($("#programId").val()) !="" && $("#programId").val() == "CPMES_UI210")
	{
		$('#grid').jqxGrid('clearselection');
		
		//main ?????? gridData ?????? ?????????
		var rows = $('#gridData', parent.document).val();
		
		var param1 = $('#param1', parent.document).val();	// ??????PK
		var param2 = $('#param2', parent.document).val();	// ??????No
		var param3 = $('#param3', parent.document).val();	// ?????????
		var param4 = $('#param4', parent.document).val();	// ?????????
		var param5 = $('#param5', parent.document).val();	// ?????????
		$('#param1').val(param1);
		
		var prows = JSON.parse(rows);
		
		// ??????&???????????? ????????? ????????? ??????????????? ????????????????????? ?????????.
		var dt1 = new Date(param4);
		var dt2 = new Date(param5);
		var intervalDay = dt1.getInterval(dt2);
		
		var newObj = new Object();
		for(i=0;i<comWorkDayArray.length;i++){
			
			if( intervalDay <= parseInt(comWorkDayArray[i].CD_V_CP) ){
				newObj = comWorkDayArray[i]
				break;
			}
		}
		
		var workDay1 = dt1.getDateSumDay(parseInt(newObj.ATTR1_CP));
		var workDay2 = dt1.getDateSumDay(parseInt(newObj.ATTR2_CP));
		var workDay3 = dt1.getDateSumDay(parseInt(newObj.ATTR3_CP));
		var workDay4 = dt1.getDateSumDay(parseInt(newObj.ATTR4_CP));
		
		var gridArray = new Array();
		for(var i=0;i< prows.length;i++)
		{
			
			var rowsdata = new Object();
			
			rowsdata.PRODUCT_NO_CP =  prows[i].PRODUCT_NO_CP;
			rowsdata.PRODUCT_NAME_CP =  prows[i].PRODUCT_NAME_CP;
			rowsdata.R_STANDARD_CP =  prows[i].R_STANDARD_CP;
			rowsdata.AMOUNT_CP =  prows[i].AMOUNT_CP;
			rowsdata.R_ORDER_PK_CP =  param1;
			rowsdata.R_ORDER_DETAIL_PK_CP =  prows[i].R_ORDER_DETAIL_PK_CP;
			//?????? ??????
			rowsdata.P001_DATE_CP = workDay1;
			rowsdata.P002_DATE_CP = workDay2;
			rowsdata.P003_DATE_CP = workDay3;
			rowsdata.P004_DATE_CP = workDay4;
			
			gridArray.push(rowsdata);
				
			   
		}
		
		rows = JSON.stringify(gridArray);
		
		setGrid("grid",  rows,setColumn,"100%");
		
		
		//fn_estimateSet();
	}
    $("#ROrderLov").change(function(){
        // ????????? ????????? ?????? ??? alert ??????
        $('#param1').val("");
		fn_search("/CPMES/CPMES_UI410_search.do", "grid",setColumn,"100%");
    });
	 
});

$( window ).resize( function() {
	
} );


$( window ).load( function() {
	$("#ROrderLov").val($('#param1').val()).prop("selected", true);
} );


// ?????????????????? ?????? ?????? - ??? ???????????? ??????
Date.prototype.getInterval = function (otherDate) {
    var interval;
 
    if(this > otherDate)
        interval = this.getTime() - otherDate.getTime();
    else
        interval = otherDate.getTime() - this.getTime();
 
    return Math.floor(interval / (1000*60*60*24));
}
//?????????????????? ?????? ?????? - ?????? ?????????
Date.prototype.getDateSumDay = function (pDay) {
    
	var newDt = new Date(this.getFullYear(), this.getMonth(), this.getDate());
	
	newDt.setDate(newDt.getDate() + pDay);
	
	var year = newDt.getFullYear();
	var month = newDt.getMonth()+1;
	var day = newDt.getDate();
	
	if(month < 10) month = "0"+month;
	if(day < 10) day = "0"+day;
	
	
	var str = year +"-"+ month +"-"+ day;
 	
    return str;
}


/*????????? ?????? */
//????????? ?????? ?????? ??????
var cellsrenderer = function (row, columnfield, value, defaulthtml, columnproperties) {

	var formattedValue = value;

	var scan = "<div class='jqx-grid-cell-middle-align' style='margin-top:9px;color:blue;cursor:pointer;text-decoration:underline;'>" + formattedValue + " </div>";
                         
 	return scan;
}


//????????? ?????? ??????
var setColumn = [
	{
	     text: '??????', sortable: false, filterable: false, editable: false, align: 'center', cellsalign: 'center',
	     groupable: false, draggable: false, resizable: false,
	     datafield: '', columntype: 'number', width: 50,
	     cellsrenderer: function (row, column, value) {
	         return "<div style='margin:7px;text-align:center'>" + (value + 1) + "</div>";
	     }
	},
	{ text: '??????'	 , columntype: 'textbox', datafield: 'PRODUCT_NO_CP'	, cellsalign: 'center', align: 'center', width: 120, editable: false},
	{ text: '??????'	 , columntype: 'textbox', datafield: 'PRODUCT_NAME_CP'	, cellsalign: 'left'  , align: 'center', editable: false},
	{ text: '??????'	 , columntype: 'textbox', datafield: 'R_STANDARD_CP'	, cellsalign: 'left'  , align: 'center', width: 300, editable: false},
	{ text: '??????'	 , columntype: 'textbox', datafield: 'AMOUNT_CP'		, cellsalign: 'center', align: 'center', width: 70 , editable: false},
	{ 
		text: '??????', datafield: 'P001_DATE_CP', columntype: 'datetimeinput',  align: 'center', cellsalign: 'center', width: 150, columngroup: 'ProductDetails1', cellsformat: 'yyyy-MM-dd',
// 	  	validation: function (cell, value) {
// 			if (value == "")
// 				return true; 
// 			var year = value.getFullYear();
// 			return true;
// 		}
	},
	{ 
		text: '??????', datafield: 'P002_DATE_CP', columntype: 'datetimeinput',  align: 'center', cellsalign: 'center', width: 150, columngroup: 'ProductDetails1', cellsformat: 'yyyy-MM-dd',
// 	  	validation: function (cell, value) {
// 			if (value == "")
// 				return true; 
// 			var year = value.getFullYear();
// 			return true;
// 		}
	},
	{ 
		text: '??????', datafield: 'P003_DATE_CP', columntype: 'datetimeinput',  align: 'center', cellsalign: 'center', width: 150, columngroup: 'ProductDetails1', cellsformat: 'yyyy-MM-dd',
// 	  	validation: function (cell, value) {
// 			if (value == "")
// 				return true; 
// 			var year = value.getFullYear();
// 			return true;
// 		}
	},
	{ 
		text: '??????', datafield: 'P004_DATE_CP', columntype: 'datetimeinput',  align: 'center', cellsalign: 'center', width: 150, columngroup: 'ProductDetails1', cellsformat: 'yyyy-MM-dd',
// 	  	validation: function (cell, value) {
// 			if (value == "")
// 				return true; 
// 			var year = value.getFullYear();
// 			return true;
// 		}
	},
	{ text: 'R_ORDER_PK_CP'	 	, columntype: 'textbox', datafield: 'R_ORDER_PK_CP' , hidden: true },
	{ text: 'R_ORDER_DETAIL_PK_CP'	, columntype: 'textbox', datafield: 'R_ORDER_DETAIL_PK_CP'	, hidden: true },
	{ text: 'CHK'	 , columntype: 'textbox', datafield: 'CHK'	, hidden: true }
];
  
var columngroups = 
	[
	  { text: '??????(????????????)', align: 'center', name: 'ProductDetails1' }
	  
	];

//????????? ROW ??????
var generaterow = function (i) {  
    var row = {};
    row["CD_V_CP"] = ""; 
    row["CD_NM_CP"] = "";
    row["CD_TP_CP"] = "TOP";
    
    return row;
}

/*????????? ?????? ???*/
 


/*????????? ?????? */
var fn_save = function () {
  //?????? ??? ?????? 
	var rowindexes = $('#grid').jqxGrid('getselectedrowindexes');

	var rows = "";
	var productNo = 0;
	var productNm = 0;
	
	for(var i=0;i<rowindexes.length;i++)
	{
		
		$("#grid").jqxGrid('setcellvalue', rowindexes[i], "CHK", "1");

		if($("#grid").jqxGrid('getcellvalue', rowindexes[i], "PRODUCT_NO_CP") == "")
		{
			productNo++;	
		}
		if($("#grid").jqxGrid('getcellvalue', rowindexes[i], "PRODUCT_NAME_CP") == "")
		{
			productNm++;	
		}
		
		//rows += $("#grid").jqxGrid('getrowdata', i);
	}
	
	
	if(rowindexes.length==0 )
	{
		alert("???????????? ??? ????????? ????????????.");
		return;
	}

 	if(productNo>0 )
 	{
 		alert("????????? ???????????? ????????????.");
 		return;
 	}
//  	if(productNm>0 )
//  	{
//  		alert("????????? ???????????? ????????????.");
//  		return;
//  	}
 	
	if(!confirm("???????????? ???????????????????")) return;
  
  //??????????????? ??????
	$('#jqxLoader').jqxLoader('open');
	
  	var rows = $('#grid').jqxGrid('getrows');
	
	$("#gridData").val(JSON.stringify(rows));
		
	$.ajax({
      url: "/CPMES/CPMES_UI410_save.do",
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
          	alert("????????? ???????????? ????????? ???????????? ???????????????.");
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
          
			alert("???????????? ???????????????.");
          
			$('#grid').jqxGrid('clearselection');
          			
		}
	});
};


//?????? 

//??????
var fn_del = function(grid_id)
{
	
	//?????? ??? ?????? 
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
		alert("?????? ??? ????????? ????????????.");
		return;
	}
	
	if(!confirm("?????????????????????????")) return;
  
  //??????????????? ??????
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
          		alert("????????? ???????????? ????????? ???????????? ???????????????.");
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
          
			alert("?????? ???????????????.");
          
			$('#grid').jqxGrid('clearselection');
          
			fn_search("/CPMES/CPMES_UI530_searchMas.do", "grid",setColumn,"100%");
          
			$("#pCdTp").val("");
			
		}
	});
	
	
};

</script>

<body>
<form id="form1" name="form1" style="height: 100%;">
<input type="hidden" id="pCdTp" name="pCdTp">
<input type="hidden" name="gridData" id="gridData" value="">
<input type="hidden" name="gridData2" id="gridData2" value="">
<input type="hidden" name="programId" id="programId" value="<%=programId%>">
<input type="hidden" name="param1" id="param1" value="">


<!-- #wrap -->
<div id="wrap" >

	<!-- #container -->
<!-- 	<div id="container">	 -->
		<!-- #side -->
		<!-- #content -->
		<div id="content" style="height:100%" id ="content">			
			<div class="content-inner hid" style="height:100%">
				<div class="inner_top">
					<h3 class="tit">????????????</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnSave" style="display: inline-block;">????????????</a>
						
					</div>
				</div>
				
				<div class="inner p_10" style="height:100%">		
					<section class="section-search">
						<form1>
							<div class="form-row">

								<div class="col">
									<label for="">??????</label>
									<select class="form-control"  name = "ROrderLov" id = "ROrderLov" style="width:300px;">
										<option value="" selected>??????</option>
										<c:forEach items="${ROrderLov}" var="ROrderLov">
										<option value="${ROrderLov.CD_V_CP}">${ROrderLov.CD_NM_CP}</option>
										</c:forEach>
									</select>
								</div>
							</div>
		
							
						</form1>
					</section>
            		<div style="height:5px;"></div>
					<div id="inner_grid" class="con_list mtable" style="height:calc(100% - 170px);">	
			           	<div id="grid"></div>
			     	</div>
         			
<!-- 					<div class="scroll_x">????????? ?????????????????? ??? ??? ????????????.</div> -->
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
