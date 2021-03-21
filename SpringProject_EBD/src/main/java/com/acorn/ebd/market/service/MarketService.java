package com.acorn.ebd.market.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.market.dto.MarketCmtDto;
import com.acorn.ebd.market.dto.MarketDto;

public interface MarketService {
	
	public void insert(HttpServletRequest request, MarketDto dto);
	public void getList(HttpServletRequest request);
	public void getDetail(ModelAndView mview, int num, HttpSession session);
	
	public void update(MarketDto dto, HttpServletRequest request);
	public void updateStatus(MarketDto dto); //디테일페이지에서 수정적용
	public void delete(int num);
	
	//댓글 관련 메소드
	public void insertCmt(HttpServletRequest request);
	public void updateCmt(MarketCmtDto dto);
	public void deleteCmt(HttpServletRequest request);
	public void moreCmtList(HttpServletRequest request);
	
	//하트 관련 메소드
	public int saveHeart(int target_num, HttpSession session);
	public int removeHeart(int target_num, HttpSession session);
	
	//마이다이어리 내가 쓴 Market의 리스트를 요청
	public void getMyWriteList(ModelAndView mView, HttpServletRequest request);
	
	
}
