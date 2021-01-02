<%@page import="util.JavascriptUtil"%>
<%@page import="controller.MemberDAO"%>
<%@page import="controller.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="isLogin.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String num = request.getParameter("num");
String grade = request.getParameter("grade");

//DTO 생성 및 저장
MemberDTO dto = new MemberDTO();
dto.setNum(num);
dto.setGrade(grade);

//DAO객체생성
MemberDAO dao = new MemberDAO(application);

int affected = dao.editGrade(dto);

if(affected==1){
	JavascriptUtil.jsAlertBack("회원등급을 수정하였습니다", out);
}
else{
%>
<script>
	alert("수정하기에 실패하였습니다.");
	history.go(-1);
</script>
<%
}
dao.close();
%>
