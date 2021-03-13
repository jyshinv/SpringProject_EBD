package com.acorn.ebd.users.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;
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
	//개인정보 보기 요청처리
	public void getInfo(HttpSession session, ModelAndView mView);
	//개인정보 업데이트 요청처리 
	public void updateUser(UsersDto dto, HttpSession session);
	//프로필 업로드 요청처리 
	public void saveProfile(MultipartFile image, HttpServletRequest request);
	//비밀번호 업데이트 요청처리 
	public void updateUserPwd(ModelAndView mView, UsersDto dto, HttpSession session);
	//회원탈퇴 요청처리
	public void deleteUser(HttpSession session);
}
