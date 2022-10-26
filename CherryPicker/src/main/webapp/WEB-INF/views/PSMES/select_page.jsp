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
		fn_search("/PSMES/PSMES_UI910_search.do", "grid",setColumn,"100%");
	});
	
	/*그리드 초기화*/
	setGrid("grid", "",setColumn,"100%");
	/*그리드 초기화 끝*/
	
	/*그리드 이벤트 끝*/
	 
	 
});

$( window ).resize( function() {
	
} );



/*그리드 설정 */
//그리드 링크 항목 처리

 
//그리드 콤보관련 끝 

//그리드 컬럼 셋팅
var setColumn = [
	
	{ text: '항목1'		, columntype: 'textbox', datafield: 'AAA'		, cellsalign: 'center', align: 'center',  width: 150 },
	{ text: '항목2'		, columntype: 'textbox', datafield: 'BBB'		, cellsalign: 'center', align: 'center',  width: 150 },
	{ text: '항목3'		, columntype: 'textbox', datafield: 'CCC'		, cellsalign: 'center', align: 'center',  width: 150 },
	{ text: '항목4'		, columntype: 'textbox', datafield: 'DDD'		, cellsalign: 'center', align: 'center',  width: 150 },
	{ text: '항목5'		, columntype: 'textbox', datafield: 'EEE'		, cellsalign: 'center', align: 'center' },
	{ text: 'CHK'		, columntype: 'textbox', datafield: 'CHK'	, hidden: true }
];
  

/*그리드 설정 끝*/
 
/*사용자 함수 시작*/

/*사용자 함수 끝*/

</script>

<body>
<form id="form1" name="form1" style="height: 100%;">
<input type="hidden" id="pCdTp" name="pCdTp">
<input type="hidden" name="gridData" id="gridData" value="">
<input type="hidden" name="gridData2" id="gridData2" value="">

	<!-- #wrap -->
	<div id="wrap" >
		<div id="content" style="height:100%" id ="content">			
			<div class="content-inner hid" style="height:100%">
				<div class="inner_top">
					<h3 class="tit">거래처관리</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnSearch" style="display: inline-block;">조회</a>
					</div>
				</div>
				
				<div class="inner p_10" style="height:100%">		
					<section class="section-search">
						<form1>
							<div class="form-row">
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
