package com.acorn.ebd.episode.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpRequest;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.episode.dto.EpisodeCmtDto;
import com.acorn.ebd.episode.dto.EpisodeDto;

public interface EpisodeService {
	//에피소드 저장해주는 메소드
	public void saveContent(EpisodeDto dto, HttpServletRequest request);
	//에피소드 목록을 불러오는 메소드
	public void getList(ModelAndView mView, HttpServletRequest request);
	//하트를 눌렀을 때 하트테이블에 저장해주는 메소드
	public int saveHeart(int target_num, HttpSession session);
	//하트 해제 시 하트테이블에서 삭제해주는 메소드
	public int removeHeart(int target_num, HttpSession session);
	//에피소드 detail을 불러오는 메소드(하트정보 포함)
	public void getData(EpisodeDto dto, ModelAndView mView, HttpSession session);
	//에피소드 내용 수정 요청처리 
	public void updateData(EpisodeDto dto, HttpServletRequest request);
	//댓글 저장 메소드
	public void saveComment(HttpServletRequest request);
	//댓글 삭제 메소드
	public void deleteComment(HttpServletRequest request);
	//댓글 수정 메소드 
	public void updateComment(EpisodeCmtDto dto);
	//새로운 댓글 List를 불러오는 메소드 
	public void moreCommentList(HttpServletRequest request);
	//에피소드 내용 삭제 요청처리
	public void deleteDetail(int num);
	//홈화면에 조회수Best3 요청 메소드
	public void getBestViewCntList(ModelAndView mView);
	//나의 서재 중 내가쓴글에 리스트를 불러오는 메소드 
	public void getMyWriteList(ModelAndView mView, HttpServletRequest request);
	
}
