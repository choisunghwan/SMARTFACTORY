var grid_id = "";
var setColumn = "";
var url = "";
// 조회

function fn_search (pUrl, pGrid_id, pSetColumn, pHeight, pSumChk ) {
	
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
            setGrid(pGrid_id, data.response, pSetColumn, pHeight, pSumChk);
            
            $('#jqxLoader').jqxLoader('close');
            
		}
	});
};   

//그리드 데이터 출력
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
		selectionmode: 'checkbox',
		
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



//그리드 데이터 출력
function setGridTopAdd (pGrid_id, pResponse, pSetColumn, pHeight)
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
		selectionmode: 'checkbox',
		
// 		pagerheight: 50,
		columnsresize: true,
		showrowlines:true,
		showcolumnlines: true,
		showcolumnheaderlines: true,	
 		columns: pSetColumn
		
	});
    
}

//그리드 데이터 출력
function setGridGroup (pGrid_id, pResponse, pSetColumn, pSetGroup, pHeight)
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
		selectionmode: 'singlecell',
		editmode: 'click',
		altrows: true,
//	 		selectionmode: 'singlecell',
//		pageable: true,
//			pagesize:15,
		theme: 'energyblue',
//		pagerbuttonscount: 10,
		
//	 		pagesizeoptions:['15', '20', '50'],
	     	pagermode: 'simple',
//	     	pagesize:totalpage,
//			pagermode: 'material',
		selectionmode: 'checkbox',
		
//		pagerheight: 50,
		columnsresize: true,
		showrowlines:true,
		showcolumnlines: true,
		showcolumnheaderlines: true,	
		columns: pSetColumn,
		columngroups: pSetGroup
		
	});
  
}

//그리드 링크 항목 처리
function cellsrenderer(row, columnfield, value, defaulthtml, columnproperties) {

	var formattedValue = value;

    var scan = "<div class='jqx-grid-cell-middle-align' style='margin-top:9px;color:blue;cursor:pointer;text-decoration:underline;'>" + formattedValue + " </div>";
                            
    return scan;
}


// 원료사용실적 등록 팝업 오픈
function fn_showPop (url){
	$("#jqxwindow").jqxWindow({ height: 470, width: 820, theme: 'summer'});
	
	
	
	//팝업 헤더 안보이게 하는 부분
//		$('.jqx-window-header').css('display', 'none');
	var opened = $("#jqxwindow").jqxWindow('isOpen');
	$("#jqxwindow").jqxWindow('setContent', "<iframe src='"+ url +"' width='100%' height='99%' scrolling='auto' frameborder='0' ></iframe>");	
	$("#jqxwindow").jqxWindow('setTitle',"원료사용실적 관리")
	$("#jqxwindow").jqxWindow("open");
}


var myWin=null; 
/** showPopup.js */
function showPopup()
{
	
var url, name, w, h, loca, top, left, status, scroll, resize;
var menubar, toolbar, locat, fullscreen;
var winprops, win;
url = arguments[0];
name = arguments[1];
if (arguments[2] == "" || arguments[2] == null)
w = 300;
else w = arguments[2];
if (arguments[3] == "" || arguments[3] == null)
h = 200;
else h = arguments[3];
if ( arguments[4] == "" || arguments[4] == null || arguments[4] == "1" || arguments[4] == "yes")
{
top = (screen.height - h) / 2;
left = (screen.width - w) / 2;
loca = 'top='+top+'; left='+left+';' ;
}
else if(arguments[4] == "0" || arguments[4] == "no")
{
if (arguments[5] == "" || arguments[5] == null)
top = 0;
else top = arguments[5];
if (arguments[6] == "" || arguments[6] == null)
left = 0;
else left = arguments[6];
loca = 'top='+top+'; left='+left+';' ;
}
else loca = '';
status = arguments[7] + '';
if (status == "" || status == null)
status = 'yes';
else if (status == "0")
status = 'no';
if (arguments[8] == "" || arguments[8] == null)
scroll = '0';
else scroll = arguments[8];
if (arguments[9] == "" || arguments[9] == null)
resize = '0';
else resize = arguments[9];
if (arguments[10] == "" || arguments[10] == null)
menubar = '0';
else menubar = arguments[10];
if (arguments[11] == "" || arguments[11] == null)
toolbar = '0';
else toolbar = arguments[11];
if (arguments[12] == "" || arguments[12] == null)
locat = '0';
else locat = arguments[12];
if (arguments[13] == "" || arguments[13] == null)
fullscreen = '0';
else fullscreen = arguments[13];
//winprops = 'width='+w+'; height='+h+'; '+loca+' status='
//+status+'; scrollbars='+scroll+'; resizable='+resize+'; menubar='
//+menubar+'; toolbar='+toolbar+'; location='+locat+'; fullscreen='+fullscreen;
winprops = 'width='+w+'; height='+h+'; '+loca+' status='
+status+'; scrollbars='+scroll+'; resizable='+resize+'; menubar='
+menubar+'; toolbar='+toolbar+'; location='+locat;
//주소창 표시로 인한 수정, fullsize 삭제
//+'; fullscreen='+fullscreen;


if (!myWin || myWin.closed ) {
	
  myWin = window.open(url,name,winprops);
} else{ 
	myWin.location=url; 
	myWin.focus(); 
}
return false;
}

/**
 * 문자열이 빈 문자열인지 체크하여 결과값을 리턴한다.
 * @param str       : 체크할 문자열
 */
function isEmpty(str){
     
    if(typeof str == "undefined" || str == null || str == "")
        return true;
    else
        return false ;
}
 
/**
 * 문자열이 빈 문자열인지 체크하여 기본 문자열로 리턴한다.
 * @param str           : 체크할 문자열
 * @param defaultStr    : 문자열이 비어있을경우 리턴할 기본 문자열
 */
function nvl(str, defaultStr){
     
    if(typeof str == "undefined" || str == null || str == "")
        str = defaultStr ;
     
    return str ;
}

/**
 * 숫자에 콤마를 추가하여 리턴한다.
 * @param str           : 체크할 문자열
 * @param defaultStr    : 문자열이 비어있을경우 리턴할 기본 문자열
 */
function addComma(number) {
    var parts = number.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
}
