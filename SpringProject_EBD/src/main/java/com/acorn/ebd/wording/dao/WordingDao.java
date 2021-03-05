package com.acorn.ebd.wording.dao;


import java.util.List;

import com.acorn.ebd.wording.dto.WordingDto;


public interface WordingDao {
	//글 추가
	public void insert(WordingDto dto);
	//목록을 불러오는 메소드
	public List<WordingDto> getList(WordingDto dto);
	//총 개수를 불러오는 메소드 
	public int getCount(WordingDto dto);
	//하트 테이블에 정보를 insert하는 메소드
	public void insertHeart(WordingDto dto);
	//하트 테이블에 정보를 delete하는 메소드
	public void deleteHeart(WordingDto dto);
	//하트 테이블 정보를 select하는 메소드
	public List<WordingDto> getHeartInfo(WordingDto dto);
	//글 목록을 select하는 메소드
	public WordingDto getData(int num);
	//글을 update하는 메소드
	public void update(WordingDto dto);
	//글을 delete하는 메소드
	public void delete(int num);
}
