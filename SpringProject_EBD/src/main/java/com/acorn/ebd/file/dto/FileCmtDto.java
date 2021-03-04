package com.acorn.ebd.file.dto;

public class FileCmtDto {
	private int num;
	private String writer;
	private String content;
	private String target_nick; //댓글의 대상자
	private int ref_group; //원글의 글 번호
	private int cmt_group; //댓글 내 에서의 그룹번호
	private String deleted; //삭제된 댓글인지의 여부 
	private String regdate;
	
	private int startRowNum;
	private int endRowNum;
	
	//디폴트 생성자
	public FileCmtDto() {}

	public FileCmtDto(int num, String writer, String content, String target_nick, int ref_group, int cmt_group,
			String deleted, String regdate, int startRowNum, int endRowNum) {
		super();
		this.num = num;
		this.writer = writer;
		this.content = content;
		this.target_nick = target_nick;
		this.ref_group = ref_group;
		this.cmt_group = cmt_group;
		this.deleted = deleted;
		this.regdate = regdate;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTarget_nick() {
		return target_nick;
	}

	public void setTarget_nick(String target_nick) {
		this.target_nick = target_nick;
	}

	public int getRef_group() {
		return ref_group;
	}

	public void setRef_group(int ref_group) {
		this.ref_group = ref_group;
	}

	public int getCmt_group() {
		return cmt_group;
	}

	public void setCmt_group(int cmt_group) {
		this.cmt_group = cmt_group;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getStartRowNum() {
		return startRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public int getEndRowNum() {
		return endRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}

	
}
