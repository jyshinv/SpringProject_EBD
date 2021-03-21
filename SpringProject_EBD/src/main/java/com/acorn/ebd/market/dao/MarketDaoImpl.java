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
	
	// 글 추가
	@Override
	public void insert(MarketDto dto) {
		session.insert("market.insert", dto);
		
	}

	// 글 수정
	@Override
	public void update(MarketDto dto) {
		session.update("market.update", dto);
		
	}

	// 글 삭제
	@Override
	public void delete(int num) {
		session.delete("market.delete",num);
		
	}

	// 글 조회수 증가 
	@Override
	public void addViewCnt(int num) {
		session.update("market.addViewCnt",num);
		
	}

	// 전체 글 목록
	@Override
	public List<MarketDto> getList(MarketDto dto) {
		// 파일 목록을 담아서
		List<MarketDto> list=session.selectList("market.getList",dto);
		// 리턴 
		return list;
	}
	
	// num번의 글
	@Override
	public MarketDto getData(int num) {
		
		MarketDto dto=session.selectOne("market.getData",num);
		return dto;
	}

	// 전체 글 갯수
	@Override
	public int getCount(MarketDto dto) {
		int count=session.selectOne("market.getCount", dto);
		return count;
	}

	// 디테일 페이지 판매 상태 수정
	@Override
	public void updateStatus(MarketDto dto) {
		session.update("market.updateStatus",dto);
	}

	/* 하트 관련  */
	
	@Override
	public void insertHeart(MarketDto dto) {
		session.insert("market.insertH",dto);
		
	}

	@Override
	public void deleteHeart(MarketDto dto) {
		session.delete("market.deleteHeart",dto);
		
	}

	@Override
	public int getHeartCntDetail(int num) {
		 return session.selectOne("market.getHeartCntDetail",num);
	}

	@Override
	public List<Integer> getHeartInfo(MarketDto dto) {
		List<Integer> list=session.selectList("market.selectHeartInfo",dto);
	    return list;
	}

	@Override
	public List<Integer> getHeartCnt(MarketDto dto) {
		return session.selectList("market.getHeartCnt",dto);
	}

	@Override
	public boolean getHeartInfoDetail(MarketDto dto) {
		//해당 닉네임이 해당 글에 좋아요를 누르지 않으면 null, 눌렀으면 target_num 이 리턴된다. 
	    String isClicked=session.selectOne("market.getHeartInfoDetail",dto);
	      
	    if(isClicked==null) {
	       return false; //해당 글에 하트를 안누름
	    }else {
	       return true;
	    }
	}
	
}
