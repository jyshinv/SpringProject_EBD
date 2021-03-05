package com.acorn.ebd.episode.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.episode.dto.EpisodeDto;
import com.acorn.ebd.wording.dto.WordingDto;

@Repository
public class EpisodeDaoImpl implements EpisodeDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(EpisodeDto dto) {
		session.insert("episode.insert",dto);
	}

	@Override
	public List<EpisodeDto> getList(EpisodeDto dto) {
		return session.selectList("episode.getList",dto);
	}

	@Override
	public int getCount() {
		return session.selectOne("episode.getCount");
	}
	
	@Override
	public void insertHeart(WordingDto dto) {
		session.insert("episode.insertHeart",dto);
	}


	@Override
	public void deleteHeart(WordingDto dto) {
		session.delete("episode.deleteHeart",dto);
	}
	
	@Override
	public List<EpisodeDto> getHeartInfo(EpisodeDto dto) {
		List<EpisodeDto> list=session.selectList("episode.selectHeartInfo",dto);
		return list;
	}

	@Override
	public EpisodeDto getData(EpisodeDto dto) {
		return session.selectOne("episode.getData",dto);
	}

	@Override
	public EpisodeDto getHeartInfoDetail(EpisodeDto dto) {
		return session.selectOne("episode.getHeartInfoDetail",dto);
	}

}
