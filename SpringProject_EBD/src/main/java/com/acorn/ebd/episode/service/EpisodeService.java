package com.acorn.ebd.episode.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.episode.dto.EpisodeDto;

public interface EpisodeService {
	//에피소드 저장해주는 메소드
	public void saveContent(EpisodeDto dto, HttpServletRequest request);
	//에피소드 목록을 불러오는 메소드
	public void getList(ModelAndView mView, HttpServletRequest request);
	
}
