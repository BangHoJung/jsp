package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import config.DBManager;
import dto.BoardDTO;
import dto.CommentDTO;
import dto.QnaDTO;
import exception.BoardException;
import vo.PagingVO;

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
			pstmt = manager.getConn().prepareStatement(sql);
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
			pstmt2 = manager.getConn().prepareStatement(sql2);
			pstmt2.setInt(1, bno);
			pstmt2.setString(2, board.getTitle());
			pstmt2.setString(3, board.getWriter());
			pstmt2.setString(4, board.getContent());
			
			int count = pstmt2.executeUpdate();
			if(count == 0) {
				throw new BoardException("게시글 등록중 오류가 발생했습니다");
			}
			
			System.out.println("DAO : 게시글 등록 성공");
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
			pstmt = manager.getConn().prepareStatement(sql);
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
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			int count = pstmt.executeUpdate();
			if(count==0) {
				throw new BoardException("아이디가 올바르지 않습니다");
			}
			System.out.println("DAO : 게시글 조회수 업데이트");
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
			pstmt2 = manager.getConn().prepareStatement(sql2);
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
			pstmt = manager.getConn().prepareStatement(sql);
			//pstmt.setString(1, lh);
			pstmt.setInt(1, result);
			pstmt.setInt(2, bno);
			
			int count = pstmt.executeUpdate();
			if(count==0) {
				System.out.println("업데이트 실패");
			}
			System.out.println("DAO : 게시글 호감도 업데이트");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, null);
		}
		
		
		return result;
	}

	public ArrayList<BoardDTO> searchAllBoardDTO(int currPage, String sort) {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM  (SELECT rs.*,ROWNUM rn FROM (SELECT * FROM BOARD  ORDER BY "+sort+" desc) rs) WHERE CEIL(rn/?) = ?";
		
		PagingVO page = new PagingVO(countAllBoard(), currPage);
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setInt(1, page.getCountPageContent());
			pstmt.setInt(2, currPage);
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

	public int insertBoardComment(CommentDTO dto) {
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO board_comment(cno,bno,content,writer) VALUES(SEQ_CNO.NEXTVAL,?,?,?)";
		int count = 0;
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setInt(1, dto.getBno());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getWriter());
			
			count = pstmt.executeUpdate();

			System.out.println("DAO : 답글 등록 성공");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, null);
		}
		
		return count;
	}

	public ArrayList<CommentDTO> searchAllCommentDTO(int bno) {
		ArrayList<CommentDTO> list = new ArrayList<CommentDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM BOARD_COMMENT WHERE bno=? ORDER BY CNO DESC";
		
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setInt(1, bno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(new CommentDTO(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, rs);
		}
		
		return list;
		
	}

	public HashMap<Integer, Integer> countAllComment() {
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="SELECT bno,COUNT(*) FROM BOARD_COMMENT GROUP BY bno";
		
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				map.put(rs.getInt(1), rs.getInt(2));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			manager.close(pstmt, rs);
		}
		
		return map;
	}
	
	public int countAllBoard() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM BOARD";
		int result=0;
		
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, rs);
		}
		
		return result;
		
	}

	public void insertQnaDTO(QnaDTO dto) throws BoardException {
		
		PreparedStatement pstmt2 = null;
		String sql2 = "INSERT INTO qna(qid,title,content,writer) VALUES(SEQ_QID.NEXTVAL,?,?,?)";
		
		try {
			pstmt2 = manager.getConn().prepareStatement(sql2);
			pstmt2.setString(1, dto.getTitle());
			pstmt2.setString(2, dto.getContent());
			pstmt2.setString(3, dto.getWriter());
			
			int count = pstmt2.executeUpdate();
			if(count == 0) {
				throw new BoardException("문의 등록이 실패했습니다");
			}
			System.out.println("DAO : 문의 등록 성공");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt2, null);
		}
	}

	public ArrayList<QnaDTO> searchQnaList(String writer, int currPage) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM ( SELECT q.*,ROWNUM rn FROM (SELECT * FROM qna WHERE writer = ? ORDER BY qid desc) q) WHERE CEIL(rn/5)=?";
		ArrayList<QnaDTO> list = new ArrayList<QnaDTO>();
		
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setInt(2, currPage);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(new QnaDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
			}
			System.out.println("DAO : qnaList");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, rs);
		}
		
		return list;
	}

	public ArrayList<QnaDTO> searchQnaMasterList(int currPage) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM ( SELECT q.*,ROWNUM rn FROM (SELECT * FROM qna ORDER BY status asc, qid desc) q) WHERE CEIL(rn/10)=?";
		ArrayList<QnaDTO> list = new ArrayList<QnaDTO>();
		
		try {
			pstmt = manager.getConn().prepareStatement(sql);
			pstmt.setInt(1, currPage);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(new QnaDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getString(7)));
			}
			System.out.println("DAO : qnaListMaster");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			manager.close(pstmt, rs);
		}
		
		return list;
	}
}
