<%@page import="controller.MemberDAO"%>
<%@page import="controller.MemberDTO"%>
<%@page import="controller.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="controller.BbsDAO"%>
<%@page import="util.PagingUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="isLogin.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

MemberDAO dao = new MemberDAO(application);

Map<String, Object> param = new HashMap<String, Object>();

//쿼리스트링..안쓰일듯
String queryStr = "";
//검색어 관련
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
String grade = request.getParameter("grade");

if(searchWord!=null){
	param.put("Column", searchColumn);
	param.put("Word", searchWord);
	
	queryStr += "searchColumn="+searchColumn
			 +"&searchWord="+searchWord+"&";
}
int totalRecordCount = dao.getTotalRecordCountSearch(param);

int pageSize = Integer.parseInt(
		application.getInitParameter("PAGE_SIZE"));
int blockPage = Integer.parseInt(
		application.getInitParameter("BLOCK_PAGE"));

int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);

int nowPage = (request.getParameter("nowPage")==null 
|| request.getParameter("nowPage").equals(""))
? 1 : Integer.parseInt(request.getParameter("nowPage"));

int start = (nowPage-1)*pageSize;
int end = pageSize;

//파라미터 맵에 저장
param.put("start", start);
param.put("end", end);


List<MemberDTO> members = dao.selectMember(param);//페이지처리O+회원정보검색;
dao.close();
%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="./include/head.jsp" %>
<body id="page-top">
<%@ include file="./include/navbar.jsp" %>
  <div id="wrapper">
	<%@ include file="./include/sidebar.jsp" %>
    <div id="content-wrapper">

      <div class="container-fluid">
        <!-- Page Content -->
        <hr>
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
			회원관리
           </div>
          <div class="card-body">
          		<div class="center_contents" style="padding-right:0;">
					<nav class="navbar navbar-expand-sm bg-white navbar-dark">
					  <form class="form-inline ml-auto">
					  	<select name="searchColumn" class="form-control" id=>
					  		<option value="id"
					  		<%=(searchColumn!=null && searchColumn.equals("id")) ?
							"selected" : ""%>>아이디</option>
					  		<option value="name"
					  		<%=(searchColumn!=null && searchColumn.equals("name")) ?
							"selected" : ""%>>이름</option>
					  		<option value="mobile"
					  		<%=(searchColumn!=null && searchColumn.equals("mobile")) ?
							"selected" : ""%>>휴대폰</option>
					  	</select>
					    <input name="searchWord" class="form-control mr-sm-2" type="text">
					    <button class="btn btn-info" type="submit">
					    <i class='fa fa-search' style='font-size:20px'></i>
					    </button>
					  </form>
					</nav>
				</div>
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
              <colgroup>
              	<col width="58px"/>
				<col width="100px"/>
				<col width="100px"/>
				<col width="150px"/>
				<col width="*"/>
				<col width="110px"/>
				<col width="100px"/>
				<col width="100px"/>
				<col width="80px"/>
              	<col width="70px"/>
              </colgroup>
                <thead>
                  <tr style="text-align:center">
                    <th>번호</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>주소</th>
                    <th>우편번호</th>
                    <th>연락처</th>
                    <th>가입일</th>
                    <th>등급</th>
                    <th>변경</th>
                  </tr>
                </thead>
                <tbody>
		<%
		/*
		List컬렉션에 입력된 데이터가 없을때 true를 반환
		*/
		if(members.isEmpty()){
			//게시물이 없는 경우...
		%>
 				<tr>
 					<td colspan="10" align="center" height="100">
 						등록된 회원이이 없습니다. 
 					</td>
 				</tr>
		<%
		}
		else
		{
			//게시물이 있는경우...
						
			int vNum = 0;//게시물의 가상번호로 사용할 변수
			int countNum = 0;
			for(MemberDTO dto : members){
				vNum = totalRecordCount - 
						(((nowPage-1) * pageSize) + countNum++);
		%>
				<tr>
					<form action="memberEdit.jsp" method="post">
					<td class="text-center"><!-- 가상번호 -->
						<%= vNum %>   
					</td>
					<td class="text-center"><%=dto.getId() %></td>
					<td class="text-center"><%=dto.getName() %></td>
					<td class="text-center"><%=dto.getMail() %></td>
					<td class="text-center"><%=dto.getAddress() %></td>
					<td class="text-center"><%=dto.getZipcode() %></td>
					<td class="text-center"><%=dto.getMobile() %></td>
					<td class="text-center"><%=dto.getRegidate() %></td>
					<td class="text-center">
					<select name="grade" class="form-control"
						 style="height:20px; padding-top:0; padding-bottom:0; font-size:0.8em;">
				  		<option value="1"
				  		<%= (dto.getGrade()!=null && dto.getGrade().equals("1")) ?
						"selected" : ""%>>1</option>
				  		<option value="2"
				  		<%= (dto.getGrade()!=null && dto.getGrade().equals("2")) ?
						"selected" : ""%>>2</option>
				  	</select>
					</td>
					<!-- <td class="text-center">
		            	<button type="button" style="font-size:8px;"
		            		onclick="location.href='edit.jsp?btype='" >수정</button>
					</td>
					<td class="text-center">
              			<button type="button" style="font-size:8px;">삭제</button>		            	
					</td> -->
					<input type="hidden" name="num" value="<%=dto.getNum() %>" />
					<td><button type="submit" style="font-size:12px">변경</button></td>
              		</form>
				</tr>
					<%
			}
		}
					%>
                </tbody>
              </table>
              
             <%--  <div class="col text-right" style="float:right;">
              <button type="button" class="btn btn-success"
              	onclick="location.href='write.jsp?btype=<%=btype%>';">글쓰기</button>
              </div> --%>
             <div style="clear:both;"></div>
              <div class="col">
					<!-- 페이지번호 부분 -->
					<ul class='pagination justify-content-center'>
						<%=PagingUtil.pagingBS4(totalRecordCount,
							pageSize, blockPage, nowPage,
							"board.jsp?"+queryStr) %>
					</ul>
				</div>
            </div>
          </div>
          <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
        </div>

      </div>
      <!-- /.container-fluid -->

<%@ include file="./include/footer.jsp" %>

    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->
<%@ include file="./include/bottom.jsp" %>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin.min.js"></script>

</body>

</html>
