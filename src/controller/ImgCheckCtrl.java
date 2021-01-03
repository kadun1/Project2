/*
 * package controller;
 * 
 * import java.io.IOException;
 * 
 * import javax.servlet.ServletContext; import javax.servlet.ServletException;
 * import javax.servlet.annotation.WebServlet; import
 * javax.servlet.http.HttpServlet; import javax.servlet.http.HttpServletRequest;
 * import javax.servlet.http.HttpServletResponse; import
 * javax.servlet.http.HttpSession;
 * 
 * import util.JavascriptUtil;
 * 
 * @WebServlet("/space/imgCheck.do") public class ImgCheckCtrl extends
 * HttpServlet{
 * 
 * @Override protected void service(HttpServletRequest req, HttpServletResponse
 * resp) throws ServletException, IOException { String num =
 * req.getParameter("num"); String id = req.getParameter("id"); String mode =
 * req.getParameter("mode"); String btype = req.getParameter("btype");
 * HttpSession session = req.getSession(); ServletContext app =
 * this.getServletContext(); String sessionId =
 * session.getAttribute("USER_ID").toString();
 * 
 * System.out.printf("num=%s, id=%s, btype=%s, sid=%s, mode=%s", num, id, btype,
 * sessionId, mode);
 * 
 * if(sessionId.equals(id)) { //패스워드 검증을 위해 model호출. BbsDAO dao = new
 * BbsDAO(app);
 * 
 * boolean isCorrect = dao.isCorrectPassword(id, num);
 * 
 * //패스워드 검증 결과를 request영역에 저장한다. req.setAttribute("ID_CORRECT", isCorrect);
 * dao.close(); } else { System.out.println("작성자가 아닙니다."); }
 * 
 * req.getRequestDispatcher("/space/PassMessage.jsp") .forward(req, resp); } }
 */