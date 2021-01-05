<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<style type="text/css" media="screen">
@import url("../css/common.css");
@import url("../css/main.css");
@import url("../css/sub.css");
</style>
<%@ include file="../include/mainJSinclude.jsp"%>
</head>
<body>
<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>
		
		<div id="main_visual">
		<a href="/product/sub01.jsp"><img src="../images/main_image_01.jpg" /></a><a href="/product/sub01_02.jsp"><img src="../images/main_image_02.jpg" /></a><a href="/product/sub01_03.jsp"><img src="../images/main_image_03.jpg" /></a><a href="/product/sub02.jsp"><img src="../images/main_image_04.jpg" /></a>
		</div>
		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title01.gif" alt="로그인 LOGIN" /></p>
				<div class="login_box">
 				<form action="../main/main.do" method="post" name="loginFrm" onsubmit="return loginValidate(this);" >
				<%
				if(session.getAttribute("USER_ID")==null){
				%>
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="45px" />
							<col width="120px" />
							<col width="55px" />
						</colgroup>
						<tr>
							<th><img src="../images/login_tit01.gif" alt="아이디" /></th>
							<td><input type="text" name="user_id" value='<%=(request.getAttribute("cookie_save")==null) ? "" : request.getAttribute("cookie_save").toString() %>'
								 class="login_input" tabindex="1"/></td>
							<td rowspan="2"><input type="image" src="../images/login_btn01.gif" alt="로그인" /></td>
						</tr>
						<tr>
							<th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
							<td><input type="password" name="user_pw" value="" class="login_input" tabindex="2"/></td>
						</tr>
					</table>
					<p>
						<input type="checkbox" name="id_save" value="Y" tabindex="3"
					<%if(request.getAttribute("cookie_save")!=null){ %>
						 	checked='checked' <% } %>  />
						 <img src="../images/login_tit03.gif" alt="저장" />
						<a href="../member/id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>
						<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a>
					</p>
					<%} else { %>
					<p style="padding:10px 0px 10px 10px"><span style="font-weight:bold; color:#333;"><%=session.getAttribute("USER_NAME") %>님,</span> 반갑습니다.<br />로그인 하셨습니다.</p>
					<p style="text-align:right; padding-right:10px;">
						<a href=""><img src="../images/login_btn04.gif" /></a>
						<a href="../member/logout.jsp"><img src="../images/login_btn05.gif" /></a>
					</p>
					<% } %>
				</form>
				</div>
			</div>
 			
			<div class="main_con_center">
				<p class="main_title"><img src="../images/main_title02.gif" alt="공지사항 NOTICE" /><a href="/space/sub01.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
				<c:forEach items="${notices }" var="row" varStatus="loop">
					<li><p style="width:200px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;">
					<a href="../space/BoardView.jsp?num=${row.num }&btype=0">${row.title }</a>
					<span>${row.postdate }</span></p></li>
				</c:forEach>
				</ul>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a href="/space/sub03.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
				<c:forEach items="${lists }" var="row" varStatus="loop">
					<li><p style="width:200px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;">
					<a href="../space/BoardView.jsp?num=${row.num }&btype=1">${row.title }</a>
					<span>${row.postdate }</span></p></li>
				</c:forEach>
				</ul>
			</div>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title"><img src="../images/main_title04.gif" alt="월간일정 CALENDAR" /></p>
				<img src="../images/main_tel.gif" />
			</div>
			<div class="main_con_center" id="calDisplay">
			
			<!-- 일정표 ajax 삽입부분 -->
		
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a href="/space/sub04.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_photo_list">
				<c:forEach items="${images }" var="row" varStatus="loop">
					<li>
						<dl>
							<dt><a href="../space/imageView.do?num=${row.num }&btype=2">
							<img src="../space/Upload/${row.sfile }" style="width:101px; height:83px;"/>
							</a></dt>
							<dd><a href="../space/imageView.do?num=${row.num }&btype=2">
							<p style="width:100px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;">${row.title }</p>
							</a></dd>
						</dl>
					</li>
				</c:forEach>
				</ul>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
	</div>

	<%@ include file="../include/footer.jsp"%>
	
</center>
</body>
</html>