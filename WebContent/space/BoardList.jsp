<%@page import="util.PagingUtil"%>
<%@page import="controller.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="controller.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
String mid = application.getInitParameter("MariaUser");
String mpw = application.getInitParameter("MariaPass");

BbsDAO dao = new BbsDAO(drv, url, mid, mpw);

Map<String, Object> param = new HashMap<String, Object>();

String queryStr = "";
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");

if(searchWord!=null){
	
	param.put("Column", searchColumn);
	param.put("Word", searchWord);
	
	queryStr += "searchColumn="+searchColumn
			 +"&searchWord="+searchWord+"&";
}

int totalRecordCount = dao.getTotalRecordCountSearch(param);//조인사용

int pageSize = Integer.parseInt(
		application.getInitParameter("PAGE_SIZE"));
int blockPage = Integer.parseInt(
		application.getInitParameter("BLOCK_PAGE"));

int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);

int nowPage = (request.getParameter("nowPage")==null 
|| request.getParameter("nowPage").equals(""))
? 1 : Integer.parseInt(request.getParameter("nowPage"));

//한페이지에 출력할 게시물의 범위를 결정한다. MariaDB에서는 limit를 사용하므로
//계산식이 조금 달라지게 된다.
int start = (nowPage-1)*pageSize;
int end = pageSize;

//게시물의 범위를 Map컬렉션에 저장하고 DAO로 전달한다.
param.put("start", start);
param.put("end", end);
/******페이지 처리를 위한 코드 추가 end ******/

List<BbsDTO> bbs = dao.selectListPageSearch(param);//페이지처리O+회원이름검색

dao.close();
%>
 <body>
<div class="container">
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>
		<img src="../images/space/sub_image.jpg" id="main_visual" />
		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub03_title.gif" alt="자유게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;자유게시판<p>
				</div>
				<div class="center_contents">
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
					    <button class="btn btn-danger" type="submit">
					    <i class='fa fa-search' style='font-size:20px'></i>
					    </button>
					  </form>
					</nav>
				</div>
				<div>
				<table style="font-size:1.2em;" class="table table-bordered table-hover table-striped">
				<colgroup>
					<col width="60px"/>
					<col width="*"/>
					<col width="100px"/>
					<col width="100px"/>
					<col width="80px"/>
				</colgroup>
				<thead>
				<tr style="background-color: darkgray; " class="text-center text-white">
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<!-- <th>첨부</th> -->
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
					<td class="text-center"><%= vNum %></td>
					<td class="text-left">
						<a href="BoardView.jsp?num=<%=dto.getNum() %>&nowPage=<%=nowPage %>&<%=queryStr %>"><%=dto.getTitle() %></a>
					</td>
					<td class="text-center"><%=dto.getName() %></td>
					<td class="text-center"><%=dto.getPostdate() %></td>
					<td class="text-center"><%=dto.getVisitcount() %></td>
				</tr>
							<!-- 리스트반복 end -->
		<%
			}
		}
		%>
					</tbody>			
				</table>
				<div align=right>
				<button type="button" class="btn btn-primary" 
						onclick="location.href='BoardWrite.jsp';">글쓰기</button>
				</div>
				</div>
			<div>
			<div class="col">
					<!-- 페이지번호 부분 -->
					<ul class='pagination justify-content-center'>
						<!-- 매개변수설명
						totalRecordCount : 게시물의 전체갯수
						pageSize : 한페이지에 출력할 게시물의 갯수
						blockPage : 한 블록에 표시할 페이지번호의 갯수
						nowPage : 현제페이지 번호
						"BoardList.jsp?" : 해당 게시판의 실행 파일명
						--> 
						<%=PagingUtil.pagingBS4(totalRecordCount,
							pageSize, blockPage, nowPage,
							"BoardList.jsp?"+queryStr) %>
					</ul>
				</div>				
			</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	<%@ include file="../include/footer.jsp" %>
</div>
 </body>
</html>
