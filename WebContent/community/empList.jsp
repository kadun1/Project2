<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/global_head.jsp" %>
<body>
<div class="container">
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>
		<img src="../images/community/sub_image.jpg" id="main_visual" />
		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/community/sub${param.btype }.gif" alt="직원자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;
						<c:if test="${param.btype eq '5' }">직원자료실	</c:if>
						<c:if test="${param.btype eq '6' }">보호자게시판</c:if>
					<p>
				</div>
				<div class="center_contents">
					<nav class="navbar navbar-expand-sm bg-white navbar-dark">
					  <form class="form-inline ml-auto">
					  <input type="hidden" name="btype" value="${param.btype }" />
					  	<select name="searchColumn" class="form-control" id=>
					  		<option value="title" >제목</option>
					  		<option value="content"	>내용</option>
					  		<option value="name" >작성자</option>
					  	</select>
					    <input name="searchWord" class="form-control mr-sm-1" type="text">
					    <button class="btn btn-danger" type="submit">
					    <i class='fa fa-search' style='font-size:20px'></i>
					    </button>
					  </form>
					</nav>
				</div>
				<div>
				<table style="font-size:1.2em;" class="table table-bordered table-hover table-striped">
				<colgroup>
					<col width="60px"/>
					<col width="*"/>
					<col width="150px"/>
					<col width="120px"/>
					<col width="80px"/>
					<col width="60px"/>
				
				</colgroup>
				<thead>
				<tr style="background-color: darkgray; " class="text-center text-white">
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>첨부</th>
				</tr>
				</thead>				
				<tbody>
<c:choose>	
	<c:when test="${empty lists }">
				<tr>
 					<td colspan="6" align="center" height="100">
 						등록된 게시물이 없습니다. 
 					</td>
 				</tr>
	</c:when>
	<c:otherwise>
			<c:forEach items="${lists }" var="row" varStatus="loop">
 				<tr>
					<td class="text-center">
						${map.totalCount - (((map.nowPage-1) * map.pageSize) + loop.index)}   
					</td>
					<td class="text-left">
		<a href="../community/empView.do?num=${row.num }&nowPage=${map.nowPage }&searchColumn=${param.searchColumn }&searchWord=${param.searchWord }&btype=${param.btype}">${row.title }</a>
					</td>
					<td class="text-center">${row.name }</td>
					<td class="text-center">${row.postdate }</td>
					<td class="text-center">${row.visitcount }</td>
					<td class="text-center">
<c:if test="${not empty row.ofile }">
					<a href="../space/download.do?sfile=${row.sfile }&ofile=${row.ofile }&num=${row.num }">
						<i class="material-icons" style="font-size:20px">File</i>
					</a>
</c:if>
					</td>
				</tr>
		</c:forEach>		
	</c:otherwise>	
</c:choose>
					</tbody>
				</table>
	<c:if test="${btype ne '0' }">
				<div align=right>
				<button type="button" class="btn btn-primary" 
						onclick="location.href='empWrite.do?btype=${param.btype}';">글쓰기</button>
				</div>
	</c:if>
				</div>
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
