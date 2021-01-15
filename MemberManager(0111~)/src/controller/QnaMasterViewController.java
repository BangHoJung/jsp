package controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import dto.QnaDTO;
import model.ModelAndView;
import service.BoardService;

public class QnaMasterViewController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request, HttpServletResponse response) {
		int qid = Integer.parseInt(request.getParameter("qid"));
		QnaDTO dto = BoardService.getInstance().searchQnaDTO(qid);
		
		ModelAndView view = null;
		
		if(dto != null) {
			request.setAttribute("dto", dto);
			view = new ModelAndView("member/qna_master_view.jsp", false);
		}
		else {
			try {
				response.getWriter().write("<script>alert('해당 문의글을 찾을 수 없습니다.');history.back();</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return view;
	}

}
