<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
	해당 페이지처럼 JSP코드를 포함한 파일을 include 할때는
	지시어를 통해 기술하는것이 좋다. 액션태그를 사용하는 경우
	먼저 컴파일된후 페이지에 삽입되므로 문제가 될 수 있다. 
*/

//글쓰기 페이지 진입전 로그인 되었는지 확인
if(session.getAttribute("USER_ID")==null||
		!session.getAttribute("USER_GRADE").equals("1")){
	
%>
	<script>
		alert("관리자 로그인이 필요합니다.");
		location.href ="../admin/login.jsp";
	</script>
<%
	/*
	JS코드보다 JSP코드가 우선순위가 높으므로 만약 if문 뒤에
	JSP코드가 존재하면 위의 JS코드가 실행되지 않을수 있다. 
	그러므로 if문을 벗어나지 못하도록 return을 걸어줘야한다.
	*/
	return;
	}
%>
