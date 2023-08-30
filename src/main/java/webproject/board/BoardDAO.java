package webproject.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

	public int getRowCount() {
		int result = 0;
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from boardtbl";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return result;
	}
	//
	// 모든 최신 게시물
	public List<BoardVO> getBoardList(int page, int displayRow) 	{
		List<BoardVO> list=null;
		StringBuilder sb=new StringBuilder();
		sb.append("select * from boardtbl order by bno desc");
//		sb.append("select * from (");
//		sb.append("select rownum rn, A.* from ");
//		sb.append("(select * from boardtbl order by bno desc) A ");
//		sb.append(" where rownum<=?");
//		sb.append(") where rn>=?");
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			pstmt=conn.prepareStatement(sb.toString());
//			pstmt.setInt(1, bno);
//			pstmt.setInt(1, page*displayRow);
//			pstmt.setInt(2, page*displayRow-displayRow+1);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				list=new ArrayList<>();
				do {
					list.add(new BoardVO(rs.getInt("bno"), rs.getString("id"), rs.getDate("regdate") , rs.getString("content"), rs.getString("srcfilename"), rs.getString("savefilename"), rs.getString("savepath"), rs.getString("tag"), rs.getString("disp")));
				} while(rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return list;
	}
	
	// 태그 검색 최신 게시물
	public List<BoardVO> getBoardList(int page, int displayRow, String tag) {
		List<BoardVO> list = null;
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		sb.append("select * from (");
		sb.append("select rownum rn, A.* from");
		sb.append("(select bno, id, regdate, content, savefilename, savepath, tag from boardtbl");
		sb.append(" where disp = 'y' and ");
		sb.append(tag);
		sb.append(" like ? order by bno desc) A");// 최신순 정렬
		sb.append(" where rownum<=?");
		sb.append(") where rn>=?");
		System.out.println(sb.toString());
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, "%" + tag + "%");
			pstmt.setInt(2, page * displayRow);
			pstmt.setInt(3, page * displayRow - displayRow + 1);
			rs = pstmt.executeQuery();
			if (rs.next()) {// 검색된 행이 하나이상이면
				list = new ArrayList<>();
				do {
					list.add(new BoardVO(rs.getInt("bno"), rs.getString("id"), rs.getDate("regdate") , rs.getString("content"), rs.getString("srcfilename"), rs.getString("savefilename"), rs.getString("savepath"), rs.getString("tag"), rs.getString("disp")));
				} while (rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return list;
	}
	
	// 페이지용 모든 행 개수
	public int getRowConut() {
		int result = 0;
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from boardtbl where disp = 'y'";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 태그 검색 모든 행 개수
	public int getRowConut(String  tag) {
		int result = 0;
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// select count(*) from booktbl where title like '%자유%'
		String sql = "select count(*) from boardtbl where disp = 'y' and tag like ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + tag + "%");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return result;
	}
}