package com.acorn.ebd.file.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.file.dto.FileDto;

public interface FileService {
	// 파일 리스트 
	public void getList(HttpServletRequest request);
	// 디테일 
	public void getDetail(int num, ModelAndView mview);
	// 파일 & 이미지 추가
	public void addFile(FileDto dto, HttpServletRequest request);
	// 삭제
	public void deleteFile(int num, HttpServletRequest request);
	// 수정 
	public void updateFile(FileDto dto);
	
	//댓글
}