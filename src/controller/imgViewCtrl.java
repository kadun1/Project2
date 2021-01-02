package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/space/imageView.do")
public class imgViewCtrl extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String num = req.getParameter("num");
		String btype = req.getParameter("btype");
		
		ServletContext ctx = this.getServletContext();
		BbsDAO dao = new BbsDAO(ctx);
		
		//일련번호에 해당하는 출력할 게시물을 가져온다.
		BbsDTO dto = dao.selectView(num, btype);
		
		//조회수를 증가시킨다. 
		dao.updateVisitCount(num);
		
		//게시물의 줄바꿈 처리를 위해 replace()를 사용한다. 
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
		
		dao.close();
		
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/space/ImageView.jsp").forward(req, resp);
		
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doGet(req, resp);
	}
}
