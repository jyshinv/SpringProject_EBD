package com.acorn.ebd.market.dao;

import java.util.List;

import com.acorn.ebd.market.dto.MarketDto;

public interface MarketDao {
	
	public void insert(MarketDto dto);
	public void update(MarketDto dto);
	public void updateStatus(MarketDto dto); //테스트
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
	
	
}
