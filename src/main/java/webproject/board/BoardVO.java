package webproject.board;

import java.sql.Date;

public class BoardVO {
	private int bno;
	private String id;
	private Date regdate;
	private String content, srcfilename, savefilename, savepath, tag, disp;
	
	public BoardVO() {
		super();
	}

	public BoardVO(int bno, String id, Date regdate, String content, String srcfilename, String savefilename,
			String savepath, String tag, String disp) {
		super();
		this.bno = bno;
		this.id = id;
		this.regdate = regdate;
		this.content = content;
		this.srcfilename = srcfilename;
		this.savefilename = savefilename;
		this.savepath = savepath;
		this.tag = tag;
		this.disp = disp;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSrcfilename() {
		return srcfilename;
	}

	public void setSrcfilename(String srcfilename) {
		this.srcfilename = srcfilename;
	}

	public String getSavefilename() {
		return savefilename;
	}

	public void setSavefilename(String savefilename) {
		this.savefilename = savefilename;
	}

	public String getSavepath() {
		return savepath;
	}

	public void setSavepath(String savepath) {
		this.savepath = savepath;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getDisp() {
		return disp;
	}

	public void setDisp(String disp) {
		this.disp = disp;
	}

	
}
