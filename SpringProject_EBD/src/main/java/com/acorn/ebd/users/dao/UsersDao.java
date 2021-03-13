package com.acorn.ebd.users.dao;

import com.acorn.ebd.users.dto.UsersDto;

public interface UsersDao {
	//회원 정보를 저장
	public void insert(UsersDto dto);	
	//인자로 전달된 정보가 유효한 정보인지 리턴
	//public boolean isValid(UsersDto dto);
	//로그인한 사용자의 닉네임을 가져옴
	public String getNick(String id);
	//해당 id와 일치하는 비밀번호가 있는지 여부를 리턴해줌 
	public String getPwd(String id);
	//아이디 중복체크
	public boolean isExistId(String id);
	//닉네임 중복체크 
	public boolean isExistNick(String nick);
	//개인정보 요청처리
	public UsersDto getData(String id);
	//개인정보 수정 요청처리
	public void update(UsersDto dto);
	//프로필 수정 요청처리 
	public void updateProfile(UsersDto dto);
}
