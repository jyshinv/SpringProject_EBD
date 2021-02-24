package com.acorn.ebd.users.dao;

import com.acorn.ebd.users.dto.UsersDto;

public interface UsersDao {
	//회원 정보를 저장
	public void insert(UsersDto dto);	
	//인자로 전달된 정보가 유효한 정보인지 리턴
	public boolean isValid(UsersDto dto);
	//로그인한 사용자의 닉네임을 가져옴
	public String getNick(String id);
}
