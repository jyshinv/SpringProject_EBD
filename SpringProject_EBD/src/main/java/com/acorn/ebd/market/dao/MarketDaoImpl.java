package com.acorn.ebd.market.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.market.dto.MarketDto;

@Repository
public class MarketDaoImpl implements MarketDao{
	//DI
	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(MarketDto dto) {
		session.insert("market.insert", dto);
		
	}

	@Override
	public void update(MarketDto dto) {
		session.update("market.update", dto);
		
	}

	@Override
	public void delete(int num) {
		session.delete("market.delete",num);
		
	}

	@Override
	public void addViewCnt(int num) {
		session.update("market.addViewCnt",num);
		
	}

	@Override
	public List<MarketDto> getList(MarketDto dto) {
		// 파일 목록을 담아서
		List<MarketDto> list=session.selectList("market.getList",dto);
		// 리턴 
		return list;
	}

	@Override
	public MarketDto getData(int num) {
		
		MarketDto dto=session.selectOne("market.getData",num);
		return dto;
	}

	@Override
	public int getCount(MarketDto dto) {
		int num=session.selectOne("market.getCount", dto);
		return 0;
	}

	@Override
	public void updateStatus(MarketDto dto) {
		session.update("market.updateStatus",dto);
	}
	
	

}
