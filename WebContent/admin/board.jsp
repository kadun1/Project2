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

//커넥션풀 연결
BbsDAO dao = new BbsDAO(application);

Map<String, Object> param = new HashMap<String, Object>();

//쿼리스트링
String queryStr = "";
//검색어 관련
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
String btype = request.getParameter("btype");
//게시판 타입..(필요없을지도)

param.put("btype", btype); //맵에 게시판 타입 저장

if(searchWord!=null){
	
	param.put("Column", searchColumn);
	param.put("Word", searchWord);
	
	queryStr += "searchColumn="+searchColumn
			 +"&searchWord="+searchWord+"&";
}
queryStr += "btype="+btype+"&";
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


List<BbsDTO> bbs = dao.selectListPageSearch(param);//페이지처리O+회원이름검색


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
            <c:choose>
            <c:when test="${param.btype eq '0'}">
            	공지사항
            </c:when>
            <c:when test="${param.btype eq '1'}">
            	회원게시판
            </c:when>
            <c:otherwise>
            	직원게시판
            </c:otherwise>
            </c:choose>
           </div>
          <div class="card-body">
          		<div class="center_contents" style="padding-right:0;">
					<nav class="navbar navbar-expand-sm bg-white navbar-dark">
					  <form class="form-inline ml-auto" action="/action_page.php">
					  	<select name="searchColumn" class="form-control" id=>
					  		<option value="title"
					  		<%=(searchColumn!=null && searchColumn.equals("title")) ?
							"selected" : ""%>>제목</option>
					  		<option value="content"
					  		<%=(searchColumn!=null && searchColumn.equals("content")) ?
							"selected" : ""%>>내용</option>
					  		<option value="name"
					  		<%=(searchColumn!=null && searchColumn.equals("name")) ?
							"selected" : ""%>>작성자</option>
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
              	<col width="60px"/>
				<col width="*"/>
				<col width="100px"/>
				<col width="80px"/>
				<col width="150px"/>
				<col width="70px"/>
				<col width="70px"/>
              </colgroup>
                <thead>
                  <tr style="text-align:center">
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                    <th>수정</th>
                    <th>삭제</th>
                  </tr>
                </thead>
                <tbody>
		<%
		/*
		List컬렉션에 입력된 데이터가 없을때 true를 반환
		*/
		if(bbs.isEmpty()){
			//게시물이 없는 경우...
		%>
 				<tr>
 					<td colspan="6" align="center" height="100">
 						등록된 게시물이 없습니다. 
 					</td>
 				</tr>
		<%
		}
		else
		{
			//게시물이 있는경우...
						
			int vNum = 0;//게시물의 가상번호로 사용할 변수
			int countNum = 0;
			for(BbsDTO dto : bbs){
				vNum = totalRecordCount - 
						(((nowPage-1) * pageSize) + countNum++);
		%>
				<tr>
					<td class="text-center"><!-- 가상번호 -->
						<%= vNum %>   
					</td>
					<td class="text-left">
						<a href="view.jsp?num=<%=dto.getNum() %>&nowPage=<%=nowPage %>&<%=queryStr %>&btype=<%=dto.getBtype()%>"><%=dto.getTitle() %></a>
					</td>
					<td class="text-center"><%=dto.getName() %></td>
					<td class="text-center"><%=dto.getVisitcount() %></td>
					<td class="text-center"><%=dto.getPostdate() %></td>
					<td class="text-center">
		            	<button type="button" style="font-size:8px;"
		            		onclick="location.href='edit.jsp?btype=<%=btype %>'" >수정</button>
					</td>
					<td class="text-center">
              			<button type="button" style="font-size:8px;">삭제</button>		            	
					</td>
				</tr>
					<%
			}
		}
					%>
                </tbody>
              </table>
              
              <div class="col text-right" style="float:right;">
              <button type="button" class="btn btn-success"
              	onclick="location.href='write.jsp?btype=<%=btype%>';">글쓰기</button>
              </div>
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
