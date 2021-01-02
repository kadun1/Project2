<%@page import="org.json.simple.JSONObject"%>
<%@page import="controller.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
System.out.println(id);
String backMsg = ""; 
String driver = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
MemberDAO dao = new MemberDAO(driver, url);
JSONObject json = new JSONObject();

int affected = dao.idCheck(id);

System.out.println("반환값:"+affected);
if(affected==1){
	json.put("result", 1);
	json.put("message", "중복된 아이디가 있습니다.");
	backMsg = "<h3>입력한 아이디 : "+id+"</h3>"
			+ "<h3>중복된 아이디가 존재합니다.</h3>";
}
else{
	json.put("result", 0);
	json.put("message", "사용가능한 아이디 입니다.");
	backMsg = "<h3>사용가능한 아이디 입니다.</h3>"
			+ "<input type='button' value='아이디사용하기' onclick='idUse();' />";
}
dao.close();
String jsonStr = json.toJSONString();
out.print(jsonStr);
%>