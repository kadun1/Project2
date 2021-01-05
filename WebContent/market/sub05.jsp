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
					<img src="../images/market/sub05_title.gif" alt="체험학습신청" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;체험학습신청<p>
				</div>
				<p class="con_tit"><img src="../images/market/sub05_tit01.gif" /></p>
				<ul class="dot_list">
					<li>무 방부제 • 무첨가제 수제 빵 제작 체험</li>
					<li>사전에 준비된 반죽으로 성형 및 굽기 체험</li>
					<li>참가비 : 일인당 20,000원 (교육비, 재료비 포함)</li>
				</ul>
				<p class="con_tit"><img src="../images/market/sub05_tit02.gif" /></p>
				<ul class="dot_list">
					<li>내가만든 맛있는 쿠키~!</li>
					<li>쿠키의 반죽 ,성형, 굽기 기술 경험의 기회! </li>
					<li>참가비 : 일인당 15,000원 (교육비, 재료비 포함)</li>
				</ul>
				<p class="con_tit"><img src="../images/market/sub05_tit03.gif" /></p>
				<ul class="dot_list">
					<li>만드는 즐거움 받는이에겐 감동을~!</li>
					<li>직접 데코레이션한 세상에서 하나뿐인
케익을 소중한 사람에게 전하세요~!
</li>
					<li>준비된 케익시트에 테코레이션 과정 체험</li>
					<li>참가비 : 일인당 25,000원 (교육비, 재료비 포함)</li>
				</ul>
				<div style="text-align:left">
					<img src="../images/market/sub05_img01.jpg" style="margin-bottom:30px;" />
				</div>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;">
					<colgroup>
						<col width="25%" />
						<col width="*" />
					</colgroup>
					<tbody>
					<form name="wantExp">
					<input type="hidden" name="id" value="${sessionScope.id }" />
						<tr>
							<th>고객명/회사명</th>
							<td style="text-align:left;"><input type="text" name="name"  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>장애유무</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td style="border-bottom:0px;"><input type="radio" name="incon"  value="Y" /> 유&nbsp;&nbsp;&nbsp;<input type="radio" name="incon"  value="N" /> 무</td>
										<th style="border-bottom:0px;" width="100px">주요장애유형</th>
										<td style="border-right:0px; border-bottom:0px;"><input type="text" name="incontype"  value="" class="join_input" /></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>보장구 사용유무</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td style="border-bottom:0px;"><input type="radio" name="item"  value="Y" /> 유&nbsp;&nbsp;&nbsp;<input type="radio" name="item"  value="N" /> 무</td>
										<th style="border-bottom:0px;" width="100px">보장구 명</th>
										<td style="border-right:0px; border-bottom:0px;"><input type="text" name="itemname"  value="" class="join_input" /></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td style="text-align:left;"><input type="text" name="phone1" value="" class="join_input" style="width:50px;" maxlength="5" /> - <input type="text" name="phone2"  value="" class="join_input" style="width:50px;" onkeyup="numFocus(this, 4, 'phone3');" /> - <input type="text" name="phone3"  value="" class="join_input" style="width:50px;" onkeyup="numFocus(this, 4, 'mobile1');"/></td>
						</tr>
						<tr>
							<th>담당자 휴대전화</th>
							<td style="text-align:left;">
							<select name="mobile1" class="join_input" style="width:50px; padding:0;" onchange="numFocus(this, 3, 'mobile2');">
								<option value="010" selected>010</option>
		                        <option value="011">011</option>
		                        <option value="016">016</option>
		                        <option value="019">019</option>
							</select>
							 - 
							 <input type="text" name="mobile2"  value="" class="join_input" style="width:50px;" onkeyup="numFocus(this, 4, 'mobile3');"/> - <input type="text" name="mobile3"  value="" class="join_input" style="width:50px;" onkeyup="numFocus(this, 4, 'e_mail1');"/></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td style="text-align:left;"><input type="text" name="e_mail1"  value="" class="join_input" style="width:100px;" /> @ <input type="text" name="e_mail2"  value="" class="join_input" style="width:100px;" /></td>
						</tr>
						<tr>
							<th>체험내용</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td>케익체험</td>
										<td style="border-right:0px;"><input type="text" name="cakeexp"  value="" class="join_input" /></td>
									</tr>
									<tr>
										<td style="border-bottom:0px;">쿠키체험</td>
										<td style="border:0px;"><input type="text" name="cookieexp"  value="" class="join_input" /></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>체험희망날짜</th>
							<td style="text-align:left;">
							<input type="text" id="datepicker" name="wantday" class="join_input" readonly>
							</td>
						</tr>
						<tr>
							<th>접수종류 구분</th>
							<td style="text-align:left;"><input type="radio" name="wanttype"  value="reservation" /> 예약신청
&nbsp;&nbsp;&nbsp;<input type="radio" name="wanttype"  value="howmuch" /> 견적문의</td>
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
	var w = document.wantExp;
	w.method = "post";
	w.action = "../market/experience.do";
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
