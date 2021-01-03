<%@page import="controller.BbsDAO"%>
<%@page import="controller.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/global_head.jsp" %>
<script>
	function checkValidate(fm){
		if(fm.title.value==""){
			alert("제목을 입력하세요."); 
			fm.title.focus(); 
			return false; 
		}
		if(fm.content.value==""){
			alert("내용을 입력하세요."); 
			fm.content.focus(); 
			return false;
		}
		if(fm.ofile.value==""){
			alert("이미지를 첨부하세요."); 
			return false;
		}
	}
</script>
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
			<form method="post" action="../space/imgWrite.do" enctype="multipart/form-data"
				onsubmit="return checkValidate(this);">
			<input type="hidden" name="btype" value="${param.btype }" />
			<input type="hidden" name="id" value="${sessionScope.USER_ID }"/>
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
						style="vertical-align:middle;">제목</th>
					<td colspan="3">
						<input type="text" class="form-control" name="title" />
					</td>
				</tr>
				<tr>
					<th class="text-center" 
						style="vertical-align:middle;">내용</th>
					<td colspan="3">
						<textarea rows="10" class="form-control" name="content"></textarea>
					</td>
				</tr>
				<tr>
					<th class="text-center" 
						style="vertical-align:middle;">첨부파일</th>
				<td colspan="3">
					<input type="file" class="form-control"	name="ofile" />
				</td>
				</tr>
			</tbody>
			</table>
</div>
<!-- 각종 버튼 부분 -->
<div class="row mb-3">
	<div class="col text-right">		
		<button type="submit" class="btn btn-danger">전송하기</button>
		<button type="reset" class="btn btn-dark">Reset</button>			
		<button type="button" class="btn btn-warning" 
			onclick="location.href='../space/image.do?btype=${dto.btype }&nowPage=${param.nowPage }&searchColumn=${param.searchColumn }&searchWord=${param.searchWord }';">
		리스트보기</button>
	</div>	
</form>
</div>

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
 </body>
</html>