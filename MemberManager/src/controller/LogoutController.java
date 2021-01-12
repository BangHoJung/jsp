package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ModelAndView;

public class LogoutController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("login", false);
		
		ModelAndView view = new ModelAndView();
		view.setSendRedirect(true);
		view.setPage(session.getAttribute("last").toString());
		
		return view;
	}

}
