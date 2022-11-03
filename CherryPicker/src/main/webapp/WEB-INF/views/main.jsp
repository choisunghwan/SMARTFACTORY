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

String user_name = user.getUser_name();

String connectTime = user.getConnectTime();

String menuType = request.getParameter("menuType");

String active ="active";

String none ="";

if(menuType == null) menuType="2";

	
%>
<!DOCTYPE HTML>

<html lang="ko">  
<head>
<meta charset="utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">

<meta http-equive="Content-Style-Type" content="text/css"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>대가대 CP</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/content.css'/>">
<%-- <script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js'/>"></script> --%>
<link rel="stylesheet" href="<c:url value='/resources/jqwidgets/styles/jqx.base.css'/>" type="text/css" />

<link rel="stylesheet" href="<c:url value='/resources/jqwidgets/styles/jqx.energyblue.css'/>" type="text/css" />

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />	
<%-- <script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js'/>"></script> --%>

<script type="text/javascript" src="<c:url value='/resources/scripts/jquery-1.11.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxcore.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxtabs.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxbuttons.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxscrollbar.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxpanel.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxbuttons.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/scripts/demos.js'/>"></script>	
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxtree.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxsplitter.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxchart.core.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxdropdownlist.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxdata.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxdraw.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/scripts/demos.js'/>"></script>	
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxdraw.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/jqwidgets/jqxbargauge.js'/>"></script>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->

<link rel="stylesheet" href="<c:url value='/resources/plugins/fontawesome-free/css/all.min.css'/>">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Tempusdominus Bootstrap 4 -->

<link rel="stylesheet" href="<c:url value='/resources/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css'/>">
<!-- iCheck -->

<link rel="stylesheet" href="<c:url value='/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css'/>">

<!-- Theme style -->
<link rel="stylesheet" href="<c:url value='/resources/dist/css/adminlte.min.css'/>">
<!-- overlayScrollbars -->

<link rel="stylesheet" href="<c:url value='/resources/plugins/overlayScrollbars/css/OverlayScrollbars.min.css'/>">
<!-- Daterange picker -->

<link rel="stylesheet" href="<c:url value='/resources/plugins/daterangepicker/daterangepicker.css'/>">
<!-- summernote -->

<link rel="stylesheet" href="<c:url value='/resources/plugins/summernote/summernote-bs4.min.css'/>">
  
  
<!-- ChartJS -->
<script src="<c:url value='/resources/plugins/chart.js/Chart.min.js'/>"></script>

<style>
.jqx-item {
    -ms-touch-action: none;
    -moz-box-sizing: content-box;
    box-sizing: content-box;
    color: inherit;
    border-color: #999999;
    /* border-top: 1px solid; */
    /* border-left: 1px solid; */
    /* border-right: 1px solid; */
    -webkit-text-size-adjust: none;
    border-bottom: 1px solid #fff;
}

text{color:red;}

.jqx-knob-label, .jqx-chart-axis-text, .jqx-chart-label-text, .jqx-chart-tooltip-text, .jqx-chart-legend-text {
    fill: #333333;
    color: red;  
    font-size: 11px;   
    font-family: Verdana;
}

.jqx-tabs-title-selected-top {
    border-color: #000;
    border-bottom: 1px solid #fff;
    background-color: #fff;
}

/*Admin LTE 디자인 변경*/
 
.small-box .icon>i {  
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 50px;
    position: absolute;
    right: 25px;
    top: 25px;
    font-style:normal;
        
}

.small-box .icon {
    
    z-index: 0;
}


