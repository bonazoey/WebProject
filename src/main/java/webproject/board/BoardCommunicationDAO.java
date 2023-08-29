package webproject.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import webproject.util.JDBCUtil;
//
public class BoardCommunicationDAO {
	private static BoardCommunicationDAO dao = new BoardCommunicationDAO();

	private BoardCommunicationDAO() {

	}

	public static BoardCommunicationDAO getinstance() {
		return dao;
	}

	// 게시물 댓글 삽입
	public int insertBoardCmt(BoardCommunicationVO vo) {
		int result = 0;
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql = "insert into boardcmt(cno, bno, id, cmt, regdate) values(cno_seq.nextval, ?, ?, ?, sysdate)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getBno());
			pstmt.setString(2, vo.getId());
			pstmt.setString(4, vo.getCmt());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return result;
	}
	
	// 게시물 대댓글 삽입
	public int insertCmtCmt(BoardCommunicationVO vo) {
		int result = 0;
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql = "insert into boardcmtcmt(ccno, cno, bno, id, cmt, regdate) values(ccno_seq.nextval, ?, ?, ?, sysdate)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getCno());
			pstmt.setString(2, vo.getId());
			pstmt.setString(4, vo.getCmt());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return result;
	}

	// 좋아요 버튼 y/n
	public int heartButton(BoardCommunicationVO vo) {
		int result = 0;
		String heart;
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select heart from boardlike where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			rs = pstmt.executeQuery();
			if (pstmt!=null) pstmt.close();
			if (rs.next()) {
				heart = rs.getString("heart");
				if (heart.equals("y")) {
					sql = "update boardlike set heart = 'n' where id = ?";
				} else {
					sql = "update boardlike set heart = 'y' where id = ?";
				}
			} else {
				sql = "update boardlike set heart = 'y' where id = ?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 해당 게시물 댓글 가져오기
	public List<BoardCommunicationVO> getBoardCmt(int page, int bno, int displayRow) 	{
		List<BoardCommunicationVO> list=null;
		StringBuilder sb=new StringBuilder();
		sb.append("select * from (");
		sb.append("select rownum rn, A.* from ");
		sb.append("(select * from boardcmt where bno=? order by bno desc) A ");
		sb.append(" where rownum<=?");
		sb.append(") where rn>=?");
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, bno);
			pstmt.setInt(2, page*displayRow);
			pstmt.setInt(3, page*displayRow-displayRow+1);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				list=new ArrayList<>();
				do {
					list.add(new BoardCommunicationVO(rs.getInt("cno"), rs.getInt("bno"),rs.getString("id") , rs.getString("cmt"), rs.getDate("regdate")));
				}while(rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
