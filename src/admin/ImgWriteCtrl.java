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

import com.oreilly.servlet.MultipartRequest;

import controller.BbsDAO;
import controller.BbsDTO;
import util.FileUtil;

@WebServlet("/admin/imgWrite.do")
public class ImgWriteCtrl extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		req.setCharacterEncoding("UTF-8");
		
		String realFileName = null;
		File oldFile = null;
		File newFile = null;
		
		ServletContext application = this.getServletContext();
		String saveDirectory = application.getRealPath("/space/Upload");
		MultipartRequest mr = FileUtil.upload(req, saveDirectory);
		
		String btype = mr.getParameter("btype");
		
		int sucOrFail;
		if(mr != null){
			
			//서버에 저장된 파일명 가져오기
			String fileName = mr.getFilesystemName("ofile");
			
			/*
			파일명을 변경하기 위해 현재날짜와 시간을 얻어온다. 
			특히 서식중 대문자 S는 초를 1/1000단위로 가져오게된다.
			*/
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
			
			//DTO객체에 위의 폼값을 저장한다. 
			
			BbsDTO dto = new BbsDTO();
			dto.setId(id);
			dto.setTitle(title);
			dto.setContent(content);
			dto.setBtype(btype);
			dto.setSfile(sfile);
			dto.setOfile(ofile);
			
			//DAO객체생성 및 연결...insert처리
			BbsDAO dao = new BbsDAO(application);			
			//파일업로드 성공 및 insert성공시..
			sucOrFail = dao.insertImgWrite(dto);
			
			/*
			페이지 처리를 위한 100개 데이터 입력
			
			sucOrFail = 1; 
			for (int i = 1; i <= 100; i++) {
				dto.setTitle("자료실 "+i+"번째 포스팅");
				dao.insert(dto);				
			}
			*/
						
			dao.close();
		}
		else{
			//mr객체가 생성되지 않은경우, 즉 파일업로드 실패시..
			sucOrFail = -1;
		}
		
		if(sucOrFail==1&&btype.equals("2")){
			//글쓰기 성공시 리스트로 이동
			resp.sendRedirect("../admin/board.jsp?btype="+btype+"");
		}
		else if(sucOrFail==1&&!btype.equals("2")) {
			resp.sendRedirect("../admin/board.jsp?btype="+btype+"");
		}
		else{
			//실패시 글쓰기 페이지로 이동
			req.getRequestDispatcher("/admin/write.jsp")
				.forward(req, resp);
		}
			
	}
}
