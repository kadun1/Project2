<%@page import="util.PagingUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/global_head.jsp"%>
<body>
	<div class="container">
		<div id="wrap">
			<%@ include file="../include/top.jsp"%>
			<img src="../images/space/sub_image.jpg" id="main_visual" />
			<div class="contents_box">
				<div class="left_contents">
					<%@ include file="../include/space_leftmenu.jsp"%>
				</div>
				<div class="right_contents">
					<div class="top_title">
						<img src="../images/space/sub2.gif" alt="사진게시판" class="con_title" />
						<p class="location">
							<img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판
						<p>
					</div>
					<div class="center_contents">
						<nav class="navbar navbar-expand-sm bg-white navbar-dark">
							<form class="form-inline ml-auto">
								<input type="hidden" name="btype" value="${param.btype }" />
								<div class="form-group">
									<select name="searchColumn" class="form-control">
										<option value="title">제목</option>
										<option value="content">내용</option>
										<option value="name">작성자</option>
									</select>
								</div>
								<div class="input-group">
									<input type="text" name="searchWord" class="form-control" />
									<div class="input-group-btn">
										<button type="submit" class="btn btn-danger">
											<i class='fa fa-search' style='font-size: 20px'></i>
										</button>
									</div>
								</div>
							</form>
						</nav>
						<c:choose>
							<c:when test="${empty lists }">
								<p>등록된 게시물이 없습니다.</p>
							</c:when>
							<c:otherwise>

								<c:set var="i" value="0" />
								<c:set var="j" value="3" />
								<table>
									<c:if test="${map.btype eq '2' }">
										<c:forEach items="${lists }" var="row" varStatus="loop">
											<c:if test="${i%j == 0 }">
												<tr>
											</c:if>
											<td style="padding: 8px; padding-top: 1px;">
												<div class="card" style="max-width: 233px; height: 320px;">
													<a href="imageView.do?num=${row.num }&nowPage=${map.nowPage }&btype=${row.btype }
			    										&searchColumn=${param.searchColumn }&&searchWord=${param.searchWord }">
															<img class="card-img-top" id="imgView" src="./Upload/${row.sfile }" alt="${row.sfile }"	style="height: 200px">
													</a>
													<div class="card-body" style="text-align: center;">
														<a href="../space/imageView.do?num=${row.num }&nowPage=${map.nowPage }&btype=${row.btype }
		    												&searchColumn=${param.searchColumn }&&searchWord=${param.searchWord }">
															<h4 class="card-title">${row.title }</h4>
														</a>
														 <span>작성자 : ${row.name }</span> <br /> <span>${row.postdate }</span>
													</div>
												</div>
											</td>
											<c:if test="${i%j == j-1 }">
												</tr>
											</c:if>
											<c:set var="i" value="${i+1 }" />
										</c:forEach>
										<p></p>
									</c:if>
								</table>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="col">
						<!-- 페이지번호 부분 -->
						<ul class='pagination justify-content-center'>
							${map.pagingImg }
						</ul>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
	</div>
	<%@ include file="../include/footer.jsp"%>
	</div>
</body>
</html>
