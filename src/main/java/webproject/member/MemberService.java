package webproject.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;

import webproject.util.JDBCUtil;

public class MemberService {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private final String path = "/WEB-INF/views/member/";
	//
	

	public MemberService(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
	}


	public String exec() throws IOException {
		String cmd = request.getParameter("cmd");
		if (cmd == null || cmd.equals("")) {
			return null;
		} else if (cmd.equals("register")) {
			return MemberRegisterService();
		} else if (cmd.equals("login")) {
			return MemberLoginService();
		} else if (cmd.equals("idcheck")) {
			MemberidcheckService();
		} else if (cmd.equals("logout")) {
			return MemberLogoutService();
		} 
		return null;
	}


	private String MemberLogoutService() {
		HttpSession session = request.getSession();
		session.invalidate();
		return "index.jsp";

	}


	private void MemberidcheckService() throws IOException {
		String id = request.getParameter("id");
		MemberDAO dao= MemberDAO.getInstance();
		int result = dao.idCheck(id);
		JsonObject ob = new JsonObject();
		if (result == 0) {
			ob.addProperty("message", "사용 가능한 아이디입니다.");
		} else
			ob.addProperty("message", "이미 존재하는 아이디입니다.");
		ob.addProperty("result", result);
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(ob);
		out.flush();
		out.close();
	}


	private String MemberLoginService() {
		String method = request.getMethod().toLowerCase();
		if (method.equals("get")) {
			return path + "login.jsp";
		} else {
			MemberVO mvo = null;
			MemberDAO dao = MemberDAO.getInstance();
			mvo = dao.login(request.getParameter("id"), request.getParameter("pwd"));
			if (mvo != null) {
				HttpSession session = request.getSession();
				session.setAttribute("mvo", mvo);
				return "board?cmd=main";
			} else {
				request.setAttribute("message", "아이디 또는 비밀번호를 다시 확인해주세요");
				return path + "login.jsp";
			}
		}
	}


	private String MemberRegisterService() {
		String method = request.getMethod().toLowerCase();
		if (method.equals("get")) {
			return path + "register.jsp";
		} else {
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String nick = request.getParameter("nick");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			MemberVO vo = new MemberVO(id, pwd, name, nick, email, phone, null, null);
			MemberDAO dao = MemberDAO.getInstance();
			int result = dao.memberInsert(vo);
			if (result == 1) {
				return path + "login.jsp";
			}
			request.setAttribute("checkReg", 0);
			return path + "register.jsp";
		}
	}

}
