package com.acorn.ebd.episode.dto;

import org.springframework.web.multipart.MultipartFile;

public class EpisodeDto {
	private int num;
	private String writer;
	private String title;
	private String content;
	private String imgPath;
	private String regdate;
	private int startRowNum;
	private int endRowNum;
	private int prevNum;
	private int nextNum;
	private MultipartFile image;
	private int viewcnt;
	private String profile; //프로필 이미지 경로(users테이블의 profile)
	private int target_num;//하트를 단 글의 번호를 의미!!(heart테이블의 target_num)
	private String nick;//닉네임(heart테이블의 nick)
	private String heartcnt; //하트 카운트 메소드
	public EpisodeDto() {
		super();
	}
	public EpisodeDto(int num, String writer, String title, String content, String imgPath, String regdate,
			int startRowNum, int endRowNum, int prevNum, int nextNum, MultipartFile image, int viewcnt, String profile,
			int target_num, String nick, String heartcnt) {
		super();
		this.num = num;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.imgPath = imgPath;
		this.regdate = regdate;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
		this.prevNum = prevNum;
		this.nextNum = nextNum;
		this.image = image;
		this.viewcnt = viewcnt;
		this.profile = profile;
		this.target_num = target_num;
		this.nick = nick;
		this.heartcnt = heartcnt;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
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
	public MultipartFile getImage() {
		return image;
	}
	public void setImage(MultipartFile image) {
		this.image = image;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public int getTarget_num() {
		return target_num;
	}
	public void setTarget_num(int target_num) {
		this.target_num = target_num;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getHeartcnt() {
		return heartcnt;
	}
	public void setHeartcnt(String heartcnt) {
		this.heartcnt = heartcnt;
	}
	
	
	
}
