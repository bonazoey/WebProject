package webproject.board;

import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import webproject.util.PageVO;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
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
		} else if (cmd.equals("imgDown")) {
			return BoardImgDownService();
		} else if (cmd.equals("new")) {
			return BoardNewService();
		} else if (cmd.equals("feed")) {
			BoardFeedService();
		} 
		return null;
	}
	
	private void BoardFeedService() throws IOException {
		int page = 1;
		String strpage = request.getParameter("page").trim();
		if (strpage != null && !strpage.equals(strpage))
			page = Integer.parseInt(strpage);
		// 페이지
		BoardDAO dao = BoardDAO.getinstance();
		// 특정 도서(bno값) 전체 개수 세기
		int rowCnt = dao.getRowCount();
		System.out.println("rowcnt : " + rowCnt);
		// 다음페이지가 있을지??
		// int page, int totalCount, int displayRow, int displayPage
		int displayRow = 5;
		PageVO pvo = new PageVO(page, rowCnt, displayRow, 0);
		boolean next = pvo.nextPageScore();
		System.out.println("next=" + next);
		// 해당페이지 검색하기
		List<BoardVO> list = dao.getBoardList(page, displayRow);
		// json 데이터를 조립해서 호출쪽으로 출력해 준다.
		// json데이터 조립 :gson 라이브러리 사용
		JsonObject jObj = new JsonObject();
		JsonArray arr = new JsonArray();
		if (list != null) {
			jObj.addProperty("next", next);// 더보기버튼 활성화
			// list를 json array로 만들기
			// json 객체 만들기
			JsonObject data = null;
			int cnt = 0;
			for (BoardVO vo : list) {
				data = new JsonObject();
				data.addProperty("id", vo.getId());
				data.addProperty("content", vo.getContent());
				data.addProperty("disp", vo.getDisp());
				data.addProperty("savefilename", vo.getSavefilename());
				data.addProperty("savepath", vo.getSavepath());
				data.addProperty("srcfilename", vo.getSrcfilename());
				data.addProperty("bno", vo.getBno());
				//data.addProperty("regdate", vo.getRegdate().toString());
				arr.add(data);
				System.out.println(cnt++);
			}
		} else {
			
		}
		jObj.add("arr", arr);
		// Gson gson=new Gson();
		// System.out.println(gson.toJson(jObj));
		// 보내기 전에 encoding
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(jObj);
		out.flush();
		out.close();
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
					return "board?cmd=main";
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
	//
	private String BoardMainService() {
		BoardDAO dao = BoardDAO.getinstance();
		BoardCommunicationDAO cdao = BoardCommunicationDAO.getinstance();
		String parmaPage = request.getParameter("page");
		int page = 0;
		if (parmaPage == null)
			page = 1;
		else
			page = Integer.parseInt(parmaPage);
		int displayRow = 21;
		int displayPage = 5;
		int rowCnt = 0;
		List<BoardVO> list = null;
		List<BoardCommunicationVO> clist = cdao.getBoardCmt(page, rowCnt, displayRow);
		String tag = request.getParameter("tag");
		if (tag == null || tag.equals("")) {
			list = dao.getBoardList(page, displayRow);
			rowCnt = dao.getRowConut();// booktbl 전체 행의 개수
		} else {
			list = dao.getBoardList(page, displayRow, tag);
			rowCnt = dao.getRowConut(tag);// booktbl 해당검색어가 있는 전체 행의 개수
		}
		// PageVO 객체 생성
		PageVO pVo = new PageVO(page, rowCnt, displayRow, displayPage);
		pVo.setSearchword(tag);// 검색어를 PageVO 객체에 저장
		// pVo.setPage(page);//page설정
		// pVo.setPage(6);
		// pVo.setTotalCount(rowCnt);
		// 브라우저에서 접근가능한 객체에 list 저장
		
		request.setAttribute("clist", clist);
		request.setAttribute("list", list);
		request.setAttribute("pVo", pVo);
		return path + "boardMain.jsp";
	}

}
