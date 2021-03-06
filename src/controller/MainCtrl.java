package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MainCtrl extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		ServletContext app = this.getServletContext();
		BbsDAO dao = new BbsDAO(app);
		List<BbsDTO> lists = dao.selectMainPage();
		List<BbsDTO> notices = dao.selectMainNotice();
		List<BbsDTO> images = dao.selectMainImg();
		Cookie[] cookies = req.getCookies();
		String save="";
		if(cookies!=null){
			for(Cookie ck : cookies){		
				if(ck.getName().equals("SaveId")){
					//아이디저장에 관련된 값이 있는지 확인
					save = ck.getValue();
					System.out.println("save="+save);
					req.setAttribute("cookie_save", save);
				}			
			}
		}
		req.setAttribute("lists", lists);
		req.setAttribute("notices", notices);
		req.setAttribute("images", images);
		
		req.getRequestDispatcher("/main/main.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		ServletContext app = this.getServletContext();
		HttpSession session = req.getSession();
		String id = req.getParameter("user_id");
		String pw = req.getParameter("user_pw");
		String id_save = req.getParameter("id_save");
		String drv = app.getInitParameter("MariaJDBCDriver");
		String url = app.getInitParameter("MariaConnectURL");
		String returnURL = req.getParameter("returnURL");
		MemberDAO dao = new MemberDAO(drv, url);
		
		MemberDTO memberDTO = dao.getMemberDTO(id, pw);
		System.out.println("아이디:"+memberDTO.getId()+" 등급:"+memberDTO.getGrade());
		if(memberDTO.getId()!=null) {
			session.setAttribute("USER_ID", memberDTO.getId());
			session.setAttribute("USER_PW", memberDTO.getPass());
			session.setAttribute("USER_NAME", memberDTO.getName());
			session.setAttribute("USER_GRADE", memberDTO.getGrade());
			if(id_save==null) {
				makeCookie(req, resp, "SaveId", "", 0);
			}
			else {
				makeCookie(req, resp, "SaveId", id, 60*60);				
			}
			if(returnURL==null||returnURL.equals("")){
				System.out.println(returnURL);
				System.out.println(req.getParameter("returnURL"));
				resp.sendRedirect("../main/main.do");
			}
			else{
				//세션이 없어 진입하지 못한 페이지로 이동한다.
				
				resp.sendRedirect(returnURL);
			}

		}
		else {
			resp.sendRedirect("../member/loginfail.jsp");
		}
	}

	public void makeCookie(HttpServletRequest req, 
		HttpServletResponse resp, String cName, String cValue, int time){

		//쿠키객체생성
		Cookie cookie = new Cookie(cName, cValue);
		//경로설정
		cookie.setPath(req.getContextPath());
		//시간설정
		cookie.setMaxAge(time);
		//응답헤더에 쿠키추가 후 클라이언트로 전송
		resp.addCookie(cookie);
	}
}
