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

<!-- ChartJS -->
<script src="<c:url value='/resources/plugins/chart.js/Chart.min.js'/>"></script>


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

<style>

#pSearchStaDt-days {

   display: none ;

}

#pSearchStaDt-months {

   display: none ;

}  

#pSearchStaDt-years {

   display: block ;

}



</style>   

<script type="text/javascript">

$(document).ready(function() {  
	  
// 	$('#mainSplitter').jqxSplitter({ width: 'calc(100% - 2px)', height: 'calc(100% - 170px)',  panels: [{ size: 650}] });
	$('#mainSplitter').jqxSplitter({ width: 'calc(100% - 2px)', height: 'calc(100% - 170px)', orientation: 'horizontal', panels: [{ size: 500 }] });
	
	/*=========== 달력설정 ============= */
	$('#pSearchStaDt').datepicker({
		duration: 0,
		dateFormat: "yy",
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
		fn_search_n("/PSMES/PSMES_UI630_searchList.do", "grid",setColumn,"100%");
		//setGrid("grid2", "",setColumn2,"100%");
	});
	
	/*버튼 이벤트 끝*/
	
	/*그리드 초기화*/
	setGrid_n("grid", "",setColumn, "100%", false);
	
	fn_search_n("/PSMES/PSMES_UI630_searchList.do", "grid",setColumn,"100%");
// 	fn_search_data3();
	  
	//setData3("");    
	 
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
            //setGrid_n(pGrid_id, data.response, pSetColumn, pHeight, pSumChk);
    		
            
    		var gridArray = new Array();
    		
    		var month = "01";
    		
    		
    		
    		for(var j=0;j<4;j++)
			{
    			var rowsdata = new Object();
    			
    			var k=1;  
    			
	    		for(var i=0;i< data.response.length;i++)
	    		{
	    			if(i<9)  
	    			{  
	    				month = "0"+k;
	    			}	
	    			else  
	    			{
	    				month = k;
	    			}	  
	    				    
    				if(data.response[i].R_MONTH == month && j==0)
       				{
    					rowsdata.GUBUN = "국내수주금액";
    					eval("rowsdata.DATA" + month + "=" + data.response[i].K_TOTAL_SUM_COST);
       				} 
    				else if(data.response[i].R_MONTH == month && j==1)
       				{
    					rowsdata.GUBUN = "국내수주건수";
    					eval("rowsdata.DATA" + month + "=" + data.response[i].K_NATION_TP_CNT);
       				}
    				else if(data.response[i].R_MONTH == month && j==2)
       				{
    					rowsdata.GUBUN = "수출수주금액";
    					eval("rowsdata.DATA" + month + "=" + data.response[i].NK_TOTAL_SUM_COST);
       				}
    				else if(data.response[i].R_MONTH == month && j==3)
       				{
    					rowsdata.GUBUN = "수출수주건수";
    					eval("rowsdata.DATA" + month + "=" + data.response[i].NK_NATION_TP_CNT);
       				}
    				  
	   				
	    			
	   				k++;
	    		}   
	    		
	    		gridArray.push(rowsdata);
    		
			} 
    		
    		rows = JSON.stringify(gridArray);
    		
    		setGrid_n("grid", rows,setColumn, "100%", false);
    		
    		setData3(data);
    		
            $('#jqxLoader').jqxLoader('close');
               
		}
	});
};


