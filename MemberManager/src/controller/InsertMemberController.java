package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exception.MemberException;
import model.ModelAndView;
import service.MemberService;
import vo.MemberVO;

public class InsertMemberController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		
		MemberVO vo = new MemberVO(id,pass,name,age,null);
		ModelAndView view = new ModelAndView();
		
		try {
			MemberService.getInstance().insertMemberVO(vo);
			view.setSendRedirect(false);
			view.setPage("member/login.jsp");
		} catch (MemberException e) {
			view.setSendRedirect(false);
			view.setPage("member/register.jsp");
			System.out.println(e.getMessage());
		}
		
		
		return view;
	}

}
