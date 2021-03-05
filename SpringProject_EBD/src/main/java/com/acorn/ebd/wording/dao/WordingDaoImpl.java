package com.acorn.ebd.wording.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.wording.dto.WordingDto;

@Repository
public class WordingDaoImpl implements WordingDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(WordingDto dto) {
		session.insert("wording.insert",dto);
		
	}
	
	
	@Override
	public List<WordingDto> getList(WordingDto dto) {

		return session.selectList("wording.getList", dto);
	}

	@Override
	public int getCount(WordingDto dto) {

		return session.selectOne("wording.getCount",dto);
	}


	@Override
	public void insertHeart(WordingDto dto) {
		session.insert("wording.insertHeart",dto);
	}


	@Override
	public void deleteHeart(WordingDto dto) {
		session.delete("wording.deleteHeart",dto);
	}


	@Override
	public List<WordingDto> getHeartInfo(WordingDto dto) {
		List<WordingDto> list=session.selectList("wording.selectHeartInfo",dto);
		return list;
	}


	@Override
	public WordingDto getData(int num) {
		return session.selectOne("wording.getData",num);
	}


	@Override
	public void update(WordingDto dto) {
		session.update("wording.update",dto);
		
	}


	@Override
	public void delete(int num) {
		session.delete("wording.delete",num);
	}

	
}
