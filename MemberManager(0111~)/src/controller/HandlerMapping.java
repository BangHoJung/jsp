package controller;

public class HandlerMapping {
	
	private static HandlerMapping instance = new HandlerMapping();
	
	private HandlerMapping() {
		
	}
	
	public static HandlerMapping getInstance() {
		if(instance == null) instance = new HandlerMapping();
		return instance;
	}
	
	public Controller createController(String command) {
		Controller controller = null;
		
		switch(command) {
		case "login.do":
			controller = new LoginController();
			break;
		case "logout.do":
			controller = new LogoutController();
			break;
		case "register_member.do":
			controller = new InsertMemberController();
			break;
		case "update_view.do":
			controller = new UpdateViewController();
			break;
		case "update_member.do":
			controller = new UpdateMemberController();
			break;
		case "register_qna.do":
			controller = new InsertQnaController();
			break;
		case "qna_view.do":
			controller = new QnaViewController();
			break;
		case "next_qnaList.do":
			controller = new NextQnaListController();
			break;
		case "qna_master_board.do":
			controller = new QnaMasterBoardController();
			break;
		}
		return controller;
	}
}
