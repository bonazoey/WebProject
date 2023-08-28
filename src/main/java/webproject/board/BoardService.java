package webproject.board;

import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardService {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private String uploadPath = "d:/upload/img";
	private final String path = "/WEB-INF/views/board/";

	public BoardService(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
	}

	public String exec() throws IOException {
		String cmd = request.getParameter("cmd");
		if (cmd == null || cmd.equals("") || cmd.equals("main")) {
			return BoardMainService();
		} else if (cmd.equals("imgdown")) {
			return BoardImgDownService();
		} else if (cmd.equals("new")) {
			return BoardNewService();
		}
		return null;
	}

	private String BoardNewService() throws IOException {
		String method = request.getMethod().toLowerCase();
		if (method.equals("get")) {
			return path + "boardNew.jsp";
		} else {
			MultipartRequest mr = new MultipartRequest(request, uploadPath, 10 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
			if (mr != null) {
				String id;
				if (mr.getParameter("id") == null) {
					id = "[anony]";
				} else id = mr.getParameter("id");
				String content = mr.getParameter("content");
				String tags = mr.getParameter("tags");
				String oFileName = mr.getOriginalFileName("file");
				BoardVO vo = new BoardVO(0, id, null, content, oFileName, mr.getFilesystemName("file"), uploadPath, tags, null);
				BoardDAO dao = BoardDAO.getinstance();
				int result = dao.insertBoard(vo);
				if (result == 1) {
					return path + "boardMain.jsp";
				}
			}
			return null;
		}
	}

	private String BoardImgDownService() throws IOException {
		String upload = request.getParameter("upload"); // 경로포함 다운로드 파일명
		String originFname = request.getParameter("originFname"); // 원본 파일명
		String savedFname = request.getParameter("savedFname");
		String agent = request.getHeader("User-Agent");
		String filename = upload + "/" + savedFname;
		System.out.println(agent);
		boolean ieBrowser = (agent.indexOf("Trident") > -1) || (agent.indexOf("Edge") > -1);
		if (ieBrowser) {
			originFname = URLEncoder.encode(originFname, "utf-8").replace("\\", "%20");
		} else { // firefox, edge, chrome
			originFname = new String(originFname.getBytes("utf-8"), "iso-8859-1");
		}
		response.setContentType("image/jpg");
		// 다운로드 되는 파일명 설정
		response.setHeader("Content-Disposition", "attachment;filename = " + originFname);
		FileInputStream in = new FileInputStream(filename); // 파일 open
		BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
		int numRead;
		byte b[] = new byte[4096]; // 4K만큼
		while ((numRead = in.read(b, 0, b.length)) != -1) {
			out.write(b, 0, numRead);
		}
		out.flush(); // 버퍼에 남은 것 출력
		in.close();
		out.close();
		return null;
	}

	private String BoardMainService() {
		return path + "boardMain.jsp";
	}

}
