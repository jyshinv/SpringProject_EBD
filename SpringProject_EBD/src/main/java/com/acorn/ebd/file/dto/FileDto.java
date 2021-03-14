package com.acorn.ebd.file.dto;

import org.springframework.web.multipart.MultipartFile;

public class FileDto {
	private int num;
	private String writer;
	private String title;
	private String orgfname;
	private String savefname;
	//파일의 크기는 byte단위로 저장하기 때문에 long integer type이 필요하다.
	private long fileSize;
	private String imgpath;
	private String content;
	private int viewcnt;
	private String regdate;
	
	private String nick; //프로필 이미지 경로(users테이블의 profile)
	private String profile; //닉네임(heart테이블의 nick)
	
	//페이징 처리를 위한
	private int startRowNum;
	private int endRowNum;
	private int prevNum; //이전글의 글번호
	private int nextNum; //다음글의 글번호
	
	//업로드 되는 파일의 정보를 담을 필드
	private MultipartFile myFile;
	private MultipartFile myImg;
	
	//디폴트 생성자
	public FileDto() {}

	public FileDto(int num, String writer, String title, String orgfname, String savefname, long fileSize,
			String imgpath, String content, int viewcnt, String regdate, String nick, String profile, int startRowNum,
			int endRowNum, int prevNum, int nextNum, MultipartFile myFile, MultipartFile myImg) {
		super();
		this.num = num;
		this.writer = writer;
		this.title = title;
		this.orgfname = orgfname;
		this.savefname = savefname;
		this.fileSize = fileSize;
		this.imgpath = imgpath;
		this.content = content;
		this.viewcnt = viewcnt;
		this.regdate = regdate;
		this.nick = nick;
		this.profile = profile;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
		this.prevNum = prevNum;
		this.nextNum = nextNum;
		this.myFile = myFile;
		this.myImg = myImg;
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

	public String getOrgfname() {
		return orgfname;
	}

	public void setOrgfname(String orgfname) {
		this.orgfname = orgfname;
	}

	public String getSavefname() {
		return savefname;
	}

	public void setSavefname(String savefname) {
		this.savefname = savefname;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getImgpath() {
		return imgpath;
	}

	public void setImgpath(String imgpath) {
		this.imgpath = imgpath;
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

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
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

	public int getPrevNum() {
		return prevNum;
	}

	public void setPrevNum(int prevNum) {
		this.prevNum = prevNum;
	}

	public int getNextNum() {
		return nextNum;
	}

	public void setNextNum(int nextNum) {
		this.nextNum = nextNum;
	}

	public MultipartFile getMyFile() {
		return myFile;
	}

	public void setMyFile(MultipartFile myFile) {
		this.myFile = myFile;
	}

	public MultipartFile getMyImg() {
		return myImg;
	}

	public void setMyImg(MultipartFile myImg) {
		this.myImg = myImg;
	}

	

	
	
}
