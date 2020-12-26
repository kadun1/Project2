package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;


public class BbsDAO {

	Connection con; 
	PreparedStatement psmt;
	ResultSet rs;
	
	public BbsDAO(String driver, String url, String id, String pw) {		
		try {
			Class.forName(driver);
			//DB에 연결된 정보를 멤버변수에 저장
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("DB연결성공(인자생성자)");
		}
		catch (Exception e) {
			System.out.println("DB연결실패(인자생성자)");
			e.printStackTrace();
		}
	}
	
	public BbsDAO(ServletContext ctx) {
		try {
			Class.forName(ctx.getInitParameter("MariaJDBCDriver"));
			String id = ctx.getInitParameter("MariaUser");
			String pw = ctx.getInitParameter("MariaPass");
			con = DriverManager.getConnection(
					ctx.getInitParameter("MariaConnectURL"),id,pw);
			System.out.println("DB연결성공");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getTotalRecordCountSearch(Map<String, Object> map) {
		int totalCount = 0;
		
		//기본쿼리문(전체레코드를 대상으로 함)
		String query = "SELECT COUNT(*) FROM board B "
				+ " 		INNER JOIN membership M "
				+ "				ON B.id=M.id ";
		
		//JSP페이지에서 검색어를 입력한 경우 where절이 동적으로 추가된다.
		if(map.get("Word")!=null) {
			query += " WHERE "+ map.get("Column") +" "
					+ " LIKE '%"+ map.get("Word") +"%'";
		}
		System.out.println("query="+query);

		try {
			//쿼리 실행후 결과값 반환
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch(Exception e) {}
		
		return totalCount;
	}
	
	public List<BbsDTO> selectListPageSearch(Map<String, Object> map) {
		List<BbsDTO> bbs = new ArrayList<BbsDTO>();

		//쿼리문이 아래와같이 페이지처리 쿼리문으로 변경됨.
		String query = " "	
			+"		SELECT B.*, M.name FROM board B " 
			+"         INNER JOIN membership M "
			+"           ON B.id=M.id " ;
		if(map.get("Word")!=null) {
			query +="      WHERE "+map.get("Column")
					+" LIKE '%"+map.get("Word")+"%' ";
		}			
		query +="		ORDER BY num DESC LIMIT ?, ?";
			
		System.out.println("쿼리문:"+ query);
		
		try {
			psmt = con.prepareStatement(query);
				
			//JSP에서 계산한 페이지 범위값을 이용해 인파라미터를 설정함.
			/*
			setString()으로 인파라미터를 설정하면 문자형이 되므로
			양쪽에 싱글 쿼테이션이 자동으로 기술된다. 여기서는 정수로
			입력해야 하므로 setInt()를 사용하고, 인자도 전달되는 변수를
			정수로 변경해야 한다.
			 */
			psmt.setInt(1, Integer.parseInt(map.get("start").toString()));
			psmt.setInt(2, Integer.parseInt(map.get("end").toString()));
			
			rs = psmt.executeQuery();

			while(rs.next()) {
				BbsDTO dto = new BbsDTO();

				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				//member테이블과의 JOIN으로 이름이 추가됨
				dto.setName(rs.getString("name"));

				bbs.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("Select시 예외발생");
			e.printStackTrace();
		}
		return bbs;
	}	
	
	public void close() {
		try {
			//사용된 자원이 있다면 자원해제 해준다.
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
		}
		catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}
	
	public void updateVisitCount(String num) {
		
		String query = "UPDATE board SET "
			+ " visitcount=visitcount+1 "
			+ " WHERE num=?";
		System.out.println("조회수증가:"+query);
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			/*
			쿼리 실행시 executeQuery() 혹은 executeUpdate()
			둘다 사용가능하다. 단, 두 메소드의 차이는 반환값이 다르다는 
			점이다. 반환값이 굳이 필요없는 경우라면 어떤것을 사용해도
			무방하다. 
			 */
			psmt.executeQuery();
		}
		catch(Exception e) {
			System.out.println("조회수 증가시 예외발생");
			e.printStackTrace();
		}
	}
	
	public BbsDTO selectView(String num) {

		BbsDTO dto = new BbsDTO();
		
		//게시판 테이블만 사용하여 게시물 조회
		//String query = "SELECT * FROM board WHERE num=?";
		
		//게시판, 회원 테이블을 조인하여 이름까지 가져와서 조회
		String query = ""
			+"SELECT "
			+"    num, title, content, B.id, postdate, visitcount, name "
			+" FROM membership M INNER JOIN board B "
			+"    ON M.id=B.id "
			+" WHERE num=? ";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString(6));		
				/*
				member 테이블과 join하여 얻어온 name을 DTO에 추가함.
				 */
				dto.setName(rs.getString(7));
			}
		}
		catch(Exception e) {
			System.out.println("상세보기시 예외발생");
			e.printStackTrace();
		}

		return dto;
	}
}