html,body{margin:0;padding:0;width:100%;height:100%;}
body{font-family: 'Noto Sans KR', sans-serif;font-size:15px;line-height:1.17;letter-spacing:0;color:#333;overflow:auto;    background: #f5f6f8;}

.row {
    display: -ms-flexbox;
    display: flex;
    -ms-flex-wrap: wrap;
    flex-wrap: wrap;
    margin-right: -7.5px;
    margin-left: -7.5px;
    margin-top: 7.5px;
}


.small-box>.small-box-footer {
    background-color: rgba(0,0,0,.1);
    color: rgba(255,255,255,.8);
    display: block;
    padding: 10px 0;
    position: relative;
    text-align: center;
    text-decoration: none;
    z-index: 10;
}

  
.card-body {
    -ms-flex: 1 1 auto;
    flex: 1 1 auto;
    min-height: 1px;
    padding: 0.5rem;
    height:360px;
}


.chart-inner-text
{
    fill: #00BAFF;
    color: #00BAFF;
    font-size: 30px;
    font-family: Verdana;
}    

</style>   
<script type="text/javascript">

  
$(document).ready(function() {
// 	$('#tabs').jqxTabs({ width: getWidth('tabs'), height: 250, position: 'top'});  
	  $('.jqx-chart-legend-text jqx-chart-legend-text-light').text("");  
	 $('#tabs').jqxTabs({   
		// 		theme: theme,		  		
		width: '100%',   
		height: '100%',  
		//height:tabHeight,
		position: 'top', 
		showCloseButtons: true,  
		reorder: true, 
		scrollPosition: 'both'
	});  
  
	
	$('#tabs').hide(); 
	       
	$(".btn-togg-left").click(function () {
		$('#side').toggleClass('toggle-left');  
		$('#container').toggleClass('toggle-con-left');  
		$(this).toggleClass('on');
		
		if (!$(this).hasClass('on')) {
			$( "#side" ).animate({
				opacity: 0,
				width: "-=200",
			}, 70, function() {
		    // Animation complete.
			});
			} else {
			
				$( "#side" ).animate({
		    	opacity: 1,
		    	width: "+=200",
			     }, 70, function() {
			    // Animation complete.
			     });
			} 
	 }); 
		
	var toggle = false;
	
	$(window).resize(function (){
		  // width값을 가져오기
		var width_size = window.outerWidth;
		    
		//console.log("width_size === > " + width_size);
		  // 800 이하인지 if문으로 확인
		if (width_size <= 1200) {
		
			if ($(".btn-togg-left").hasClass('on')) {  
				if(!toggle)
				{
					$(".btn-togg-left").trigger('click'); 
					toggle = true;
				}
			}
		}
		else if(toggle && width_size > 1200)
		{
			if (!$(".btn-togg-left").hasClass('on')) {
				if(toggle)
				{
					$(".btn-togg-left").trigger('click'); 
					toggle = false;
				}
			}    
		}

	});
	
	
	var $tab = $(this).find('.tabmenu'),
	$tabAnchors = $tab.find('a'), 
	$tabPanels = $(this).find('.view'); 

	$tab.on('click', 'a', function (event) {
	
		event.preventDefault(); 
	
		var $this = $(this); 
	
	 
		 if ($this.hasClass('active')) { 
			return;
		}
		
		$tabAnchors.removeClass('active');
		$this.addClass('active')
	
		$tabPanels.hide(); 
		$($this.attr('href')).show(); 

	})
	
 	$tabAnchors.eq(0).trigger('click');

// 	$( window ).resize( function() {
		 
//     } );
	
	//메뉴 클릭 시 다른 메뉴 닫히게 처리 
	$(".lnb").click(function(){
   
	$(".lnb").not(this).next().slideUp(300);
    
	if(!$(this).hasClass('opened'))
	{
		$(this).next().slideToggle(200);
		$(this).addClass('opened');  

 		$(".lnb").not(this).removeClass('opened'); 
	}  
	else  
	{ 
		$(this).next().slideToggle(200);
		$(this).removeClass('opened');
	}
	
	return false;
	});   
	//메뉴 화면 링크 클릭 시 눌려진 항목 표시를 위한 css 변경
	var $lna = $(this).find('#tab_01'),
		$lnaAnchors = $lna.find('a'), 
		$lnaPanels = $(this).find('.view'); 
	
		$lna.on('click', 'a', function (event) {
		
		event.preventDefault(); 
		
		var $this = $(this); 
		
		 
		if ($this.hasClass('active')) { 
				return;
		}
			
		$lnaAnchors.removeClass('active');
		$this.addClass('active')
		 
		$($this.attr('href')).show(); 
	
	})
	//메뉴 클릭 시 다른 메뉴 닫히게 처리 
	$(".lnb").next().slideUp(300);
	var addButton,
    addButtonWidth = 29,
    index = 0;
	  
	var theme = '';
	var tabHeight =document.body.offsetHeight-100;  
	
	   
	// chart 
	 //-------------
    //- DONUT CHART -
    //-------------
    // Get context with jQuery - using jQuery's .get() method.
    var donutChartCanvas = $('#donutChart1').get(0).getContext('2d')
    var donutData        = {
      datasets: [    
        {
           data: [0,100],
//          data: [700,300],
           backgroundColor : ['#f56954', '#00a65a', '#f39c12', '#00c0ef', '#3c8dbc', '#d2d6de'],
//          backgroundColor : ['#f56954', '#00a65a'],
        }
      ]
    }
    var donutOptions     = {
      maintainAspectRatio : false,
      responsive : true,
    }
    //Create pie or douhnut chart
    // You can switch between pie and douhnut using the method below.
    new Chart(donutChartCanvas, {
      type: 'doughnut',
      data: donutData,
      options: donutOptions
    })
	
	for(var i=1;i<5;i++)
	{
		var donutChartCanvas = $('#donutChart' + i).get(0).getContext('2d')
	    var donutData        = {
	      
	      datasets: [
	        {
//	           data: [700,500,400,600,300,100],
	          data: [0,100],
//	           backgroundColor : ['#f56954', '#00a65a', '#f39c12', '#00c0ef', '#3c8dbc', '#d2d6de'],
	          backgroundColor : ['#f56954', '#d2d6de'],
	        }
	      ]
	    }
	    var donutOptions     = {
	      maintainAspectRatio : false,
	      responsive : true,
	    }
	    //Create pie or douhnut chart
	    // You can switch between pie and douhnut using the method below.
	    new Chart(donutChartCanvas, {
	      type: 'doughnut',
	      data: donutData,
	      options: donutOptions
	    })
	}
    
	
	
	
	//chart 끝
	
	
 	fn_search_data1();
	
     fn_search_data2();
    
     fn_search_data3();
	
});	




//화면별 오픈 방법
var index =0;

// 화면 눌렀을 때 탭이 추가되며 화면 열림
function addTab(src, label) { 
	var tabsCount =  $("#tabs").jqxTabs('length');
	
	$('#tabs').show(); 
	  
	if(tab_is_open(label) >= 0)  
	{
		$('#tabs').jqxTabs('select', tab_is_open(label));
		return;
	}
	
	$('#tabs').jqxTabs('addLast', label, '<div style="height: 100%;" id="main_content"><iframe src="' + src + '" height="100%" width="100%" frameborder="0" vspace="0" hspace="0" marginwidth="0" marginheight="0" scrolling="no" /></div>');
	
}

//화면 눌렀을 때 탭이 추가되며 화면 열림
function addTabNewLoad(src, label, gridData, param1, param2, param3, param4, param5 ) { 
	var tabsCount =  $("#tabs").jqxTabs('length');
	
	$("#gridData").val(gridData);
	$("#param1").val(param1);
	$("#param2").val(param2);
	$("#param3").val(param3);
	$("#param4").val(param4);
	$("#param5").val(param5);
		
	//alert($("#gridData").val());
	$('#tabs').show(); 
	
	src += "&param1="+encodeURI(param1) + "&param2="+encodeURI(param2) + "&param3="+encodeURI(param3) + "&param4="+encodeURI(param4) + "&param5="+encodeURI(param5)
	
	if(tab_is_open(label) >= 0)    
	{
		$('#tabs').jqxTabs('select', tab_is_open(label));
		$('#tabs').jqxTabs('setContentAt', tab_is_open(label), '<div style="height: 100%;" id="main_content"><iframe src="' + src + '" height="100%" width="100%" frameborder="0" vspace="0" hspace="0" marginwidth="0" marginheight="0" scrolling="no" /></div>');
		return;   
	}
	
	$('#tabs').jqxTabs('addLast', label, '<div style="height: 100%;" id="main_content"><iframe src="' + src + '" height="100%" width="100%" frameborder="0" vspace="0" hspace="0" marginwidth="0" marginheight="0" scrolling="no" /></div>');
	
}

//화면이 열려 있는지 체크		
function tab_is_open(name){
	
	$('#grape_area').hide();
	$('#tabs').show();
	removeTab();
	
	var tabsCount = $("#tabs").jqxTabs('length');

	var position;
	if (tabsCount>0){
		for (var i = 0; i < tabsCount; i++) {
			var tabTitle = $("#tabs").jqxTabs('getTitleAt', i);
             
			if (tabTitle == name) {
				return i;
				break;
			}
		}
	}else{
		return -1;    
	}
}

function fn_menu_change(menu)
{
	
	
	if(menu == "1")
	{
		$(".titleName").text("(탈산제)");
		$("#menu1").show();
		$("#menu2").hide();
	}
	else
	{
		$(".titleName").text("(빌렛)");
		$("#menu2").show();
		$("#menu1").hide();
	}
	
	location.ref = "menu"
	
	window.reload();
}

function fn_logout()
{
	location.href="/login.do"
	
}

function removeTab()
{
	var selectedItem = $('#tabs').jqxTabs('selectedItem');
//     var disabledItems = $('#tabs').jqxTabs('getDisabledTabsCount');
    var items = $('#tabs').jqxTabs('length');
    var maincnt =0;
    for (var i = 0; i < items; i++) {
		var tabTitle = $("#tabs").jqxTabs('getTitleAt', i);
        
		if (tabTitle == "Main") {
			selectedItem = i;
			maincnt++;
			//return i;
			break;
		}  
	}
    
    if (maincnt > 0) {
        $('#tabs').jqxTabs('removeAt', selectedItem);
    }	
}


//월 수주 및 발주정보 조회

//마스터 정보 조회
function fn_search_data1() {
	//로딩이미지 오픈
// 	$('#jqxLoader').jqxLoader('open');
	
	pUrl = "/CPMES/CPMES_UI110_searchData1.do";
	
	$.ajax({
        url: pUrl ,
        dataType: 'json',
        data : $("#form1").serialize(),
		//data : param,
        type : 'POST',
        beforeSend: function (request) {
//         	xmlHttpRequest.setRequestHeader("AJAX", "true");
//         	$("jqxgrid").html('');
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
// 			$('#jqxLoader').jqxLoader('close');
            
			setData1( data);
		}
	});
};  


function setData1( data)
{
	
	var S02 = 0;
	var S03 = 0;
	var S04 = 0;
	var ORDER = 0;
	
	for(var i=0;i<data.list.length;i++)
	{
		if(data.list[i].GUBUN_CP == "S02")
		{
			S02 = data.list[i].CNT;
		}	
		else if(data.list[i].GUBUN_CP == "S03")
		{
			S03 = data.list[i].CNT;
		}
		else if(data.list[i].GUBUN_CP == "S04")
		{
			S04 = data.list[i].CNT;
		}
		else if(data.list[i].GUBUN_CP == "ORDER")
		{
			ORDER = data.list[i].CNT;
		}
	}
	
	$("#s02").html(S02 + " 건");
	$("#s03").html(S03 + " 건");
	$("#s04").html(S04 + " 건");
	$("#order").html(ORDER + " 건");
   
}


function fn_search_data2() {
	//로딩이미지 오픈
// 	$('#jqxLoader').jqxLoader('open');
	
	pUrl = "/CPMES/CPMES_UI110_searchData2.do";
	
	$.ajax({
        url: pUrl ,
        dataType: 'json',
        data : $("#form1").serialize(),
		//data : param,
        type : 'POST',
        beforeSend: function (request) {
//         	xmlHttpRequest.setRequestHeader("AJAX", "true");
//         	$("jqxgrid").html('');
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
// 			$('#jqxLoader').jqxLoader('close');
            
			setData2( data);
		}  
	});
};    



function setData2(data)
{
	var process = 0;
	
	$('#donutChart1').remove(); // this is my <canvas> element
	$('#donutChart2').remove(); // this is my <canvas> element
	$('#donutChart3').remove(); // this is my <canvas> element
	$('#donutChart4').remove(); // this is my <canvas> element
	 
	$('#graph-container1').append('<canvas id="donutChart1" style="min-height: 220px; height: 220px; max-height: 220px; max-width: 100%;margin-top:30px;"></canvas>');
	$('#graph-container2').append('<canvas id="donutChart2" style="min-height: 220px; height: 220px; max-height: 220px; max-width: 100%;margin-top:30px;"></canvas>');
	$('#graph-container3').append('<canvas id="donutChart3" style="min-height: 220px; height: 220px; max-height: 220px; max-width: 100%;margin-top:30px;"></canvas>');
	$('#graph-container4').append('<canvas id="donutChart4" style="min-height: 220px; height: 220px; max-height: 220px; max-width: 100%;margin-top:30px;"></canvas>');
	
	if(data.list.length==0)
	{
		setDunutChart(1, process);
		setDunutChart(2, process);
		setDunutChart(3, process);
		setDunutChart(4, process);
	}
	else
	{
		for(var i=0;i<data.list.length;i++)
		{
			if(data.list[i].V_GUBUN_CP == "P1")
			{
				process = 0;
				process = data.list[i].V_PERCENT_CP;
				setDunutChart(1, process);
			}	
			else if(data.list[i].V_GUBUN_CP == "P2")
			{
				process = 0;
				process = data.list[i].V_PERCENT_CP;
				setDunutChart(2, process); 
			}
			else if(data.list[i].V_GUBUN_CP == "P3")
			{
				process = 0;
				process = data.list[i].V_PERCENT_CP;
				setDunutChart(3, process);
			}
			else if(data.list[i].V_GUBUN_CP == "P4")
			{
				process = 0;
				process = data.list[i].V_PERCENT_CP;
				setDunutChart(4, process);
			}
		}
	}	
	
}

// chart   
               
        
Chart.plugins.register({ 
	beforeDraw: function (chart) 
	{ 
		  
		if (chart.config.options.elements.center) 
		{ //Get ctx from string 
			var ctx = chart.chart.ctx; //Get options from the center object in options 
			var centerConfig = chart.config.options.elements.center; 
			var fontSize = centerConfig.fontSize || '50'; 
			var fontStyle = centerConfig.fontStyle || 'Arial'; 
			var txt = centerConfig.text; 
			var color = centerConfig.color || '#000'; 
			var sidePadding = centerConfig.sidePadding || 20; 
			var sidePaddingCalculated = (sidePadding/100) * (chart.innerRadius * 2) //Start with a base font of 30px 
			ctx.font = fontSize + "px " + fontStyle;
			//Get the width of the string and also the width of the element minus 10 to give it 5px side padding 
			var stringWidth = ctx.measureText(txt).width; 
			var elementWidth = (chart.innerRadius * 2) - sidePaddingCalculated; // Find out how much the font can grow in width. 
			var widthRatio = elementWidth / stringWidth; 
			var newFontSize = Math.floor(30 * widthRatio); 
			var elementHeight = (chart.innerRadius * 0.7); // Pick a new font size so it will not be larger than the height of label. 
			var fontSizeToUse = Math.min(newFontSize, elementHeight); //Set font settings to draw it correctly. 
			ctx.textAlign = 'center'; 
			ctx.textBaseline = 'middle'; 
			var centerX = ((chart.chartArea.left + chart.chartArea.right) / 2); 
			var centerY = ((chart.chartArea.top + chart.chartArea.bottom) / 2); //반도넛일 경우 
			if (chart.config.options.rotation === Math.PI && chart.config.options.circumference === Math.PI) 
			{ 
				centerY = ((chart.chartArea.top + chart.chartArea.bottom) / 1.3); 
			} 
			ctx.font = fontSizeToUse+"px " + fontStyle;
			ctx.fillStyle = color; //Draw text in center 
			
		    txt = chart.config.data.datasets[0].data[0];
	        if(txt == undefined){
	           txt = "0%";
	        }else{
	           txt = txt +"%";
	        }
	         
			//요기 txt 값 넣어 줘야 함
			ctx.fillText(txt, centerX, centerY); 
			}      
		}   
	});
 
function setDunutChart(index, cha)
{
	var perdata = 100;
	
	var chaData = Number(perdata) - Number(cha);
	
	var donutChartCanvas = $('#donutChart' + index).get(0).getContext('2d')
	
	var donutData        = {
	  labels: ['작업완료','작업미완료'],
      datasets: [    
        {
           data: [cha,chaData],
           backgroundColor : ['#00a65a', '#d2d6de'],
        }
      ]
    }
	  
	var num =1;
	 
	var txtlabel = "";
	
	if(index==1){
		
	}else if(index==1){
		
	}else if(index==1){
		
	}
	
    var donutOptions     = {
      maintainAspectRatio : false,
      responsive : true,
      legend: { display: false },
      elements: { 
    	  center: { 
    		  text: Math.round(num*100), fontStyle: 'Helvetica', //Default Arial 
    		  sidePadding: 15 //Default 20 (as a percentage) 
      		} 
      },     
      maintainAspectRatio : false,
      //cutoutPercentage:70, 
      animation:false, 
       
    	    
    }
    //Create pie or douhnut chart
    // You can switch between pie and douhnut using the method below.
    new Chart(donutChartCanvas, {
      type: 'doughnut',
      data: donutData,
      options: donutOptions
    })	
    

}



//bar chart
//-------------
//- BAR CHART -  
//-------------

function fn_search_data3() {
	//로딩이미지 오픈
// 	$('#jqxLoader').jqxLoader('open');
	
	pUrl = "/CPMES/CPMES_UI110_searchData3.do";
	
	$.ajax({
        url: pUrl ,  
        dataType: 'json',
        data : $("#form1").serialize(),
		//data : param,
        type : 'POST',
        beforeSend: function (request) {
//         	xmlHttpRequest.setRequestHeader("AJAX", "true");
//         	$("jqxgrid").html('');
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
// 			$('#jqxLoader').jqxLoader('close');
            
			setData3( data);
		}  
	});
};    

function setData3(data)
{
	 var data1 = new Array();
	 var data2 = new Array();
	 var data3 = new Array();
	 
	 if(data.list.length==0)
	 {
		for(var i=0;i<12;i++)
		{
			data1.push(0);
			data2.push(0);
			data3.push(0);
		}
	 }
	 else
	 {
		 for(var i=0;i<12;i++)
		 {
			 data1.push(data.list[i].FINAL_COST_CP);
			 data2.push(data.list[i].GENERAL_COST_CP);
			 data3.push(data.list[i].P_FINAL_COST_CP);
		 }	
	 }	 
		 
	
/* 차트 주석 처리 한거 ??*/	 
 	/*  data1 = eval(data1); 
	 data2 = eval(data2);
	 data3 = eval(data3);
	     
	  
 	 alert("11" + data1); */
	 var areaChartData = {
			 labels  : ['01월', '02월', '03월', '04월', '05월', '06월', '07월', '08월', '09월', '10월', '11월', '12월'],
			 
			   
 	 datasets: [  
	   {
	     label               : '수주금액',
	     backgroundColor     : '#fd7e14',
	     borderColor         : '#fd7e14',
	     pointRadius          : false,
	     pointColor          : '#fd7e14',
	     pointStrokeColor    : '#fd7e14',
	     pointHighlightFill  : '#fff',
	     pointHighlightStroke: '#fd7e14',
	     data                :  data1,
	   },
	   {
	     label               : '일반관리비',
	     backgroundColor     : 'rgba(210, 214, 222, 1)',
	     borderColor         : 'rgba(210, 214, 222, 1)',
	     pointRadius         : false,
	     pointColor          : 'rgba(210, 214, 222, 1)',
	     pointStrokeColor    : '#c1c7d1',
	     pointHighlightFill  : '#fff',
	     pointHighlightStroke: 'rgba(220,220,220,1)',
	     data                : data2
	   },
	   {
	     label               : '외주비용',
	     backgroundColor     : '#17a2b8',
	     borderColor         : '#17a2b8',
	     pointRadius         : false,
	     pointColor          : '#17a2b8',
	     pointStrokeColor    : '#17a2b8',
	     pointHighlightFill  : '#fff',
	     pointHighlightStroke: '#17a2b8',
	     data                : data3
	   },
		   
	 ]
	}

	var barChartCanvas = $('#barChart').get(0).getContext('2d');
	var barChartData = $.extend(true, {}, areaChartData);
	var temp0 = areaChartData.datasets[0];
	var temp1 = areaChartData.datasets[1];
	var temp2 = areaChartData.datasets[2];
	barChartData.datasets[0] = temp0;
	barChartData.datasets[1] = temp1;
	barChartData.datasets[2] = temp2;
 
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
	         yAxes: [{
	          ticks: {
	            beginAtZero: true,
	            callback: function(value, index) {
	              if(value.toString().length > 8) return (Math.floor(value / 100000000)).toLocaleString("ko-KR") + "억";
	              else if(value.toString().length > 4) return (Math.floor(value / 10000)).toLocaleString("ko-KR") + "만";
	              else return value.toLocaleString("ko-KR"); 
	            }
	          },
	        }]
	      }
	    }
 
	new Chart(barChartCanvas, {
	 type: 'bar',
	 data: barChartData,
	 options: barChartOptions
	})
}
 



