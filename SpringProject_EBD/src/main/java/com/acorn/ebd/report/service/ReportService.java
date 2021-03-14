package com.acorn.ebd.report.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.report.dto.ReportCmtDto;
import com.acorn.ebd.report.dto.ReportDto;

public interface ReportService {
	
	public void replaceInfo(String booktitle, String author, String link, ModelAndView mView);
	
	//새 독후감을 저장하는 메소드
	public void saveContent(ReportDto dto, HttpServletRequest request);
	
	//독후감을 불러오는 메소드
	public void getList(ModelAndView mView, HttpServletRequest request);
	
	//독후감 하나의 정보를 불러오는 메소드
	public void getDetail(ReportDto dto, ModelAndView mView, HttpSession session);
	
	//독후감을 삭제하는 메소드
	public void deleteContent(int num);
	
	//독후감 공개/비공개 여부를 결정하는 메소드
	public void updatepublicck(ReportDto dto);
	
	//공개 독후감 목록을 불러오는 메소드
	public void getPublicList(ModelAndView mView, HttpServletRequest request);

	//댓글을 저장하는 메소드
	public void saveComment(HttpServletRequest request);
	
	//댓글을 삭제하는 메소드
	public void deleteComment(HttpServletRequest request);
	
	//댓글을 수정하는 메소드
	public void updateComment(ReportCmtDto dto);
	
	//댓글을 추가 응답하는 메소드
	public void moreCommentList(HttpServletRequest request);
	
	//마이리포트 수정하는 메소드
	public void updateData(ReportDto dto, HttpServletRequest request);
	
	//하트 해제시 해당 테이블에서 target_num을 삭제해주는 메소드
	public int removeHeart(int target_num, HttpSession session);
	
	//하트 추가시 해당 테이블에서 target_num과 nick 을 추가해주는 메소드
	public int saveHeart(int target_num, HttpSession session);
}
