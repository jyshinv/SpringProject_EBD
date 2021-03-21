package com.acorn.ebd.market.dao;

import java.util.List;

import com.acorn.ebd.market.dto.MarketDto;

public interface MarketDao {
	
	public void insert(MarketDto dto);
	public void update(MarketDto dto);
	public void updateStatus(MarketDto dto); //디테일페이지 판매상태 수정
	public void delete(int num);
	public void addViewCnt(int num);
	
	public List<MarketDto> getList(MarketDto dto);
	public MarketDto getData (int num);
	public int getCount(MarketDto dto);
	
	//하트 관련
	public void insertHeart(MarketDto dto);
	public void deleteHeart(MarketDto dto);
	public int getHeartCntDetail(int num);
	public List<Integer> getHeartInfo(MarketDto dto);
	public List<Integer> getHeartCnt(MarketDto dto);
	public boolean getHeartInfoDetail(MarketDto dto);
	
	//마이다이어리에서 내가 쓴글 요청
	public List<MarketDto> getMyList(MarketDto dto);
	//마이다이어리에서 내가 쓴글의 count요청
	public int getMyCount(MarketDto dto);
	
	
}
