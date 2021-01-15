package service;

import java.util.ArrayList;
import java.util.HashMap;

import dao.BoardDAO;
import dto.BoardDTO;
import dto.CommentDTO;
import dto.QnaDTO;
import exception.BoardException;

public class BoardService {

	private static BoardService instance = new BoardService();
	
	private BoardDAO dao = null;
	private BoardService() {
		dao = BoardDAO.getInstance();
	}
	
	public static BoardService getInstance() {
		if(instance == null) instance = new BoardService();
		return instance;
	}
	
	public int insertBoardDTO(BoardDTO board) throws BoardException {
		if(board.getTitle().length()<1) {
			throw new BoardException("제목을 입력하세요");
		}
		else if(board.getWriter().length()<1) {
			throw new BoardException("아이디가 올바르지 않습니다");
		}
		else if(board.getContent().length()<1) {
			throw new BoardException("내용을 입력하세요");
		}
		else {
			return dao.insertBoardDTO(board);
		}
	}
	
	public BoardDTO searchBoardDTO(int bno) {
		try {
			dao.addBoardCount(bno);
		} catch (BoardException e) {
			e.getMessage();
		}
		return dao.searchBoardDTO(bno);
	}
	
	public int addLikeHateBoardDTO(int bno,String lh) {
		return dao.addLikeHateBoardDTO(bno,lh);
	}
	
	public ArrayList<BoardDTO> searchAllBoardDTO(int currPage, String sort) {
		return dao.searchAllBoardDTO(currPage,sort);
	}
	
	public int insertBoardComment(CommentDTO dto) {
		return dao.insertBoardComment(dto);
	}
	
	public ArrayList<CommentDTO> searchAllCommentDTO(int bno) {
		return dao.searchAllCommentDTO(bno);
	}
	
	public HashMap<Integer, Integer> countAllComment() {
		return dao.countAllComment();
	}

	public void insertQnaDTO(QnaDTO dto) throws BoardException {
		dao.insertQnaDTO(dto);
	}

	public ArrayList<QnaDTO> searchQnaList(String writer, int currPage, String grade) {
		if(grade.equals("master")) {
			return dao.searchQnaMasterList(currPage);
		}
		else {
			return dao.searchQnaList(writer,currPage);
		}
	}

	public ArrayList<QnaDTO> searchNoAnswerQnaList() {
		return dao.searchNoAnswerQnaList();
	}

	public QnaDTO searchQnaDTO(int qid) {
		return dao.searchQnaDTO(qid);
	}

	public int updateQnaResponse(int qid, String answer) {
		int count = dao.updateQnaResponse(qid,answer);
		return count;
	}

}
