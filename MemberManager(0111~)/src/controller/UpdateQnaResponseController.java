package controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ModelAndView;
import service.BoardService;

public class UpdateQnaResponseController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request, HttpServletResponse response) {
		int qid = Integer.parseInt(request.getParameter("qid"));
		String answer = request.getParameter("response");
		
		ModelAndView view = null;
		int count = BoardService.getInstance().updateQnaResponse(qid,answer);
		if(count == 0) {
			try {
				response.getWriter().write("<script>alert('답변 등록에 실패했습니다');location.href='qna_master_view.do';");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		else {
			view = new ModelAndView("qna_view.do", true);
		}
		
		return view;
	}

}
