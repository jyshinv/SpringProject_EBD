package com.acorn.ebd.wording.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.wording.dto.WordingDto;

public interface WordingService {

	//도서 api에서 가져온 정보의 html요소를 제거하는 메소드
	public void replaceInfo(String title, String author, ModelAndView mView);
	//새 글을 저장하는 메소드
	public void saveContent(WordingDto dto, HttpSession session);
	//글 목록과 로그인된 아이디의 하트 클릭 정보(하트테이블)을 얻어오고 페이징 처리에 필요한 값을을 ModelAndView 객체에 담아주는 메소드
	public void getList(ModelAndView mView, HttpServletRequest request);
	//하트를 눌렀을 때 하트테이블에 저장해주는 메소드
	public int saveHeart(int target_num, HttpSession session);
	//하트 해제 시 하트테이블에서 삭제해주는 메소드
	public int removeHeart(int target_num, HttpSession session);
	//글의 수정폼을 위한 detail을 얻어오는 메소드
	public void getDetail(int num, ModelAndView mView);
	//글 수정을 위한 메소드
	public void update(WordingDto dto);
	//글 삭제를 위한 메소드
	public void delete(int num, HttpServletRequest request);
	//홈 화면에 좋아요 Best3를 요청하는 메소드 
	public void getBestHeartList(ModelAndView mView);
	//나의 서재에 내가 쓴글을 불러오는 메소드 
	public void getMyWriteList(ModelAndView mView, HttpServletRequest request);
	
}
