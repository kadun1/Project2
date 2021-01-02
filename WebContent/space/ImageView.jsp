<%@page import="controller.BbsDAO"%>
<%@page import="controller.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/global_head.jsp" %>
<body>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub2.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				</div>
				<div>
			<form enctype="multipart/form-data">
			<table class="table table-bordered">
			<colgroup>
				<col width="20%"/>
				<col width="30%"/>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th class="text-center" 
						style="vertical-align:middle;">작성자</th>
					<td>${dto.name }</td>
					<th class="text-center" 
						style="vertical-align:middle;">작성일</th>
					<td>${dto.postdate }</td>
				</tr>
				<tr>
					<th class="text-center" 
						style="vertical-align:middle;">이메일</th>
					<td>
						${dto.e_mail }
					</td>
					<th class="text-center" 
						style="vertical-align:middle;">조회수</th>
					<td>${dto.visitcount }</td>
				</tr>
				<tr>
					<th class="text-center" 
						style="vertical-align:middle;">제목</th>
					<td colspan="3">
						${dto.title }
					</td>
				</tr>
				<tr>
					<th class="text-center" 
						style="vertical-align:middle;">내용</th>
					<td colspan="3">
						<img src="./Upload/${dto.sfile }" alt="${dto.ofile }" />
						<br/>
						${dto.content }
					</td>
				</tr>
				<tr>
					<th class="text-center" 
						style="vertical-align:middle;">첨부파일</th>
				<td colspan="3">
					${dto.ofile }
					<a href="../space/download.do?sfile=${dto.sfile }&ofile=${dto.ofile }&num=${dto.num}">
						[다운로드]
					</a>				
				</td>
				</tr>
			</tbody>
			</table>
			</form>
<!-- 각종 버튼 부분 -->
<div class="row mb-3">
<div class="col-6"> 
<button type="button" class="btn btn-secondary"
	onclick="location.href='../space/imgEdit.do&btype=${dto.btype }&num=${param.num}&nowPage=${param.nowPage }&searchColumn=${param.searchColumn }&searchWord=${param.searchWord }&id=${dto.id }';">
	수정하기</button>
<button type="button" class="btn btn-success"
	onclick="location.href='../space/imgDelete.doe&btype=${dto.btype }&num=${dto.num}&nowPage=${param.nowPage }&searchColumn=${param.searchColumn }&searchWord=${param.searchWord }&id=${dto.id }';">
	삭제하기</button> 
</div>
<div class="col-6 text-right pr-5">					
<button type="button" class="btn btn-warning" 
	onclick="location.href='../space/image.do?btype=${dto.btype }&nowPage=${param.nowPage }&searchColumn=${param.searchColumn }&searchWord=${param.searchWord }';">
리스트보기</button>
			</div>	
</div>

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
 </body>
</html>