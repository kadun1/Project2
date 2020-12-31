<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
Cookie[] cookies = request.getCookies();
String save="";

if(cookies!=null){
	for(Cookie ck : cookies){		
		if(ck.getName().equals("SaveId")){
			//아이디저장에 관련된 값이 있는지 확인
			save = ck.getValue();
		}			
	}
}
%>
<script>
function loginValidate(fn){
	if(!fn.user_id.value){
		alert("아이디를 입력하세요");
		fn.user_id.focus();
		return false;
	}
	if(fn.user_pw.value==""){
		alert("패스워드를 입력하세요");
		fn.user_pw.focus();
		return false;
	}
}
</script>
 <body>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/login_title.gif" alt="인사말" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p>
				</div>
				<div class="login_box01">
					<form action="../main/main.do" method="post" name="loginFrm" onsubmit="return loginValidate(this);" >
					<img src="../images/login_tit.gif" style="margin-bottom:30px;" />
					<ul>
						<li><img src="../images/login_tit001.gif" alt="아이디" style="margin-right:15px;" />
						<input type="text" name="user_id" value='<%=(save.length()==0) ? "" : save %>' class="login_input01" /></li>
						<li><img src="../images/login_tit002.gif" alt="비밀번호" style="margin-right:15px;" />
						<input type="text" name="user_pw" value="" class="login_input01" /></li>
						
						<div width=0 height=0 style="visibility:hidden">
						<input type="hidden" name="returnURL" value="${param.returnURL}" size="10" />
						<input type="checkbox" name="id_save" value="Y" tabindex="3"
						<%if(save.length()!=0){ %> checked='checked' <% } %>  />
						</div>
						
					</ul>
					<input type="image" src="../images/login_btn.gif" class="login_btn01" />
					</form>
				</div>
				<p style="text-align:center; margin-bottom:50px;"><a href=""><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>&nbsp;<a href=""><img src="../images/login_btn03.gif" alt="회원가입" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
 </body>
</html>
