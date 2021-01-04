package admin;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import controller.BbsDAO;
import controller.BbsDTO;
import util.FileUtil;
import util.JavascriptUtil;

@WebServlet("/admin/imgEdit.do")
public class ImgEditCtrl extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//일련번호 
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		String num = req.getParameter("num");
		String btype = req.getParameter("btype");
		/*
		서블릿에서 application내장객체를 얻어오기 위해 메소드 호출함.
		해당 내장객체는 DAO로 전달하여 초기화파라미터를 얻어오게된다.
		 */
		ServletContext app = this.getServletContext();				
		BbsDAO dao = new BbsDAO(app);
		
		//수정폼을 구성하기 위해 게시물의 내용을 가져온다. 
		BbsDTO dto = dao.selectView(num, btype);
		System.out.println("doGet에서 btype:"+btype);
		req.setAttribute("dto", dto);
		HttpSession session = req.getSession();
		if(!session.getAttribute("USER_GRADE").toString().equals("1")) {
			PrintWriter out = resp.getWriter();
			out.println("<script>alert('관리자만 수정 가능합니다');"
					+ " history.back(); "
					+ "</script>");
			out.close();
		}
		else {
			req.getRequestDispatcher("/admin/edit.jsp")
			.forward(req, resp);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		ServletContext app = this.getServletContext();	
		String saveDirectory = app.getRealPath("/space/Upload");
		MultipartRequest mr = FileUtil.upload(req, saveDirectory);
			
		String realFileName = null;
		File oldFile = null;
		File newFile = null;
		
		int sucOrFail;
		
		String num = mr.getParameter("num");
		String btype = mr.getParameter("btype");
		String nowPage = mr.getParameter("nowPage");
		
		if(mr != null){
			//첨부파일의 수정을 위해 hidden폼으로 작성한 기본파일명을 받는다.
			String originalfile = mr.getParameter("originalfile");
			//이미지 게시판이므로 첨부파일이 필수...우선 파일명을 받는다.
			String fileName = mr.getFilesystemName("ofile");
			System.out.println("지울 파일이름:"+originalfile);
			
			//수정처리후 상세보기 페이지로 이동해야 하므로 영역에 속성을 저장한다.
			req.setAttribute("btype", btype);
			req.setAttribute("num", num);
			req.setAttribute("nowPage", nowPage);
			
			String nowTime = new SimpleDateFormat("yyyy_MM_dd_H_m_s_S")
					.format(new Date());
			/*
			파일의 확장자를 가져오기 위해 파일명의 마지막에 있는 점의 위치를 찾는다.
			따라서 lastIndexof()를 통해 찾아서 확장자를 따낸다.
			*/
			int idx = -1;
			idx = fileName.lastIndexOf(".");
			//시간을 통해 얻은 문자열과 확장자를 합쳐준다. 
			realFileName = nowTime + fileName.substring(idx, fileName.length());
			
			/*
			서버의 물리적경로와 생성된 파일명을 통해 File객체를 생성한다. 
			파일객체.separator : 파일경로를 나타낼때 윈도우와 리눅스는 각각
				\ 혹은 / 와 같이 os에 따라 구분기호가 틀린데, 해당 OS에 맞는
				구분기호를 구해주는 역할을 한다. 
			*/
			//기존 파일명 얻어오기....
			oldFile = new File(saveDirectory+oldFile.separator+fileName);
			//이름바꿀 새 파일명 얻어오기....
			newFile = new File(saveDirectory+oldFile.separator+realFileName);
		
			//저장된 파일명을 변경한다. 
			oldFile.renameTo(newFile);
			
			/*
			파일업로드가 완료되면 나머지 폼값을 받기위해 mr참조변수를 이용한다. 
			 */
			String id = mr.getParameter("id");
			System.out.println("아이디 : "+id);
			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			
			//서버에 저장된 실제파일명을 가져온다. 
			String ofile = mr.getOriginalFileName("ofile");
			String sfile = realFileName;
			
			BbsDTO dto = new BbsDTO();
			dto.setOfile(ofile);
			dto.setSfile(sfile);
			dto.setContent(content);
			dto.setTitle(title);
			dto.setId(id);
			dto.setNum(num);
			dto.setBtype(btype);
						
			BbsDAO dao = new BbsDAO(app);
			sucOrFail = dao.adminUpdateImg(dto);
			
			/*
			레코드의 update가 성공이고 동시에 새로운 파일이 업로드 되었다면
			기존의 파일은 삭제처리 한다. 
			첨부한 파일이 없다면 기존파일은 유지된다. 
			 */
			if(sucOrFail==1 && mr.getFilesystemName("ofile")!=null)
			{
				//기존 파일을 어떻게 지우지.........?
				System.out.println("기존파일 찾는중이제는?:"+ofile+"s파일은?:"+sfile);
				FileUtil.deleteFile(req, "/space/Upload", originalfile);
				System.out.println("파일변경으로 삭제완료");
			}
			
			dao.close();
			System.out.println(btype);
		}
		else{
			sucOrFail = -1;
		}
		
		//수정처리 이후에는 상세보기 페이지로 이동한다. 
		req.setAttribute("SUC_FAIL", sucOrFail);
		req.setAttribute("WHEREIS", "UPDATE");				
		req.getRequestDispatcher("/admin/Message.jsp").forward(req, resp);		
	}
}
