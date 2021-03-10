package com.acorn.ebd.market.dao;

import java.util.List;

import com.acorn.ebd.market.dto.MarketCmtDto;

public interface MarketCmtDao {
	//댓글 추가하는 메소드
	public void insert(MarketCmtDto dto);
	//댓글 목록 리턴하는 메소드
	public List<MarketCmtDto> getList(MarketCmtDto dto);
	//댓글 수정하는 메소드
	public void update(MarketCmtDto dto);
	//댓글 삭제하는 메소드
	public void delete(int num);
	//댓글의 시퀀스값(글 번호)를 리턴하는 메소드
	public int getSeq();
	//하나의 댓글정보 리턴하는(가져오는) 메소드
	public MarketCmtDto getData(int num);
	//댓글의 갯수를 리턴하는 메소드
	public int getCount(int ref_group);
}
