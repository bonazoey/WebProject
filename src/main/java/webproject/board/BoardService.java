package webproject.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardService {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private final String path = "/WEB-INF/views/board/";

	public BoardService(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
	}

	public String exec() {
		String cmd = request.getParameter("cmd");
		if (cmd == null || cmd.equals("")) {
			return BoardMainService();
		} else if (cmd.equals("#")) {
			
		}
		return null;
	}

	private String BoardMainService() {
		return path + "boardMain.jsp";
	}

}
