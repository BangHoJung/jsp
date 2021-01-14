package batch;

import java.util.ArrayList;
import java.util.Calendar;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import dto.QnaDTO;
import service.BoardService;

public class SearchNoAnswerQnaJob implements Job{

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		// TODO Auto-generated method stub
		ArrayList<QnaDTO> list = BoardService.getInstance().searchNoAnswerQnaList();
		
		System.out.println(Calendar.getInstance().getTime() + " / SearchNoAnswerQnaJob execute");
		for(int i=0;i<list.size();i++) {
			System.out.println(list.get(i));
		}
	}
	
}