function setData3(data)
{
	 
	var data1 = new Array();
	var data2 = new Array();
	var data3 = new Array();
	var data4 = new Array();
	 
	if(data != "")
	{
		if(data.response.length==0)  
		 {
			for(var i=0;i<12;i++)
			{
				data1.push(0);
				data2.push(0);
				data3.push(0);
				data4.push(0);
			}
		 }
		 else
		 {
			 for(var i=0;i<12;i++)
			 {
				 data1.push(data.response[i].K_TOTAL_SUM_COST);
				 data2.push(data.response[i].NK_TOTAL_SUM_COST);
				 
				 data3.push(data.response[i].K_NATION_TP_CNT);
				 data4.push(data.response[i].NK_NATION_TP_CNT);
			 }	
		 }	 
			 
		
	}
	else
	{
		for(var i=0;i<12;i++)
		{
			data1.push(0);
			data2.push(0);
			data3.push(0);
			data4.push(0);
		}
	}	
	 
	   
// 	 data1 = eval(data1); 
// 	 data2 = eval(data2);
// 	 data3 = eval(data3);
	     
	 var areaChartData = {
			 labels  : ['01월', '02월', '03월', '04월', '05월', '06월', '07월', '08월', '09월', '10월', '11월', '12월'],
			 
			       
 	 datasets: [  
	   {
	     label               : '국내수주금액',
	     backgroundColor     : 'rgba(255, 99, 132, 0.8)',
	     borderColor         : 'rgba(255, 99, 132, 1)',
	     pointRadius          : false,
	     pointColor          : '#fd7e14',
	     pointStrokeColor    : '#fd7e14',
	     pointHighlightFill  : '#fff',  
	     pointHighlightStroke: '#fd7e14',
	     data                :  data1,
	     yAxesID			 : 'y-axis-0',  
	     
	   },
	   {
	     label               : '수출수주금액',
	     backgroundColor     : 'rgba(54, 162, 235, 0.8)',
	     borderColor         : 'rgba(54, 162, 235, 1)',
	     pointRadius         : false,
	     pointColor          : 'rgba(210, 214, 222, 1)',
	     pointStrokeColor    : '#c1c7d1',
	     pointHighlightFill  : '#fff',
	     pointHighlightStroke: 'rgba(220,220,220,1)',
	     data                : data2,
	     yAxesID			 : 'y-axis-0',  
	   },
	   {
	     label               : '국내수주건수',
	     backgroundColor     : 'rgba(255, 36, 36, 0.8)',
	     borderColor         : 'rgba(255, 36, 36, 1)',
	     pointRadius         : false,
	     pointColor          : '#17a2b8',
	     pointStrokeColor    : '#17a2b8',
	     pointHighlightFill  : '#fff',
	     pointHighlightStroke: '#17a2b8',
	     data                : data3,
	     type				 : 'line',
	     yAxisID: 'y_sub',
	     fill: false,
	     tension: 0
	   },
	   {
	     label               : '수출수주건수',
	     backgroundColor     : 'rgba(36, 120, 255, 0.8)',
	     borderColor         : 'rgba(36, 120, 255, 1)',
	     pointRadius         : false,
	     pointColor          : '#17a2b8',
	     pointStrokeColor    : '#17a2b8',
	     pointHighlightFill  : '#fff',
	     pointHighlightStroke: '#17a2b8',
	     data                : data4,
	     type				 : 'line',
	     yAxisID: 'y_sub',
	     fill: false,
	     tension: 0
	   },
		   
	 ]
	}
 
	var barChartCanvas = $('#barChart').get(0).getContext('2d');
	var barChartData = $.extend(true, {}, areaChartData);
	var temp0 = areaChartData.datasets[0];
	var temp1 = areaChartData.datasets[1];
	var temp2 = areaChartData.datasets[2];
	var temp3 = areaChartData.datasets[3];
	barChartData.datasets[0] = temp0;
	barChartData.datasets[1] = temp1;
	barChartData.datasets[2] = temp2;
	barChartData.datasets[3] = temp3;

/*
// 	var barChartOptions = {
// 	 responsive              : true,
// 	 maintainAspectRatio     : false,
// 	 datasetFill             : false,
	 
// 	}
	*/
	var barChartOptions = {
	      responsive              : true,
	      maintainAspectRatio     : false,
	      datasetFill             : false,
	      scales: {
	         yAxes: 
	       	 [
	       	 {
	          	id:"y-axis-0",
	          	position : "left",
	       		ticks: {
	            beginAtZero: true,
	            callback: function(value, index) {
	              if(value.toString().length > 8) return (Math.floor(value / 100000000)).toLocaleString("ko-KR") + "억";
	              else if(value.toString().length > 4) return (Math.floor(value / 10000)).toLocaleString("ko-KR") + "만";
	              else return value.toLocaleString("ko-KR"); 
	            }
	          },
	         },
	         {
	          	id:"y_sub",
	          	position : "right",
	       		ticks: {
	            
	       			beginAtZero: true,
	       			min : 0,
	       			max :50
// 		            callback: function(value, index) {
// 		               return value.toString();
// 		            }
			         	
		          }   
		          
	         }
	       	 ]
	          
	            
	      }
	    }
 
	new Chart(barChartCanvas, {
	 type: 'bar',
	 data: barChartData,
	 options: barChartOptions
	})
}


