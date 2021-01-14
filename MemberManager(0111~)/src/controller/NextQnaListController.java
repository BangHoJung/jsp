package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import dto.QnaDTO;
import model.ModelAndView;
import service.BoardService;

public class NextQnaListController implements Controller {

	@Override
	public ModelAndView execute(HttpServletRequest request, HttpServletResponse response) {
		//1.조회할 페이지 번호 읽어옴
		String writer = (String)request.getSession().getAttribute("id");
		int nextPage = Integer.parseInt(request.getParameter("nextPage"));
		String grade = (String)request.getSession().getAttribute("grade");
		//2.해당 페이지 목록을 읽어옴 - list
		ArrayList<QnaDTO> list = BoardService.getInstance().searchQnaList(writer, nextPage, grade);
		//3.다음페이지 번호 / 다음페이지 없으면 0
		if(BoardService.getInstance().searchQnaList(writer, nextPage+1, grade).size()==0) {
			nextPage = 0;
		}
		else {
			nextPage++;
		}
		//4. JSON으로 변환(QnaDTO, 다음페이지 번호)
		JSONObject jsonObject = new JSONObject();
    	jsonObject.put("nextPage",nextPage);
    	JSONArray jsonArray = new JSONArray(list);
    	jsonObject.put("array",jsonArray);
		//5. writer로 출력
		try {
			response.getWriter().write(jsonObject.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		//6. 페이지이동 X이므로 view X
		return null;
	}

}
