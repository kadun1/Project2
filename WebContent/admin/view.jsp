<%@page import="controller.BbsDAO"%>
<%@page import="controller.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="isLogin.jsp" %>
<%
String queryStr = "";
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
if(searchWord!=null){
	queryStr += "searchColumn="+searchColumn+"&searchWord="+searchWord;
}
//2페이지에서 상세보기 했다면 리스트로 돌아갈때도 페이지가 유지되어야 한다.
String nowPage = request.getParameter("nowPage");

if(nowPage==null){
	queryStr += "&nowPage="+1;
}
else{
	queryStr += "&nowPage="+nowPage;
}

//파라미터로 전송된 게시물의 일련번호를 받음
String num = request.getParameter("num");
String btype = request.getParameter("btype");
queryStr += "&btype=" + btype;
BbsDAO dao = new BbsDAO(application);

//일련번호에 해당하는 게시물을 DTO객체로 반환함
BbsDTO dto = dao.selectView(num, btype);

dao.close();
%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="./include/head.jsp" %>
<body id="page-top">
<%@ include file="./include/navbar.jsp" %>
  <div id="wrapper">
	<%@ include file="./include/sidebar.jsp" %>

    <div id="content-wrapper">

      <div class="container-fluid">
        <!-- Page Content -->
        <h1>상세보기</h1>
        <hr>
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
			<%=dto.getE_mail() %>
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
		<%if(dto.getBtype().equals("2")){ %>
			<img src="../space/Upload/<%=dto.getSfile() %>" alt="이미지" />
			<br />
		<%} %>
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
</form>
<div style="float:right;">
<form name="deleteFrm">
	<input type="hidden" name="num" value="<%=dto.getNum() %>" />
	<input type="hidden" name="btype" value="${param.btype }" />
</form>
	<button type="button" class="btn btn-primary"
		onclick="location.href='edit.jsp?num=<%=dto.getNum()%>&btype=${param.btype }';">수정하기</button>
	<button type="button" class="btn btn-success"
		onclick="isDelete();">삭제하기</button>
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
		onclick="location.href='board.jsp?<%=queryStr %>';">리스트보기</button>	
		</div>
      </div>
      <!-- /.container-fluid -->
</div>
<%@ include file="./include/footer.jsp" %>

    </div>
    <!-- /.content-wrapper -->
  </div>
  <!-- /#wrapper -->
<%@ include file="./include/bottom.jsp" %>
  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin.min.js"></script>

</body>

</html>
    