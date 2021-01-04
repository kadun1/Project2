<%@page import="util.JavascriptUtil"%>
<%@page import="controller.BbsDAO"%>
<%@page import="controller.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="isLogin.jsp" %>
<%
//파라미터로 전송된 게시물의 일련번호를 받음
String num = request.getParameter("num");
String btype = request.getParameter("btype");
BbsDAO dao = new BbsDAO(application);

BbsDTO dto = dao.selectView(num, btype);

if(!session.getAttribute("USER_GRADE").toString().equals("1")){
	JavascriptUtil.jsAlertBack("관리자만 수정 가능합니다.", out);
	return;
}
//일련번호에 해당하는 게시물을 DTO객체로 반환함

dao.close();
%>

<!DOCTYPE html>
<html lang="en">
<%@ include file="./include/head.jsp" %>
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
	}
	
	function checkValidatefile(fm){
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
			alert("파일을 첨부하세요."); 
			return false;
		}
	}
</script>
<body id="page-top">
<%@ include file="./include/navbar.jsp" %>
  <div id="wrapper">
	<%@ include file="./include/sidebar.jsp" %>

    <div id="content-wrapper">

      <div class="container-fluid">
        <!-- Page Content -->
        <h1>수정하기</h1>
        <hr>
		<div>
<form name="writeFrm" method="post" 
<%if(btype.equals("2")||btype.equals("4")||btype.equals("5")){ %>
			 action="../admin/imgEdit.do" enctype="multipart/form-data"
			onsubmit="return checkValidatefile(this);"
<%}else{ %> action="EditProc.jsp"
			onsubmit="return checkValidate(this);"<%} %>   >
<input type="hidden" name="num" value="<%=num %>" />
<input type="hidden" name="btype" value="<%=btype %>" />
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
		<td>
		<input type="text" name="name"
				value="<%=dto.getId() %>" class="form-control" />
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td><%=dto.getPostdate() %></td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<input type="text" name="email"
				value="<%=dto.getE_mail() %>" class="form-control" />
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td><%=dto.getVisitcount() %></td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			<input type="text" name="title"
				value="<%=dto.getTitle() %>" class="form-control" />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			<textarea rows="10" name="content"
			class="form-control"><%=dto.getContent()%></textarea>
		</td>
	</tr>
<%if(btype.equals("2")||btype.equals("4")||btype.equals("5")){ %>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td>
			기존파일명:<%=dto.getOfile() %>
			<input type="file" class="form-control" name="ofile"/>
		</td>
	</tr>
<%} %>
</tbody>
</table>
<div style="float:right;">
	<button type="submit" class="btn btn-danger">전송하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='board.jsp?btype=${param.btype }';">리스트보기</button>	
		</div>
</form>
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
    