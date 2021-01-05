<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(function() { 
	$.ajax({
		url : "../common/calajax.jsp",
		type : "post",	
		dataType : "html",
		contentType : "application/x-www-form-urlencoded;chatset:utf-8",
		success : function(Date){
				$("#calDisplay").html(Date);	
		},
		error : function(request,status,error){
	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});

	$(document).on('click', '#prevButton', function(){
		$.ajax({
			url : "../common/calajax.jsp",
			type : "post",
			data :
			{
				year : $('#prevYear').val(),
				month : $('#prevMonth').val()
			},
			dataType : "html",
			contentType : "application/x-www-form-urlencoded;chatset:utf-8",
			success : function(Date){
					$("#calDisplay").html(Date);	
			},
			error : function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	});
	$(document).on('click', '#nextButton', function(){
		$.ajax({
			url : "../common/calajax.jsp",
			type : "post",
			data :
			{
				year : $('#nextYear').val(),
				month : $('#nextMonth').val()
			},
			dataType : "html",
			contentType : "application/x-www-form-urlencoded;chatset:utf-8",
			success : function(Date){
					$("#calDisplay").html(Date);	
			},
			error : function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	});	
});
function loginValidate(fn){
	if(!fn.user_id.value){
		alert("아이디를 입력하세요");
		fn.user_id.focus();
		return false;
	}
	if(fn.user_pw.value==""){
		alert("패스워드를 입력하세요");
		fn.user_pw.focus();
		return false;
	}
}
</script>