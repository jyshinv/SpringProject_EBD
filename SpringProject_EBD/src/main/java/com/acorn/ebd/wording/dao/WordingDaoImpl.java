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
	public List<Integer> getHeartInfo(WordingDto dto) {
		List<Integer> list=session.selectList("wording.selectHeartInfo",dto);
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


	@Override
	public List<Integer> getHeartCnt(WordingDto dto) {
		return session.selectList("wording.getHeartCnt",dto);
	}
	
	@Override
	public int getHeartCntDetail(int num) {
		return session.selectOne("wording.getHeartCntDatail",num);

	}


	//좋아요 수 Best3를 리턴
	@Override
	public List<WordingDto> getBestHeartList() {
		List<WordingDto> list=session.selectList("wording.getBestHeartList");
		return list;
	}


	//나의 서재 내가 쓴글 리스트 리턴
	@Override
	public List<WordingDto> getMyList(WordingDto dto) {
		// TODO Auto-generated method stub
		return session.selectList("wording.getMyList", dto);
	}


	//나의 서재 내가 쓴글 리스트 개수 리턴
	@Override
	public int getMyCount(WordingDto dto) {
		// TODO Auto-generated method stub
		return session.selectOne("wording.getMyCount",dto);
	}


	//나의 서재 내가 누른 하트 리스트 리턴
	@Override
	public List<WordingDto> getMyHeartList(WordingDto dto) {
		// TODO Auto-generated method stub
		return session.selectList("wording.getMyHeartList", dto);
	}

	//나의 서재 내가 누른 하트 리스트 개수 리턴
	@Override
	public int getMyHeartCount(WordingDto dto) {
		return session.selectOne("wording.getMyHeartCount",dto);
	}


	//나의 서재 내가 누른 하트 리스트의 하트 클릭 여부 리턴
	@Override
	public List<Integer> getMyHeartInfo(WordingDto dto) {
		List<Integer> list=session.selectList("wording.selectMyHeartInfo",dto);
		return list;
	}

	
}
