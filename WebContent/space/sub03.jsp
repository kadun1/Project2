<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<style>
  table {
    width: 100%;
    height: 60%;
    border: 1px solid black;
    border-collapse: collapse;
    text-align: center;
  }
  th, td {
    border: 1px solid #444444;
  }
  table tr:first-child td{
  	border: none;
  	text-align: center;
  	color: red;
  }
</style>
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
					<tr>
						<td>
						<a href=""><<</a>
						</td>
						<td colspan="5" style="border:0; font-size:1.4em">2021년 &nbsp;&nbsp;&nbsp; 1월</td>
						<td>
						<a href="">>></a>
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
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td>1</td>
					</tr>
					<tr>
						<td>2</td>
						<td>3</td>
						<td>4</td>
						<td>5</td>
						<td>6</td>
						<td>7</td>
						<td>8</td>
					</tr>
					<tr>
						<td>9</td>
						<td>10</td>
						<td>11</td>
						<td>12</td>
						<td>13</td>
						<td>14</td>
						<td>15</td>
					</tr>
					<tr>
						<td>16</td>
						<td>17</td>
						<td>18</td>
						<td>19</td>
						<td>20</td>
						<td>21</td>
						<td>22</td>
					</tr>
					<tr>
						<td>23</td>
						<td>24</td>
						<td>25</td>
						<td>26</td>
						<td>27</td>
						<td>28</td>
						<td>29</td>
					</tr>
					<tr>
						<td>30</td>
						<td>31</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
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
