package com.acorn.ebd.episode.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.acorn.ebd.episode.dto.EpisodeDto;
import com.acorn.ebd.episode.service.EpisodeService;

@Controller
public class EpisodeController {
	
	//EpisodeService 객체 주입하기 
	@Autowired
	private EpisodeService service;
	
	//에피소드 list 요청처리
	@RequestMapping("/episode/list.do")
	public String list() {
		return "episode/list";
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

}
