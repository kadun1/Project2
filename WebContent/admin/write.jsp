<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="isLogin.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
String btype = request.getParameter("btype");
if(!session.getAttribute("USER_GRADE").toString().equals("1")){
	JavascriptUtil.jsAlertBack("관리자만 수정 가능합니다.", out);
	return;
}
%>
<%@ include file="./include/head.jsp" %>
<script>
$( function() {
    $( "#datepicker" ).datepicker({
    	"dateFormat":"yymd"
    });
  });
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

<!DOCTYPE html>
<html>
<body id="page-top">
<%@ include file="./include/navbar.jsp" %>
  <div id="wrapper">
	<%@ include file="./include/sidebar.jsp" %>

    <div id="content-wrapper">

      <div class="container-fluid">
        <!-- Page Content -->
        <h1>게시물 작성</h1>
        <hr>
		<div>
<form name="writeFrm" method="post" 
<%if(btype.equals("2")||btype.equals("4")||btype.equals("5")){ %>
			 action="../admin/imgWrite.do" enctype="multipart/form-data"
			onsubmit="return checkValidatefile(this);"
<%}else{ %> action="WriteProc.jsp"
			onsubmit="return checkValidate(this);"<%} %>   >
<input type="hidden" name="btype" value=${param.btype } />
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
		<th class="text-center"	style="vertical-align:middle;">제목</th>
		<td colspan="3">
			<input type="text" name="title" class="form-control" />
		</td>
	</tr>
	<tr>
		<th class="text-center" style="vertical-align:middle;">내용</th>
		<td colspan="3">
			<textarea rows="10" name="content"
			class="form-control"></textarea>
		</td>
	</tr>
<%if(btype.equals("2")||btype.equals("4")||btype.equals("5")){ %>
	<tr>
		<th class="text-center" style="vertical-align:middle;">첨부파일</th>
		<td colspan="3">
			<input type="file" class="form-control" name="ofile"/>
		</td>
	</tr>
<%}else if(btype.equals("3")){  %>
	<tr>
		<th class="text-center" style="vertical-align:middle;">일정</th>
		<td colspan="3">
		<input type="text" id="datepicker" name="schedule">  
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
  </div>
    <!-- /.content-wrapper -->
  <!-- /#wrapper -->
<%@ include file="./include/bottom.jsp" %>
  <!-- Bootstrap core JavaScript-->
 
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin.min.js"></script>



</body>

</html>
    