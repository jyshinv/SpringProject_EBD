package com.acorn.ebd.market.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.market.dto.MarketDto;
import com.acorn.ebd.market.service.MarketService;
import com.acorn.ebd.market.service.MarketServiceImpl;

@Controller
public class MarketController {
	@Autowired
	private MarketService marketService;

	// 마켓 목록 
	@RequestMapping("/market/list")
	public ModelAndView getList(HttpServletRequest request, ModelAndView mview) {
		
		marketService.getList(request);
		mview.setViewName("market/list");
		return mview;
	}
	
	// 마켓 디테일 
	@RequestMapping("/market/detail")
	public ModelAndView getDetail(HttpServletRequest request, ModelAndView mview, int num) {
		
		marketService.getDetail(mview, num);
		mview.setViewName("market/detail");
		return mview;
	}
	
	// 마켓 글쓰기 폼
	@RequestMapping("/market/private/insertform")
	public ModelAndView inserform(ModelAndView mview) {
		
		mview.setViewName("market/private/insertform");
		return mview;
	}
	
	// 마켓 글쓰기 요청 처리 
	@RequestMapping(value = "/market/private/insert" , method = RequestMethod.POST)
	public ModelAndView insert(ModelAndView mview, HttpServletRequest request, 
							MarketDto dto) {
		
		marketService.insert(request, dto);
		mview.setViewName("market/private/insert");
		return mview;
	}
	
	// 마켓 글쓰기 수정 폼
	@RequestMapping("/market/private/updateform")
	public ModelAndView updateform(ModelAndView mview, @RequestParam int num) {
		// num번의 데이터를 가지고 와야하니까
		marketService.getDetail(mview, num);
		mview.setViewName("market/private/updateform");
		return mview;
	}
	
	// 마켓 글쓰기 수정
	@RequestMapping(value= "/market/private/update", method = RequestMethod.POST)
	public String update(@ModelAttribute("dto") MarketDto dto) {
		
		marketService.update(dto);
		return "market/private/update";
	}
	
	@RequestMapping("/market/private/updateStatus")
	public String updateStatus(@ModelAttribute("dto") MarketDto dto) {
		
		// 디테일페이지에서 판매상태 수정하기
		marketService.updateStatus(dto);
		return "market/private/updateStatus";
	}
	
	@RequestMapping("/market/private/delete")
	public String delete(@RequestParam int num) {
		
		return "market/private/delete";
	}
}
