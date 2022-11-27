<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page session="false" %> --%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ page import="com.CherryPicker.web.common.util.CommonUtils" %>
<%@ page import="com.CherryPicker.web.comm.UserVO" %>
<%@ page import="java.util.*" %>
<%

UserVO user = (UserVO)session.getAttribute("UserInfo");

String pSearchStaDt = CommonUtils.diffDate(7);
String pSearchEndDt = CommonUtils.currenDate();

String pROrderPk = request.getParameter("pROrderPk");	
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

<link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/4.3.1/flatly/bootstrap.min.css">
  <script src="<c:url value='/resources/js/jquery-simple-upload.js'/>"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
  <style>
   body { min-height: 100vh; 
   	
   }
  .container { margin: 0px auto; max-width: 960px; font-family: 'Open Sans'; }
  .dropZone {
    width: 100%;
    height: 250px;
    border: 1px solid #ccc;
    text-align: center;
    line-height: 250px;
    font-size:1.5rem;
  }
  #basic_message {

  }
  
  #content h3.tit {
  
  }
  </style>
	</head>
<script type="text/javascript">

$(document).ready(function() {
	
	//조회버튼
	$('#btnClose').click(function () {
		opener.fn_detail_search();
		window.close();
	});
});
</script>
<body >
<div id="wrap" >	
  <div class="container" style="margin: 0px auto;">
  	<div id="content" style="height:100%" id ="content">			
			<div class="content-inner hid" style="height:100%">
				<div class="inner_top">
					<h3 class="tit" style="height: 40px;line-height: 40px;font-size: 16px;color: #333333;margin: 0;display: block;float: left;font-family: 'Noto Sans KR', sans-serif;">도면등록</h3>
					<div class="top_btn">
						<a href="#n" class="btn1" id="btnClose"  >닫기</a> 
					</div>
				</div> 
 <br>			 
  <input type="file" name="input_file" multiple="true" id="basic">
  <div id="basic_drop_zone" class="dropZone mt-3 mb-3"><div><i class="fas fa-upload"></i> 도면파일을 영역안에 가져오세요.</div></div>
  <div id="basic_progress"></div>
  <div id="basic_message" class="alert alert-danger"></div>
  			</div>
  		</div>
	</div> 	 			
</div>  
  <script>
  $('#basic').simpleUpload({
    url: '/CPMES/CPMES_UI210_FIleUp.do',
    method: 'post',
    params: { pROrderPk: '<%=pROrderPk%>' },
    dropZone: '#basic_drop_zone',
    progress: '#basic_progress'
  }).on('upload:before', function(e, files) {
    console.log('before');
    console.log(files);
  }).on('upload:after', function(e, files) {
    console.log('after');
    console.log(files);
  }).on('upload:start', function(e, file, i) {
    console.log('start ' + i);
    console.log(file);
  }).on('upload:progress', function(e, file, i, loaded, total) {
    console.log('progress ' + i + ' ' + loaded + '/' + total);
  }).on('upload:end', function(e, file, i) {
    console.log('end ' + i);
    console.log(file);
  }).on('upload:done', function(e, file, i) {
    console.log('done ' + i);
    console.log(file);
    $('#basic_message').prepend('<p>done: ' + file.name + '</p>');
  }).on('upload:fail', function(e, file, i) {
    console.log('fail ' + i);
    console.log(file);
    $('#basic_message').prepend('<p>fail: ' + file.name + '</p>');
  });
  </script>
</body>
</html>
