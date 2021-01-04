package admin;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.BbsDAO;
import controller.BbsDTO;
import util.FileUtil;

@WebServlet("/admin/imgDelete.do")
public class ImgDeleteCtrl extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ServletContext app = this.getServletContext();
		HttpSession session = req.getSession();
		String id = session.getAttribute("USER_ID").toString();
		String num = req.getParameter("num");
		String nowPage = req.getParameter("nowPage");
		String btype = req.getParameter("btype");
		req.setAttribute("nowPage", nowPage);
		req.setAttribute("btype", btype);
			
		BbsDAO dao = new BbsDAO(app);
		//첨부파일 삭제를 위해 기존의 게시물을 가져와서 DTO객체에 저장.
		BbsDTO dto = dao.selectView(num, btype);
		System.out.println("이미지삭제중:"+dto.getNum());
		//게시물 삭제
		int sucOrFail = dao.deleteImg(dto);
		if(sucOrFail==1) { 
			//게시물 삭제가 완료되었다면 첨부파일도 삭제한다. 
			String fileName = dto.getSfile();
			//경로명, 파일명을 전달하여 물리적경로에 저장된 파일을 삭제처리함.
			FileUtil.deleteFile(req, "/space/Upload", fileName);
		}
		
		//Message.jsp에서 페이지이동 및 알림창을 위한 속성 저장
		req.setAttribute("WHEREIS", "DELETE");
		req.setAttribute("SUC_FAIL", sucOrFail);
		
		req.getRequestDispatcher("/admin/Message.jsp").forward(req, resp);
		
	}
	
}









