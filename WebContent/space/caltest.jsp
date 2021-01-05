<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.*,java.util.*"%>
<%
int year;
int month;
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
<body>

<table border="1" style="font-size:2em; text-align:center;">
	<tr>
		<td align="center" height='18' valign='bottom' colspan="7">
			<a href='caltest.jsp?year=<%=cal.get(Calendar.YEAR)%>&month=<%=((cal.get(Calendar.MONTH) + 1) - 1)%>'><font
				color='484848' size='2'>◀ </font></a> <font color='484848' size='2'><%=cal.get(Calendar.YEAR)%>
				/ <%=(cal.get(Calendar.MONTH) + 1)%> </font>
			<a href='caltest.jsp?year=<%=cal.get(Calendar.YEAR)%>&month=<%=((cal.get(Calendar.MONTH) + 1) + 1)%>'><font
				color='484848' size='2'>▶ </font></a>
		</td>
	</tr>
	<tr>
		<td>일</td>
		<td>월</td>
		<td>화</td>
		<td>수</td>
		<td>목</td>
		<td>금</td>
		<td>토</td>
	</tr>
<%
	cal.set(year, month - 1, 1);
int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
%>
	<tr>
<%for (int i = 1; i < dayOfWeek; i++) {%>
		<td></td>
<%
}
for (int i = 1; i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++) {
%>
		<td>
		<a href='day.jsp?year=<%=cal.get(Calendar.YEAR)%>&month=<%=((cal.get(Calendar.MONTH) + 1))%>&day=<%=i%>'><%=i%></a>
		</td>
<%if ((dayOfWeek - 1 + i) % 7 == 0) {%>
	</tr>
	<tr>
<%
	}
}
%>
	</tr>
</table>


</body>
</html>
