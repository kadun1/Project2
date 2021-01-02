package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.JavascriptUtil;

@WebServlet("/space/imgEdit.do")
public class ImgEditCtrl extends HttpServlet{

	/*
	상세보기 페이지에서 수정/삭제 버튼을 눌러서 패스워드 검증폼으로 
	진입할때의 요청 처리
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//전송된 3가지 값을 가져와 변수에 저장한다. 
		String num = req.getParameter("num");
		String mode = req.getParameter("mode");
		String id = req.getParameter("id"); 
		String btype = req.getParameter("btype");
		HttpSession session = req.getSession();
		ServletContext app = this.getServletContext();
		String sessionId = session.getAttribute("USER_ID").toString();
		
		System.out.printf("num=%s, mode=%s, id=%s, btype=%s, sid=%s",
				 num, mode, id, btype, sessionId);
		
		
		if(sessionId.equals(id)) {
			//패스워드 검증을 위해 model호출. 
			BbsDAO dao = new BbsDAO(app);
			boolean isCorrect = dao.isCorrectPassword(id, num);
			req.setAttribute("ID_CORRECT", isCorrect);
			dao.close();
			req.getRequestDispatcher("/space/PassMessage.jsp")
			.forward(req, resp);	
			
		}
		else {
			System.out.println("게시물 작성자가 아닙니다.");
			JavascriptUtil.jsAlertBack("게시물 작성자가 아닙니다");
		}

		//패스워드 검증 결과를 request영역에 저장한다. 

	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}








