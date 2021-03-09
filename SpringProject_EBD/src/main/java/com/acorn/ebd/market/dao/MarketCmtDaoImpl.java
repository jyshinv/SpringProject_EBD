package com.acorn.ebd.market.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.market.dto.MarketCmtDto;

@Repository
public class MarketCmtDaoImpl implements MarketCmtDao {
	@Autowired
	private SqlSession session;

	@Override
	public void insert(MarketCmtDto dto) {
		
		session.insert("marketCmt.insert", dto);
	}

	@Override
	public List<MarketCmtDto> getList(MarketCmtDto dto) {
		
		List<MarketCmtDto> list=
				session.selectList("marketCmt.getList" , dto);
		return list;
	}

	@Override
	public void update(MarketCmtDto dto) {
		
		session.update("marketCmt.update", dto);
	}

	@Override
	public void delete(int num) {
		
		session.update("marketCmt.delete", num);
	}

	/*
	 *  새로운 댓글을 저장한 직후에 바로 해당 댓글의 번호가 필요 하기 때문에
	 *  댓글의 글번호는 미리 얻어내서 작업을 해야한다. 
	 *  따라서 새 댓글의 글번호를 리턴해주는 메소드가 필요하다. 
	 */
	
	@Override
	public MarketCmtDto getData(int num) {
		
		MarketCmtDto dto=
				session.selectOne("marketCmt.getData", num);
		return dto;
	}

	@Override
	public int getCount(int ref_group) {
		
		int count=
				session.selectOne("marketCmt.getCount", ref_group);
		return count;
	}

	@Override
	public int getSeq() {
		
		int seq=session.selectOne("marketCmt.getSeq");
		return seq;
	}
	
	
}
