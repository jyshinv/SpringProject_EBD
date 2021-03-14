package com.acorn.ebd.report.dto;

import org.springframework.web.multipart.MultipartFile;

public class ReportDto {
	//필드
	private int num;
	private String writer;
	private String booktitle;
	private String author;
	private String title;
	private String genre;
	private String stars;
	private String imgpath;
	private String link;
	private String content;
	private String viewcnt;
	private String regdate;
	private String publicck;
	private int startRowNum;
	private int endRowNum;
	private int prevNum;
	private int nextNum;
	private MultipartFile image;
	private String nick;
	private String profile;
	
	public ReportDto() {}

	public ReportDto(int num, String writer, String booktitle, String author, String title, String genre, String stars,
			String imgpath, String link, String content, String viewcnt, String regdate, String publicck,
			int startRowNum, int endRowNum, int prevNum, int nextNum, MultipartFile image, String nick,
			String profile) {
		super();
		this.num = num;
		this.writer = writer;
		this.booktitle = booktitle;
		this.author = author;
		this.title = title;
		this.genre = genre;
		this.stars = stars;
		this.imgpath = imgpath;
		this.link = link;
		this.content = content;
		this.viewcnt = viewcnt;
		this.regdate = regdate;
		this.publicck = publicck;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
		this.prevNum = prevNum;
		this.nextNum = nextNum;
		this.image = image;
		this.nick = nick;
		this.profile = profile;
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

	public String getBooktitle() {
		return booktitle;
	}

	public void setBooktitle(String booktitle) {
		this.booktitle = booktitle;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getStars() {
		return stars;
	}

	public void setStars(String stars) {
		this.stars = stars;
	}

	public String getImgpath() {
		return imgpath;
	}

	public void setImgpath(String imgpath) {
		this.imgpath = imgpath;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getViewcnt() {
		return viewcnt;
	}

	public void setViewcnt(String viewcnt) {
		this.viewcnt = viewcnt;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getPublicck() {
		return publicck;
	}

	public void setPublicck(String publicck) {
		this.publicck = publicck;
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

	
}
