package webproject.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import webproject.util.JDBCUtil;

public class MemberDAO {
	private static MemberDAO dao = new MemberDAO();

	private MemberDAO() {
		
	}
	
	public static MemberDAO getInstance() {
		return dao;
	}
	
	public int memberInsert(MemberVO vo) {
		int result = 0;
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql = "insert into membertbl values(?, ?, ?, ?, ?, ?, 'c', sysdate)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getNick());
			pstmt.setString(5, vo.getEmail());
			pstmt.setString(6, vo.getPhone());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int idCheck(String id) {
		int result = 1;
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from membertbl where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
}
