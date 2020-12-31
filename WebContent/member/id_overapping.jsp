<%@page import="controller.MemberDAO"%>
<%@page import="controller.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");

String driver = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
MemberDAO dao = new MemberDAO(driver, url);
int affected = dao.idCheck(id);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>id_overapping.jsp</title>
<script type="text/javascript">
function idUse(){
	 
	opener.document.registFrm.id.value = 
			document.overlapFrm.retype_id.value;
	self.close();
}
</script>
</head>
<body>
	<h2>아이디 중복확인</h2>	 
	<h3>입력한 아이디 : <%=id %></h3>
<%if(affected==1){%> <h3>중복된 아이디가 존재합니다.</h3>
<%}else{ %>	<h3>사용가능한 아이디 입니다.</h3> <%} %>
	<form name="overlapFrm">
		<input type=
		<%if(affected==1){ %>"text"<%}else{ %>"hidden"<%} %>
		 	name="retype_id" value=<%=request.getParameter("id") %> size="20" />
		<%-- <%if(affected==1){ %><input type="button" value="중복확인" onclick="idCheck();"/>
		<%} %> --%>
		<input type="button" value="아이디사용하기" onclick="idUse();" />
		
	</form>
</body>
</html>