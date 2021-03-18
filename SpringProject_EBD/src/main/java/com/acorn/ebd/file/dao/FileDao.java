package com.acorn.ebd.file.dao;

import java.util.List;

import com.acorn.ebd.file.dto.FileDto;
import com.acorn.ebd.market.dto.MarketDto;

public interface FileDao {
	// 글 목록
	public List<FileDto> getList(FileDto dto);
	// 글의 갯수 (검색 키워드에 해당하는 갯수)
	public int getCount(FileDto dto);
	// 글 하나의 정보 얻어오기 
	public FileDto getData(int num);
	// 글 추가하기
	public void insert(FileDto dto);
	// 글 삭제하기
	public void delete(int num);
	// 글 수정하기 
	public void update(FileDto dto);
	// 글 조회수 올리기
	public void addViewCount(int num);
	
	// 하트 관련
	public void insertHeart(MarketDto dto);
	public void deleteHeart(MarketDto dto);
	public List<Integer> getHeartInfo(FileDto dto); //하트 정보
	public List<Integer> getHeartCnt(FileDto dto); //하트 갯수
	public boolean getHeartInfoDetail(FileDto dto);
	public int getHeartCntDetail(int num);
	
	//조회수 높은 순대로 TOP5를 리턴하는 메소드 
	public List<FileDto> getBestViewCntList();
}
