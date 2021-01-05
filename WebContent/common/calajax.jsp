<%@ page import="java.text.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
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
%>
<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title05.gif" alt="월간일정 CALENDAR" /></p>
<div class="cal_top">
	<table cellpadding="0" cellspacing="0" border="0">
		<colgroup>
			<col width="13px;" />
			<col width="*" />
			<col width="13px;" />
		</colgroup>
		<tr>
			<!-- 이전달 -->
			<td>
			<input type="hidden" id="prevYear" value="<%=cal.get(Calendar.YEAR)%>"/>
			<input type="hidden" id="prevMonth" value="<%=((cal.get(Calendar.MONTH) + 1) - 1)%>" />
			<button id="prevButton" style="border:0;"><img src="../images/cal_a01.gif" style="margin-top:3px;" /></button>
			</td>
			
			<!-- 현재 년/월 -->
			<td><span id="currentYear"><%=cal.get(Calendar.YEAR)%></span>년 / <span id="currentMonth"><%=(cal.get(Calendar.MONTH) + 1)%>월</span></td>
			<!-- 다음달 -->
			<td>
			<input type="hidden" id="nextYear" value="<%=cal.get(Calendar.YEAR)%>"/>
			<input type="hidden" id="nextMonth" value="<%=((cal.get(Calendar.MONTH) + 1) + 1)%>" />
			<button id="nextButton" style="border:0; "><img src="../images/cal_a02.gif" style="margin-top:3px;" /></button>
			</td>
		</tr>
	</table>
</div>
<div class="cal_bottom">
<table cellpadding="0" cellspacing="0" border="0" class="calendar">
	<colgroup>
		<col width="14%" />
		<col width="14%" />
		<col width="14%" />
		<col width="14%" />
		<col width="14%" />
		<col width="14%" />
		<col width="*" />
	</colgroup>
	<tr>
		<th><img src="../images/day01.gif" alt="S" /></th>
		<th><img src="../images/day02.gif" alt="M" /></th>
		<th><img src="../images/day03.gif" alt="T" /></th>
		<th><img src="../images/day04.gif" alt="W" /></th>
		<th><img src="../images/day05.gif" alt="T" /></th>
		<th><img src="../images/day06.gif" alt="F" /></th>
		<th><img src="../images/day07.gif" alt="S" /></th>
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
		<a href='../space/ScheduleView.jsp?btype=3&year=<%=cal.get(Calendar.YEAR)%>&month=<%=((cal.get(Calendar.MONTH) + 1))%>&day=<%=i%>'><%=i%></a>
		</td>
<% if ((dayOfWeek - 1 + i) % 7 == 0) { %>						
	</tr>
	<tr>
<%	}
} %>					
	</tr>
</table>
</div>