<%@page import="controller.MemberDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="smtp.SMTPAuth"%>
<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
//폼값받기
String name = request.getParameter("name");
String email = request.getParameter("email");
String id = request.getParameter("id");

System.out.println(name+" "+email+" "+id);
//DB연결
String driver = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
MemberDAO dao = new MemberDAO(driver, url);

//DAO에서 비번받기
String findpw = dao.pwFind(id, name, email);

//메일연동
SMTPAuth smtp = new SMTPAuth();
//메일보낼 내용
String mailContents = "아이디 : "+id+" 비번:"+findpw;

//정보 맵에 저장
Map<String,String> emailContent = new HashMap<String,String>();
emailContent.put("from", "kadun@naver.com");
emailContent.put("to", email);
emailContent.put("subject", "비밀번호 찾기 결과");
//emailContent.put("content", request.getParameter("content"));
emailContent.put("content", mailContents);

//전송확인
if(findpw != null){
	boolean emailResult = smtp.emailSending(emailContent);
	if(emailResult==true){
		JavascriptUtil.jsAlertLocation("메일발송성공", "../main/main.do;");
	}
	else{
		JavascriptUtil.jsAlertBack("메일발송실패ㅜㅜ", out);
	}
	//return;
	}
%>