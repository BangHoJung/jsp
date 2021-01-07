package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import config.DBManager;
import dto.BoardDTO;
import exception.BoardException;

public class BoardDAO {
	
	private static BoardDAO instance = new BoardDAO();
	private DBManager manager = null;
	private BoardDAO() {
		manager = DBManager.getInstance();
	}
	
	public static BoardDAO getInstance() {
		if(instance == null) instance = new BoardDAO();
		return instance;
	}

	public int insertBoardDTO(BoardDTO board) throws BoardException {
		
		int bno = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT SEQ_BNO.NEXTVAL FROM DUAL";
		
		try {
			pstmt = manager.getSource().getConnection().prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bno = rs.getInt(1);
			}
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		} finally {
			manager.close(pstmt, rs);
		}
		
		
		PreparedStatement pstmt2 = null;
		String sql2 = "INSERT INTO BOARD(bno,title,writer,content) VALUES(?,?,?,?)";
		
		try {
			pstmt2 = manager.getSource().getConnection().prepareStatement(sql2);
			pstmt2.setInt(1, bno);
			pstmt2.setString(2, board.getTitle());
			pstmt2.setString(3, board.getWriter());
			pstmt2.setString(4, board.getContent());
			
			int count = pstmt2.executeUpdate();
			if(count == 0) {
				throw new BoardException("게시글 등록중 오류가 발생했습니다");
			}
			
			System.out.println("게시글 등록 성공");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			manager.close(pstmt2, null);
		}
		
		return bno;
	}

	public BoardDTO searchBoardDTO(int bno) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM BOARD WHERE bno = ?";
		
		try {
			pstmt = manager.getSource().getConnection().prepareStatement(sql);
			pstmt.setInt(1, bno);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getInt(8));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, rs);
		}
		
		return dto;
	}

	public void addBoardCount(int bno) throws BoardException {

		PreparedStatement pstmt = null;
		String sql = "UPDATE BOARD SET bcount = bcount + 1 WHERE bno=?";
		
		try {
			pstmt = manager.getSource().getConnection().prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			int count = pstmt.executeUpdate();
			if(count==0) {
				throw new BoardException("아이디가 올바르지 않습니다");
			}
			System.out.println("게시글 조회수 업데이트");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, null);
		}
		
	}

	public int addLikeHateBoardDTO(int bno, String lh) {
		
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		lh = "b"+lh;
		lh = lh.trim();
		System.out.println(lh);
		int result = 0;
		String sql2 = "SELECT "+lh+" FROM BOARD WHERE bno = ?";
		
		try {
			pstmt2 = manager.getSource().getConnection().prepareStatement(sql2);
			//pstmt2.setString(1, lh);
			pstmt2.setInt(1, bno);
			
			rs = pstmt2.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt2, rs);
		}
		
		result = result + 1;

		PreparedStatement pstmt = null;
		String sql = "UPDATE BOARD SET "+ lh +" = ? WHERE bno = ?";
		
		try {
			pstmt = manager.getSource().getConnection().prepareStatement(sql);
			//pstmt.setString(1, lh);
			pstmt.setInt(1, result);
			pstmt.setInt(2, bno);
			
			int count = pstmt.executeUpdate();
			if(count==0) {
				System.out.println("업데이트 실패");
			}
			System.out.println("업데이트 성공");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, null);
		}
		
		
		return result;
	}

	public ArrayList<BoardDTO> searchAllBoardDTO() {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM BOARD";
		
		try {
			pstmt = manager.getSource().getConnection().prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(new BoardDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getInt(8)));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, rs);
		}
		
		return list;
	}
}
