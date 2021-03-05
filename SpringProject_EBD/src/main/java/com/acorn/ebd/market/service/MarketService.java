package com.acorn.ebd.market.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.market.dto.MarketDto;

public interface MarketService {
	
	public void insert(HttpServletRequest request, MarketDto dto);
	public void getList(HttpServletRequest request);
	public void getDetail(ModelAndView mview, int num);
	
	public void update(MarketDto dto);
	public void updateStatus(MarketDto dto); //디테일페이지에서 수정적용
	public void delete(int num);
}
