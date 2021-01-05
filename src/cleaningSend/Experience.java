package cleaningSend;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import smtp.SMTPAuth;


@WebServlet("/market/experience.do")
public class Experience extends HttpServlet{

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String id = req.getParameter("id");
		String incon = req.getParameter("incon");
		String incontype = req.getParameter("incontype");
		String item = req.getParameter("item");
		String itemname = req.getParameter("itemname");
		String name = req.getParameter("name");
		String phone1 = req.getParameter("phone1");
		String phone2 = req.getParameter("phone2");
		String phone3 = req.getParameter("phone3");
		String mobile1 = req.getParameter("mobile1");
		String mobile2 = req.getParameter("mobile2");
		String mobile3 = req.getParameter("mobile3");
		String e_mail1 = req.getParameter("e_mail1");
		String e_mail2 = req.getParameter("e_mail2");
		String cakeexp = req.getParameter("cakeexp");
		String cookieexp = req.getParameter("cookieexp");
		String wantday = req.getParameter("wantday");
		String wanttype = req.getParameter("wanttype");
		String etc = req.getParameter("etc");
		String email = e_mail1+"@"+e_mail2;
		
		System.out.println(phone1+"-"+phone2+"-"+phone3);
		System.out.println(mobile1+"-"+mobile2+"-"+mobile3);
		System.out.println(e_mail1+"@"+e_mail2);
		System.out.println(name+"<>"+incon+"<>"+incontype+"<>"+item+"<>"+itemname+"<>"+wantday+"<>"+wanttype+"<>"+etc);
		
		String mailContents = "이름 : " + name +"<br/>";
			  mailContents += "장애유무 : " + incon +"<br/>";
			  mailContents += "장애유형 : " + incontype +"<br/>";
			  mailContents += "보장구명 : " + itemname +"<br/>";
			  mailContents += "보장구유무 : " + item +"<br/>";
			  mailContents += "연락처 : " +phone1+"-"+phone2+"-"+phone3+"<br/>";
			  mailContents += "휴대전화 : " +mobile1+"-"+mobile2+"-"+mobile3+"<br/>";
			  mailContents += "이메일 : " +e_mail1+"@"+e_mail2+"<br/>";
			  mailContents += "케잌체험 : " + cakeexp +"<br/>";
			  mailContents += "쿠키체험 : " + cookieexp +"<br/>";
			  mailContents += "희망날짜 : " + wantday +"<br/>";
			  mailContents += "접수종류 : " + wanttype +"<br/>";
			  mailContents += "기타사항 : " + etc +"<br/>";
		
		SMTPAuth smtp = new SMTPAuth();
		
		Map<String,String> emailContent = new HashMap<String,String>();
		emailContent.put("from", "kadun@naver.com");
		emailContent.put("to", email);
		emailContent.put("tome", "kaduns@nate.com");
		emailContent.put("subject", "체험학습신청");
		//emailContent.put("content", request.getParameter("content"));
		emailContent.put("content", mailContents);
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		//전송확인
		if(id != null){
			boolean emailResult = smtp.emailSending(emailContent);
			if(emailResult==true){
				System.out.println("클리닝성공");
				out.println(""
						+"<script>"
						+"alert('메일 발송 성공~~!!!');"
						+"location.href='../main/main.do;'"
						+"</script>"
						+"");
				out.close();
			}
			else{
				System.out.println("클리닝실패");
				
				out.println(""
						+"<script>"
						+"alert('발송 실패...ㅜㅜ');"
						+"history.back();"
						+"</script>"
						+"");	
				out.close();
			}
		}
	}
}
