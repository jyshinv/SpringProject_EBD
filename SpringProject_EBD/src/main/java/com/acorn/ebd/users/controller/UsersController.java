package com.acorn.ebd.users.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.users.dto.UsersDto;
import com.acorn.ebd.users.service.UsersService;

@Controller
public class UsersController {
	
	@Autowired
	private UsersService service;
	
	@RequestMapping("/users/signupform.do")//.do는 생략가능
	public String signupForm() {
		return "users/signupform";
	}
	
	//회원가입 요청처리
	@RequestMapping(value="/users/signup.do",method = RequestMethod.POST)
	public String signup(@ModelAttribute("dto") UsersDto dto) {
		service.addUser(dto);
		return "users/signup";
	}
	
	//로그인 폼 요청처리
	@RequestMapping("/users/loginform.do")//.do는 생략가능
	public ModelAndView loginform(HttpServletRequest request, ModelAndView mView) {
		//로그인 폼에 관련된 로직을 서비스를 통해서 처리한다. --> 이러한 뚱뚱한 로직들은 대부분 서비스에서 처리한다.
		service.loginformLogic(request, mView);
		//뷰페이지 정보도 담는다.
		mView.setViewName("users/loginform");
		//리턴
		return mView;
	}
	
	//로그인 요청처리
	@RequestMapping(value="/users/login.do", method=RequestMethod.POST)//.do는 생략가능
	public String login(HttpServletRequest request, HttpServletResponse response) {
		//로그인에 관련된 로직을 서비스를 통해서 처리한다.
		service.loginLogic(request, response);
		
		//view page로 forward이동해서 응답
		return "users/login";
	}
	
	//로그아웃 요청처리(세션에서 아이디와 nick을 삭제해주면 된다.)
	@RequestMapping("/users/logout.do")//.do는 생략가능
	public String logout(HttpSession session) {
		//session.invalidate(); //세션 초기화
		session.removeAttribute("id");//세션에서 id 삭제 (invalidate 혹은 removeAttribute를 사용해서 세션을 비워준다.)
		session.removeAttribute("nick");
		
		return "users/logout"; 
	}
	

}
