package com.acorn.ebd.users.dto;

public class UsersDto {
	private String id;
	private String pwd;
	private String name;
	private String nick;
	private String gender;
	private String birth_year;
	private String birth_month;
	private String birth_day;
	private String email;
	private String phone;
	private String profile;
	private String regdate;
	private String newpwd;
	
	//생성자
	public UsersDto() {
		// TODO Auto-generated constructor stub
	}
	
	

	public UsersDto(String id, String pwd, String name, String nick, String gender, String birth_year,
			String birth_month, String birth_day, String email, String phone, String profile, String regdate,
			String newpwd) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.nick = nick;
		this.gender = gender;
		this.birth_year = birth_year;
		this.birth_month = birth_month;
		this.birth_day = birth_day;
		this.email = email;
		this.phone = phone;
		this.profile = profile;
		this.regdate = regdate;
		this.newpwd = newpwd;
	}



	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirth_year() {
		return birth_year;
	}

	public void setBirth_year(String birth_year) {
		this.birth_year = birth_year;
	}

	public String getBirth_month() {
		return birth_month;
	}

	public void setBirth_month(String birth_month) {
		this.birth_month = birth_month;
	}

	public String getBirth_day() {
		return birth_day;
	}

	public void setBirth_day(String birth_day) {
		this.birth_day = birth_day;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getNewpwd() {
		return newpwd;
	}

	public void setNewpwd(String newpwd) {
		this.newpwd = newpwd;
	}
	
	
	



	
}
