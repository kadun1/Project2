<%@page import="util.PagingUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/global_head.jsp" %>
 <body>
<div class="container">
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>
		<img src="../images/space/sub_image.jpg" id="main_visual" />
		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;자유게시판<p>
				</div>
				<div class="center_contents">
					<nav class="navbar navbar-expand-sm bg-white navbar-dark">
					  <form class="form-inline ml-auto">	
					<div class="form-group">
	<select name="searchColumn" class="form-control">
		<option value="title">제목</option>		
		<option value="content">내용</option>
		<option value="name">작성자</option>
	</select>
					</div>
					<div class="input-group">
	<input type="text" name="searchWord"  class="form-control"/>
						<div class="input-group-btn">
	<button type="submit" class="btn btn-danger">
		<i class='fa fa-search' style='font-size:20px'></i>
	</button>
						</div>
					</div>
				</form>
					  
					</nav>
				</div>
				
<c:choose>
	<c:when test="${empty lists }">
		<p>등록된 게시물이 없습니다.</p>
	</c:when>
	<c:otherwise>
	<div class="card-columns">
	<c:if test="${map.btype eq '2' }">
		<c:forEach items="${lists }" var="row" varStatus="loop">
			<div class="card" style="height:350px">
				  <img class="card-img-top" src="./Upload/${row.sfile }" alt="${row.sfile }" style="height:60%">
				  <div class="card-body">
				    <a href="ImageView.do?num=${row.num }&nowPage=${map.nowPage }
				    	&searchColumn=${param.searchColumn }&&searchWord=${param.searchWord }">
				    		<h4 class="card-title">${row.title }</h4></a>
				    <h5>작성자 : ${row.name }</h5>
				  </div>
				</div>
		</c:forEach>
	</c:if>
	</div>
	</c:otherwise>
</c:choose>
			<div>
			<div class="col">
					<!-- 페이지번호 부분 -->
					<ul class='pagination justify-content-center'>
					${map.pagingImg }
					</ul>
				</div>				
			</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	<%@ include file="../include/footer.jsp" %>
</div>
 </body>
</html>
