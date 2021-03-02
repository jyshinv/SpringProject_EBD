package com.acorn.ebd.file.dao;

import java.util.List;

import com.acorn.ebd.file.dto.FileCmtDto;

public interface FileCmtDao {
	//댓글 목록 얻어오기
	public List<FileCmtDto> getList(FileCmtDto dto);
	//댓글 추가 
	public void insert(FileCmtDto dto);
	//댓글 수정
	public void update(FileCmtDto dto);
	//댓글 삭제
	public void delete(int num);
	
	//댓글의 시퀀스 값(글번호)를 리턴하는 메소드
	public int getSeq();
	//댓글 하나의 정보를 리턴하는 메소드
	public FileCmtDto getData(int num);
	//댓글의 갯수를 리턴하는 메소드
	public int getCount(int ref_group);
}
