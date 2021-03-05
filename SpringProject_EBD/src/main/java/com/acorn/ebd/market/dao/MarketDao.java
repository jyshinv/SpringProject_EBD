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
	
	
}
