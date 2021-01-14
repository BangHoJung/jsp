package controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.QnaDTO;
import model.ModelAndView;
import service.BoardService;

public class QnaViewController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request, HttpServletResponse response) {
		//관리자인 경우에는 모든 사용자의 문의목록 읽어옴.
		HttpSession session = request.getSession();
		String writer = (String) session.getAttribute("id");
		String grade = (String) session.getAttribute("grade");
		int nextPage;
		ArrayList<QnaDTO> list = BoardService.getInstance().searchQnaList(writer,1,grade);
		
		if(BoardService.getInstance().searchQnaList(writer, 2, grade).size()==0) {
			nextPage = 0;
		}
		else {
			nextPage = 2;
		}
		
		request.setAttribute("list", list);
		request.setAttribute("nextPage", nextPage);
		ModelAndView view = null;
		if(grade.equals("master")) {
			view = new ModelAndView("member/qna_master.jsp", false);
		}
		else {
			view = new ModelAndView("member/qna.jsp", false);
		}

		System.out.println("first nextPage : " + nextPage);
		return view;
	}
	

}
