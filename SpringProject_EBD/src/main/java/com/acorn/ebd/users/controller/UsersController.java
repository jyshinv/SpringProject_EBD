package com.acorn.ebd.users.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
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
	
	//아이디 중복 여부 확인 요청처리
	@RequestMapping("/users/checkid.do")
	@ResponseBody
	public Map<String, Object> checkid(@RequestParam String inputId,
			ModelAndView mView) {
	
		//서비스를 이용해서 해당 아이디가 존재하는지 여부를 알아낸다.
		boolean isExist=service.isExistId(inputId);
		// {"isExist":true} or {"isExist":false} 를 응답하기 위한 Map 구성
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isExist", isExist);
		return map;
	}
	
	//닉네임 중복 여부 확인 요청처리
	@RequestMapping("/users/checknick.do")
	@ResponseBody
	public Map<String, Object> checknick(@RequestParam String inputNick,
			ModelAndView mView) {
	
		//서비스를 이용해서 해당 닉네임이 존재하는지 여부를 알아낸다.
		boolean isExist=service.isExistNick(inputNick);
		// {"isExist":true} or {"isExist":false} 를 응답하기 위한 Map 구성
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isExist", isExist);
		return map;
	}
	
	
	//개인정보보기 요청처리
	@RequestMapping("/users/private/info.do")
	public ModelAndView info(ModelAndView mView, HttpSession session) {
		service.getInfo(session, mView);
		mView.setViewName("/users/private/info");
		return mView;
	}
	
	//개인정보 업데이트 폼 요청처리
	@RequestMapping("/users/private/updateform.do")
	public ModelAndView updateform(ModelAndView mView, HttpSession session) {
		service.getInfo(session, mView);
		mView.setViewName("users/private/updateform");
		return mView;
	}
	
	//개인정보 수정 요청 처리
	@RequestMapping(value="/users/private/update", method=RequestMethod.POST)
	public ModelAndView update(UsersDto dto, HttpSession session, ModelAndView mView) {
		service.updateUser(dto, session);
		mView.setViewName("users/private/update");
		return mView;
	}
	
	//프로필 이미지 업데이트 요청처리 
	@RequestMapping("/users/private/profile_upload.do")
	public String profile_upload(MultipartFile image, HttpServletRequest request) {
		service.saveProfile(image, request);
		//회원 수정페이지로 다시 리다이렉트 시키기 
		return "redirect:/users/private/updateform.do";
	}
	
	//비밀번호 수정 폼 요청처리
	@RequestMapping("/users/private/pwd_updateform.do")//.do는 생략가능
	public String pwd_updateform() {
		return "users/private/pwd_updateform";
	}
	
	//비밀번호 수정 요청 처리
	@RequestMapping(value="/users/private/pwd_update", method=RequestMethod.POST)
	public ModelAndView pwd_update(ModelAndView mView, UsersDto dto, HttpSession session) {
		//UsersDto에는 폼전송된 아이디, 구비밀번호, 새비밀번호가 담여있다.
		service.updateUserPwd(mView, dto, session);
		mView.setViewName("users/private/pwd_update");
		return mView;
	}
	
	//회원탈퇴 요청차리
	@RequestMapping("users/private/delete.do")//.do는 생략가능
	public String delete(HttpSession session) {
		service.deleteUser(session);
		return "users/private/delete";
	}
	
	
	

}
