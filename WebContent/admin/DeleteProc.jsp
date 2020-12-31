<%@page import="util.JavascriptUtil"%>
<%@page import="controller.BbsDAO"%>
<%@page import="controller.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="isLogin.jsp" %>
<%
String num = request.getParameter("num");
String btype = request.getParameter("btype");
BbsDTO dto = new BbsDTO();
BbsDAO dao = new BbsDAO(application);

//작성자 본인확인을 위해 기존 게시물의 내용을 가져온다. 
dto = dao.selectView(num, btype);

//세션영역에 저장된 로그인 아이디를 String형으로 가져온다. 
String grade = session.getAttribute("USER_GRADE").toString();//방법1
//String session_id = (String)session.getAttribute("USER_ID");//방법2
System.out.print(btype);
System.out.print(grade);
int affected = 0;

//작성자 본인 확인을 위해 DB에 입력된 작성자와 세션영역에 저장된 속성을 비교한다.
if(grade.equals("1")){
	dto.setNum(num);//dto에 일련번호를 저장한후..
	affected = dao.delete(dto);//delete 메소드 호출
}
else{
	//작성자 본인이 아닌경우...
	JavascriptUtil.jsAlertBack("관리자만 삭제가능합니다.", out);
	return; 
}

if(affected==1){
	/*
	삭제이후에는 기존 게시물이 사라지므로 리스트로 이동해서
	삭제된 내역을 확인한다. 
	*/
	JavascriptUtil.jsAlertLocation("삭제되었습니다", 
		"board.jsp?btype="+btype, out);	
}
else{
	out.println(JavascriptUtil.jsAlertBack("삭제실패하였습니다"));
}

%>