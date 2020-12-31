<%@page import="util.JavascriptUtil"%>
<%@page import="controller.BbsDAO"%>
<%@page import="controller.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="isLogin.jsp" %>
<%
if(!session.getAttribute("USER_GRADE").toString().equals("1")){
	JavascriptUtil.jsAlertBack("관리자만 수정 가능합니다.", out);
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="./include/head.jsp" %>
<script>
	/* 연습문제] 글쓰기 폼에 빈값이 있는경우 서버로 전송되지
			않도록 아래 validate()함수를 완성하시오.
			모든 값이 입력되었다면 WriteProc.jsp로 
			submit되어야 한다.
	*/
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
</script>
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
<form name="writeFrm" method="post" action="WriteProc.jsp"
	onsubmit="return checkValidate(this);">
<input type="hidden" name="btype" value=${param.btype } />
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="30%"/>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
<!-- 	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>
		<input type="text" name="name" class="form-control" />
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<input type="text" name="email" class="form-control" />
		</td>
	</tr> -->
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			<input type="text" name="title" class="form-control" />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			<textarea rows="10" name="content"
			class="form-control"></textarea>
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
    