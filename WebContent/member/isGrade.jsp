<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(!(session.getAttribute("USER_GRADE").toString().equals("1")||
		session.getAttribute("USER_GRADE").toString().equals("2"))){
	JavascriptUtil.jsAlertBack("직원만 로그인 가능합니다.");
};
%>