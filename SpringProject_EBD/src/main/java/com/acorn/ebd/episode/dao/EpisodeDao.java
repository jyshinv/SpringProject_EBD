package com.acorn.ebd.episode.dao;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.acorn.ebd.episode.dto.EpisodeDto;
import com.acorn.ebd.wording.dto.WordingDto;

public interface EpisodeDao {
	public void insert(EpisodeDto dto);
	public List<EpisodeDto> getList(EpisodeDto dto);
	public int getCount();
	//하트 테이블에 정보를 insert하는 메소드
	public void insertHeart(WordingDto dto);
	//하트 테이블에 정보를 delete하는 메소드
	public void deleteHeart(WordingDto dto);
	//하트 테이블 정보를 select하는 메소드
	public List<EpisodeDto> getHeartInfo(EpisodeDto dto);
}
