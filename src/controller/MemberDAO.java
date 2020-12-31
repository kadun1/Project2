package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import controller.MemberDTO;

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
}
