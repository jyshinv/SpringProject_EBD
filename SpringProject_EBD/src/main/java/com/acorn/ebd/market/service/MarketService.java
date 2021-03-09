package com.acorn.ebd.market.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.market.dto.MarketCmtDto;
import com.acorn.ebd.market.dto.MarketDto;

public interface MarketService {
	
	public void insert(HttpServletRequest request, MarketDto dto);
	public void getList(HttpServletRequest request);
	public void getDetail(ModelAndView mview, int num);
	
	public void update(MarketDto dto);
	public void updateStatus(MarketDto dto); //디테일페이지에서 수정적용
	public void delete(int num);
	
	//댓글 관련 메소드
	public void insertCmt(HttpServletRequest request);
	public void updateCmt(MarketCmtDto dto);
	public void deleteCmt(HttpServletRequest request);
	public void moreCmtList(HttpServletRequest request);
	
}
