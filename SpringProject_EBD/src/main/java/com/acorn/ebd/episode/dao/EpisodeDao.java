package com.acorn.ebd.episode.dao;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.acorn.ebd.episode.dto.EpisodeDto;
import com.acorn.ebd.wording.dto.WordingDto;

public interface EpisodeDao {
	public void insert(EpisodeDto dto);
	public List<EpisodeDto> getList(EpisodeDto dto);
	public int getCount(EpisodeDto dto);
	//하트 테이블에 정보를 insert하는 메소드
	public void insertHeart(EpisodeDto dto);
	//하트 테이블에 정보를 delete하는 메소드
	public void deleteHeart(EpisodeDto dto);
	//하트 테이블 정보를 select하는 메소드
	public List<Integer> getHeartInfo(EpisodeDto dto);
	//에피소드 디테일에서 글 정보를 불러오는 메소드
	public EpisodeDto getData(EpisodeDto dto);
	//에피소드 디테일에서 하트정보를 불러오는 메소드
	public boolean getHeartInfoDetail(EpisodeDto dto);
	//에피소드 리스트에 하트 개수 테이블을 불러오는 메소드
	public List<Integer> getHeartCnt(EpisodeDto dto);
	//에피소드 디테일에서 하트개수 정보를 불러오는 메소드
	public int getHeartCntDetail(int num);
	//에피소드 수정 요청
	public void updateData(EpisodeDto dto);
}
