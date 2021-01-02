package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/idCheck.do")
public class IdCheck extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json;charset=UTF-8");
		req.setCharacterEncoding("UTF-8");
		String id =req.getParameter("id");

		ServletContext app = this.getServletContext();
		String driver = app.getInitParameter("MariaJDBCDriver");
		String url = app.getInitParameter("MariaConnectURL");
		MemberDAO dao = new MemberDAO(driver, url);
		PrintWriter out = resp.getWriter();
		
		int affected = dao.idCheck(id);
		System.out.println(affected);
		if(affected==1){
			 out.print(id);
		}
		else {
			//out.print("b");
		}
	}
}
