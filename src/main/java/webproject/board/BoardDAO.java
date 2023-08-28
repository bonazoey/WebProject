package webproject.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import webproject.util.JDBCUtil;

public class BoardDAO {
	private static BoardDAO dao = new BoardDAO();
	
	private BoardDAO() {
		
	}
	
	public static BoardDAO getinstance() {
		return dao;
	}

	public int insertBoard(BoardVO vo) {
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		int result = 0;
		System.out.println(vo.getId());
		System.out.println(vo.getContent());
		System.out.println(vo.getSrcfilename());
		System.out.println(vo.getSavefilename());
		System.out.println(vo.getSavepath());
		System.out.println(vo.getTag());
		String sql = "insert into boardtbl(bno, id, content, srcfilename, savefilename, savepath, tag) values(bno_seq.nextval, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getSrcfilename());
			pstmt.setString(4, vo.getSavefilename());
			pstmt.setString(5, vo.getSavepath());
			pstmt.setString(6, vo.getTag());
			result = pstmt.executeUpdate();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return 0;
	}
	
}
