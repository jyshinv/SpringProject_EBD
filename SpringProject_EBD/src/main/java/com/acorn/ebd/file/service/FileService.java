package com.acorn.ebd.file.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.file.dto.FileCmtDto;
import com.acorn.ebd.file.dto.FileDto;

public interface FileService {
	// 파일 리스트
	public void getList(HttpServletRequest request);
	// 디테일 
	public void getDetail(int num, ModelAndView mview, HttpSession session);
	// 파일 & 이미지 추가
	public void addFile(FileDto dto, HttpServletRequest request);
	// 삭제
	public void deleteFile(int num, HttpServletRequest request);
	// 수정 
	public void updateFile(FileDto dto, HttpServletRequest request);
	
	//댓글
	public void saveCmt(HttpServletRequest request);
	public void updateCmt(FileCmtDto dto);
	public void deleteCmt(HttpServletRequest request);
	public void moreCmtList(HttpServletRequest request);
	
	//하트 
	public int saveHeart(int target_num, HttpSession session);
	public int removeHeart(int target_num, HttpSession session);
	
}
