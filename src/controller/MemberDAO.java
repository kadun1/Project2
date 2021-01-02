package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

public class MemberDAO {
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public MemberDAO(String driver, String url) {
		try {
			Class.forName(driver);
			String id = "suamil_user";
			String pw = "1234";
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("DB연결성공(디폴트생성자)");
		}
		catch (Exception e) {
			System.out.println("DB연결실패");
			e.printStackTrace();
		}
	}
	
	public MemberDAO(ServletContext ctx) {
		try {
			Class.forName(ctx.getInitParameter("MariaJDBCDriver"));
			String id = ctx.getInitParameter("MariaUser");
			String pw = ctx.getInitParameter("MariaPass");
			con = DriverManager.getConnection(
					ctx.getInitParameter("MariaConnectURL"),id,pw);
			System.out.println("DB연결성공(커넥션풀)");
		}
		catch (Exception e) {
			System.out.println("DB연결실패(커넥션풀)");
			e.printStackTrace();
		}
	}
	
	public MemberDTO getMemberDTO(String uid, String upass) {
		
		//회원정보 저장을 위해 DTO객체 생성
		MemberDTO dto = new MemberDTO();
		
		//회원정보를 가져오기 위한 쿼리문 작성
		String query = "SELECT id, pass, name, grade FROM "
				+ " membership WHERE id=? AND pass=?";
		try {
			//prepare객체생성
			psmt = con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			//쿼리실행
			rs = psmt.executeQuery();
			//오라클이 반환해준 ResultSet을 통해 결과값이 있는지 확인
			if(rs.next()) {
				//결과가 있다면 DTO객체에 정보저장
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setGrade(rs.getString("grade"));
			}
			else {
				System.out.println("결과셋이 없습니다.");
			}
		}
		catch(Exception e) {
			System.out.println("getMemberDTO오류");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	public int registMember(MemberDTO dto) {
		
		int affected = 0;
		try {
			String sql = "INSERT INTO membership ( "
				+ " id, pass, name, e_mail, address, "
				+ " zipcode, mobile) VALUES ( "
				+ " ?, ?, ?, ?, ?, ?, ?) ";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getMail());
			psmt.setString(5, dto.getAddress());
			psmt.setString(6, dto.getZipcode());
			psmt.setString(7, dto.getMobile());
			
			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("회원등록시 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
	
	public int idCheck(String id) {
		
		int affected = 0;
		String sql = " SELECT COUNT(*) FROM membership "
					+ " WHERE id = ? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			rs.next();
			affected = rs.getInt(1);				
		
		}
		catch(Exception e) {
			System.out.println("아이디체크중 예외발생");
		}
		return affected;	
	}
	
	public void close() {
		try {
			//연결을 해제하는것이 아니고 풀에 다시 반납한다. 
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
		}
		catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}
	
	public String idFind(String name, String email) {
		String findid = "";
		String sql = " SELECT id FROM membership "
				+ " WHERE name = ? AND e_mail = ? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, name);
			psmt.setString(2, email);			
			rs = psmt.executeQuery();
			while(rs.next()) {
				findid = rs.getString(1);
				System.out.println("아이디:"+findid);
			}
		}
		catch(Exception e) {
			System.out.println("아이디 찾기중 예외발생");
			e.printStackTrace();
		}
		return findid;	
	}
	
	public String pwFind(String id, String name, String email) {
		String findpw = "";
		String sql = " SELECT pass FROM membership "
				+ " WHERE id= ? AND name = ? AND e_mail = ? ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, name);
			psmt.setString(3, email);
			rs = psmt.executeQuery();
			while(rs.next()) {
				findpw = rs.getString(1);				
			}
		}
		catch(Exception e) {
			System.out.println("비번찾기중 예외발생");
			e.printStackTrace();
		}
		return findpw;
	}
	
	public int getTotalRecordCountSearch(Map<String, Object> map) {
		int totalCount = 0;
		
		//기본쿼리문(전체레코드를 대상으로 함)
		String query = "SELECT COUNT(*) FROM membership ";
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
	
	public List<MemberDTO> selectMember(Map<String, Object> map) {
		List<MemberDTO> members = new ArrayList<MemberDTO>();

		//쿼리문이 아래와같이 페이지처리 쿼리문으로 변경됨.
		String query = " "	
			+"		SELECT * FROM membership "; 
		if(map.get("Word")!=null) {
			query +=" WHERE "+map.get("Column")
					+" LIKE '%"+map.get("Word")+"%' ";
		}			
		query +=" ORDER BY num DESC LIMIT ?, ?";
			
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
				MemberDTO dto = new MemberDTO();

				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setRegidate(rs.getDate("regidate"));
				dto.setMail(rs.getString("e_mail"));
				dto.setAddress(rs.getString("address"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setMobile(rs.getString("mobile"));
				dto.setGrade(rs.getString("grade"));

				members.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("Select시 예외발생");
			e.printStackTrace();
		}
		return members;
	}	
	public int editGrade(MemberDTO dto) {
		int affected = 0;
		System.out.println(dto.getGrade()+" "+dto.getNum());
		try {
			String sql = " UPDATE membership SET "
					+ " grade = ? WHERE num=? ";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getGrade());
			psmt.setString(2, dto.getNum());
			affected = psmt.executeUpdate();
			System.out.println(affected);
		}
		catch(Exception e) {
			System.out.println("회원정보 수정중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
}
