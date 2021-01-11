package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import config.DBManager;
import exception.MemberException;
import vo.MemberVO;

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	private DBManager manager = null;
	
	private MemberDAO() {
		manager = DBManager.getInstance();
	}
	
	public static MemberDAO getIntance() {
		if(instance == null) instance = new MemberDAO();
		return instance;
	}

	public void insertMemberVO(MemberVO vo) throws MemberException{
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO MEMBER VALUES(?,?,?,?,1)";
		
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPass());
			pstmt.setString(3, vo.getName());
			pstmt.setInt(4, vo.getAge());
			
			int count = pstmt.executeUpdate();
			
			if(count == 0) {
				throw new MemberException("멤버 등록 실패");
			}
			System.out.println("멤버 등록 성공");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, null);
		}
		
	}
	
	public MemberVO searchMemberVO(String id) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO vo = null;
		String sql = "SELECT id,pass,name,age,grade_name FROM member,grade_list WHERE id =? AND member.grade=grade_list.grade ";
		
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new MemberVO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4),rs.getString(5));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, rs);
		}
		
		return vo;
	}

	public void updatePass(String id, String pass) throws MemberException {
		PreparedStatement pstmt = null;
		String sql = "update  member set pass = ? where id = ?";
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setString(1, pass);
			pstmt.setString(2,id);
			int count = pstmt.executeUpdate();
			if(count == 0)
				throw new MemberException("암호수정에 실패했습니다.");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, null);
		}
		
	}

	public MemberVO searchMemberVO(String id, String pass) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO vo = null;
		String sql = "SELECT id,pass,name,age,grade_name FROM member,grade_list WHERE id=? AND pass=? AND member.grade = grade_list.grade";
		
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new MemberVO(rs.getString(1), null, rs.getString(3), rs.getInt(4), rs.getString(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, rs);
		}
		
		return vo;
	}

	public void updateMemberVO(MemberVO vo) throws MemberException {

		PreparedStatement pstmt = null;
		if(vo.getGrade() == null) {
			System.out.println("pass update");
			String sql = "UPDATE MEMBER SET pass = ?, name = ?, age = ? WHERE id = ?";
			
			try {
				pstmt = manager.getConn().prepareStatement(sql);
				pstmt.setString(1, vo.getPass());
				pstmt.setString(2, vo.getName());
				pstmt.setInt(3, vo.getAge());
				pstmt.setString(4, vo.getId());
				
				int count = pstmt.executeUpdate();
				if(count == 0) {
					throw new MemberException("멤버 정보 변경에 실패했습니다.");
				}
				
				System.out.println("정보 변경 성공");
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				manager.close(pstmt, null);
			}
		}
		
		else if(vo.getPass() == null) {
			System.out.println("grade update");
			String sql = "UPDATE MEMBER SET name = ?, age = ?, grade = (SELECT grade FROM grade_list WHERE grade_name = ?) WHERE id = ?";
			
			try {
				pstmt = manager.getConn().prepareStatement(sql);
				pstmt.setString(1, vo.getName());
				pstmt.setInt(2, vo.getAge());
				pstmt.setString(3, vo.getGrade());
				pstmt.setString(4, vo.getId());
				
				int count = pstmt.executeUpdate();
				if(count == 0) {
					throw new MemberException("멤버 정보 변경에 실패했습니다.");
				}
				
				System.out.println("정보 변경 성공");
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				manager.close(pstmt, null);
			}
		}
		
	}
	
	public String getGradeName(int grade) {
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String sql = "SELECT grade_name FROM GRADE_LIST WHERE grade = ?";
		String grade_name = "";
		
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setInt(1, grade);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				grade_name = rs.getString(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, rs);
		}
		
		return grade_name;
	}
	
	public ArrayList<MemberVO> searchAllMemberVO(String name) {
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		name = "%"+name+"%";
		String sql = "SELECT id,pass,name,age,grade_name FROM MEMBER,GRADE_LIST WHERE member.grade = grade_list.grade AND name Like ?";
		
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(new MemberVO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, rs);
		}
		
		return list;
		
	}

	public void deleteMemberVO(String id) throws MemberException {

		PreparedStatement pstmt = null;
		String sql = "DELETE FROM MEMBER WHERE id=?";
		
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setString(1, id);
			
			int count = pstmt.executeUpdate();
			if(count == 0) {
				throw new MemberException("삭제된 데이터가 없습니다.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, null);
		}
	}
}
