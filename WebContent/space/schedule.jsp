<%@page import="controller.BbsDTO"%>
<%@page import="controller.BbsDAO"%>
<%@ page import="java.text.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String btype = request.getParameter("btype");
BbsDAO dao = new BbsDAO(application);

Map<String, String> map = dao.selectAllSchedule(btype);

int year, month;
Calendar today = Calendar.getInstance();
Calendar cal = new GregorianCalendar();
year = (request.getParameter("year") == null) ? today.get(Calendar.YEAR)
		: Integer.parseInt(request.getParameter("year"));

month = (request.getParameter("month") == null) ? today.get(Calendar.MONTH) + 1
		: Integer.parseInt(request.getParameter("month"));

if (month <= 0) {
	month = 12;
	year = year - 1;
} else if (month >= 13) {
	month = 1;
	year = year + 1;
}
cal.set(Calendar.YEAR, year);
cal.set(Calendar.MONTH, (month - 1));
cal.set(Calendar.DATE, 1);

dao.close();
%>
<%@ include file="../include/schedulecss.jsp" %>
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
					<img src="../images/space/sub3.gif" alt="프로그램일정" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정<p>
				</div>
				<div>
				<table>
					<tr class="nottr">
						
						<th colspan="7" style="border:0; font-size:1.4em">
							
							<!-- 이전달 -->
							<a href='schedule.jsp?year=<%=cal.get(Calendar.YEAR)%>&month=<%=((cal.get(Calendar.MONTH) + 1) - 1)%>&btype=${param.btype}'>
							<span>◀ </span>
							</a>&nbsp;&nbsp;&nbsp;
							
							<!-- 현재 년/월 -->
							<span><%=cal.get(Calendar.YEAR)%>년 / <%=(cal.get(Calendar.MONTH) + 1)%>월</span>&nbsp;&nbsp;&nbsp;&nbsp;
							
							<!-- 다음달 -->
							<a href='schedule.jsp?year=<%=cal.get(Calendar.YEAR)%>&month=<%=((cal.get(Calendar.MONTH) + 1) + 1)%>&btype=${param.btype}'>
							<span>▶</span>
							</a>
							
						</th>
					</tr>
					<tr>
						<th style="color: red; vertical-align:middle;">일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th style="color: blue;">토</th>
					</tr>
<%
	cal.set(year, month - 1, 1);
int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
%>
					<tr>
<% for (int i = 1; i < dayOfWeek; i++) {%>
						<td></td>
<% } for (int i = 1; i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++) { %>		
						<td>
						<a href='ScheduleView.jsp?year=<%=cal.get(Calendar.YEAR)%>&month=<%=((cal.get(Calendar.MONTH) + 1))%>&day=<%=i%>&btype=${param.btype}'><%=i%><br/>
<% 
String schedule = Integer.toString(cal.get(Calendar.YEAR))+
			Integer.toString((cal.get(Calendar.MONTH) + 1))+
			Integer.toString(i);

if(map.containsKey(schedule)){
%>
<%=map.get(schedule) %>
<%} %>						
						</a>
						</td>
<% if ((dayOfWeek - 1 + i) % 7 == 0) { %>						
					</tr>
					<tr>
<%	}
} %>					
					</tr>
				</table>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
</div>

	<%@ include file="../include/footer.jsp" %>
 </body>
</html>
