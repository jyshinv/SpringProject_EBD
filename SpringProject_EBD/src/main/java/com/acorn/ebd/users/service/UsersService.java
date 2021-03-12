package com.acorn.ebd.users.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.users.dto.UsersDto;

public interface UsersService {
	//회원 가입 처리를 하는 메소드
	public void addUser(UsersDto dto);
	//로그인폼에 관련된 처리를 하는 메소드
	public void loginformLogic(HttpServletRequest request, ModelAndView mView);
	//로그인 관련 처리를 하는 메소드
	public void loginLogic(HttpServletRequest request, HttpServletResponse response);
	//아이디 중복체크
	public boolean isExistId(String id);
	//닉네임 중복체크
	public boolean isExistNick(String nick);
}
