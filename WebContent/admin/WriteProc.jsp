<%@page import="controller.BbsDAO"%>
<%@page import="controller.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../member/isLogin.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String title = request.getParameter("title");//제목
String content = request.getParameter("content");//내용
title= new String(title .getBytes("8859_1"), "UTF-8");
content = new String(content .getBytes("8859_1"), "UTF-8");
String btype = request.getParameter("btype");
String schedule = request.getParameter("schedule");
System.out.println("게시판타입:"+btype);
System.out.println("스케쥴:"+schedule);
System.out.println("제목:"+title);
System.out.println("내용:"+content);

//DTO객체에 폼값과 아이디 저장
BbsDTO dto = new BbsDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setBtype(btype);
//일정게시판이면 일정도 저장..
if(schedule!=null){
	dto.setSchedule(schedule);	
} 
//세션영역에 저장된 회원인증정보를 가져와서 DTO에 삽입
dto.setId(session.getAttribute("USER_ID").toString());

//DAO객체 생성시 application내장객체를 파라미터로 전달
BbsDAO dao = new BbsDAO(application); 

//사용자의 입력값을 저장한 DTO객체를 DAO로 전달후 insert처리

int affected = dao.insertWrite(dto);
if(affected==1){
	/*
	새로운 게시물이 작성되었으므로 확인을 위해
	리스트의 첫번째 페이지로 이동해야 한다. 
	*/
	response.sendRedirect("board.jsp?btype="+btype);
}
else{
%>
	<script>
		alert("글쓰기에 실패하였습니다.");
		history.go(-1);
	</script>
<%	
}
%>

