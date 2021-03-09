package com.acorn.ebd.wording.dto;

public class WordingDto {
	private int num;
	private String writer;
	private String title;
	private String author;
	private String content;
	private int viewcnt;
	private String regdate;
	private int startRowNum;
	private int endRowNum;
	private String profile; //프로필 이미지 경로(users테이블의 profile)
	private String nick;//닉네임(heart테이블의 nick)
	
	public WordingDto() {
		// TODO Auto-generated constructor stub
	}

	public WordingDto(int num, String writer, String title, String author, String content, int viewcnt, String regdate,
			String profile, int startRowNum, int endRowNum, String nick) {
		super();
		this.num = num;
		this.writer = writer;
		this.title = title;
		this.author = author;
		this.content = content;
		this.viewcnt = viewcnt;
		this.regdate = regdate;
		this.profile = profile;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
		this.nick = nick;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getViewcnt() {
		return viewcnt;
	}

	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
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

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}
	
	
	
	
	
}