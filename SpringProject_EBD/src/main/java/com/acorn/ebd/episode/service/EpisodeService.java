package com.acorn.ebd.episode.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.episode.dto.EpisodeDto;

public interface EpisodeService {
	//에피소드 저장해주는 메소드
	public void saveContent(EpisodeDto dto, HttpServletRequest request);
	//에피소드 목록을 불러오는 메소드
	public void getList(ModelAndView mView, HttpServletRequest request);
	//하트를 눌렀을 때 하트테이블에 저장해주는 메소드
	public void saveHeart(int target_num, HttpSession session);
	//하트 해제 시 하트테이블에서 삭제해주는 메소드
	public void removeHeart(int target_num, HttpSession session);
	
}
