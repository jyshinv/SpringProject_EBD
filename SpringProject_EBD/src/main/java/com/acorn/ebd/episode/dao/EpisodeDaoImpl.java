package com.acorn.ebd.episode.dao;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.episode.dto.EpisodeDto;

@Repository
public class EpisodeDaoImpl implements EpisodeDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(EpisodeDto dto) {
		session.insert("episode.insert",dto);
	}

}