//bar char 끝

//--------------
//- AREA CHART -
//--------------


</script>


</head>
<body>
<!-- #wrap -->
<form id="form1" name="form1" style="height: 100%;">
<div id="wrap" >
	<div id="side">
<!-- 		<div class="logo">  -->
		<div class="logo">
			<h1>
				<a href="/main.do">DCU CherryPicker</a>
			</h1>
		</div>  
		<input type="hidden" name="menuType" id="menuType" value="<%=menuType %>">
		<form action="" method="post" target="param"></form>
		<input type="hidden" name="gridData" id="gridData" value="">
		<input type="hidden" name="param1" id ="param1" value ="">
		<input type="hidden" name="param2" id ="param2" value ="">
		<input type="hidden" name="param3" id ="param3" value ="">
		<input type="hidden" name="param4" id ="param4" value ="">
		<input type="hidden" name="param5" id ="param5" value ="">
		
		
		<div class="aniarea" id="menu" name="menu" >
			<ul class="tabmenu">
				<li><a href="#tab_01">Menu</a></li>
<!-- 				<li><a href="#tab_02">Favorite</a></li>					 -->
			</ul> 
			<div class="main">
				<section class="view" id="tab_01">
					<!-- #lnb -->
					<ul id="lnb">				
<!-- 							<li class="active"><a href="#n" class="opened  lnb01" onclick="$(this).toggleClass('opened').next().slideToggle(200); return false;">원료관리</a> -->
						<li class="active"><a href="#n" class="lnb">매출관리</a>
							<ul>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI210.do', '수주 등록 및 조회')">수주 등록 및 조회</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI220.do', '수주목록')">수주목록</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI230.do', '제품출고관리')">제품출고관리</a></li>
								
							</ul> 
						</li>
						<li class="active"><a href="#n" class="lnb">매입관리</a>
							<ul>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI310.do', '발주 등록 및 조회')">발주 등록 및 조회</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI320.do', '발주목록')">발주목록</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI330.do', '입고관리')">입고관리</a></li>
							</ul> 
						</li>
						<li class="active"><a href="#n" class="lnb">생산관리</a>
							<ul>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI410.do', '작업지시')">작업지시</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI420.do', '생산실적조회')">생산실적조회</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI430.do', '설비관리')">설비관리</a></li>
							</ul> 
						</li>
						<li class="active"><a href="#n" class="lnb">기준정보</a>
							<ul>  
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI510.do', '거래처관리')">거래처관리</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI520.do', '사원정보관리')">사원정보관리</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI530.do', '공통코드관리')">공통코드관리</a></li>
							</ul> 
						</li>
						<li class="active"><a href="#n" class="lnb">경영정보</a>
							<ul>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI620.do', '생산계획대비실적')">생산계획대비실적</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI630.do', '월별수주현황')">월별수주현황</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI640.do', '외주관리현황')">외주관리현황</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI650.do', '제품출고현황')">제품출고현황</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI660.do', '월별누계')">월별누계</a></li>
								
							</ul> 
						</li>
						
						
