<%@page import="controller.BbsDAO"%>
<%@page import="controller.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
String queryStr = "";
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
if(searchWord!=null){
	queryStr += "searchColumn="+searchColumn+"&searchWord="+searchWord;
}
//2페이지에서 상세보기 했다면 리스트로 돌아갈때도 페이지가 유지되어야 한다.
String nowPage = request.getParameter("nowPage");
queryStr += "&nowPage="+nowPage;


//파라미터로 전송된 게시물의 일련번호를 받음
String num = request.getParameter("num");
BbsDAO dao = new BbsDAO(application);

//조회수를 업데이트하여 visitcount컬럼을 1증가시킴
dao.updateVisitCount(num);

//일련번호에 해당하는 게시물을 DTO객체로 반환함
BbsDTO dto = dao.selectView(num);

dao.close();
%>

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
					<img src="../images/space/sub03_title.gif" alt="자유게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
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
		<td><%=dto.getId() %></td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td><%=dto.getPostdate() %></td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			nakjasabal@naver.com
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td><%=dto.getVisitcount() %></td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			<%=dto.getTitle() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			<%=dto.getContent().replace("\r\n","<br/>") %>
		</td>
	</tr>
	<!-- <tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td colspan="3">
			파일명.jpg
		</td>
	</tr> -->
</tbody>
</table>

<div class="row text-right" style="float:right; margin-right:2px;">
	<!-- 각종 버튼 부분 -->
<%
/*
로그인이 완료된 상태에서만 수정/삭제 버튼을 보이게하고, 
또한 작성자에게만 노출되도록 한다. 작성자가 아니라면 
버튼은 숨김처리된다. 
*/
if(session.getAttribute("USER_ID")!=null &&
	session.getAttribute("USER_ID").toString().equals(dto.getId())){
%>
	<button type="button" class="btn btn-primary"
		onclick="location.href='BoardEdit.jsp?num=<%=dto.getNum()%>';">수정하기</button>
	<button type="button" class="btn btn-success"
		onclick="isDelete();">삭제하기</button>
<%
}
%>
<form name="deleteFrm">
	<input type="hidden" name="num" value="<%=dto.getNum() %>" />
</form>
<script>
	function isDelete(){
		var c = confirm("삭제할까요?");
		if(c){
			var f = document.deleteFrm;
			f.method = "post";
			f.action = "DeleteProc.jsp"
			f.submit();
		}
	}
</script>
			 		
	<button type="button" class="btn btn-warning" 
		onclick="location.href='BoardList.jsp?<%=queryStr %>';">리스트보기</button>
</div>
</form> 

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
 </body>
</html>