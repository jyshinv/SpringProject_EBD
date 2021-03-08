package com.acorn.ebd.episode.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.episode.dto.EpisodeDto;
import com.acorn.ebd.episode.service.EpisodeService;

@Controller
public class EpisodeController {
	
	//EpisodeService 객체 주입하기 
	@Autowired
	private EpisodeService service;
	
	//에피소드 list 요청처리
	@RequestMapping("/episode/list.do")
	public ModelAndView list(ModelAndView mView, HttpServletRequest request) {
		service.getList(mView, request);
		mView.setViewName("episode/list");
		return mView;
	}
	
	//에피소드 작성폼 요청 처리 
	@RequestMapping("/episode/private/uploadform.do")
	public String uploadform() {
		return "episode/private/uploadform";
	}
	
	//에피소드 작성 클릭 요청 처리
	@RequestMapping(value="/episode/private/upload.do", method=RequestMethod.POST)
	public String upload(EpisodeDto dto, HttpServletRequest request) {
		service.saveContent(dto, request);
		return "episode/private/upload";
	}
	
	//하트 클릭 요청처리
    @RequestMapping("/episode/saveheart.do")
    @ResponseBody
    public Map<String, Object> insertheart(@RequestParam String target_num, HttpSession session){
    	int new_target_num = Integer.parseInt(target_num);
    	int heartCnt = service.saveHeart(new_target_num, session);
    	Map<String, Object> map=new HashMap<String, Object>();
    	map.put("heartCnt",heartCnt);
    	return map;
    }
    
    //하트눌림 클릭 요청처리(하트 해제)
    @RequestMapping("/episode/removeheart.do")
    @ResponseBody
    public Map<String, Object> deleteheart(@RequestParam String target_num, HttpSession session) {
    	int new_target_num = Integer.parseInt(target_num);
    	int heartCnt=service.removeHeart(new_target_num, session);
    	Map<String, Object> map=new HashMap<String, Object>();
    	map.put("heartCnt",heartCnt);
    	return map;
    }
    
    //에피소드 디테일 클릭 요청 처리
    @RequestMapping("/episode/detail.do")
    public ModelAndView detail(EpisodeDto dto, ModelAndView mView, HttpSession session) {
    	service.getData(dto, mView, session);
    	mView.setViewName("episode/detail");
    	return mView;
    }
    
    //에피소드 디테일에서 수정폼 요청 처리
    @RequestMapping("/episode/private/updateform.do")
    public ModelAndView updateform(EpisodeDto dto, ModelAndView mView, HttpSession session) {
    	service.getData(dto, mView, session);
    	mView.setViewName("episode/private/updateform");
    	return mView;
    }
    
    //에피소드 수정 폼에서 수정 클릭시 수정 요청 처리
    @RequestMapping(value="/episode/private/update.do", method=RequestMethod.POST)
    public String update(EpisodeDto dto, HttpServletRequest request) {
    	service.updateData(dto, request);
    	return "episode/private/update";
    }
	

}
