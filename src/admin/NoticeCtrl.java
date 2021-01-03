/*
 * package admin;
 * 
 * import java.io.IOException; import java.util.HashMap; import java.util.List;
 * import java.util.Map;
 * 
 * import javax.servlet.ServletContext; import javax.servlet.ServletException;
 * import javax.servlet.annotation.WebServlet; import
 * javax.servlet.http.HttpServlet; import javax.servlet.http.HttpServletRequest;
 * import javax.servlet.http.HttpServletResponse;
 * 
 * import controller.BbsDAO; import controller.BbsDTO; import
 * controller.MemberDAO; import util.PagingUtil;
 * 
 * @WebServlet("/admin/notice") public class NoticeCtrl extends HttpServlet{
 * 
 * @Override protected void doGet(HttpServletRequest req, HttpServletResponse
 * resp) throws ServletException, IOException {
 * req.setCharacterEncoding("UTF-8"); //DAO객체 생성 및 커넥션풀을 통한 DB연결 ServletContext
 * app = this.getServletContext(); BbsDAO dao = new BbsDAO(app);
 * 
 * //컨트롤러(서블릿) 및 View(JSP)로 전달할 파라미터를 저장하기 위한 맵 컬렉션 Map<String, Object> param =
 * new HashMap<String, Object>(); String queryStr = ""; String searchColumn =
 * req.getParameter("searchColumn"); String searchWord =
 * req.getParameter("searchWord"); String btype = "0"; param.put("btype",
 * btype); if(searchWord!=null){
 * 
 * param.put("Column", searchColumn); param.put("Word", searchWord);
 * 
 * queryStr += "searchColumn="+searchColumn +"&searchWord="+searchWord+"&"; }
 * int totalRecordCount = dao.getTotalRecordCountSearch(param);
 * 
 * int pageSize = Integer.parseInt( app.getInitParameter("PAGE_SIZE")); int
 * blockPage = Integer.parseInt( app.getInitParameter("BLOCK_PAGE"));
 * 
 * int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
 * 
 * int nowPage = (req.getParameter("nowPage")==null ||
 * req.getParameter("nowPage").equals("")) ? 1 :
 * Integer.parseInt(req.getParameter("nowPage"));
 * 
 * int start = (nowPage-1)*pageSize; int end = pageSize;
 * 
 * param.put("start", start); param.put("end", end); param.put("totalPage",
 * totalPage); param.put("nowPage", nowPage); param.put("totalCount",
 * totalRecordCount); param.put("pageSize", pageSize); String pagingImg =
 * PagingUtil.pagingBS4(totalRecordCount, pageSize, blockPage, nowPage,
 * "../DataRoom/DataList?"+queryStr); param.put("pagingImg", pagingImg);
 * 
 * List<BbsDTO> bbs = dao.selectListPageSearch(param);//페이지처리O+회원이름검색
 * 
 * dao.close();
 * 
 * req.setAttribute("bbs", bbs); req.setAttribute("map", param);
 * 
 * req.getRequestDispatcher("/admin/notice.jsp").forward(req, resp); }
 * 
 * @Override protected void doPost(HttpServletRequest req, HttpServletResponse
 * resp) throws ServletException, IOException { doGet(req, resp); } }
 */