//그리드 컬럼 셋팅
var setColumn = [
	{ text: '구분'		, columntype: 'textbox', datafield: 'GUBUN'		, cellsalign: 'center', align: 'center',  editable: false },
	{ text: '01월'		, columntype: 'numberinput'		, datafield: 'DATA01'	, cellsalign: 'right' , align: 'center',  width: 115, cellsformat: 'D', editable:false},
	{ text: '02월'		, columntype: 'numberinput'		, datafield: 'DATA02'	, cellsalign: 'right' , align: 'center',  width: 115, cellsformat: 'D', editable:false},
	{ text: '03월'		, columntype: 'numberinput'		, datafield: 'DATA03'	, cellsalign: 'right' , align: 'center',  width: 115, cellsformat: 'D', editable:false},
	{ text: '04월'		, columntype: 'numberinput'		, datafield: 'DATA04'	, cellsalign: 'right' , align: 'center',  width: 115, cellsformat: 'D', editable:false},
	{ text: '05월'		, columntype: 'numberinput'		, datafield: 'DATA05'	, cellsalign: 'right' , align: 'center',  width: 115, cellsformat: 'D', editable:false},
	{ text: '06월'		, columntype: 'numberinput'		, datafield: 'DATA06'	, cellsalign: 'right' , align: 'center',  width: 115, cellsformat: 'D', editable:false},
	{ text: '07월'		, columntype: 'numberinput'		, datafield: 'DATA07'	, cellsalign: 'right' , align: 'center',  width: 115, cellsformat: 'D', editable:false},
	{ text: '08월'		, columntype: 'numberinput'		, datafield: 'DATA08'	, cellsalign: 'right' , align: 'center',  width: 115, cellsformat: 'D', editable:false},
	{ text: '09월'		, columntype: 'numberinput'		, datafield: 'DATA09'	, cellsalign: 'right' , align: 'center',  width: 115, cellsformat: 'D', editable:false},
	{ text: '10월'		, columntype: 'numberinput'		, datafield: 'DATA10'	, cellsalign: 'right' , align: 'center',  width: 115, cellsformat: 'D', editable:false},  
	{ text: '11월'		, columntype: 'numberinput'		, datafield: 'DATA11'	, cellsalign: 'right' , align: 'center',  width: 115, cellsformat: 'D', editable:false},
	{ text: '12월'		, columntype: 'numberinput'		, datafield: 'DATA12'	, cellsalign: 'right' , align: 'center',  width: 115, cellsformat: 'D', editable:false}
	
];

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
					<h3 class="tit">월별수주현황</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
					</div>
				</div>
				
				<div class="inner p_10" style="height:100%">		
					<section class="section-search">
						<form1>
							<div class="form-row">
								<div class="col">
									<label for="">년도</label>
									<select class="form-control"  name = "pYear" id = "pYear">
										<c:forEach items="${yearCombo}" var="yearCombo">
										<option value="${yearCombo.CD_V}">${yearCombo.CD_NM}</option>
										</c:forEach>
									</select>
								</div>
								 
							</div>
		
							
						</form1>
					</section>
					
					<div style="height:5px;"></div>
					
					<div id="mainSplitter">
		                <div class="splitter-panel">
		                	<div class="chart">
			                  <canvas id="barChart" style="min-height: 400px; height: 400px; max-height: 400px; max-width: 100%;"></canvas>
							</div>
		                	
		                </div>
		                <div class="splitter-panel">
		                	<div id="inner_grid" class="con_list mtable" style="height:100%;">		
					           	<div id="grid"></div>
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
