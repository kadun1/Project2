<%@page import="controller.MemberDAO"%>
<%@page import="controller.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>id_overapping.jsp</title>
<script type="text/javascript">
$(function(){
	$('#idCheck').click(function(){
		$.ajax({
			url : "../idCheck.do",
			type : "get",
			data : {
				id : $("#id").val()
			},
			dataType : "html",
			contentType : "text/html;charset:utf-8",
			success : function(d){
				if(d==$("#id").val()){
					alert("아이디가 중복되었습니다.");
					$("#check").val("아이디 재입력");
					$("#id").val("");
					$("#useId").hide();
				}
				else{
					alert("사용 가능한 아이디 입니다.");
					$("#useId").show();
				}
			},
			error : function(e){
				alert("실패"+e.status);
			}
		});
	});
	$('#idCheck').trigger("click");
});
function idUse(){
	 
	opener.document.registFrm.id.value = 
			document.getElementById("id").value;
	self.close();
}
</script>
</head>
<body>
	<h2>아이디 중복확인</h2>	 
	<h3 id="check"></h3>
	<input type="text" id="id" name="retype_id" value=${param.id } size="22" />
	<br/><br/>
	<p><input type="button" value="중복확인" id="idCheck"/>
	<input type="button" id="useId" value="아이디사용하기" onclick="idUse();" /></p>
</body>
</html>