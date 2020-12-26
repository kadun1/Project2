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
		String query = "SELECT id, pass, name FROM "
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
	

		
	
}
