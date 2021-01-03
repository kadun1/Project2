package admin;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.MemberDAO;
import controller.MemberDTO;

public class LoginCtrl extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		ServletContext app = this.getServletContext();
		HttpSession session = req.getSession();
		String id = req.getParameter("admin_id");
		String pw = req.getParameter("admin_pw");
		//String id_save = req.getParameter("id_save"); 쿠키
		String drv = app.getInitParameter("MariaJDBCDriver");
		String url = app.getInitParameter("MariaConnectURL");
		MemberDAO dao = new MemberDAO(drv, url);
		
		MemberDTO memberDTO = dao.getMemberDTO(id, pw);
		if(memberDTO.getId()!=null) {
			session.setAttribute("USER_ID", memberDTO.getId());
			session.setAttribute("USER_PW", memberDTO.getPass());
			session.setAttribute("USER_NAME", memberDTO.getName());
			session.setAttribute("USER_GRADE", memberDTO.getGrade());
			System.out.println(memberDTO.getGrade());
			if(memberDTO.getGrade().equals("1")) {
				resp.sendRedirect("../admin/index.jsp");
			}
			else {
				resp.sendRedirect("../admin/loginfail.jsp");
			}
		}
		else {
			resp.sendRedirect("../admin/loginfail.jsp");
			
		}
		
	}
}
