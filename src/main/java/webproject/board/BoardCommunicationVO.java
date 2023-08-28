package webproject.board;

import java.sql.Date;

public class BoardCommunicationVO {
	private int lno, bno, cno, ccno;
	private String id, heart, cmt;
	private Date regdate;

	public BoardCommunicationVO() {
		super();
	}

	public BoardCommunicationVO(int lno, int bno, int cno, int ccno, String id, String heart, String cmt, Date regdate) {
		super();
		this.lno = lno;
		this.bno = bno;
		this.cno = cno;
		this.ccno = ccno;
		this.id = id;
		this.heart = heart;
		this.cmt = cmt;
		this.regdate = regdate;
	}

	public int getLno() {
		return lno;
	}

	public void setLno(int lno) {
		this.lno = lno;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public int getCcno() {
		return ccno;
	}

	public void setCcno(int ccno) {
		this.ccno = ccno;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getHeart() {
		return heart;
	}

	public void setHeart(String heart) {
		this.heart = heart;
	}

	public String getCmt() {
		return cmt;
	}

	public void setCmt(String cmt) {
		this.cmt = cmt;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

}