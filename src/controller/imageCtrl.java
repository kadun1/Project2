package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.PagingUtil;

@WebServlet("/space/image.do")
public class imageCtrl extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		ServletContext ctx = this.getServletContext();
		BbsDAO dao = new BbsDAO(ctx);
		String query = "";
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		String btype = req.getParameter("btype");
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		if(!(searchWord==null || searchWord.equals("")))
		{
			//검색어가 있는경우 파라미터를 Map에 저장하고, 쿼리스트링을 만들어준다.
			query = String.format("searchColumn=%s&searchWord=%s&", 
					searchColumn, searchWord);
			param.put("Column", searchColumn);
			param.put("Word", searchWord);
		}
		query += "btype="+btype+"&";
		param.put("btype", btype);
		int totalRecordCount = dao.getTotalRecordCountSearch(param);
		
		int pageSize = Integer.parseInt(
				ctx.getInitParameter("IMAGEPAGE_SIZE"));
		int blockPage = Integer.parseInt(
				ctx.getInitParameter("BLOCK_PAGE"));
		
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);		
		System.out.println("전체레코드수:"+ totalRecordCount);
		System.out.println("전체페이지수:"+ totalPage);
		
		int nowPage = (req.getParameter("nowPage")==null
				|| req.getParameter("nowPage").equals("")) ?
						1 : Integer.parseInt(req.getParameter("nowPage"));
		
		int start = (nowPage-1) * pageSize;
		int end = pageSize;
		
		//Map 컬렉션에 데이터 저장
		param.put("start", start);
		param.put("end", end);
		param.put("totalPage", totalPage);
		param.put("nowPage", nowPage);
		param.put("totalCount", totalRecordCount);
		param.put("pageSize", pageSize);
		
		String pagingImg = PagingUtil.pagingBS4(totalRecordCount, 
				pageSize, blockPage, nowPage,
				"../space/image.do?"+query);
		param.put("pagingImg", pagingImg);		
	
		List<BbsDTO> lists = dao.selectListPageSearch(param);
		
		dao.close();
		
		req.setAttribute("lists", lists);
		req.setAttribute("map", param); 
		
		req.getRequestDispatcher("/space/ImageList.jsp").forward(req, resp);
	}
}
