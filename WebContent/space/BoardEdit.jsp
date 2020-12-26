<%@page import="util.JavascriptUtil"%>
<%@page import="controller.BbsDTO"%>
<%@page import="controller.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../member/isLogin.jsp" %>
<%
//파라미터로 전송된 게시물의 일련번호를 받음
String num = request.getParameter("num");
BbsDAO dao = new BbsDAO(application);

//본인이 작성한 게시물이므로 조회수 증가는 의미없음.

//일련번호에 해당하는 게시물을 DTO객체로 반환함
BbsDTO dto = dao.selectView(num);

//본인확인 후 작성자가 아니면 뒤로보내기
if(!session.getAttribute("USER_ID").toString().equals(dto.getId())){
	JavascriptUtil.jsAlertBack("작성자 본인만 수정 가능합니다.", out);
	return;
}

dao.close();
%>
<script>
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
</script>
 <body>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub03_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
				</div>
				<div>

<form name="writeFrm" method="post" action="EditProc.jsp"
	onsubmit="return checkValidate(this);">
<input type="hidden" name="num" value="<%=num %>" />
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<!-- <tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>
			<input type="text" class="form-control" 
				style="width:100px;" />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<input type="text" class="form-control" 
				style="width:400px;" />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">패스워드</th>
		<td>
			<input type="text" class="form-control" 
				style="width:200px;" />
		</td>
	</tr> -->
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td>
			<input type="text" name="title"
				value="<%=dto.getTitle() %>" class="form-control" />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td>
			<textarea rows="10" name="content"
			class="form-control"><%=dto.getContent()%></textarea>
		</td>
	</tr>
	<!-- <tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td>
			<input type="file" class="form-control" />
		</td>
	</tr> -->
</tbody>
</table>

<div class="row text-center" style="float:right; margin-right:2px;">
	<!-- 각종 버튼 부분 -->
	
	<button type="submit" class="btn btn-danger">전송하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='BoardList.jsp';">리스트보기</button>
</div>
</form> 

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
 </body>
</html>