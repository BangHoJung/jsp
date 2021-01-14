package batch;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Application Lifecycle Listener implementation class StartBatch
 *
 */
@WebListener
public class StartBatch implements ServletContextListener {
	private CronTriggerMaker js;
    /**
     * Default constructor. 
     */
    public StartBatch() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0)  { 
    	System.out.println("MemberManager End");
//    	js.shutdownScheduler();
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0)  { 
    	System.out.println("MemberManager Start");
//    	js = new CronTriggerMaker("0 0 9 1/1 * ? *", SearchNoAnswerQnaJob.class);
//    	js = new CronTriggerMaker("0/5 * * * * ?", SearchNoAnswerQnaJob.class);
//    	js.createScheduler();
    }
	
}
