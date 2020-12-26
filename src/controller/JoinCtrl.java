package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/join.do")
public class JoinCtrl extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();

		String name = req.getParameter("name");
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		String mobile = req.getParameter("mobile1") + "-"
				+ req.getParameter("mobile2") + "-"
				+ req.getParameter("mobile3");
		String e_mail = req.getParameter("email_1") +"@"
				+ req.getParameter("email_2");
		String zipcode = req.getParameter("zipcode");
		String address = req.getParameter("addr1") +" "
				+ req.getParameter("addr2");

		//폼값 확인
		System.out.printf("%s %s %s %s %s %s %s",
				name, id, pass, mobile, e_mail, zipcode, address );
		
		MemberDTO dto = new MemberDTO();
		dto.setName(name);
		dto.setId(id);
		dto.setPass(pass);
		dto.setMobile(mobile);
		dto.setMail(e_mail);
		dto.setZipcode(zipcode);
		dto.setAddress(address);
		
		ServletContext app = this.getServletContext();
		String driver = app.getInitParameter("MariaJDBCDriver");
		String url = app.getInitParameter("MariaConnectURL");
		MemberDAO dao = new MemberDAO(driver, url);
		
		int sof = dao.registMember(dto);
		
		dao.close();
		
		if(sof==1) {
			System.out.println(sof);
			out.println("<script>alert('"+id+"님 환영합니다'); location.href='../main/main.do';</script>");
			out.close();
			
		}
		else {
			System.out.println(sof);
			out.println("<script>alert('회원가입에 실패했습니다.'); history.back(); </script>");
			out.close();
		}
	}
}