<!-- 						<li class="active"><a href="#n" class="lnb">TEST</a>
							<ul>
								<li><a href="#n" onclick = "javascript:addTab('/PSMES/PSMES_UI910.do', 'TEST조회')">TEST조회</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/PSMES/PSMES_UI920.do', '조건조회')">조건조회</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/PSMES/PSMES_UI930.do', '저장,수정,삭제')">저장,수정,삭제</a></li>
								
							</ul> 
						</li> -->
						
						
						<!-- 10월20일 내가 만든 테스트용 리스트 -->
<!-- 						<li class="active"><a href="#n" class="lnb">TEST1</a>
							<ul>
								<li><a href="#n" onclick = "javascript:addTab('/PSMES/PSMES_UI940.do', '조회')">TEST1조회</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/PSMES/PSMES_UI950.do', '조건조회')">TEST1조건조회</a></li>
								<li><a href="#n" onclick = "javascript:addTab('/PSMES/PSMES_UI960.do', '저장,수정,삭제')">TEST1저장,수정,삭제</a></li>
								
							</ul> 
						</li> -->
						
					</ul>
					<!-- //#lnb -->
				</section>
				
			</div> <!-- main -->
		</div><!-- aniarea -->
		
	</div><!-- #side 
		
			<!-- #container -->
	<div id="container"  style="height: 100%; overflow:auto;">	   
		<div class="topbar">
			
			<a href="#n" class="btn-togg-left on">열기/닫기
				<div class="btn_nav_bar_01"></div>
				<div class="btn_nav_bar_02"></div>
				<div class="btn_nav_bar_03"></div>
			</a>
			<div class="header-left">
			<ul id="gnb" class="menutop_gnb">
			
			</ul>  
			</div>
			<div class="header-right">  
				<ul class="gfm">
					<li class="strong"><%=user_name %></li>
					<li class="time"><%=connectTime %></li>
					<li class="out"><a href="#" onclick="fn_logout();">로그아웃</a></li>
				</ul>  
			</div> 
		</div>    
		<div id="content" class="page-content" style="height: 100%;">
			<div class="content-inner hid"   style="height: 100%;">
				<div id='jqxWidget'   style="height: 100%;">
					<div id='tabs' >  
			            <ul>    
			                <li style="margin-left: 30px;">Main</li>
			            </ul>  
			            <div>  
						</div>  
					</div>   
					<!-- Main content -->
				    <table style="width: 100%;">
				    	<tr>
				    		<td style="width: 50%;">  
				    			
				    			<div class="card card-secondary" style="margin: 10px;">
					              <div class="card-header">
					                <h3 class="card-title">  월 수주 및 발주현황</h3>
					                <h2><a href="https://drive.google.com/drive/folders/1LvvmF9INyLZrYa8Ma4tVt6bNuOijrxis?usp=share_link">접속</a></h2> 
					              </div>
					              <!-- /.card-header -->
					              <div class="card-body" > 
					                	<table style="width: 100%;">
					                		<tr>
					                			<td style="width: 100%;">
					                				<section class="content">
												      <div class="container-fluid">
												        <!-- Small boxes (Stat box) -->
												        <div class="row">
												          <div class="col-lg-6 col-6">
												            <!-- small box -->
												            <div class="small-box bg-info">
												              <div class="inner">
												                <h3><span style="color:black;">수주</span></h3>
												  
												                <p>&nbsp;</p> 
												              </div>
												              <div class="icon">   
					<!-- 							                <i class="ion ion-bag"></i> -->
												                <i class=""><span id="s02" style="color: #17a2b8;"></span></i>
												              </div> 
												              <a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI220.do', '수주목록')" class="small-box-footer">더보기 <i class="fas fa-arrow-circle-right"></i></a>
												            </div>
												          </div>
												          <!-- ./col -->
												          <div class="col-lg-6 col-6">
												            <!-- small box -->
												            <div class="small-box bg-success">
												              <div class="inner">
												                <h3><span style="color:black;">발주</span></h3>
												
												                <p>&nbsp;</p>
												              </div>
												              <div class="icon">
												                <i class=""><span id="order" style="color: #28a745;"></span></i>
												              </div>
												              <a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI320.do', '발주목록')" class="small-box-footer">더보기 <i class="fas fa-arrow-circle-right"></i></a>
												            </div>
												          </div>
												          
												        </div>
														</div>
													</section>
					                			</td>
					                		</tr>
					                			
					                		<tr>
					                			<td>
					                				<section class="content">
												      <div class="container-fluid">
												        <!-- Small boxes (Stat box) -->
												        <div class="row">
												          <div class="col-lg-6 col-6">
												            <!-- small box -->
												            <div class="small-box bg-warning">
												              <div class="inner">
												                <h3><span style="color:black;">작업중</span></h3>
												
												                <p>&nbsp;</p>
												              </div>
												              <div class="icon">
												                <i class=""><span id="s03" style="color: #ffc107;"></span></i>
												              </div>
												              <a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI420.do', '생산실적조회')" class="small-box-footer">더보기 <i class="fas fa-arrow-circle-right"></i></a>
												            </div>
												          </div>
												          <!-- ./col -->
												          <div class="col-lg-6 col-6">
												            <!-- small box -->
												            <div class="small-box bg-danger">
												              <div class="inner">
												                <h3><span style="color:black;">작업완료</span></h3>
												
												                <p>&nbsp;</p>
												              </div>
												              <div class="icon">
												                <i class=""><span id="s04" style="color: #dc3545;"></span></i>
												              </div>
												              <a href="#n" onclick = "javascript:addTab('/CPMES/CPMES_UI420.do', '생산실적조회')"  class="small-box-footer">더보기 <i class="fas fa-arrow-circle-right"></i></a>
												            </div>
												          </div>
												          <!-- ./col -->
												        </div>
														</div>
													</section>	
					                			</td>
					                		</tr>
					                	</table>
					                		
					              </div>
					              <!-- /.card-body -->
					            </div>
					            <!-- /.card -->
				    				
				    		</td>
				    		  
				    		
				    		<td style="width: 50%;">
				    		
				    			<div class="card card-secondary" style="margin: 10px;">
					              <div class="card-header">
					                <h3 class="card-title">  작업진행 현황</h3>  
					                <div class="top_btn">
					                	<select name = "pOrderPk" id = "pOrderPk" style ="width:300px;height:24px;" onChange="fn_search_data2();">
								  			<c:forEach items="${orderCom}" var="orderCom"> 
											<option value="${orderCom.CD_V_CP}">${orderCom.CD_NM_CP}</option> 
											</c:forEach> 
										</select>
									  	  
										   
					                </div>        
					                    
					              </div>    
					              
					              <!-- /.card-header -->
					              <div class="card-body" > 
					                	<table style="width: 100%;height: 100%;">
					                			  
					                		<tr>  
					                			<td>  
					                				<table cellpadding="0" cellspacing="0" style="width: 100%;width: 100%;">
											        	    
											        	                     
												        <tr>      
												            <td style="text-align:center;width: 25%;">     
												            	<span style="font-size: 3em;padding-bottom:10px;"><b>[제관공정]</b></span>
												            	<div id="graph-container1"><canvas id="donutChart1" style="min-height: 220px; height: 220px; max-height: 220px; max-width: 100%;margin-top:30px;"></canvas></div>  
												            </td>  
												            <td align="center" style="width: 25%;">
												            	<span style="font-size: 3em;padding-bottom:10px;"><b>[용접공정]</b></span><br>
												            	<div id="graph-container2"><canvas id="donutChart2" style="min-height: 220px; height: 220px; max-height: 220px; max-width: 100%;margin-top:30px;"></canvas></div>
												            </td>  
												            <td align="center" style="width: 25%;">
												            	<span style="font-size: 3em;padding-bottom:10px;"><b>[가공공정]</b></span><br>
												            	<div id="graph-container3"><canvas id="donutChart3" style="min-height: 220px; height: 220px; max-height: 220px; max-width: 100%;margin-top:30px;"></canvas></div>
												            </td>
												            <td align="center" style="width: 25%;">   
												            	<span style="font-size: 3em;padding-bottom:10px;"><b>[조립공정]</b></span><br>
												            	<div id="graph-container4"><canvas id="donutChart4" style="min-height: 220px; height: 220px; max-height: 220px; max-width: 100%;margin-top:30px;"></canvas></div>
												            </td>    
												        </tr>
											        
											    	</table>
					                			</td>
					                		</tr>
					                	</table>
					                		
					              </div>
					              <!-- /.card-body -->
					            </div>
					            <!-- /.card -->	
				    		</td>
				    	</tr>
				    	
				    </table>
				          
					<div id ="grape_area" style="padding:0px">  
<!-- 					  	<h3 class="tit">&nbsp;&nbsp;□ 년간  탈산제 원료입고/ 제품 생산 실적</h3> -->
					  	    
					  	<table   style="width:100%; height:100%;" style="padding:10px">
					  		<colgroup>
							    <col width="100%" />
							</colgroup>  
					  		<tr>  
								<td style="padding:0px; height: 100%;">    
								<div class="card card-secondary" style="margin: 10px;height:460px" >
									<div class="card-header">
										<h3 class="card-title">  월별 수주/외주/일반관리비</h3>  
									</div>	
					                
									<div class="card-body">  
										<div class="chart">
						                  <canvas id="barChart" style="min-height: 400px; height: 400px; max-height: 400px; max-width: 100%;"></canvas> 
						                  <%-- <canvas id="barChart" style="min-height: 100%; height: 100%; max-height: 100%; min-width:100%; width: 100%; max-width: 100%;"></canvas> --%>
										</div>
									</div>
								</div>	  
					  			</td>
					  		</tr>
					  		
					  	</table>
					</div>
		       </div>
		       
			</div>
			
		</div>
		
	</div> 
</div>
<!-- //#wrap -->	
</form>
</body>
</html>
