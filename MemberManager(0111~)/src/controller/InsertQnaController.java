package controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.QnaDTO;
import exception.BoardException;
import model.ModelAndView;
import service.BoardService;
import service.MemberService;

public class InsertQnaController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request, HttpServletResponse response) {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String writer = (String)request.getSession().getAttribute("id");
		
		QnaDTO dto = new QnaDTO(title, content, writer);
		ModelAndView view = null;
		try {
			BoardService.getInstance().insertQnaDTO(dto);
			view = new ModelAndView("qna_view.do", false);
		} catch (BoardException e) {
			try {
				response.getWriter().append("<script>alert('"+e.getMessage()+"');history.back();</script>");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		
		
		return view;
	}

}
