<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../member/isLogin.jsp" %>
 <body>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/market/sub03_title.gif" alt="블루크리닝 견적 의뢰" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;블루크리닝 견적 의뢰<p>
				</div>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;">
					<colgroup>
						<col width="25%" />
						<col width="*" />
					</colgroup>
					<tbody>
					<form action="../market/cleaning.do" name="wantClean">
					<input type="hidden" name="id" value="${sessionScope.id }" />
						<tr>
							<th>고객명/회사명</th>
							<td style="text-align:left;"><input type="text" name="name" value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>청소할 곳 주소</th>
							<td style="text-align:left;"><input type="text" name="address" value="" class="join_input" style="width:300px;" /></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td style="text-align:left;"><input type="text" name="phone1" value="" class="join_input" style="width:50px;" maxlength="5" /> - <input type="text" name="phone2"  value="" class="join_input" style="width:50px;" onkeyup="numFocus(this, 4, 'phone3');" /> - <input type="text" name="phone3"  value="" class="join_input" style="width:50px;" onkeyup="numFocus(this, 4, 'mobile1');"/></td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td style="text-align:left;">
							<!-- <input type="text" name="mobile1"  value="" class="join_input" style="width:50px;" /> -->
							<select name="mobile1" class="join_input" style="width:50px; padding:0;" onchange="numFocus(this, 3, 'mobile2');">
								<option value="010" selected>010</option>
		                        <option value="011">011</option>
		                        <option value="016">016</option>
		                        <option value="019">019</option>
							</select>
							 - 
							<input type="text" name="mobile2"  value="" class="join_input" style="width:50px;" onkeyup="numFocus(this, 4, 'mobile3');" /> - <input type="text" name="mobile3"  value="" class="join_input" style="width:50px;" onkeyup="numFocus(this, 4, 'e_mail1');" /></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td style="text-align:left;"><input type="text" name="e_mail1"  value="" class="join_input" style="width:100px;" /> @ <input type="text" name="e_mail2"  value="" class="join_input" style="width:100px;" /></td>
						</tr>
						<tr>
							<th>청소의뢰내역</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td>청소종류</td>
										<td style="border-right:0px;"><input type="text" name="cleantype"  value="" class="join_input" /></td>
									</tr>
									<tr>
										<td style="border-bottom:0px;">분양평수/등기평수</td>
										<td style="border:0px;"><input type="text" name="wide"  value="" class="join_input" /></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>청소 희망날짜</th>
							<td style="text-align:left;">
							<input type="text" id="datepicker" name="wantday" class="join_input" readonly> 
						</tr>
						<tr>
							<th>접수종류 구분</th>
							<td style="text-align:left;"><input type="radio" name="wanttype"  value="reservation" /> 예약신청
										&nbsp;&nbsp;&nbsp;<input type="radio" name="wanttype"  value="howto" /> 견적문의</td>
						</tr>
						<tr>
							<th>기타특이사항</th>
							<td style="text-align:left;"><input type="text" name="etc"  value="" class="join_input" style="width:400px;" /></td>
						</tr>
					</form>
					</tbody>
				</table>
				<p style="text-align:center; margin-bottom:40px"><img src="../images/btn01.gif" onclick="go();" style="cursor:pointer;" />&nbsp;&nbsp;<img src="../images/btn02.gif" onclick="back();" style="cursor:pointer"/></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
<script>
function back(){
	history.back();
}
function go(){
	var w = document.wantClean;
	w.method = "post";
	w.action = "../market/cleaning.do";
	w.submit();
}
function numFocus(obj, mLenght, next_obj){
    var strLength = obj.value.length;

    if(strLength>=mLenght){
         document.getElementsByName(next_obj)[0].focus();
    }
}
$( function() {
    $( "#datepicker" ).datepicker({
    	"dateFormat":"yy-mm-dd"
    });
});
</script>	

	<%@ include file="../include/footer.jsp" %>
 </body>
</html>
